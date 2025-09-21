class_name StarButton extends TextureButton

@onready var _stars_parent: Node2D = $"../../../../StarsParent"

@export var _star_amount := 0 # how many star this button contain
@export var _star_type := Star.StarType.RED

const _star := preload("res://Scenes/star.tscn")

func _ready() -> void:
	$AmountLabel.text = str(_star_amount)
	match _star_type:
		Star.StarType.RED:
			$TypeLabel.text = "RED"
		Star.StarType.GREEN:
			$TypeLabel.text = "RED"
		Star.StarType.BLUE:
			$TypeLabel.text = "RED"
	self.pressed.connect(_on_pressed)
	
func _on_pressed() -> void:
	var _new_star :Star = _star.instantiate()
	_new_star.set_type(_star_type)
	_new_star.freeze_physics(false)
	MouseState.set_drag(true)
	MouseState.set_holded_star(_new_star)
	_stars_parent.add_child(_new_star)
	_new_star.global_position = get_global_mouse_position()
	decrease_star_amount()
	if _star_amount == 0:
		self.queue_free()

func increase_star_amount() -> void:
	_star_amount += 1
	$AmountLabel.text = str(_star_amount)

func decrease_star_amount() -> void:
	_star_amount -= 1
	$AmountLabel.text = str(_star_amount)

func set_star_type(s: Star.StarType) -> void:
	_star_type = s

func get_star_type() -> Star.StarType:
	return _star_type
