extends Control

@onready var imageDisplayed = $Image
@onready var imageDisplayedTexture = imageDisplayed.texture
@onready var imageDisplayedScale = imageDisplayed.scale

# Called when the node enters the scene tree for the first time.
func _ready():
	var image = Image.load_from_file("res://testImage.png")
	var texture = ImageTexture.create_from_image(image)
	imageDisplayedTexture = texture
	var windowSize = get_viewport_rect().size
	if imageDisplayedTexture.get_width() > imageDisplayedTexture.get_height():
		if imageDisplayedTexture.get_width() > windowSize.x:
			var imageHeight = windowSize.x * imageDisplayedTexture.get_height() / imageDisplayedTexture.get_width()
			var newScale = imageHeight / imageDisplayedTexture.get_height()
			imageDisplayedScale = Vector2(newScale, newScale)
	elif imageDisplayedTexture.get_width() > windowSize.x or imageDisplayedTexture.get_height() > windowSize.y:
		var imageWidth = windowSize.y * imageDisplayedTexture.get_width() / imageDisplayedTexture.get_height()
		var newScale = imageWidth / imageDisplayedTexture.get_width()
		imageDisplayedScale = Vector2(newScale, newScale)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_image_pressed():
	queue_free()
