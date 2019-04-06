SUBSYSTEM_DEF(generator)
	name = "Generator"
	init_order = INIT_ORDER_GENERATOR
	wait = 33
	flags = SS_KEEP_TIMING

	var/list/generator_machinery = list()
	var/list/currentrun = list()

/datum/controller/subsystem/generator/stat_entry()
	..("Generators: [generator_machinery.len]")

/datum/controller/subsystem/generator/fire(resumed = 0)
	if(!resumed)
		src.currentrun = generator_machinery.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/obj/machinery/power/generator/G = currentrun[currentrun.len]
		currentrun.len--
		if(G)
			G.process_generator()
		else
			generator_machinery -= G
		if(MC_TICK_CHECK)
			return