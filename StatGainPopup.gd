extends Marker2D


@export var popup_node : PackedScene


#NOT IMPLEMENTED YET. FEEL FREE TO DELETE!
func popup_stat_gain():
	var popup = popup_node.instantiate()
	popup.position = global_position
	
	get_tree().current_scene.add_child(popup)
	
	
