/// @description Call update on limbs

if (o_control.playing) {

	//Flag
	var flag = instance_nearest(x, y, o_flag);
	if (!null(flag) && distance_to_object(flag) < 64) {
		last_flag = flag;	
	}

	//Standing
	standing = (
		(collision_point(limb.l_foot.x, limb.l_foot.y, o_stand, 1, true) && limb.l_foot.lock) ||
		(collision_point(limb.r_foot.x, limb.r_foot.y, o_stand, 1, true) && limb.r_foot.lock)
	);

	if (standing && !burnt) {
		body.l_shoulder.vy -= 8;
		body.r_shoulder.vy -= 8;
	}

	//Center of mass
	var mass_count = 2;
	mass_x = body.l_shoulder.x;
	mass_x += body.r_hip.x;
	mass_y = body.l_shoulder.y;
	mass_y += body.r_hip.y;

	locks = 0;

	if (limb.l_hand.lock) {
		locks += 1;
		mass_count += 1;
		mass_x += limb.l_hand.x;
		mass_y += limb.l_hand.y;
	}
	if (limb.r_hand.lock) {
		locks += 1;
		mass_count += 1;
		mass_x += limb.r_hand.x;
		mass_y += limb.r_hand.y;
	}
	if (limb.l_foot.lock) {
		locks += 1;
		mass_count += 1;
		mass_x += limb.l_foot.x;
		mass_y += limb.l_foot.y;
	}
	if (limb.r_foot.lock) {
		locks += 1;
		mass_count += 1;
		mass_x += limb.r_foot.x;
		mass_y += limb.r_foot.y;
	}

	mass_x /= mass_count;
	mass_y /= mass_count;

	x = lerp(x, mass_x, 0.5);
	y = lerp(y, mass_y, 0.5);

	//Updates
	body.l_shoulder.update();
	body.r_shoulder.update();
	body.l_hip.update();
	body.r_hip.update();

	limb.l_elbow.update();
	limb.l_hand.update();
	limb.r_elbow.update();
	limb.r_hand.update();
	limb.l_knee.update();
	limb.l_foot.update();
	limb.r_knee.update();
	limb.r_foot.update();
}