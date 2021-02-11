// String identifiers for associative list lookup


#define CHECK_DNA_AND_SPECIES(C) if((!(C.dna)) || (!(C.dna.species))) return

#define MUTCHK_FORCED        1

// mob/var/list/mutations

// Used in preferences.
#define DISABILITY_FLAG_NEARSIGHTED 1
#define DISABILITY_FLAG_FAT         2
#define DISABILITY_FLAG_BLIND       4
#define DISABILITY_FLAG_MUTE        8
#define DISABILITY_FLAG_COLOURBLIND 16
#define DISABILITY_FLAG_WINGDINGS   32
#define DISABILITY_FLAG_NERVOUS     64
#define DISABILITY_FLAG_SWEDISH     128
#define DISABILITY_FLAG_LISP        256
#define DISABILITY_FLAG_DIZZY       512
#define DISABILITY_FLAG_CHAV        1024
#define DISABILITY_FLAG_DEAF        2048

///////////////////////////////////////
// MUTATIONS
///////////////////////////////////////

// Generic mutations:
#define CLUMSY			"clumsy"

//Nutrition levels for humans. No idea where else to put it
#define NUTRITION_LEVEL_FAT 600
#define NUTRITION_LEVEL_FULL 550
#define NUTRITION_LEVEL_WELL_FED 450
#define NUTRITION_LEVEL_FED 350
#define NUTRITION_LEVEL_HUNGRY 250
#define NUTRITION_LEVEL_STARVING 150
#define NUTRITION_LEVEL_HYPOGLYCEMIA 100
#define NUTRITION_LEVEL_CURSED 0

//Used as an upper limit for species that continuously gain nutriment
#define NUTRITION_LEVEL_ALMOST_FULL 535

//Blood levels
#define BLOOD_VOLUME_MAXIMUM		2000
#define BLOOD_VOLUME_NORMAL			560
#define BLOOD_VOLUME_SAFE			501
#define BLOOD_VOLUME_OKAY			336
#define BLOOD_VOLUME_BAD			224
#define BLOOD_VOLUME_SURVIVE		122

//Sizes of mobs, used by mob/living/var/mob_size
#define MOB_SIZE_TINY 0
#define MOB_SIZE_SMALL 1
#define MOB_SIZE_HUMAN 2
#define MOB_SIZE_LARGE 3

//Ventcrawling defines
#define VENTCRAWLER_NONE   0
#define VENTCRAWLER_NUDE   1
#define VENTCRAWLER_ALWAYS 2

//Used for calculations for negative effects of having genetics powers
#define DEFAULT_GENE_STABILITY 100
#define GENE_INSTABILITY_MINOR 5
#define GENE_INSTABILITY_MODERATE 10
#define GENE_INSTABILITY_MAJOR 15

#define GENETIC_DAMAGE_STAGE_1 80
#define GENETIC_DAMAGE_STAGE_2 65
#define GENETIC_DAMAGE_STAGE_3 35

#define CLONER_FRESH_CLONE "fresh"
#define CLONER_MATURE_CLONE "mature"

//Species traits.

#define IS_WHITELISTED 	"whitelisted"
#define LIPS			"lips"
#define NO_BLOOD		"no_blood"
#define NO_DNA			"no_dna"
#define NO_SCAN 		"no_scan"
#define NO_PAIN 		"no_pain"
#define IS_PLANT 		"is_plant"
#define NO_INTORGANS	"no_internal_organs"
#define RADIMMUNE		"rad_immunity"
#define NOTRANSSTING	"no_trans_sting"
#define VIRUSIMMUNE		"virus_immunity"
#define NOCRITDAMAGE	"no_crit"
#define NO_EXAMINE		"no_examine"
#define CAN_WINGDINGS	"can_wingdings"
#define NO_GERMS		"no_germs"
#define NO_DECAY		"no_decay"
#define PIERCEIMMUNE	"pierce_immunity"
#define NO_HUNGER		"no_hunger"
#define EXOTIC_COLOR	"exotic_blood_colour"
#define NO_OBESITY		"no_obesity"
