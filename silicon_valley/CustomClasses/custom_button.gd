extends Button
class_name CustomButton

@export var sfx_id_mouse_entered: int = 2
@export var sfx_id_focus_entered: int = 2
@export var sfx_id_pressed: int = 3
@export var sfx_id_mouse_exited: int = 0
@export var sfx_id_focus_exited: int = 0

func _init() -> void:
	pass
	#self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.button_down.connect(_on_button_down)
	self.pressed.connect(_on_button_pressed)
	self.button_up.connect(_on_button_up)
	self.focus_entered.connect(_on_focus_entered)
	self.focus_exited.connect(_on_focus_exited)
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)


#region Animations
func animationZoomIn() -> void:
	self.pivot_offset = self.size / 2.0
	
	#var tween: Tween = create_tween()
	
	#tween.set_ease(Tween.EASE_IN_OUT)
	#tween.set_trans(Tween.TRANS_SINE)
	
	#tween.tween_property(self, "scale", Vector2(0.975, 0.975), 0.20).from_current()

func animationZoomOut() -> void:
	self.pivot_offset = self.size / 2.0
	
	#var tween: Tween = create_tween()
	
	#tween.set_ease(Tween.EASE_IN_OUT)
	#tween.set_trans(Tween.TRANS_SINE)
	
	#tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.20).from_current()
#endregion


func _on_button_down() -> void:
	pass

func _on_button_pressed() -> void:
	SfxPlayer.play(sfx_id_pressed)

func _on_button_up() -> void:
	pass

func _on_focus_entered() -> void:
	SfxPlayer.play(sfx_id_focus_entered, 0.95, 1.05)
	animationZoomIn()

func _on_focus_exited() -> void:
	animationZoomOut()

func _on_mouse_entered() -> void:
	SfxPlayer.play(sfx_id_mouse_entered, 0.95, 1.05)
	animationZoomIn()

func _on_mouse_exited() -> void:
	animationZoomOut()
