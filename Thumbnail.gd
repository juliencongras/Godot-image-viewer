extends TextureRect

var filePath : String

func _on_mouse_entered():
	Global.selectedImagePath = filePath

func _on_mouse_exited():
	Global.selectedImagePath = ""
