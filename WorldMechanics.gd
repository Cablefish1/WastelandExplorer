extends Node

@onready var player = $"../PlayerDataObject"

@export var chance_of_hazards : int = 15 #chance of encountering a hazard in percent


func resolve_hazard():
	var hazard_file_name = get_hazard_file_name_from_folder()
	var hazard = load("res://Hazards/"+hazard_file_name)
	print(hazard.hazard_name)
	# I got the file. It's loaded! Now do stuff with it!

func get_hazard_file_name_from_folder():
	var hazards_dir = DirAccess.open("res://Hazards/")
	var hazards : Array = hazards_dir.get_files()
	var hazard_file_name = hazards.pick_random()
	return hazard_file_name
	
	
