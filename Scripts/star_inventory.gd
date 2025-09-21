extends ScrollContainer

@onready var _star_container: GridContainer = $StarContainer
@onready var _game : Node2D = $"../../" # Reference game node that store mouse state


func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_entered_inventory)

func _on_mouse_entered_inventory() -> void:
	for _str_btn: TextureButton in _star_container.get_children():
		
		pass

func _process(delta: float) -> void:
	pass
