extends Control

func _ready() -> void:
	$DebugScroll.hide()
	$DebugButton.pressed.connect(_on_debug_button_pressed)

func _on_debug_button_pressed() -> void:
	if $DebugScroll.visible:
		$DebugScroll.hide()
	else:
		$DebugScroll.show()
		
