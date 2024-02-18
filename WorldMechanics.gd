extends Node

@onready var player = $"../PlayerDataObject"

@export var chance_of_hazards : int = 15 #chance of encountering a hazard in percent

var hazard : Resource 

func resolve_hazard():
	pass
	
