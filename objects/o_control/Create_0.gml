/// @description Lighting and menu

player = instance_create_layer(x, y, "Instances", o_player);

big_door = instance_nearest(x, y, o_door);
big_rock = instance_nearest(x, y, o_rock_cover);

camera = view_camera[0];

screen_shake = -1;
quake_timer = 180 * room_speed;

playing = true;

lava_sound = noone;