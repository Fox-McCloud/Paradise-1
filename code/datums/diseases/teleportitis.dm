/datum/disease/teleportitis
	name = "Teleportitis"
	max_stages = 1
	spread_text = "Non-Contagious"
	spread_flags = SPECIAL
	cures = list("teslium")
	cure_chance = 8
	cure_text = "Teslium"
	agent = "liquid spacetime"
	disease_flags = CURABLE
	spread_flags = NON_CONTAGIOUS
	viable_mobtypes = list(/mob/living/carbon/human)

/datum/disease/teleportitis/stage_act()
	..()
	if(prob(5))
		affected_mob.emote("hiccup")
	if(prob(15))
		if(!isturf(affected_mob.loc))
			return
		if(!is_teleport_allowed(affected_mob.z))
			return

		var/list/randomturfs = list()
		for(var/turf/T in orange(affected_mob, 10))
			if(isspaceturf(T) || T.density)
				continue
			randomturfs.Add(T)
		if(LAZYLEN(randomturfs))
			to_chat(affected_mob, "<span class='warning'>You are suddenly zapped away elsewhere!</span>")
			affected_mob.forceMove(pick(randomturfs))
			do_sparks(5, 1, affected_mob.loc)
		randomturfs.Cut()