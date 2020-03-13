
/*
  PLANE MASTERS
*/

/obj/screen/plane_master
	screen_loc = "CENTER"
	icon_state = "blank"
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	blend_mode = BLEND_OVERLAY
	var/show_alpha = 255
	var/hide_alpha = 0

/obj/screen/plane_master/ghost_master
	plane = OBSERVER_PLANE

/obj/screen/plane_master/ghost_dummy
	// this avoids a bug which means plane masters which have nothing to control get angry and mess with the other plane masters out of spite
	alpha = 0
	appearance_flags = 0
	plane = OBSERVER_PLANE

GLOBAL_LIST_INIT(ghost_master, list(
	new /obj/screen/plane_master/ghost_master(),
	new /obj/screen/plane_master/ghost_dummy()
))


//Why do plane masters need a backdrop sometimes? Read https://secure.byond.com/forum/?post=2141928
//Trust me, you need one. Period. If you don't think you do, you're doing something extremely wrong.
/obj/screen/plane_master/proc/backdrop(mob/mymob)

///Things rendered on "openspace"; holes in multi-z
/obj/screen/plane_master/openspace
	name = "open space plane master"
	plane = OPENTURF_MAX_PLANE
	layer = 10
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_MULTIPLY
	alpha = 255

/obj/screen/plane_master/openspace/backdrop(mob/mymob)
	to_world("Calling backdrop and setting our filters")
	var/image/over_OS_darkness = image('icons/turf/open_space.dmi', "black_open")
	over_OS_darkness.plane = OPENTURF_MAX_PLANE
	over_OS_darkness.layer = OPENSPACE_LAYER 
	over_OS_darkness.filters += filter(type="blur", 1)
	overlays += over_OS_darkness
	/*
	filters += filter(type = "drop_shadow", color = "#04080FAA", size = -10)
	filters += filter(type = "drop_shadow", color = "#04080FAA", size = -15)
	filters += filter(type = "drop_shadow", color = "#04080FAA", size = -20)
	*/


/obj/screen/plane_master/proc/outline(_size, _color)
	filters += filter(type = "outline", size = _size, color = _color)

/obj/screen/plane_master/proc/shadow(_size, _border, _offset = 0, _x = 0, _y = 0, _color = "#04080FAA")
	filters += filter(type = "drop_shadow", x = _x, y = _y, color = _color, size = _size, offset = _offset)

/obj/screen/plane_master/proc/clear_filters()
	filters = list()
