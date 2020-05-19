/// @description Player behaviour every frame

/* -------
	INPUT
   ------- */
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_up);

/* ----------
	MOVEMENT
   ---------- */
// Calculate Movement
var move = key_right - key_left;

hsp = move * walksp; // 4, 0 or -4 pixel movement
vsp += grv; // Gravity

// Check if player is on the floor
if (place_meeting(x, y+1, obj_wall)) && key_jump {
	vsp = -7; // Jump
}

// Horizontal Collision
if (place_meeting(x+hsp, y, obj_wall)) { // predict future collision
	// For perfect collision (no pixel gap of +-4 speed)
	// while there's no collision with wall
	while(!place_meeting(x+sign(hsp), y, obj_wall)) {
		x += sign(hsp);
	}
	hsp = 0; // set horizontal speed to 0
}

// Horizontal Movement
x += hsp;


// Vertical Collision
if (place_meeting(x, y+vsp, obj_wall)) { // predict future collision
	// For perfect collision (no pixel gap of +-4 speed)
	// while there's no collision with wall
	while(!place_meeting(x, y+sign(vsp), obj_wall)) {
		y += sign(vsp);
	}
	vsp = 0; // set horizontal speed to 0
}

// Vertical Movement
y += vsp;


/* -----------
	ANIMATION
   ----------- */
// Check if player is in the air (inefficient collision check)
if (!place_meeting(x, y+1, obj_wall)) {
	sprite_index = spr_player_a;
	image_speed = 0;
	
	// if the player model is falling
	if (sign(vsp) > 0) {
		image_index = 1;
	} else {
		image_index = 0;	
	}
} else {
	image_speed = 1;
	if (hsp == 0) {
		sprite_index = spr_player;
	} else {
		sprite_index = spr_player_run;
	}
}

// Orient our animation so it faces the direction of movement
if (hsp != 0) {
	image_xscale = sign(hsp);
}