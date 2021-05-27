extends Node2D


func _ready():
	Socket.connect_to_server()
	pass 


func _on_Play_Again_pressed():
	var _path = get_tree().change_scene("res://Cenas/Main_Certa.tscn")


func _on_Exit_pressed():
	get_tree().quit()



func _on_sair_area_entered(_area):
	_on_Exit_pressed()


func _on_Jogardnv_area_entered(_area):
	_on_Play_Again_pressed()
