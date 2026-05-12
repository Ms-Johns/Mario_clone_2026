extends AnimatedSprite2D

func trigger_animation(velocity: Vector2, direction: int):
	
	# jumps
	if not get_parent().is_on_floor():
		play("jump")
	
	# slide
	elif sign(velocity.x) != sign(direction) and velocity.x != 0 and direction != 0:
		play("slide")
		scale.x = direction
	
	# run
	else:
		# handle direction
		if scale.x != sign(velocity.x) and velocity.x != 0:
			scale.x = sign(velocity.x)
		
		if velocity.x != 0:
			play("run")
		
		# idle
		else:
			play("idle")
