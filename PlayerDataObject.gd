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


func roll_stat(stat):
	print(stat)
	
	#THE RIGHT STAT IS NOW BEING SENT TO THIS SCRIPT
'''	if stats.has(stat):
		print(stats.stat)
		var stat_roll = dicebag.roll_dice(1,100)
		stat_roll = stat_roll + stats.stat
		print("STAT FOUND")
		return true
	else: print("ERROR NONEXISTING STAT!")'''
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
