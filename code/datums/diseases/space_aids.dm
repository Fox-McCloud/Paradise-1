/datum/disease/space_aids
	name = "Space AIDS"
	max_stages = 3
	stage_prob = 5
	spread_text = "Non-Contagious"
	spread_flags = SPECIAL
	agent = "HIV"
	cure_text = "Incurable"
	viable_mobtypes = list(/mob/living/carbon/human)
	severity = BIOHAZARD
	spread_flags = NON_CONTAGIOUS
	disease_flags = CAN_CARRY
	bypasses_immunity = TRUE
	virus_heal_resistant = TRUE

/datum/disease/space_aids/stage_act()
	..()
	switch(stage)
		if(1)
			if(prob(5))
				affected_mob.emote(pick("cough", "sneeze"))
			if (prob(8))
				to_chat(affected_mob, "<span class='warning'>[pick("You feel utterly horrible.", "You feel deathly ill.", "You feel like your body is shutting down...")]</span>")
		if(2)
			if(prob(10))
				for(var/datum/disease/D in affected_mob.viruses)
					affected_mob.adjustToxLoss(1)
			if(prob(8))
				affected_mob.emote("sneeze")
			if (prob(8))
				to_chat(affected_mob, "<span class='warning'>[pick("You feel like you're dying...", "Your innards ache horribly.")]</span>")
		if(3)
			if(prob(10))
				for(var/datum/disease/D in affected_mob.viruses)
					affected_mob.adjustToxLoss(1)
			if(prob(5))
				affected_mob.emote(pick("cough", "sneeze"))
			if(prob(8))
				to_chat(affected_mob, "<span class='warning'>[pick("It feels like you could drop dead any second...","Pain and nausea wrack your entire body.")]</span>")
			if(prob(5))
				for(var/thing in (subtypesof(/datum/disease) - /datum/disease/critical - typesof(/datum/disease/advance)))
					var/datum/disease/D = thing
					if(prob(10))
						affected_mob.ForceContractDisease(new D)