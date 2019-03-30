/datum/reagent/disease
	name = "disease"
	id = "disease"
	description = "the true disease to end all diseases: no disease."
	var/infection_volume = 4.5
	var/disease = null

/datum/reagent/disease/on_mob_life(mob/living/carbon/M)
	if(volume > infection_volume)
		if(disease)
			M.ForceContractDisease(new disease(0))
	return ..()

/datum/reagent/disease/mucus
	name = "mucus"
	id = "mucus"
	description = "The stuff that comes from your throat."
	reagent_state = LIQUID
	color = "#F5FFF5"
	infection_volume = 0
	disease = /datum/disease/cold

/datum/reagent/disease/green_mucus
	name = "green Mucus"
	id = "green mucus"
	description = "Mucus. Thats green."
	reagent_state = LIQUID
	color = "#D7FFD7"
	infection_volume = 0
	disease = /datum/disease/flu

/datum/reagent/disease/stringy_gibbis
	name = "stringy gibbis"
	id = "stringy gibbis"
	description = "Liquid gibbis that is very stringy."
	reagent_state = LIQUID
	color = "#FF0000"
	disease = /datum/disease/fake_gbs

/datum/reagent/disease/nanomachines
	name = "Nanomachines"
	id = "nanomachines"
	description = "Microscopic construction robots."
	color = "#535E66" // rgb: 83, 94, 102
	can_synth = FALSE
	infection_volume = 1.5
	disease = /datum/disease/transformation/robot

/datum/reagent/disease/liquid_spacetime // Teleportitis
	name = "liquid spacetime"
	id = "liquid_spacetime"
	description = "A drop of liquid spacetime."
	reagent_state = LIQUID
	color = "#000000"
	disease = /datum/disease/teleportitis

/datum/reagent/disease/xenomicrobes
	name = "Xenomicrobes"
	id = "xenomicrobes"
	description = "Microbes with an entirely alien cellular structure."
	color = "#535E66" // rgb: 83, 94, 102
	can_synth = FALSE
	infection_volume = 1.5
	disease = /datum/disease/transformation/xeno

/datum/reagent/disease/ecoli
	name = "e.coli bacteria"
	id = "e.coli"
	description = "A nasty bacteria found in contaminated food and biological waste products."
	reagent_state = LIQUID
	infection_volume = 0
	color = "#1E4600"
	disease = /datum/disease/food_poisoning

/datum/reagent/disease/mrsa // for infected wounds
	name = "MRSA"
	id = "mrsa"
	description = "A virulent bacteria that often strikes dirty hospitals."
	reagent_state = LIQUID
	color = "#1E4600"
	disease = /datum/disease/infection

/datum/reagent/disease/viral_curative
	name = "viral curative"
	id = "viral_curative"
	description = "A virus that feeds on other virii and bacteria."
	reagent_state = LIQUID
	infection_volume = 0
	color = "#000000"
	disease = /datum/disease/panacaea

/datum/reagent/disease/hiv
	name = "HIV"
	id = "HIV"
	description = "Human Immunodeficiency Virus. Extremely deadly."
	reagent_state = LIQUID
	fluid_r = 255
	fluid_g = 40
	fluid_b = 40
	disease = /datum/disease/space_aids

/datum/reagent/disease/fungalspores
	name = "Tubercle bacillus Cosmosis microbes"
	id = "fungalspores"
	description = "Active fungal spores."
	color = "#92D17D" // rgb: 146, 209, 125
	can_synth = FALSE
	infection_volume = 2.5
	disease = /datum/disease/tuberculosis

/datum/reagent/disease/jagged_crystals
	name = "Jagged Crystals"
	id = "jagged_crystals"
	description = "Rapid chemical decomposition has warped these crystals into twisted spikes."
	reagent_state = SOLID
	color = "#FA0000" // rgb: 250, 0, 0
	can_synth = FALSE
	infection_volume = 0
	disease = /datum/disease/berserker

/datum/reagent/disease/salmonella
	name = "Salmonella"
	id = "salmonella"
	description = "A nasty bacteria found in spoiled food."
	reagent_state = LIQUID
	color = "#1E4600"
	can_synth = FALSE
	infection_volume = 0
	disease = /datum/disease/food_poisoning

/datum/reagent/disease/gibbis
	name = "Gibbis"
	id = "gibbis"
	description = "Liquid gibbis."
	reagent_state = LIQUID
	color = "#FF0000"
	can_synth = FALSE
	infection_volume = 2.5
	disease = /datum/disease/gbs/curable

/datum/reagent/disease/prions
	name = "Prions"
	id = "prions"
	description = "A disease-causing agent that is neither bacterial nor fungal nor viral and contains no genetic material."
	reagent_state = LIQUID
	color = "#FFFFFF"
	can_synth = FALSE
	disease = /datum/disease/kuru

/datum/reagent/disease/grave_dust
	name = "Grave Dust"
	id = "grave_dust"
	description = "Moldy old dust taken from a grave site."
	reagent_state = LIQUID
	color = "#465046"
	can_synth = FALSE
	disease = /datum/disease/vampire

/datum/reagent/disease/bacon_grease
	name = "pure bacon grease"
	id = "bacon_grease"
	description = "Hook me up to an IV of that sweet, sweet stuff!"
	reagent_state = LIQUID
	color = "#F7E6B1"
	can_synth = FALSE
	disease = /datum/disease/critical/heart_failure

/datum/reagent/spider_eggs
	name = "spider eggs"
	id = "spidereggs"
	description = "A fine dust containing spider eggs. Oh gosh."
	reagent_state = SOLID
	color = "#FFFFFF"
	can_synth = FALSE

/datum/reagent/spider_eggs/on_mob_life(mob/living/M)
	if(volume > 2.5)
		if(iscarbon(M))
			if(!M.get_int_organ(/obj/item/organ/internal/body_egg))
				new/obj/item/organ/internal/body_egg/spider_eggs(M) //Yes, even Xenos can fall victim to the plague that is spider infestation.
	return ..()

/datum/reagent/heartworms
	name = "Space heartworms"
	id = "heartworms"
	description = "Aww, gross! These things can't be good for your heart. They're gunna eat it!"
	reagent_state = SOLID
	color = "#925D6C"
	can_synth = FALSE

/datum/reagent/heartworms/on_mob_life(mob/living/carbon/M)
	if(volume > 4.5)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			var/obj/item/organ/internal/heart/ate_heart = H.get_int_organ(/obj/item/organ/internal/heart)
			if(ate_heart)
				ate_heart.remove(H)
				qdel(ate_heart)
	return ..()

/datum/reagent/concentrated_initro
	name = "Concentrated Initropidril"
	id = "concentrated_initro"
	description = "A guaranteed heart-stopper!"
	reagent_state = LIQUID
	color = "#AB1CCF"
	can_synth = FALSE

/datum/reagent/concentrated_initro/on_mob_life(mob/living/M)
	if(volume >= 5)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(!H.undergoing_cardiac_arrest())
				H.set_heartattack(TRUE) // rip in pepperoni
	return ..()

//virus foods

/datum/reagent/consumable/virus_food
	name = "Virus Food"
	id = "virusfood"
	description = "A mixture of water, milk, and oxygen. Virus cells can use this mixture to reproduce."
	reagent_state = LIQUID
	nutriment_factor = 2 * REAGENTS_METABOLISM
	color = "#899613" // rgb: 137, 150, 19

/datum/reagent/mutagen/mutagenvirusfood
	name = "mutagenic agar"
	id = "mutagenvirusfood"
	description = "mutates blood"
	color = "#A3C00F" // rgb: 163,192,15

/datum/reagent/mutagen/mutagenvirusfood/sugar
	name = "sucrose agar"
	id = "sugarvirusfood"
	color = "#41B0C0" // rgb: 65,176,192

/datum/reagent/medicine/diphenhydramine/diphenhydraminevirusfood
	name = "virus rations"
	id = "diphenhydraminevirusfood"
	description = "mutates blood"
	color = "#D18AA5" // rgb: 209,138,165

/datum/reagent/plasma_dust/plasmavirusfood
	name = "virus plasma"
	id = "plasmavirusfood"
	description = "mutates blood"
	color = "#A69DA9" // rgb: 166,157,169

/datum/reagent/plasma_dust/plasmavirusfood/weak
	name = "weakened virus plasma"
	id = "weakplasmavirusfood"
	color = "#CEC3C6" // rgb: 206,195,198
