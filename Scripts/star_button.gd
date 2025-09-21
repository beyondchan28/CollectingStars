class_name StarButton extends TextureButton

@export var _star_amount := 0 # how many star this button contain
@export var _star_type := Star.StarType.RED

func _ready() -> void:
	match _star_type:
		Star.StarType.RED:
			$Label.text = "RED"
		Star.StarType.GREEN:
			$Label.text = "RED"
		Star.StarType.BLUE:
			$Label.text = "RED"

func increase_star_amount() -> void:
	_star_amount += 1

func decrease_star_amount() -> void:
	_star_amount -= 1

func set_star_type(s: Star.StarType) -> void:
	_star_type = s

func get_star_type() -> Star.StarType:
	return _star_type
