extends Node2D

onready var item = preload("res://Scenes/Prefabs/Task_Item.tscn")

var task = [
	"Colete"
]
var posy = 65

func _ready():
	
	for i in range(6):
		add_item(i)

func add_item(index):
	var it = item.instance()
	it.set_position(Vector2(360, posy))
	it.set_item()
			
	get_node("Panel/ScrollContainer/VBoxContainer").add_child(it)
	
	posy += 128

func _on_Exit_pressed():
	Transition.clear_above()
