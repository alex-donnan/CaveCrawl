/// @description Initialize limbs


last_flag = noone;
selected = noone;
mass_x = 0;
mass_y = 0;
locks = 0;
standing = false;
burnt = false;

Joint = function(_name = "Joint", _player, _x, _y, _grab = false) constructor {
	name = _name;
	player = _player;
	parent_arr = [];
	parent_len = [];
	child_arr = [];
	child_len = [];
	x = _x;
	y = _y;
	vx = 0;
	vy = 0;
	grab = _grab;
	hover = false;
	
	lock = false;
	mouse_follow = false;

	special_update = function() {} ;
	
	function draw() {
		draw_set_color(c_white);
		array_foreach(
			parent_arr,
			function(_el) {
				draw_line(x, y, _el.x, _el.y);
			}
		);
		
		array_foreach(
			child_arr,
			function(_el) {
				draw_line(x, y, _el.x, _el.y);
			}
		);
		
		if (mouse_follow) draw_circle(x, y, 4, true);
		if (lock) {
			draw_set_color(c_red);
			draw_circle(x, y, 4, true);
		}
	}
	
	function add_parent(_joint, _len) {
		if (!array_contains(parent_arr, _joint)) {
			array_push(parent_arr, _joint);
			array_push(parent_len, _len);
		}
		_joint.add_child(self, _len);
		return self;
	}
	
	function remove_parent(_joint) {
		var ind = array_get_index(parent_arr, _joint);
		if (ind >= 0) {
			array_delete(parent_arr, ind, 1);
			array_delete(parent_len, ind, 1);
		}
		return self;		
	}
	
	function add_child(_joint, _len) {
		if (!array_contains(child_arr, _joint)) {
			array_push(child_arr, _joint);
			array_push(child_len, _len);
		}
		return self;
	}
	
	function remove_child(_joint) {
		var ind = array_get_index(child_arr, _joint);
		if (ind >= 0) {
			array_delete(child_arr, ind, 1);
			array_delete(child_len, ind, 1);
		}
		return self;		
	}
	
	function update() {	
		vy += (hover || mouse_follow || lock) ? 0 : 1;	
		
		if (grab && !player.burnt) {
			mouse_follow = (!mouse_follow) ?
				(
					null(player.selected) &&
					device_mouse_check_button(0, mb_left) &&
					point_distance(device_mouse_x(0), device_mouse_y(0), x, y) <= 6
				) : mouse_follow;
			
			if (mouse_follow) {
				player.selected = self;
				
				lock = false;
				var dir = point_direction(x, y, device_mouse_x(0), device_mouse_y(0));
				var dist = point_distance(x, y, device_mouse_x(0), device_mouse_y(0));
				vx += lengthdir_x(min(dist, 8), dir);
				vy += lengthdir_y(min(dist, 8), dir);
				
				if (device_mouse_check_button_released(0, mb_left)) {
					player.selected = noone;
					
					lock = (collision_circle(x + vx, y + vy, 4, o_solid, 0, true) && !collision_circle(x + vx, y + vy, 2, o_solid_slope, 0, true));
					mouse_follow = false;
					
					if (lock) {
						audio_play_sound(s_grab, 0, false,,,random_range(-0.1,0.1),);	
					}
				}
			}
		}
		
		if (!player.burnt) special_update();
				
		array_foreach(
			child_arr,
			function (_el, _ind) {				
				var dist = point_distance(x + vx, y + vy, _el.x + _el.vx, _el.y + _el.vy);
				var dir = point_direction(_el.x + _el.vx, _el.y + _el.vy, x + vx, y + vy);
				if (dist != child_len[_ind]) {
					var new_dist = dist - child_len[_ind];
					if (!_el.lock && !lock) {
						_el.vx += lengthdir_x(new_dist * 0.5, dir);
						_el.vy += lengthdir_y(new_dist * 0.5, dir);
						vx += lengthdir_x(new_dist * 0.5, dir + 180);
						vy += lengthdir_y(new_dist * 0.5, dir + 180);
					} else if (_el.lock && !lock) {
						vx += lengthdir_x(new_dist, dir + 180);
						vy += lengthdir_y(new_dist, dir + 180);
					} else if (!_el.lock && lock) {
						_el.vx += lengthdir_x(new_dist, dir);
						_el.vy += lengthdir_y(new_dist, dir);
					} else {
						lock = false;
						_el.lock = false;
					}
				}
			}
		);
		
		if (collision_point(x + vx, y + vy, o_solid, 1, true) || collision_point(x + vx, y + vy, o_solid_slope, 1, true)) {
			var dir = point_direction(x + vx, y + vy, x, y);
			while (collision_point(x + vx, y + vy, o_solid, 1, true) || collision_point(x + vx, y + vy, o_solid_slope, 1, true)) {
				vx += lengthdir_x(0.1, dir);
				vy += lengthdir_y(0.1, dir);
			}
		}
		
		// Important collisions
		if (collision_point(x + vx, y + vy, o_lava, 1, true)) {
			player.burnt = true;
		}
		
		hover = collision_point(x + vx, y + vy, o_hover, 1, true);
		
		if (collision_point(x + vx, y + vy, o_key, 1, true)) {
			instance_destroy(collision_point(x + vx, y + vy, o_key, 1, true));
		}
		
		if (lock) {
			vx = 0;
			vy = 0;
		}
		
		x += vx;
		y += vy;
		
		vx *= 0.9;
		vy *= 0.9;
	}
}

body = {
	l_shoulder	: new Joint("Left Shoulder", self, x - 12, y - 12,),
	r_shoulder	: new Joint("Right Shoulder", self, x + 12, y - 12,),
	l_hip		: new Joint("Left Hip", self, x - 12, y + 12,),
	r_hip		: new Joint("Right Hip", self, x + 12, y + 12,),
}

limb = {
	l_elbow		: new Joint("Left Elbow", self, x - 16, y - 16,),
	l_hand		: new Joint("Left Hand", self, x - 32, y - 16, true),
	r_elbow		: new Joint("Right Elbow", self, x + 16, y - 16,),
	r_hand		: new Joint("Right Hand", self, x + 32, y - 16, true),
	l_knee		: new Joint("Left Knee", self, x - 16, y + 16,),
	l_foot		: new Joint("Left Foot", self, x - 16, y + 32, true),
	r_knee		: new Joint("Right Knee", self, x + 16, y + 16,),
	r_foot		: new Joint("Right Foot", self, x + 16, y + 32, true),
}

body.l_shoulder
	.add_parent(body.r_shoulder, 24)
	.add_parent(body.l_hip, 48)
	.add_parent(body.r_hip, 57.6);
limb.l_elbow.add_parent(body.l_shoulder, 24);
limb.l_hand.add_parent(limb.l_elbow, 24);

body.r_shoulder
	.add_parent(body.l_shoulder, 24)
	.add_parent(body.l_hip, 57.6)
	.add_parent(body.r_hip, 48);
limb.r_elbow.add_parent(body.r_shoulder, 24);
limb.r_hand.add_parent(limb.r_elbow, 24);

body.l_hip
	.add_parent(body.l_shoulder, 48)
	.add_parent(body.r_shoulder, 57.6)
	.add_parent(body.r_hip, 24);
limb.l_knee.add_parent(body.l_hip, 24);
limb.l_foot.add_parent(limb.l_knee, 24);

body.r_hip
	.add_parent(body.l_shoulder, 57.6)
	.add_parent(body.r_shoulder, 48)
	.add_parent(body.l_hip, 24);
limb.r_knee.add_parent(body.r_hip, 24);
limb.r_foot.add_parent(limb.r_knee, 24);

//Special updates

function limb_update() {
	//A foot? Standing check
	if (string_ends_with(name, "Foot")) {
		if (collision_point(x + vx, y + vy, o_stand, 1, true) && collision_point(x + vx, y + vy + 1, o_solid, 1, true)) {
			lock = true;
		}
	}
	
	//Falling check
	if (mouse_follow && !player.standing) {
		with (player) {
			switch (locks) {
				case 1:
					if (limb.l_foot.lock || limb.r_foot.lock) {
						limb.l_hand.mouse_follow = false;
						limb.r_hand.mouse_follow = false;
						
						limb.l_foot.mouse_follow = false;
						limb.l_foot.lock = false;
						limb.r_foot.mouse_follow = false;
						limb.r_foot.lock = false;
						
						selected = noone;
					}
					break;
				case 2:
					if (limb.l_foot.lock && limb.r_foot.lock) {
						limb.l_hand.mouse_follow = false;
						limb.r_hand.mouse_follow = false;
						
						limb.l_foot.mouse_follow = false;
						limb.l_foot.lock = false;
						limb.r_foot.mouse_follow = false;
						limb.r_foot.lock = false;
						
						selected = noone;
					}
					break;
				default:
					break;
			}
		}
	}
}

limb.l_hand.special_update = limb_update;
limb.r_hand.special_update = limb_update;
limb.l_foot.special_update = limb_update;
limb.r_foot.special_update = limb_update;
