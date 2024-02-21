extends Node

@onready var dicebag = Dicebag.new()

#Values
@export var max_health : int = 20
@export var health : int = max_health
@export var rads : int = 0


@export var stats : Dictionary = {
	"Strength" : 0,
	"Perception" : 0,
	"Constitution" : 0,
	"Dexterity" : 0,
	"Intelligence" : 0,
	"Charisma" : 0
}


func roll_stat(stat_name,dificulty):
	print(stat_name)
	
	if stats.has(stat_name):
		randomize()
		var stat_roll = dicebag.roll_dice(1,100)
		print(stat_roll)
		stat_roll = stat_roll + stats[stat_name]
		print(stat_roll)
		if (stat_roll >= dificulty):
			return true
		else: return false
		
	else: print("ERROR NONEXISTING STAT!")
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
