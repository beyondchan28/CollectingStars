extends RigidBody2D

func _init() -> void:
	self.sleeping = true

func _ready() -> void:
	self.body_entered.connect(_on_collide_with_star)

func _on_collide_with_star(star: RigidBody2D) -> void:
	print(star.name)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
