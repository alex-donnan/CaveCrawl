/// @description Insert description here
// You can write your code in this editor

if (wait <= 0) {
	var sub = collision_point(device_mouse_x(0), device_mouse_y(0), self, 0, false) ? 1 : 0
	draw_sprite_ext(sp_continue, sub, x, y, 1, 1, 0, c_white, 1);
}