extends Node2D

@onready var file_dialog = $FileDialog
@onready var scroll_container = $ScrollContainer
@onready var thumbnails_container = $"ScrollContainer/Thumbnails container"
@onready var selected_image = $"Selected image"
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
		filesInFolder.clear()
	var folderPath = DirAccess.open(dir)
	folderPath.list_dir_begin()
	var file_name = folderPath.get_next()
	while file_name != "":
		if file_name.get_extension() == "png" or file_name.get_extension() == "jpg" :
			var fullPath = str(dir, "/", file_name)
			filesInFolder.append(fullPath)
		file_name = folderPath.get_next()
	for file in filesInFolder:
		var selfSelected : bool = false
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
		newImage.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
		thumbnails_container.add_child(newImage)
		newImage.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		newImage.set_meta("filepath", file)
		if newImage.mouse_entered:
			selfSelected = true
		elif newImage.mouse_exited:
			selfSelected = false
		if selfSelected and InputEventMouseButton:
			image_selected(file)
		
func image_selected(info):
	var image = Image.load_from_file(info)
	var texture = ImageTexture.create_from_image(image)
	selected_image.texture = texture
	var windowSize = get_viewport_rect().size
	print(selected_image.texture.get_height())
	if selected_image.texture.get_width() > selected_image.texture.get_height():
		var imageHeight = windowSize.x * selected_image.texture.get_height() / selected_image.texture.get_width()
		var newScale = imageHeight / selected_image.texture.get_height()
		selected_image.scale = Vector2(newScale, newScale)
	else:
		var imageWidth = windowSize.y * selected_image.texture.get_width() / selected_image.texture.get_height()
		var newScale = imageWidth / selected_image.texture.get_width()
		selected_image.scale = Vector2(newScale, newScale)
	selected_image.visible = true
