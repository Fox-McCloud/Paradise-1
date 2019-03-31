/datum/disease/panacea
	name = "Panacea"
	max_stages = 2
	spread_text = "Airborne"
	cure_text = "Self-Curing"
	agent = "viral curative"
	disease_flags = CURABLE | CAN_CARRY
	spread_flags = AIRBORNE
	viable_mobtypes = list(/mob/living/carbon/human)
	virus_heal_resistant = TRUE

/datum/disease/panacea/stage_act()
	..()
	if(prob(5))
		cure()
		return
	if(prob(8))
		to_chat(affected_mob, "<span class='notice'>[pick("You feel very healthy.", "All your aches and pains fade.", "You feel really good!")]</span>")
	if(prob(8))
		to_chat(affected_mob, "<span class='notice'>You feel refreshed.</span>")
		affected_mob.adjustBruteLoss(-2)
		affected_mob.adjustFireLoss(-2)
		affected_mob.adjustToxLoss(-2)
	switch(stage)
		if(2)
			if(prob(10))
				for(var/datum/disease/D in affected_mob.viruses)
					if(D.virus_heal_resistant)
						continue
					D.cure()
