extends CollisionShape2D

func _on_exit2_body_entered(body):
	print("BEEG")
	scale = Vector2(20,100) # Replace with function body.



func _on_exit1_body_entered(body):
	scale = Vector2(20,100)
