extends Node

@onready var dicebag = Dicebag.new()
@onready var storyteller = $"../Storyteller"

#Values
@export var max_health : int = 20
@export var health : int = max_health
@export var rads : int = 0

var stat_improved : String = "" 

@export var stats : Dictionary = {
	"Strength" : 0,
	"Perception" : 0,
	"Constitution" : 0,
	"Dexterity" : 0,
	"Intelligence" : 0,
	"Charisma" : 0
}



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func roll_stat(stat_name,dificulty):
#debug 	print(stat_name)
	
	if stats.has(stat_name):
		randomize()
		var stat_roll = dicebag.roll_dice(1,100)
		print("Dice roll "+str(stat_roll))
		stat_roll = stat_roll + stats[stat_name]
		print("Stat roll "+str(stat_roll))
		if (stat_roll >= dificulty):
			if (stat_roll <= dificulty + 10):
				improve_stat(stat_name)
				
				
				return true
			return true
		else: return false
		
	else: print("ERROR NONEXISTING STAT!")
		

func improve_stat(stat_name):
	var amount_to_improve = dicebag.roll_dice(1, 10)
	stats[stat_name] = stats[stat_name] + amount_to_improve
	#Create a floating text node
	#maybe from this video: https://www.youtube.com/watch?v=zGng3u9Y6dg
	print("You improve "+stat_name+" by "+str(amount_to_improve))
	return

	
	
	
	
