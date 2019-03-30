/datum/disease/flu
	name = "The Flu"
	max_stages = 3
	spread_text = "Airborne"
	resist_probability = 25
	cure_text = "Sleep"
	cures = list("chickensoup")
	cure_chance = 10
	agent = "green mucus"
	viable_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/human/monkey)
	permeability_mod = 0.75
	desc = "If left untreated the subject will feel quite unwell."
	severity = MEDIUM

/datum/disease/flu/stage_act()
	..()
	if(affected_mob.sleeping && prob(33))
		to_chat(affected_mob, "<span class='notice'>You feel better.</span>")
		cure()
		return
	switch(stage)
		if(2)
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, "<span class='danger'>Your muscles ache.</span>")
				if(prob(20))
					affected_mob.take_organ_damage(1)
			if(prob(1))
				to_chat(affected_mob, "<span class='danger'>Your stomach hurts.</span>")
				if(prob(20))
					affected_mob.adjustToxLoss(1)

		if(3)
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, "<span class='danger'>Your muscles ache.</span>")
				if(prob(20))
					affected_mob.take_organ_damage(1)
			if(prob(1))
				to_chat(affected_mob, "<span class='danger'>Your stomach hurts.</span>")
				if(prob(20))
					affected_mob.adjustToxLoss(1)