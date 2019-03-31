/datum/disease/tissue_necrosis
	name = "Tissue Necrosis"
	max_stages = 5
	stage_prob = 5
	spread_text = "Non-Contagious"
	spread_flags = NON_CONTAGIOUS
	disease_flags = CURABLE
	cure_text = "Formaldehyde"
	cures = list("formaldehyde")
	cure_chance = 10
	agent = "rotting"
	viable_mobtypes = list(/mob/living/carbon/human)

/datum/disease/tissue_necrosis/stage_act()
	..()
	if(!ishuman(affected_mob))
		return
	if(stage > 1)
		var/mob/living/carbon/human/H = affected_mob
		if(H.decaylevel != stage - 1)
			H.decaylevel = stage - 1
			H.show_message("<span class='warning'>You feel [pick("very", "rather", "a bit", "terribly", "stinkingly")] rotten!</span>")
			if(H.decaylevel == 4)
				H.makeSkeleton()

/datum/disease/tissue_necrosis/cure()
	if(ishuman(affected_mob))
		var/mob/living/carbon/human/H = affected_mob
		H.decaylevel = 0
		H.removeSkeleton()
	..()