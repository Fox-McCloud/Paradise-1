/obj/item/storage/toolbox
	name = "toolbox"
	desc = "Danger. Very robust."
	icon = 'icons/obj/storage.dmi'
	icon_state = "red"
	item_state = "toolbox_red"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	flags = CONDUCT
	force = 10
	throwforce = 10
	throw_speed = 2
	throw_range = 7
	w_class = WEIGHT_CLASS_BULKY
	materials = list(MAT_METAL = 500)
	origin_tech = "combat=1;engineering=1"
	attack_verb = list("robusted")
	hitsound = 'sound/weapons/smash.ogg'
	drop_sound = 'sound/items/handling/toolbox_drop.ogg'
	pickup_sound =  'sound/items/handling/toolbox_pickup.ogg'

/obj/item/storage/toolbox/emergency
	name = "emergency toolbox"
	icon_state = "red"
	item_state = "toolbox_red"

/obj/item/storage/toolbox/emergency/populate_contents()
	new /obj/item/crowbar/red(src)
	new /obj/item/weldingtool/mini(src)
	new /obj/item/extinguisher/mini(src)
	if(prob(50))
		new /obj/item/flashlight(src)
	else
		new /obj/item/flashlight/flare(src)
	new /obj/item/radio(src)

/obj/item/storage/toolbox/emergency/old
	name = "rusty red toolbox"
	icon_state = "toolbox_red_old"

/obj/item/storage/toolbox/mechanical
	name = "mechanical toolbox"
	icon_state = "blue"
	item_state = "toolbox_blue"

/obj/item/storage/toolbox/mechanical/populate_contents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/analyzer(src)
	new /obj/item/wirecutters(src)

/obj/item/storage/toolbox/mechanical/greytide
	flags = NODROP

/obj/item/storage/toolbox/mechanical/old
	name = "rusty blue toolbox"
	icon_state = "toolbox_blue_old"

/obj/item/storage/toolbox/electrical
	name = "electrical toolbox"
	icon_state = "yellow"
	item_state = "toolbox_yellow"

/obj/item/storage/toolbox/electrical/populate_contents()
	var/pickedcolor = pick(COLOR_RED, COLOR_YELLOW, COLOR_GREEN, COLOR_BLUE, COLOR_PINK, COLOR_ORANGE, COLOR_CYAN, COLOR_WHITE)
	new /obj/item/screwdriver(src)
	new /obj/item/wirecutters(src)
	new /obj/item/t_scanner(src)
	new /obj/item/crowbar(src)
	new /obj/item/stack/cable_coil(src, 30, paramcolor = pickedcolor)
	new /obj/item/stack/cable_coil(src, 30, paramcolor = pickedcolor)
	if(prob(5))
		new /obj/item/clothing/gloves/color/yellow(src)
	else
		new /obj/item/stack/cable_coil(src, 30, paramcolor = pickedcolor)

/obj/item/storage/toolbox/syndicate
	name = "suspicious looking toolbox"
	icon_state = "syndicate"
	item_state = "toolbox_syndi"
	origin_tech = "combat=2;syndicate=1;engineering=2"
	silent = TRUE
	force = 15
	throwforce = 18

/obj/item/storage/toolbox/syndicate/populate_contents()
	new /obj/item/screwdriver(src, "red")
	new /obj/item/wrench(src)
	new /obj/item/weldingtool/largetank(src)
	new /obj/item/crowbar/red(src)
	new /obj/item/wirecutters(src, "red")
	new /obj/item/multitool(src)
	new /obj/item/clothing/gloves/combat(src)

/obj/item/storage/toolbox/fakesyndi
	name = "suspicous looking toolbox"
	icon_state = "syndicate"
	item_state = "toolbox_syndi"
	desc = "Danger. Very Robust. The paint is still wet."

/obj/item/storage/toolbox/drone
	name = "mechanical toolbox"
	icon_state = "blue"
	item_state = "toolbox_blue"

/obj/item/storage/toolbox/drone/populate_contents()
	var/pickedcolor = pick(pick(COLOR_RED, COLOR_YELLOW, COLOR_GREEN, COLOR_BLUE, COLOR_PINK, COLOR_ORANGE, COLOR_CYAN, COLOR_WHITE))
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/stack/cable_coil(src, 30, paramcolor = pickedcolor)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)

/obj/item/storage/toolbox/artistic
	name = "artistic toolbox"
	desc = "A toolbox painted bright green. Why anyone would store art supplies in a toolbox is beyond you, but it has plenty of extra space."
	icon_state = "green"
	item_state = "artistic_toolbox"
	w_class = WEIGHT_CLASS_GIGANTIC //Holds more than a regular toolbox!
	max_combined_w_class = 20
	storage_slots = 10

/obj/item/storage/toolbox/artistic/populate_contents()
	new /obj/item/storage/fancy/crayons(src)
	new /obj/item/crowbar(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/stack/cable_coil/yellow(src)
	new /obj/item/stack/cable_coil/blue(src)
	new /obj/item/stack/cable_coil/green(src)
	new /obj/item/stack/cable_coil/pink(src)
	new /obj/item/stack/cable_coil/orange(src)
	new /obj/item/stack/cable_coil/cyan(src)
	new /obj/item/stack/cable_coil/white(src)

/obj/item/storage/toolbox/brass
	name = "brass box"
	desc = "A huge brass box with several indentations in its surface."
	icon_state = "brassbox"
	item_state = null
	resistance_flags = FIRE_PROOF | ACID_PROOF
	w_class = WEIGHT_CLASS_HUGE
	max_w_class = WEIGHT_CLASS_NORMAL
	max_combined_w_class = 28
	storage_slots = 28
	attack_verb = list("robusted", "crushed", "smashed")

/obj/item/storage/toolbox/brass/prefilled/populate_contents()
	new /obj/item/screwdriver/brass(src)
	new /obj/item/wirecutters/brass(src)
	new /obj/item/wrench/brass(src)
	new /obj/item/crowbar/brass(src)
	new /obj/item/weldingtool/experimental/brass(src)
