/datum/disease/infection
	form = "Infection"
	name = "MRSA"
	max_stages = 3
	stage_prob = 3
	spread_text = "The patient has an aggressive Staph infection."
	spread_flags = SPECIAL
	cure_text = "Antibiotics"
	cures = list("spaceacillin")
	cure_chance = 100
	agent = "MRSA"
	viable_mobtypes = list(/mob/living/carbon/human)
	spread_flags = NON_CONTAGIOUS
	disease_flags = CURABLE | CAN_CARRY

/datum/disease/infection/stage_act()
	..()
	switch(stage)
		if(1)
			if(prob(1) && prob(10))
				to_chat(affected_mob, "<span class='notice'>You feel better.</span>")
				cure()
				return
			if(prob(4))
				affected_mob.emote("shiver")
		if(2)
			if(prob(1) && prob(10))
				to_chat(affected_mob, "<span class='notice'>You feel better.</span>")
				cure()
				return
			if(prob(5))
				to_chat(affected_mob, "<span class='warning'>You feel feverish!</span>")
				affected_mob.bodytemperature += rand(5, 10)
				affected_mob.adjustToxLoss(1)

			if(prob(4))
				affected_mob.emote("groan")
		if(3)
			if(prob(1) && prob(10))
				to_chat(affected_mob, "<span class='notice'>You feel better.</span>")
				cure()
				return
			if(prob(7))
				affected_mob.adjustBruteLoss(1)
			if(prob(7))
				affected_mob.emote(pick("tremble", "groan", "shake"))
				to_chat(affected_mob, "<span class='warning'>You feel like you're burning up!</span>")
				affected_mob.bodytemperature += rand(10, 30)
				affected_mob.adjustFireLoss(1)
				affected_mob.adjustToxLoss(1)
			if(prob(5))
				to_chat(affected_mob, "<span class='warning'>You feel sick!</span>")
				affected_mob.AdjustConfused(5)
				affected_mob.adjustToxLoss(1)
			if(prob(3))
				affected_mob.emote(pick("faint", "groan", "shiver"))