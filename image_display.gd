extends Control

@onready var imageDisplayed = $Image

# Called when the node enters the scene tree for the first time.
func _ready():
	var image = Image.load_from_file(Global.selectedImagePath)
	var texture = ImageTexture.create_from_image(image)
	imageDisplayed.texture = texture
	var windowSize = get_viewport_rect().size
	if imageDisplayed.texture.get_width() > imageDisplayed.texture.get_height():
		if imageDisplayed.texture.get_width() > windowSize.x:
			var imageHeight = windowSize.x * imageDisplayed.texture.get_height() / imageDisplayed.texture.get_width()
			var newScale = imageHeight / imageDisplayed.texture.get_height()
			imageDisplayed.scale = Vector2(newScale, newScale)
	elif imageDisplayed.texture.get_width() > windowSize.x or imageDisplayed.texture.get_height() > windowSize.y:
		var imageWidth = windowSize.y * imageDisplayed.texture.get_width() / imageDisplayed.texture.get_height()
		var newScale = imageWidth / imageDisplayed.texture.get_width()
		imageDisplayed.scale = Vector2(newScale, newScale)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_image_pressed():
	queue_free()
