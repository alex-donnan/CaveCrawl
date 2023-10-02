/// @description Draw all joints

var head = point_direction(body.l_hip.x, body.l_hip.y, body.l_shoulder.x, body.l_shoulder.y);
var head_ldx = lengthdir_x(24, head);
var head_ldy = lengthdir_y(24, head);
draw_sprite_pos(sp_head, 0,
	body.l_shoulder.x + head_ldx, body.l_shoulder.y + head_ldy,
	body.r_shoulder.x + head_ldx, body.r_shoulder.y + head_ldy,
	body.r_shoulder.x, body.r_shoulder.y,
	body.l_shoulder.x, body.l_shoulder.y,
	1
);
	

draw_sprite_pos(sp_body, 0,
	body.l_shoulder.x, body.l_shoulder.y,
	body.r_shoulder.x, body.r_shoulder.y,
	body.r_hip.x, body.r_hip.y,
	body.l_hip.x, body.l_hip.y,
	1
);

// Left Leg
var lu_leg = point_direction(body.l_hip.x, body.l_hip.y, limb.l_knee.x, limb.l_knee.y);
var lu_leg_ldx = lengthdir_x(6, lu_leg + 90);
var lu_leg_ldy = lengthdir_y(6, lu_leg + 90);
var lu_leg_ildx = lengthdir_x(6, lu_leg + 270);
var lu_leg_ildy = lengthdir_y(6, lu_leg + 270);
draw_sprite_pos(sp_leg_upper, 0,
	body.l_hip.x + lu_leg_ildx, body.l_hip.y + lu_leg_ildy,
	body.l_hip.x + lu_leg_ldx, body.l_hip.y + lu_leg_ldy,
	limb.l_knee.x + lu_leg_ldx, limb.l_knee.y + lu_leg_ldy,
	limb.l_knee.x + lu_leg_ildx, limb.l_knee.y + lu_leg_ildy,
	1
);

var ll_leg = point_direction(limb.l_knee.x, limb.l_knee.y, limb.l_foot.x, limb.l_foot.y);
var ll_leg_ldx = lengthdir_x(4, ll_leg + 90);
var ll_leg_ldy = lengthdir_y(4, ll_leg + 90);
var ll_leg_ildx = lengthdir_x(4, ll_leg + 270);
var ll_leg_ildy = lengthdir_y(4, ll_leg + 270);
draw_sprite_pos(sp_leg_lower, 0,
	limb.l_knee.x + ll_leg_ildx, limb.l_knee.y + ll_leg_ildy,
	limb.l_knee.x + ll_leg_ldx, limb.l_knee.y + ll_leg_ldy,
	limb.l_foot.x + ll_leg_ldx, limb.l_foot.y + ll_leg_ldy,
	limb.l_foot.x + ll_leg_ildx, limb.l_foot.y + ll_leg_ildy,
	1
);

var lh_sub = limb.l_foot.lock ? 1 : 0;
var lh_scale = limb.l_foot.lock ? 1.1 : 1;
draw_sprite_ext(sp_foot, lh_sub,
	limb.l_foot.x, limb.l_foot.y,
	lh_scale, lh_scale,
	ll_leg + 90, c_white, 1);
	
//Right Arm
var ru_leg = point_direction(body.r_hip.x, body.r_hip.y, limb.r_knee.x, limb.r_knee.y);
var ru_leg_ldx = lengthdir_x(6, ru_leg + 90);
var ru_leg_ldy = lengthdir_y(6, ru_leg + 90);
var ru_leg_ildx = lengthdir_x(6, ru_leg + 270);
var ru_leg_ildy = lengthdir_y(6, ru_leg + 270);
draw_sprite_pos(sp_leg_upper, 0,
	body.r_hip.x + ru_leg_ldx, body.r_hip.y + ru_leg_ldy,
	body.r_hip.x + ru_leg_ildx, body.r_hip.y + ru_leg_ildy,
	limb.r_knee.x + ru_leg_ildx, limb.r_knee.y + ru_leg_ildy,
	limb.r_knee.x + ru_leg_ldx, limb.r_knee.y + ru_leg_ldy,
	1
);

var rl_leg = point_direction(limb.r_knee.x, limb.r_knee.y, limb.r_foot.x, limb.r_foot.y);
var rl_leg_ldx = lengthdir_x(4, rl_leg + 90);
var rl_leg_ldy = lengthdir_y(4, rl_leg + 90);
var rl_leg_ildx = lengthdir_x(4, rl_leg + 270);
var rl_leg_ildy = lengthdir_y(4, rl_leg + 270);
draw_sprite_pos(sp_leg_lower, 0,
	limb.r_knee.x + rl_leg_ldx, limb.r_knee.y + rl_leg_ldy,
	limb.r_knee.x + rl_leg_ildx, limb.r_knee.y + rl_leg_ildy,
	limb.r_foot.x + rl_leg_ildx, limb.r_foot.y + rl_leg_ildy,
	limb.r_foot.x + rl_leg_ldx, limb.r_foot.y + rl_leg_ldy,
	1
);

var rh_sub = limb.r_foot.lock ? 1 : 0;
var rh_scale = limb.r_foot.lock ? 1.1 : 1;
var rh_scale_x = angle_difference(ru_leg, rl_leg) > 25 ? -1 : 1;
draw_sprite_ext(sp_foot, rh_sub,
	limb.r_foot.x, limb.r_foot.y,
	-rh_scale * rh_scale_x, rh_scale,
	rl_leg + 90, c_white, 1);

// Left Hand
var lu_arm = point_direction(body.l_shoulder.x, body.l_shoulder.y, limb.l_elbow.x, limb.l_elbow.y);
var lu_arm_ldx = lengthdir_x(6, lu_arm + 90);
var lu_arm_ldy = lengthdir_y(6, lu_arm + 90);
var lu_arm_ildx = lengthdir_x(6, lu_arm + 270);
var lu_arm_ildy = lengthdir_y(6, lu_arm + 270);
draw_sprite_pos(sp_arm_upper, 0,
	body.l_shoulder.x + lu_arm_ildx, body.l_shoulder.y + lu_arm_ildy,
	body.l_shoulder.x + lu_arm_ldx, body.l_shoulder.y + lu_arm_ldy,
	limb.l_elbow.x + lu_arm_ldx, limb.l_elbow.y + lu_arm_ldy,
	limb.l_elbow.x + lu_arm_ildx, limb.l_elbow.y + lu_arm_ildy,
	1
);

var ll_arm = point_direction(limb.l_elbow.x, limb.l_elbow.y, limb.l_hand.x, limb.l_hand.y);
var ll_arm_ldx = lengthdir_x(4, ll_arm + 90);
var ll_arm_ldy = lengthdir_y(4, ll_arm + 90);
var ll_arm_ildx = lengthdir_x(4, ll_arm + 270);
var ll_arm_ildy = lengthdir_y(4, ll_arm + 270);
draw_sprite_pos(sp_arm_lower, 0,
	limb.l_elbow.x + ll_arm_ildx, limb.l_elbow.y + ll_arm_ildy,
	limb.l_elbow.x + ll_arm_ldx, limb.l_elbow.y + ll_arm_ldy,
	limb.l_hand.x + ll_arm_ldx, limb.l_hand.y + ll_arm_ldy,
	limb.l_hand.x + ll_arm_ildx, limb.l_hand.y + ll_arm_ildy,
	1
);

var lh_sub = limb.l_hand.lock ? 1 : 0;
var lh_scale = limb.l_hand.lock ? 1.1 : 1;
var lh_scale_x = angle_difference(lu_arm, ll_arm) < -25 ? -1 : 1;
draw_sprite_ext(sp_hand, lh_sub,
	limb.l_hand.x, limb.l_hand.y,
	lh_scale * lh_scale_x, lh_scale,
	ll_arm + 90, c_white, 1);

//Right Arm
var ru_arm = point_direction(body.r_shoulder.x, body.r_shoulder.y, limb.r_elbow.x, limb.r_elbow.y);
var ru_arm_ldx = lengthdir_x(6, ru_arm + 90);
var ru_arm_ldy = lengthdir_y(6, ru_arm + 90);
var ru_arm_ildx = lengthdir_x(6, ru_arm + 270);
var ru_arm_ildy = lengthdir_y(6, ru_arm + 270);
draw_sprite_pos(sp_arm_upper, 0,
	body.r_shoulder.x + ru_arm_ldx, body.r_shoulder.y + ru_arm_ldy,
	body.r_shoulder.x + ru_arm_ildx, body.r_shoulder.y + ru_arm_ildy,
	limb.r_elbow.x + ru_arm_ildx, limb.r_elbow.y + ru_arm_ildy,
	limb.r_elbow.x + ru_arm_ldx, limb.r_elbow.y + ru_arm_ldy,
	1
);

var rl_arm = point_direction(limb.r_elbow.x, limb.r_elbow.y, limb.r_hand.x, limb.r_hand.y);
var rl_arm_ldx = lengthdir_x(4, rl_arm + 90);
var rl_arm_ldy = lengthdir_y(4, rl_arm + 90);
var rl_arm_ildx = lengthdir_x(4, rl_arm + 270);
var rl_arm_ildy = lengthdir_y(4, rl_arm + 270);
draw_sprite_pos(sp_arm_lower, 0,
	limb.r_elbow.x + rl_arm_ldx, limb.r_elbow.y + rl_arm_ldy,
	limb.r_elbow.x + rl_arm_ildx, limb.r_elbow.y + rl_arm_ildy,
	limb.r_hand.x + rl_arm_ildx, limb.r_hand.y + rl_arm_ildy,
	limb.r_hand.x + rl_arm_ldx, limb.r_hand.y + rl_arm_ldy,
	1
);

var rh_sub = limb.r_hand.lock ? 1 : 0;
var rh_scale = limb.r_hand.lock ? 1.1 : 1;
var rh_scale_x = angle_difference(ru_arm, rl_arm) > 25 ? -1 : 1;
draw_sprite_ext(sp_hand, rh_sub,
	limb.r_hand.x, limb.r_hand.y,
	-rh_scale * rh_scale_x, rh_scale,
	rl_arm + 90, c_white, 1);