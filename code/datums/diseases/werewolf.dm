/datum/disease/lycanthropy
	name = "Unidentified virus"
	max_stages = 5
	stage_prob = 5
	spread_text = "Saliva"
	spread_flags = SPECIAL
	cure_text = "Incurable"
	viable_mobtypes = list(/mob/living/carbon/human)
	spread_flags = NON_CONTAGIOUS
	disease_flags = CAN_CARRY
	bypasses_immunity = TRUE
	virus_heal_resistant = TRUE
	var/triggered_transformation = FALSE

/datum/disease/lycanthropy/stage_act()
	..()
	if(isvulpkanin(affected_mob))
		cure()
		return
	if(ishuman(affected_mob))
		var/mob/living/carbon/human/H = affected_mob
		switch(stage)
			if(2)
				if(prob(1))
					H.emote("sneeze")

			if(3)
				if(prob(5))
					H.emote("cough")
				else if(prob(5))
					H.emote("gasp")
				if(prob(10))
					to_chat(H, "<span class='warning'>You're starting to feel weak.</span>")

			if(4)
				if(prob(10))
					H.emote("cough")
				if(prob(5) && !H.weakened && !H.paralysis)
					to_chat(H, "<span class='warning'>You suddenly feel very weak.</span>")
					H.emote("collapse")

			if(5)
				to_chat(H, "<span class='warning'>Your body feels as if it's on fire!</span>")
				if(triggered_transformation)
					return
				if(prob(50))
					H.visible_message("<span class='danger'>[H] starts having a seizure!</B></span>")
					H.Weaken(15)
					H.Stuttering(10)
					H.Jitter(1000)
					triggered_transformation = TRUE
					addtimer(CALLBACK(src, .proc/transform, H), rand(100, 300))

/datum/disease/lycanthropy/proc/transform(mob/living/carbon/human/H) //lol
	if(H)
		H.set_species(/datum/species/vulpkanin)
		H.SetWeakened(0)
		H.SetJitter(0)
		H.SetStuttering(0)
		H.visible_message("<span class='danger'>[H] transforms into a werewolf---wait, what?</span>")
		H.emote("howl")
		cure()