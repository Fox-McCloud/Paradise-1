
#define COLOR_INPUT_DISABLED "#F0F0F0"
#define COLOR_INPUT_ENABLED "#D3B5B5"
#define COLOR_RED 			   "#FF0000"
#define COLOR_GREEN 		   "#00FF00"
#define COLOR_BLUE 			   "#0000FF"
#define COLOR_CYAN 			   "#00FFFF"
#define COLOR_PINK 			   "#FF00FF"
#define COLOR_YELLOW 		   "#FFFF00"
#define COLOR_ORANGE 		   "#FF9900"
#define COLOR_WHITE 		   "#FFFFFF"
#define COLOR_GRAY      	   "#808080"
#define COLOR_BLACK            "#000000"
#define COLOR_NAVY_BLUE        "#000080"
#define COLOR_LIGHT_GREEN      "#008000"
#define COLOR_DARK_GRAY        "#404040"
#define COLOR_MAROON           "#800000"
#define COLOR_PURPLE           "#800080"
#define COLOR_VIOLET           "#9933ff"
#define COLOR_OLIVE            "#808000"
#define COLOR_BROWN_ORANGE     "#824b28"
#define COLOR_DARK_ORANGE      "#b95a00"
#define COLOR_GRAY40           "#666666"
#define COLOR_GRAY20           "#333333"
#define COLOR_GRAY15           "#151515"
#define COLOR_SEDONA           "#cc6600"
#define COLOR_DARK_BROWN       "#917448"
#define COLOR_DEEP_SKY_BLUE    "#00e1ff"
#define COLOR_LIME             "#00ff00"
#define COLOR_TEAL             "#33cccc"
#define COLOR_PALE_PINK        "#bf89ba"
#define COLOR_YELLOW_GRAY      "#c9a344"
#define COLOR_PALE_YELLOW      "#c1bb7a"
#define COLOR_WARM_YELLOW      "#b3863c"
#define COLOR_RED_GRAY         "#aa5f61"
#define COLOR_BROWN            "#b19664"
#define COLOR_GREEN_GRAY       "#8daf6a"
#define COLOR_DARK_GREEN_GRAY  "#54654c"
#define COLOR_BLUE_GRAY        "#6a97b0"
#define COLOR_DARK_BLUE_GRAY   "#3e4855"
#define COLOR_SUN              "#ec8b2f"
#define COLOR_PURPLE_GRAY      "#a2819e"
#define COLOR_BLUE_LIGHT       "#33ccff"
#define COLOR_RED_LIGHT        "#ff3333"
#define COLOR_BEIGE            "#ceb689"
#define COLOR_BABY_BLUE        "#89cff0"
#define COLOR_PALE_GREEN_GRAY  "#aed18b"
#define COLOR_PALE_RED_GRAY    "#cc9090"
#define COLOR_PALE_PURPLE_GRAY "#bda2ba"
#define COLOR_PALE_BLUE_GRAY   "#8bbbd5"
#define COLOR_LUMINOL          "#66ffff"
#define COLOR_SILVER           "#c0c0c0"
#define COLOR_GRAY80           "#cccccc"
#define COLOR_OFF_WHITE        "#eeeeee"
#define COLOR_GOLD             "#6d6133"
#define COLOR_NT_RED           "#9d2300"
#define COLOR_BOTTLE_GREEN     "#1f6b4f"
#define COLOR_PALE_BTL_GREEN   "#57967f"
#define COLOR_GUNMETAL         "#545c68"
#define COLOR_WALL_GUNMETAL    "#353a42"
#define COLOR_STEEL            "#a8b0b2"
#define COLOR_MUZZLE_FLASH     "#ffffb2"
#define COLOR_CHESTNUT         "#996633"
#define COLOR_BEASTY_BROWN     "#663300"
#define COLOR_WHEAT            "#ffff99"
#define COLOR_CYAN_BLUE        "#3366cc"
#define COLOR_LIGHT_CYAN       "#66ccff"
#define COLOR_PAKISTAN_GREEN   "#006600"
#define COLOR_HULL             "#436b8e"
#define COLOR_AMBER            "#ffbf00"
#define COLOR_COMMAND_BLUE     "#46698c"
#define COLOR_SKY_BLUE         "#5ca1cc"
#define COLOR_PALE_ORANGE      "#b88a3b"
#define COLOR_CIVIE_GREEN      "#b7f27d"
#define COLOR_TITANIUM         "#d1e6e3"
#define COLOR_DARK_GUNMETAL    "#4c535b"
#define COLOR_BRONZE           "#8c7853"
#define COLOR_BRASS            "#b99d71"
#define COLOR_INDIGO           "#4b0082"
#define COLOR_ALUMINIUM        "#bbbbbb"
#define COLOR_CRYSTAL          "#00c8a5"
#define COLOR_ASTEROID_ROCK    "#735555"
#define COLOR_NULLGLASS        "#ff6088"
#define COLOR_DIAMOND          "#d8d4ea"

//Color defines used by the assembly detailer.
#define COLOR_ASSEMBLY_BLACK   "#545454"
#define COLOR_ASSEMBLY_BGRAY   "#9497AB"
#define COLOR_ASSEMBLY_WHITE   "#E2E2E2"
#define COLOR_ASSEMBLY_RED     "#CC4242"
#define COLOR_ASSEMBLY_ORANGE  "#E39751"
#define COLOR_ASSEMBLY_BEIGE   "#AF9366"
#define COLOR_ASSEMBLY_BROWN   "#97670E"
#define COLOR_ASSEMBLY_GOLD    "#AA9100"
#define COLOR_ASSEMBLY_YELLOW  "#CECA2B"
#define COLOR_ASSEMBLY_GURKHA  "#999875"
#define COLOR_ASSEMBLY_LGREEN  "#789876"
#define COLOR_ASSEMBLY_GREEN   "#44843C"
#define COLOR_ASSEMBLY_LBLUE   "#5D99BE"
#define COLOR_ASSEMBLY_BLUE    "#38559E"
#define COLOR_ASSEMBLY_PURPLE  "#6F6192"


/**
 * Some defines to generalise colours used in lighting.
 *
 * Important note: colors can end up significantly different from the basic html picture, especially when saturated
 */
/// As bright as it can go.
#define LIGHT_COLOR_WHITE		"#FFFFFF"
/// Warm but extremely diluted red. rgb(250, 130, 130)
#define LIGHT_COLOR_RED        "#FA8282"
/// Bright but quickly dissipating neon green. rgb(100, 200, 100)
#define LIGHT_COLOR_GREEN      "#64C864"
/// Electric green. rgb(0, 255, 0)
#define LIGHT_COLOR_ELECTRIC_GREEN      "#00FF00"
/// Cold, diluted blue. rgb(100, 150, 250)
#define LIGHT_COLOR_BLUE       "#6496FA"
/// Light blueish green. rgb(125, 225, 175)
#define LIGHT_COLOR_BLUEGREEN  "#7DE1AF"
/// Diluted cyan. rgb(125, 225, 225)
#define LIGHT_COLOR_CYAN       "#7DE1E1"
/// Electric cyan rgb(0, 255, 255)
#define LIGHT_COLOR_ELECTRIC_CYAN	"#00FFFF"
/// More-saturated cyan. rgb(16, 21, 22)
#define LIGHT_COLOR_LIGHT_CYAN "#40CEFF"
/// Saturated blue. rgb(51, 117, 248)
#define LIGHT_COLOR_DARK_BLUE  "#6496FA"
/// Diluted, mid-warmth pink. rgb(225, 125, 225)
#define LIGHT_COLOR_PINK       "#E17DE1"
/// Dimmed yellow, leaning kaki. rgb(225, 225, 125)
#define LIGHT_COLOR_YELLOW     "#E1E17D"
/// Clear brown, mostly dim. rgb(150, 100, 50)
#define LIGHT_COLOR_BROWN      "#966432"
/// Mostly pure orange. rgb(250, 150, 50)
#define LIGHT_COLOR_ORANGE     "#FA9632"
/// Light Purple. rgb(149, 44, 244)
#define LIGHT_COLOR_PURPLE     "#952CF4"
/// Less-saturated light purple. rgb(155, 81, 255)
#define LIGHT_COLOR_LAVENDER   "#9B51FF"
///slightly desaturated bright yellow.
#define LIGHT_COLOR_HOLY_MAGIC	"#FFF743"
/// deep crimson
#define LIGHT_COLOR_BLOOD_MAGIC	"#D00000"

#define LIGHT_COLOR_PURE_CYAN	"#00FFFF"

#define LIGHT_COLOR_DARKRED		"#A91515"

#define LIGHT_COLOR_PURE_RED	"#FF0000"

#define LIGHT_COLOR_DARKGREEN	"#50AB00"

#define LIGHT_COLOR_PURE_GREEN	"#00FF00"

#define LIGHT_COLOR_LIGHTBLUE	"#0099FF"

#define LIGHT_COLOR_DARKBLUE	"#315AB4"

#define LIGHT_COLOR_PURE_BLUE	"#0000FF"

#define LIGHT_COLOR_FADEDPURPLE	"#A97FAA"

/* These ones aren't a direct colour like the ones above, because nothing would fit */
/// Warm orange color, leaning strongly towards yellow. rgb(250, 160, 25)
#define LIGHT_COLOR_FIRE       "#FAA019"
/// Very warm yellow, leaning slightly towards orange. rgb(196, 138, 24)
#define LIGHT_COLOR_LAVA       "#C48A18"
/// Bright, non-saturated red. Leaning slightly towards pink for visibility. rgb(250, 100, 75)
#define LIGHT_COLOR_FLARE      "#FA644B"
/// Weird color, between yellow and green, very slimy. rgb(175, 200, 75)
#define LIGHT_COLOR_SLIME_LAMP "#AFC84B"
/// Extremely diluted yellow, close to skin color (for some reason). rgb(250, 225, 175)
#define LIGHT_COLOR_TUNGSTEN   "#FAE1AF"
/// Barely visible cyan-ish hue, as the doctor prescribed. rgb(240, 250, 250)
#define LIGHT_COLOR_HALOGEN    "#F0FAFA"

// Pipe colours
#define	PIPE_COLOR_GREY		"#ffffff"	//yes white is grey
#define	PIPE_COLOR_RED		"#ff0000"
#define	PIPE_COLOR_BLUE		"#0000ff"
#define	PIPE_COLOR_CYAN		"#00ffff"
#define	PIPE_COLOR_GREEN	"#00ff00"
#define	PIPE_COLOR_YELLOW	"#ffcc00"
#define	PIPE_COLOR_PURPLE	"#5c1ec0"
