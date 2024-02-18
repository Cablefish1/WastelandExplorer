extends Resource
class_name Hazards

#Some way to load stuff


@export var hazard_name : String 

@export_multiline var description

@export_enum("Strength", "Perception", "Constitution", "Dexterity", "Intelligence", "Charisma") var stat_to_overcome

@export_multiline var good_outcome
@export_multiline var bad_outcome


@export_category("Bad Stuff")
@export_enum("Health", "Rads") var stuff_to_loose
@export var min_damage_amount : int
@export var max_damage_amount : int


func resolve_hazard(Ressource):
	pass
