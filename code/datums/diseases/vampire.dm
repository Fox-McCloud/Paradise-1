/datum/disease/vampire
	name = "Grave Fever"
	max_stages = 3
	stage_prob = 5
	spread_text = "Non-Contagious"
	spread_flags = SPECIAL
	cure_text = "Antibiotics"
	cures = list("spaceacillin")
	agent = "Grave Dust"
	cure_chance = 100
	viable_mobtypes = list(/mob/living/carbon/human)
	severity = DANGEROUS
	disease_flags = CURABLE
	spread_flags = NON_CONTAGIOUS

/datum/disease/vampire/stage_act()
	..()
	var/toxdamage = stage * 2
	var/stuntime = stage * 2

	if(prob(10))
		affected_mob.emote(pick("cough","groan", "gasp"))
		affected_mob.AdjustLoseBreath(1)

	if(prob(15))
		if(prob(33))
			to_chat(affected_mob, "<span class='danger'>You feel sickly and weak.</span>")
			affected_mob.AdjustSlowed(3)
		affected_mob.adjustToxLoss(toxdamage)

	if(prob(5))
		to_chat(affected_mob, "<span class='danger'>Your joints ache horribly!</span>")
		affected_mob.Weaken(stuntime)
		affected_mob.Stun(stuntime)

/datum/disease/vampiritis
	name = "Draculaculiasis"
	max_stages = 3
	stage_prob = 9
	spread_text = "Non-Contagious"
	spread_flags = SPECIAL
	cure_text = "None"
	agent = "vampire serum"
	viable_mobtypes = list(/mob/living/carbon/human)
	severity = DANGEROUS
	disease_flags = CAN_CARRY
	spread_flags = NON_CONTAGIOUS

/datum/disease/vampiritis/stage_act()
	..()
	if(!ishuman(affected_mob))
		cure()
		return
	if(affected_mob.mind && affected_mob.mind.vampire)
		cure()
		return

	if(stage < max_stages)
		if(prob(5))
			affected_mob.emote(pick("shiver", "pale"))
		if(prob(8))
			to_chat(affected_mob, "<span class='warning'>You taste blood.  Gross.</span>")
		if(prob(5))
			affected_mob.emote(pick("shiver","pale","drool"))

	else
		if(!affected_mob.mind)
			return
		if(prob(40))
			to_chat(affected_mob, "<span class='warning'>Your heart stops...</span>")
			SEND_SOUND(affected_mob, 'sound/effects/singlebeat.ogg')
			affected_mob.emote("collapse")

			if(!(affected_mob.mind in ticker.mode.vampires))
				ticker.mode.vampires += affected_mob.mind
				ticker.mode.grant_vampire_powers(affected_mob)
				ticker.mode.update_vampire_icons_added(affected_mob.mind)
				var/datum/mindslaves/slaved = new()
				slaved.masters += affected_mob.mind
				affected_mob.mind.som = slaved
				affected_mob.mind.special_role = SPECIAL_ROLE_VAMPIRE
				to_chat(affected_mob, "<span class='userdanger'>Remember, if you were not an antag prior to this, you aren't one now!!</span>")
			cure()