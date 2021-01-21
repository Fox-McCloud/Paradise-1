// stored_energy += (pulse_strength-RAD_COLLECTOR_EFFICIENCY)*RAD_COLLECTOR_COEFFICIENT
#define RAD_COLLECTOR_EFFICIENCY 80 	// radiation needs to be over this amount to get power
#define RAD_COLLECTOR_COEFFICIENT 100
#define RAD_COLLECTOR_STORED_OUT 0.04	// (this*100)% of stored power outputted per tick. Doesn't actualy change output total, lower numbers just means collectors output for longer in absence of a source
#define RAD_COLLECTOR_MINING_CONVERSION_RATE 0.00001 //This is gonna need a lot of tweaking to get right. This is the number used to calculate the conversion of watts to research points per process()
#define RAD_COLLECTOR_OUTPUT min(stored_energy, (stored_energy*RAD_COLLECTOR_STORED_OUT)+1000) //Produces at least 1000 watts if it has more than that stored

GLOBAL_LIST_EMPTY(rad_collectors)

/obj/machinery/power/rad_collector
	name = "Radiation Collector Array"
	desc = "A device which uses Hawking Radiation and plasma to produce power."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "ca"
	anchored = 0
	density = 1
	req_access = list(ACCESS_ENGINE_EQUIP)
//	use_power = NO_POWER_USE
	max_integrity = 350
	integrity_failure = 80
	rad_insulation = RAD_EXTREME_INSULATION
	var/obj/item/tank/plasma/loaded_tank = null
	var/stored_energy = 0
	var/active = 0
	var/locked = FALSE
	var/drainratio = 1
	var/powerproduction_drain = 0.001

/obj/machinery/power/rad_collector/Initialize(mapload)
	. = ..()
	GLOB.rad_collectors += src

/obj/machinery/power/rad_collector/Destroy()
	GLOB.rad_collectors -= src
	return ..()

/obj/machinery/power/rad_collector/process()
	if(!loaded_tank)
		return
	if(loaded_tank.air_contents.toxins <= 0)
		investigate_log("<font color='red'>out of fuel</font>.", "singulo")
		playsound(src, 'sound/machines/ding.ogg', 50, TRUE)
		eject()
	else
		var/gasdrained = min(powerproduction_drain * drainratio, loaded_tank.air_contents.toxins)
		loaded_tank.air_contents.toxins -= gasdrained

		var/power_produced = RAD_COLLECTOR_OUTPUT
		add_avail(power_produced)
		stored_energy -= power_produced



/obj/machinery/power/rad_collector/attack_hand(mob/user as mob)
	if(anchored)
		if(!src.locked)
			toggle_power()
			user.visible_message("[user.name] turns the [src.name] [active? "on":"off"].", \
			"You turn the [src.name] [active? "on":"off"].")
			investigate_log("turned [active?"<font color='green'>on</font>":"<font color='red'>off</font>"] by [user.key]. [loaded_tank ? "Fuel: [round(loaded_tank.air_contents.toxins / 0.29)]%":"<font color='red'>It is empty</font>"].","singulo")
			return
		else
			to_chat(user, "<span class='warning'>The controls are locked!</span>")
			return


/obj/machinery/power/rad_collector/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/analyzer) && loaded_tank)
		atmosanalyzer_scan(loaded_tank.air_contents, user)
	else if(istype(W, /obj/item/tank/plasma))
		if(!src.anchored)
			to_chat(user, "<span class='warning'>The [src] needs to be secured to the floor first.</span>")
			return 1
		if(loaded_tank)
			to_chat(user, "<span class='warning'>There's already a plasma tank loaded.</span>")
			return 1
		user.drop_item()
		loaded_tank = W
		W.loc = src
		update_icons()
	else if(istype(W, /obj/item/crowbar))
		if(loaded_tank && !src.locked)
			eject()
			return 1
	else if(istype(W, /obj/item/wrench))
		if(loaded_tank)
			to_chat(user, "<span class='notice'>Remove the plasma tank first.</span>")
			return 1
		playsound(src.loc, W.usesound, 75, 1)
		src.anchored = !src.anchored
		user.visible_message("[user.name] [anchored? "secures":"unsecures"] the [src.name].", \
			"You [anchored? "secure":"undo"] the external bolts.", \
			"You hear a ratchet")
		if(anchored)
			connect_to_network()
		else
			disconnect_from_network()
	else if(istype(W, /obj/item/card/id)||istype(W, /obj/item/pda))
		if(src.allowed(user))
			if(active)
				src.locked = !src.locked
				to_chat(user, "The controls are now [src.locked ? "locked." : "unlocked."]")
			else
				src.locked = 0 //just in case it somehow gets locked
				to_chat(user, "<span class='warning'>The controls can only be locked when the [src] is active</span>")
		else
			to_chat(user, "<span class='warning'>Access denied!</span>")
			return 1
	else
		return ..()

/obj/machinery/power/rad_collector/examine(mob/user)
	. = ..()
	if(active)
		// stored_energy is converted directly to watts every SSmachines.wait * 0.1 seconds.
		// Therefore, its units are joules per SSmachines.wait * 0.1 seconds.
		// So joules = stored_energy * SSmachines.wait * 0.1
		var/joules = stored_energy * SSmachines.wait * 0.1
		. += "<span class='notice'>[src]'s display states that it has stored <b>[DisplayJoules(joules)]</b>, and is processing <b>[DisplayPower(RAD_COLLECTOR_OUTPUT)]</b>.</span>"
	else
		. += "<span class='notice'><b>[src]'s display displays the words:</b> \"Power production mode. Please insert <b>Plasma</b>.\"</span>"

/obj/machinery/power/rad_collector/obj_break(damage_flag)
	if(!(stat & BROKEN) && !(flags & NODECONSTRUCT))
		eject()
		stat |= BROKEN

/obj/machinery/power/rad_collector/proc/eject()
	locked = FALSE
	var/obj/item/tank/plasma/Z = loaded_tank
	if(!Z)
		return
	Z.forceMove(drop_location())
	Z.layer = initial(Z.layer)
	Z.plane = initial(Z.plane)
	loaded_tank = null
	if(active)
		toggle_power()
	else
		update_icons()

/obj/machinery/power/rad_collector/rad_act(amount)
	. = ..()
	if(loaded_tank && active && amount > RAD_COLLECTOR_EFFICIENCY)
		stored_energy += (amount - RAD_COLLECTOR_EFFICIENCY) * RAD_COLLECTOR_COEFFICIENT


/obj/machinery/power/rad_collector/proc/update_icons()
	overlays.Cut()
	if(loaded_tank)
		overlays += image('icons/obj/singularity.dmi', "ptank")
	if(stat & (NOPOWER|BROKEN))
		return
	if(active)
		overlays += image('icons/obj/singularity.dmi', "on")


/obj/machinery/power/rad_collector/proc/toggle_power()
	active = !active
	if(active)
		icon_state = "ca_on"
		flick("ca_active", src)
	else
		icon_state = "ca"
		flick("ca_deactive", src)
	update_icons()

#undef RAD_COLLECTOR_EFFICIENCY
#undef RAD_COLLECTOR_COEFFICIENT
#undef RAD_COLLECTOR_STORED_OUT
#undef RAD_COLLECTOR_MINING_CONVERSION_RATE
#undef RAD_COLLECTOR_OUTPUT
