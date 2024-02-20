extends Node

@onready var player = $"../PlayerDataObject"

@export var chance_of_hazards : int = 15 #chance of encountering a hazard in percent
@onready var storyteller = $"../Storyteller"


func resolve_hazard():
	var hazard_file_name = get_hazard_file_name_from_folder()
	var hazard = load("res://Hazards/"+hazard_file_name)
	storyteller.tell_player("[color=yellow]You encounter: "+hazard.hazard_name+".[/color]")
	storyteller.tell_player(hazard.description)
	# The folloing array translates the hazards enum to a string that can be read by the dictionary in the playerscript. 
	# Very important this is identical to the stat order in the PlayerDataObject!
	var stats = ["Strength", "Perception", "Constitution", "Dexterity", "Intelligence", "Charisma"] 
	if player.roll_stat(stats[hazard.stat_to_overcome]) == true:
		storyteller.tell_player(hazard.good_outcome)
		#reward player
		return
	else:
		storyteller.tell_player(hazard.bad_outcome)
		#resolve bad stuff + check if dead
		
	

func get_hazard_file_name_from_folder():
	var hazards_dir = DirAccess.open("res://Hazards/")
	var hazards : Array = hazards_dir.get_files()
	var hazard_file_name = hazards.pick_random()
	return hazard_file_name
	
	
