@tool
extends Control

const Horadric = preload("res://addons/horadric/horadric.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

func _on_save_button_pressed() -> void:
	Horadric.save()


func _on_reload_button_pressed() -> void:
	Horadric.reload_structure()
