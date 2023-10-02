/// @description Reset the player

if (keyboard_check_pressed(vk_escape) && room == rm_main) {
	playing = !playing;
	if (!playing) {
		instance_create_layer(camera_get_view_x(camera) + 180, camera_get_view_y(camera) + 180, "QuitButton", o_quit);
	} else {
		instance_destroy(instance_nearest(x, y, o_quit));	
	}
}

if (playing) {
	//Reset
	if (!null(player.last_flag) && keyboard_check_pressed(ord("R"))) {
		var flag = player.last_flag;
		instance_destroy(player);
		player = instance_create_layer(flag.x, flag.y, "Instances", o_player);
	}

	//Clear ending
	if (
		null(instance_nearest(x, y, o_key1)) &&
		null(instance_nearest(x, y, o_key2)) &&
		null(instance_nearest(x, y, o_key3)) &&
		null(instance_nearest(x, y, o_key4)) &&
		null(instance_nearest(x, y, o_key5))) {

		instance_destroy(big_door);
		instance_destroy(big_rock);
	}
	
	//SCreen Shake
	if (quake_timer > 0) {
		quake_timer -= 1;
	} else {
		//Play sound
		audio_play_sound(s_rumble, 0, 0, 0, 0, -3);
		screen_shake = random_range(2, 4) * room_speed;
		quake_timer = random_range(45, 120) * room_speed;
	}

	if (screen_shake > 0) {
		screen_shake -= 1;
	
		var cam_x = random_range(-6, 6);
		var cam_y = random_range(-6, 6);
	
		camera_set_view_pos(camera,
			clamp(camera_get_view_x(camera) + cam_x, 0, room_width - 180),
			clamp(camera_get_view_y(camera) + cam_y, 0, room_height - 180)
		);
	}

	//Camera follow player
	if (point_distance(camera_get_view_x(camera) + 180, camera_get_view_y(camera) + 180, player.x, player.y) > 24) {
		camera_set_view_pos(camera,
			clamp(lerp(camera_get_view_x(camera), player.x - 180, 0.5), 0, room_width - 180),
			clamp(lerp(camera_get_view_y(camera), player.y - 180, 0.5), 0, room_height - 180)
		);
	}
	
	//Lava proximity
	with (player) {
		var lava = instance_nearest(x, y, o_lava);
		var near_lava = point_distance(x, y, lava.x, lava.y) < 256;
		layer_set_visible(layer_get_id("LavaHeat"), near_lava);
		if (near_lava) {
			if (null(other.lava_sound)) {
				other.lava_sound = audio_play_sound(s_bubble, 0, true,,,-0.1);
			} else {
				if (audio_is_paused(other.lava_sound)) audio_resume_sound(other.lava_sound);
			}
		} else {
			if (!null(other.lava_sound) && audio_is_playing(other.lava_sound)) audio_pause_sound(other.lava_sound);
		}
	}
}