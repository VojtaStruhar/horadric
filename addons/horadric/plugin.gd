@tool
extends EditorPlugin

const DASHBOARD: PackedScene = preload("res://addons/horadric/ui/dashboard.tscn")
var dashboard_instance: Control = null

func _enter_tree() -> void:
	dashboard_instance = DASHBOARD.instantiate()
	EditorInterface.get_editor_main_screen().add_child(dashboard_instance)
	_make_visible(false)
	print("[Horadric] Loaded")


func _exit_tree() -> void:
	if dashboard_instance != null:
		dashboard_instance.queue_free()
		dashboard_instance = null
		print("[Horadric] Unloaded")


func _has_main_screen() -> bool:
	return true


func _make_visible(visible: bool) -> void:
	if dashboard_instance != null:
		dashboard_instance.visible = visible


func _get_plugin_name() -> String:
	return "Horadric"


func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")
