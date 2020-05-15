extends Node
#var Thing = preload("res://Thing.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func destroy(thing:Node):
	thing.free();

func combine(thing1:Thing, thing2:Thing):
	print("combining...")
	var newThing = Thing.new(
		(thing1.hp + thing2.hp) / 2,
		(thing1.mass + thing2.mass) / 2,
		(thing1.hardness + thing2.hardness) / 2);
	newThing.transform = thing1.transform;
	newThing.name = thing1.name + thing2.name;
	
	var sprite = Sprite.new();
	newThing.add_child(sprite);
	#blending the images:
	var image1 = thing1.get_child(0).texture.get_data();
	var image2 = thing2.get_child(0).texture.get_data();
	var newTexture = ImageTexture.new();
	var newImage = image1.blit_rect(image2, Rect2(Vector2(0,0),Vector2(32,64)), Vector2(0,0));
	#var newImage = image1;
	newTexture.create_from_image(image1);
	newThing.get_child(0).texture = newTexture;
	
	#adding collision shape
	var shape = RectangleShape2D.new();
	shape.set_extents(Vector2(32,32));
	var collShape = CollisionShape2D.new();
	collShape.set_shape(shape);
	newThing.add_child(collShape)
	
	thing1.get_parent().add_child(newThing);
	thing1.free();
	thing2.free();
