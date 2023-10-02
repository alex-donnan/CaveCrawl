/// @description Insert description here
// You can write your code in this editor

var sub = collision_point(device_mouse_x(0), device_mouse_y(0), self, 0, false) ? 1 : 0
draw_sprite_ext(sp_start, sub, x, y, 2, 2, 0, c_white, 1);