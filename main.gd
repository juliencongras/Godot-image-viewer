extends Node2D

@onready var file_dialog = $FileDialog

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_open_folder_button_pressed():
	file_dialog.visible = true

func _on_file_dialog_dir_selected(dir):
	pass # Replace with function body.
