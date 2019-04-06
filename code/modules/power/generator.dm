/obj/machinery/power/generator
	name = "generator"
	desc = "It's a high efficiency thermoelectric generator."
	icon = 'icons/goonstation/power/power.dmi'
	icon_state = "teg"
	anchored = FALSE
	density = TRUE
	use_power = NO_POWER_USE

	var/obj/machinery/atmospherics/binary/circulator/cold_circ
	var/obj/machinery/atmospherics/binary/circulator/hot_circ

	var/cold_dir = WEST
	var/hot_dir = EAST

	var/lastgen = 0
	var/lastgenlev = -1
	var/running = FALSE
	var/spam_limiter = FALSE
	var/efficiency_controller = 52

	var/grump = 0
	var/grumping = FALSE

	var/list/grump_prefix = list("an upsetting", "an unsettling", "a scary", "a loud", "a sassy", "a grouchy", "a grumpy",
								 "an awful", "a horrible", "a despicable", "a pretty rad", "a godawful")

	var/list/grump_suffix = list("noise", "racket", "ruckus", "sound", "clatter", "fracas", "hubbub")

	var/sound_engine1 = 'sound/goonstation/machines/tractor_running.ogg'
	var/sound_engine2 = 'sound/goonstation/machines/engine_highpower.ogg'
	var/sound_tractorrev = 'sound/goonstation/machines/tractorrev.ogg'
	var/sound_engine_alert1 = 'sound/machines/engine_alert1.ogg'
	var/sound_engine_alert2 = 'sound/machines/engine_alert2.ogg'
	var/sound_engine_alert3 = 'sound/goonstation/machines/engine_alert3.ogg'
	var/sound_bigzap = 'sound/effects/eleczap.ogg'
	var/sound_bellalert = 'sound/goonstation/machines/bellalert.ogg'
	var/sound_warningbuzzer = 'sound/machines/warning-buzzer.ogg'
	var/list/sounds_enginegrump = list('sound/goonstation/machines/engine_grump1.ogg', 'sound/goonstation/machines/engine_grump2.ogg', 'sound/goonstation/machines/engine_grump3.ogg', 'sound/goonstation/machines/engine_grump4.ogg')
	var/list/sounds_engine = list('sound/goonstation/machines/tractor_running2.ogg', 'sound/goonstation/machines/tractor_running3.ogg')

/obj/machinery/power/generator/Initialize(mapload)
	. = ..()
	SSgenerator.generator_machinery += src
	connect()
	update_desc()

/obj/machinery/power/generator/Destroy()
	SSgenerator.generator_machinery -= src
	disconnect()
	return ..()

/obj/machinery/power/generator/examine(mob/user)
	..()
	to_chat(user, "Current Output: [engineering_notation(lastgen)]W")

/obj/machinery/power/generator/proc/update_desc()
	desc = initial(desc) + " Its cold circulator is located on the [dir2text(cold_dir)] side, and its heat circulator is located on the [dir2text(hot_dir)] side."

/obj/machinery/power/generator/proc/disconnect()
	if(cold_circ)
		cold_circ.generator = null
	if(hot_circ)
		hot_circ.generator = null
	if(powernet)
		disconnect_from_network()

/obj/machinery/power/generator/proc/connect()
	connect_to_network()

	var/obj/machinery/atmospherics/binary/circulator/circpath = /obj/machinery/atmospherics/binary/circulator
	cold_circ = locate(circpath) in get_step(src, cold_dir)
	hot_circ = locate(circpath) in get_step(src, hot_dir)

	if(cold_circ && cold_circ.side == cold_dir)
		cold_circ.generator = src
		cold_circ.update_icon()
	else
		cold_circ = null

	if(hot_circ && hot_circ.side == hot_dir)
		hot_circ.generator = src
		hot_circ.update_icon()
	else
		hot_circ = null

	power_change()
	update_icon()
	updateDialog()

/obj/machinery/power/generator/power_change()
	if(!anchored)
		stat |= NOPOWER
	else
		..()

/obj/machinery/power/generator/update_icon()
	if(stat & (NOPOWER|BROKEN))
		overlays.Cut()
	else
		overlays.Cut()

		if(lastgenlev != 0)
			overlays += image('icons/goonstation/power/power.dmi', "teg-op[lastgenlev]")

		switch(lastgenlev)
			if(0)
				set_light(0)
			if(1 to 11)
				light_color = "#FFFFFF"
				set_light(2)
			if(12 to 15)
				light_color = "#4D4DE6"
				set_light(2)
			if(16 to 17)
				light_color =  "#E6E61A"
				set_light(2)
			if(18 to 22)
				playsound(src.loc, 'sound/goonstation/effects/elec_bzzz.ogg', 50,0)
				light_color = "#E61A1A"
				set_light(2)
			if(18 to 25)
				playsound(src.loc, 'sound/effects/eleczap.ogg', 50,0)
				light_color = "#E61A1A"
				set_light(3)
			if(26 to INFINITY)
				playsound(src.loc, 'sound/goonstation/effects/electric_shock.ogg', 50,0)
				light_color = "#E600E6"
				set_light(3)

/obj/machinery/power/generator/proc/process_generator()
	if(stat & (NOPOWER|BROKEN))
		return

	if(!cold_circ || !hot_circ)
		return

	lastgen = 0

	if(powernet)

		var/datum/gas_mixture/cold_air = cold_circ.return_transfer_air()
		var/datum/gas_mixture/hot_air = hot_circ.return_transfer_air()

		if(cold_air && hot_air)
			var/cold_air_heat_capacity = cold_air.heat_capacity()
			var/hot_air_heat_capacity = hot_air.heat_capacity()

			var/delta_temperature = hot_air.temperature - cold_air.temperature

			if(delta_temperature > 0 && cold_air_heat_capacity > 0 && hot_air_heat_capacity > 0)
				var/efficiency = (1 - cold_air.temperature / hot_air.temperature) * (efficiency_controller * 0.01) //controller expressed as a percentage

				var/energy_transfer = delta_temperature * hot_air_heat_capacity * cold_air_heat_capacity / (hot_air_heat_capacity + cold_air_heat_capacity)

				var/heat = energy_transfer * (1 - efficiency)
				lastgen = energy_transfer * efficiency

				hot_air.temperature = hot_air.temperature - energy_transfer / hot_air_heat_capacity
				cold_air.temperature = cold_air.temperature + heat / cold_air_heat_capacity

				add_avail(lastgen)
		// update icon overlays only if displayed level has changed

		if(hot_air)
			var/datum/gas_mixture/hot_circ_air1 = hot_circ.get_outlet_air()
			hot_circ_air1.merge(hot_air)

		if(cold_air)
			var/datum/gas_mixture/cold_circ_air1 = cold_circ.get_outlet_air()
			cold_circ_air1.merge(cold_air)

	var/genlev = max(0, min(round(26 * lastgen / 4000000), 26)) // raised 2MW toplevel to 3MW, dudes were hitting 2mw way too easily
	if((genlev != lastgenlev) && !spam_limiter)
		spam_limiter = TRUE
		lastgenlev = genlev
		update_icon()
		if(!genlev)
			running = FALSE
		else if(genlev && !running)
			playsound(loc, sound_tractorrev, 55, 0)
			running = TRUE
		addtimer(CALLBACK(src, .proc/reset_spam_limiter), 5)
	updateDialog()

	// engine looping sounds and hazards
	if(lastgenlev > 0)
		if(grump < 0) // grumpcode
			grump = 0 // no negative grump plz
		grump++ // get grump'd
		if(grump >= 100 && prob(5))
			playsound(loc, pick(sounds_enginegrump), 70, 0)
			visible_message("<span class='warning'>[src] makes [pick(grump_prefix)] [pick(grump_suffix)]!</span>")
			grump -= 5
	switch(lastgenlev)
		if(0)
			return
		if(1 to 2)
			playsound(loc, sound_engine1, 60, 0)
			if(prob(5))
				playsound(loc, pick(sounds_engine), 70, 0)
		if(3 to 11)
			playsound(loc, sound_engine1, 60, 0)
		if(12 to 15)
			playsound(loc, sound_engine2, 60, 0)
		if(16 to 18)
			playsound(loc, sound_bellalert, 60, 0)
			if(prob(5))
				do_sparks(2, 1, get_turf(src))
		if(19 to 21)
			playsound(loc, sound_warningbuzzer, 50, 0)
			if (prob(5))
				var/datum/effect_system/smoke_spread/bad/smoke = new
				smoke.set_up(1, 0, loc)
				smoke.attach(src)
				smoke.start()
				visible_message("<span class='warning'>[src] starts smoking!</span>")
			if(!grumping && grump >= 100 && prob(5))
				grumping = TRUE
				playsound(loc, 'sound/goonstation/machines/engine_grump1.ogg', 50, 0)
				visible_message("<span class='warning'>[src] erupts in flame!</span>")
				fireflash(src, 1)
				grumping = 0
				grump -= 10
		if(22 to 23)
			playsound(loc, sound_engine_alert1, 55, 0)
			if(prob(5))
				zapStuff()
			if(prob(5))
				var/datum/effect_system/smoke_spread/bad/smoke = new
				smoke.set_up(1, 0, loc)
				smoke.attach(src)
				smoke.start()
				visible_message("<span class='warning'>[src] starts smoking!</span>")
			if(!grumping && grump >= 100 && prob(5))
				grumping = TRUE
				playsound(loc, 'sound/goonstation/machines/engine_grump1.ogg', 50, 0)
				visible_message("<span class='warning'>[src] erupts in flame!</span>")
				fireflash(src, rand(1, 3))
				grumping = FALSE
				grump -= 30

		if(24 to 25)
			playsound(loc, sound_engine_alert1, 55, 0)
			if(prob(10))
				zapStuff()
			if(prob(5))
				var/datum/effect_system/smoke_spread/bad/smoke = new
				smoke.set_up(1, 0, loc)
				smoke.attach(src)
				smoke.start()
				visible_message("<span class='warning'>[src] starts smoking!</span>")
			if (!grumping && grump >= 100 && prob(10)) // probably not good if this happens several times in a row
				grumping = TRUE
				playsound(loc, 'sound/goonstation/weapons/rocket.ogg', 50, 0)
				visible_message("<span class='warning'>[src] explodes in flame!</span>")
				var/firesize = rand(1, 4)
				fireflash(src, firesize)
				for(var/atom/movable/AM in view(firesize, loc)) // fuck up those jerkbag engineers
					if(AM.anchored)
						continue
					if(isliving(AM))
						var/mob/living/L = AM
						L.Weaken(8)
						L.adjustBruteLoss(10)
						var/atom/targetTurf = get_edge_target_turf(L, get_dir(src, get_step_away(L, src)))
						L.throw_at(targetTurf, 200, 4)
					else if(prob(15)) // cut down the number of other junk things that get blown around
						var/atom/targetTurf = get_edge_target_turf(AM, get_dir(src, get_step_away(AM, src)))
						AM.throw_at(targetTurf, 200, 4)
				grumping = FALSE
				grump -= 30

		if(26 to INFINITY)
			playsound(loc, sound_engine_alert3, 55, 0)
			if(!grumping && grump >= 100 && prob(6))
				grumping = TRUE
				visible_message("<span class='danger'>[src] [pick("resonates", "shakes", "rumbles", "grumbles", "vibrates", "roars")] [pick("dangerously", "strangely", "ominously", "frighteningly", "grumpily")]!</span>")
				playsound(loc, 'sound/effects/explosionfar.ogg', 65, 1)
				for(var/obj/structure/window/W in range(6, src.loc)) // smash nearby windows
					if(W.max_integrity >= 80) // plasma glass or better, no break please and thank you
						continue
					if(prob(get_dist(W, loc) * 6))
						continue
					W.take_damage(max_integrity, BRUTE, 0, FALSE)
				for(var/mob/living/L in range(6, loc))
					shake_camera(L, 3, 2)
					L.Weaken(1)
				for(var/turf/simulated/S in range(rand(1, 3), loc))
					animate_shake(S, 1, 2, 2)
				grumping = FALSE
				grump -= 30

				if(lastgen >= 10000000)
					for(var/turf/T in range(6, src))
						var/T_dist = get_dist(T, src)
						var/T_effect_prob = 100 * (1 - (max(T_dist - 1, 1) / 5))

						for(var/obj/item/I in T)
							if(prob(T_effect_prob))
								animate_float(I, 1, 3, return_normal = TRUE)

			if(prob(33))
				zapStuff()
			if(prob(5))
				visible_message("<span class='warning'>[src] [pick("rumbles", "groans", "shudders", "grustles", "hums", "thrums")] [pick("ominously", "oddly", "strangely", "oddly", "worringly", "softly", "loudly")]!</span>")
			else if(prob(2))
				visible_message("<span class='danger'>[src] hungers!</span>")

/obj/machinery/power/generator/proc/reset_spam_limiter()
	spam_limiter = FALSE

/obj/machinery/power/generator/proc/zapStuff()
	var/atom/target = null
	var/atom/last = src

	var/list/starts = list()
	for(var/atom/movable/AM in orange(3, src))
		if(istype(AM, /obj/effect) || isobserver(AM))
			continue
		starts.Add(AM)

	if(!starts.len)
		return

	if(prob(10))
		var/person = null
		person = (locate(/mob/living) in starts)
		if(person)
			target = person
		else
			target = pick(starts)
	else
		target = pick(starts)

	if(isturf(target))
		return

	playsound(target, sound_bigzap, 40, 1)

	for(var/count = 0, count < 3, count++)

		if(!target)
			break
		last.Beam(target, icon_state = "lightning[rand(1, 12)]", icon = 'icons/effects/effects.dmi', time = 6)

		if(isliving(target)) //Probably unsafe.
			var/mob/living/L = target
			L.adjustFireLoss(20)

		var/list/next = list()
		for(var/atom/movable/AM in orange(2, target))
			if(istype(AM, /obj/effect) || isobserver(AM))
				continue
			next.Add(AM)

		last = target
		target = pick(next)

/obj/machinery/power/generator/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/power/generator/attack_ghost(mob/user)
	if(stat & (NOPOWER|BROKEN))
		return
	interact(user)

/obj/machinery/power/generator/attack_hand(mob/user)
	if(..())
		user << browse(null, "window=teg")
		return
	interact(user)

/obj/machinery/power/generator/attackby(obj/item/I, mob/user, params)
	if(iswrench(I))
		anchored = !anchored
		if(!anchored)
			disconnect()
			power_change()
		else
			connect()
		playsound(loc, I.usesound, 50, 1)
		to_chat(user, "<span class='notice'>You [anchored ? "secure" : "unsecure"] the bolts holding [src] to the floor.</span>")
		return
	if(ismultitool(I))
		if(cold_dir == WEST)
			cold_dir = EAST
			hot_dir = WEST
		else if(cold_dir == NORTH)
			cold_dir = SOUTH
			hot_dir = NORTH
		else if(cold_dir == EAST)
			cold_dir = WEST
			hot_dir = EAST
		else
			cold_dir = NORTH
			hot_dir = SOUTH
		connect()
		to_chat(user, "<span class='notice'>You reverse the generator's circulator settings. The cold circulator is now on the [dir2text(cold_dir)] side, and the heat circulator is now on the [dir2text(hot_dir)] side.</span>")
		update_desc()
		return
	return ..()

/obj/machinery/power/generator/proc/get_menu(include_link = TRUE)
	var/t = ""
	if(!powernet)
		t += "<span class='bad'>Unable to connect to the power network!</span>"
		t += "<BR><A href='?src=[UID()];check=1'>Retry</A>"
	else if(cold_circ && hot_circ)
		var/datum/gas_mixture/cold_circ_air1 = cold_circ.get_outlet_air()
		var/datum/gas_mixture/cold_circ_air2 = cold_circ.get_inlet_air()
		var/datum/gas_mixture/hot_circ_air1 = hot_circ.get_outlet_air()
		var/datum/gas_mixture/hot_circ_air2 = hot_circ.get_inlet_air()

		t += "<div class='statusDisplay'>"

		t += "Output: [engineering_notation(lastgen)]W"

		t += "<BR>"

		t += "<B><font color='blue'>Cold loop</font></B><BR>"
		t += "Temperature Inlet: [round(cold_circ_air2.temperature, 0.1)] K / Outlet: [round(cold_circ_air1.temperature, 0.1)] K<BR>"
		t += "Pressure Inlet: [round(cold_circ_air2.return_pressure(), 0.1)] kPa /  Outlet: [round(cold_circ_air1.return_pressure(), 0.1)] kPa<BR>"

		t += "<B><font color='red'>Hot loop</font></B><BR>"
		t += "Temperature Inlet: [round(hot_circ_air2.temperature, 0.1)] K / Outlet: [round(hot_circ_air1.temperature, 0.1)] K<BR>"
		t += "Pressure Inlet: [round(hot_circ_air2.return_pressure(), 0.1)] kPa / Outlet: [round(hot_circ_air1.return_pressure(), 0.1)] kPa<BR>"

		t += "</div>"
	else
		t += "<span class='bad'>Unable to locate all parts!</span>"
		t += "<BR><A href='?src=[UID()];check=1'>Retry</A>"
	if(include_link)
		t += "<BR><A href='?src=[UID()];close=1'>Close</A>"

	return t

/obj/machinery/power/generator/interact(mob/user)
	user.set_machine(src)

	var/datum/browser/popup = new(user, "teg", "Generator", 460, 300)
	popup.set_content(get_menu())
	popup.set_title_image(user.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()
	return TRUE

/obj/machinery/power/generator/Topic(href, href_list)
	if(..())
		return FALSE
	if( href_list["close"] )
		usr << browse(null, "window=teg")
		usr.unset_machine()
		return FALSE
	if( href_list["check"] )
		if(!powernet || !cold_circ || !hot_circ)
			connect()
	return TRUE

/obj/machinery/power/generator/power_change()
	..()
	update_icon()

/proc/engineering_notation(value = 0)
	if(!value)
		return "0 "

	var/suffix = ""
	var/power = round(log(10, value) / 3)
	switch(power)
		if(-8)
			suffix = "y"
		if(-7)
			suffix = "z"
		if(-6)
			suffix = "a"
		if(-5)
			suffix = "f"
		if (-4)
			suffix = "p"
		if(-3)
			suffix = "n"
		if(-2)
			suffix = "&#956;"
		if(-1)
			suffix = "m"
		if(1)
			suffix = "k"
		if(2)
			suffix = "M"
		if(3)
			suffix = "G"
		if(4)
			suffix = "T"
		if(5)
			suffix = "P"
		if(6)
			suffix = "E"
		if(7)
			suffix = "Z"
		if(8)
			suffix = "Y"

	value = round((value / (10 ** (3 * power))), 0.001)
	return "[value] [suffix]"