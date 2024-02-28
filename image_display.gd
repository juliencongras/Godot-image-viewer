extends Control

@onready var imageDisplayed = $Image
@onready var imageDimensions = $"Image dimensions"
@onready var zoomSlider = $ZoomSlider

var clickingImage : bool = false
var mouseOriginalPosition : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	var image = Image.load_from_file(Global.selectedImagePath)
	var texture = ImageTexture.create_from_image(image)
	imageDisplayed.texture = texture
	var windowSize = get_viewport_rect().size
	imageDimensions.text = str(imageDisplayed.texture.get_width(), " X " ,imageDisplayed.texture.get_height())
	#Scale image to fit the screen
	if imageDisplayed.texture.get_width() > imageDisplayed.texture.get_height():
		if imageDisplayed.texture.get_width() > windowSize.x:
			var imageHeight = windowSize.x * imageDisplayed.texture.get_height() / imageDisplayed.texture.get_width()
			var newScale = imageHeight / imageDisplayed.texture.get_height()
			imageDisplayed.scale = Vector2(newScale, newScale)
		if imageDisplayed.texture.get_height() > windowSize.y:
			var imageWidth = windowSize.y * imageDisplayed.texture.get_width() / imageDisplayed.texture.get_height()
			var newScale = imageWidth / imageDisplayed.texture.get_width()
			imageDisplayed.scale *= Vector2(newScale, newScale)
	else:
		if imageDisplayed.texture.get_height() > windowSize.y:
			var imageWidth = windowSize.y * imageDisplayed.texture.get_width() / imageDisplayed.texture.get_height()
			var newScale = imageWidth / imageDisplayed.texture.get_width()
			imageDisplayed.scale = Vector2(newScale, newScale)
		if imageDisplayed.texture.get_width() > windowSize.x:
			var imageHeight = windowSize.x * imageDisplayed.texture.get_height() / imageDisplayed.texture.get_width()
			var newScale = imageHeight / imageDisplayed.texture.get_height()
			imageDisplayed.scale *= Vector2(newScale, newScale)
	#Center image
	imageDisplayed.position.x = windowSize.x / 2 - (imageDisplayed.texture.get_width() * imageDisplayed.scale.x) / 2
	imageDisplayed.position.y = windowSize.y / 2 - (imageDisplayed.texture.get_height() * imageDisplayed.scale.y) / 2
	zoomSlider.value = imageDisplayed.scale.x

func _process(_delta):
	var mouseRelativePosition = get_global_mouse_position() - mouseOriginalPosition
	
	if Input.is_action_just_pressed("click"):
		clickingImage = true
		mouseOriginalPosition = get_global_mouse_position()
	
	if Input.is_action_just_released("click"):
		clickingImage = false
	
	if clickingImage:
		imageDisplayed.position = mouseRelativePosition

func _on_close_image_pressed():
	queue_free()

func _on_zoom_slider_value_changed(value):
	var windowSize = get_viewport_rect().size
	imageDisplayed.scale = Vector2(value, value)
	imageDisplayed.position.x = windowSize.x / 2 - (imageDisplayed.texture.get_width() * imageDisplayed.scale.x) / 2
	imageDisplayed.position.y = windowSize.y / 2 - (imageDisplayed.texture.get_height() * imageDisplayed.scale.y) / 2
