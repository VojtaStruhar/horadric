@tool
extends Control

@onready var structure_tree: Tree = %StructureTree
@onready var main_vbox: VBoxContainer = %MainVbox

const Horadric = preload("res://addons/horadric/horadric.gd")

const INSPECTOR_INTEGER = preload("res://addons/horadric/ui/property_inspectors/inspector_integer.tscn")
const INSPECTOR_STRING = preload("res://addons/horadric/ui/property_inspectors/inspector_string.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_reload_button_pressed()

func _on_save_button_pressed() -> void:
	Horadric.save()


func _on_reload_button_pressed() -> void:
	Horadric.reload_structure()
	structure_tree.clear()
	
	var s = Horadric.structure
	var root = structure_tree.create_item()
	root.set_text(0, Horadric.managed_dir_path)
	
	for t in s.templates:
		_create_items_for_template(t, root)
	
func _create_items_for_template(t: Horadric.HoradricTemplate, parent: TreeItem) -> void:
	var t_item = parent.create_child()
	t_item.set_text(0, t.name.to_pascal_case())
	
	for inst in t.instances:
		var sub = t_item.create_child()
		sub.set_text(0, inst)


func _on_test_pressed() -> void:
	print("test - displaying the first member of the first template available")
	
	var s = Horadric.structure
	print(s.templates[0].members[0].name)
	display_template(s.templates[0])
	display_template(s.templates[0])

func display_template(t: Horadric.HoradricTemplate) -> void:
	print("Displaying template: ", t.name)
	for ch in main_vbox.get_children():
		ch.queue_free()
	
	for m in t.members:
		print("member", m.name)
		if m.type == "String":
			main_vbox.add_child(INSPECTOR_STRING.instantiate())
		elif m.type == "int":
			main_vbox.add_child(INSPECTOR_INTEGER.instantiate())
		else:
			push_warning("Member - unknown type: " + m.type)
	

func display_instance(i: Resource) -> void:
	print("Displaying instance: ", i)
