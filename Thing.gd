extends RigidBody2D
class_name Thing

var hp;
var hardness;

func _init(hp, mass, hardness):
	self.hp = hp;
	self.mass = mass;
	self.hardness = hardness; # on a scale from 0 to 10
	self.gravity_scale = 0;
	self.linear_damp = mass * 0.1
	self.angular_damp = mass * 0.1


func _ready():
	print("The " + name + " has the following properties: hp: " + str(hp) + ", mass: " + str(mass) + ", hardness: " + str(hardness));
