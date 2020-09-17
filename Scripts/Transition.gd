extends CanvasLayer

var next
var above

func _ready():
	clear()

func fade_to(path):
	var timer = get_node("Timer")
	var anim = get_node("AnimationPlayer")
	timer.start()
	anim.play("Loading")
	next = path
	yield(timer, "timeout")
	clear()
	anim.stop()
	change_scene()
	
func clear():
	get_node("ColorRect").visible = false
	get_node("Control").visible = false

func change_scene():
	if next != null:
		get_tree().change_scene(next)

func put_above(path):
	get_tree().paused = true
	above = load(path).instance()
	get_tree().get_root().add_child(above)
	
func clear_above():
	get_tree().get_root().remove_child(above)
	above = null
	get_tree().paused = false
