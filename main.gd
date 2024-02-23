extends Node2D

@onready var file_dialog = $FileDialog
@onready var scroll_container = $ScrollContainer
@onready var thumbnails_container = $"ScrollContainer/Thumbnails container"
var filesInFolder = []
var thumbnailSize = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	thumbnails_container.columns = scroll_container.get_rect().size.x / thumbnailSize

func _on_open_folder_button_pressed():
	file_dialog.visible = true

func _on_file_dialog_dir_selected(dir):
	for gridImage in thumbnails_container.get_children():
		gridImage.queue_free()
	var folderPath = DirAccess.open(dir)
	folderPath.list_dir_begin()
	var file_name = folderPath.get_next()
	while file_name != "":
		if file_name.get_extension() == "png" or file_name.get_extension() == "jpg" :
			var fullPath = str(dir, "/", file_name)
			filesInFolder.append(fullPath)
		file_name = folderPath.get_next()
	for file in filesInFolder:
		var newImage = TextureRect.new()
		var imageFile = Image.load_from_file(file)
		var thumbnailImageOriginalSize = imageFile.get_size()
		if thumbnailImageOriginalSize.x > thumbnailImageOriginalSize.y:
			var thumbnailHeight = thumbnailSize * thumbnailImageOriginalSize.y / thumbnailImageOriginalSize.x
			imageFile.resize(thumbnailSize, thumbnailHeight)
		else:
			var thumbnailWidth = thumbnailSize * thumbnailImageOriginalSize.x / thumbnailImageOriginalSize.y
			imageFile.resize(thumbnailWidth, thumbnailSize)
		var textureFromImage = ImageTexture.create_from_image(imageFile)
		newImage.texture = textureFromImage
		thumbnails_container.add_child(newImage)
		newImage.focus_mode = Control.FOCUS_CLICK
		newImage.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		#if newImage.focus_entered:
		#	imageClicked.emit(file)
		print(newImage.texture.resource_name)
