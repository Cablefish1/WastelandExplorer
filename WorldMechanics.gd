extends Node

@onready var player = $"../PlayerDataObject"
@onready var dicebag = Dicebag.new()
@export var chance_of_hazards : int = 15 #chance of encountering a hazard in percent
@onready var storyteller = $"../Storyteller"

var stat_improved : String  = ""

func resolve_hazard():
	var hazard_file_name = get_hazard_file_name_from_folder()
	var hazard = load("res://Hazards/"+hazard_file_name)
	storyteller.tell_player("[color=yellow]You encounter: "+hazard.hazard_name+".[/color]")
	storyteller.tell_player(hazard.description)
	# The folloing array translates the hazards enum to a string that can be read by the dictionary in the playerscript. 
	# Very important this is identical to the stat order in the PlayerDataObject!
	var stats = ["Strength", "Perception", "Constitution", "Dexterity", "Intelligence", "Charisma"] 

	if player.roll_stat(stats[hazard.stat_to_overcome], hazard.dificulty) == true:
		storyteller.tell_player("[color=green]"+hazard.good_outcome+"[/color]")
		var stat_after_roll = player.stats[hazard.stat_to_overcome]

	else:
		storyteller.tell_player("[color=red]"+hazard.bad_outcome+"[/color]")
		var damage_taken = 0
		damage_taken = dicebag.roll_dice(1, hazard.max_damage_amount)
		storyteller.tell_player("[color=red]You take "+str(damage_taken)+" damage[/color]")
		player.health = player.health - damage_taken
		$"..".update_health_bar()
		#resolve bad stuff + check if dead
		
	

func get_hazard_file_name_from_folder():
	var hazards_dir = DirAccess.open("res://Hazards/")
	var hazards : Array = hazards_dir.get_files()
	var hazard_file_name = hazards.pick_random()
	return hazard_file_name
	
	
