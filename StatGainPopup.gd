extends Label

func _ready():
	pass

func display_popup(amount : int , stat_name : String):
	set_text("+"+str(amount)+" "+stat_name)
	print(stat_name)
	show()
	$StatGainPopupHideTimer.start()
	return
	


func _on_stat_gain_popup_hide_timer_timeout():
	hide()
