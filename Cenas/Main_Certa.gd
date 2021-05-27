extends Node2D


onready var Main = get_node('/root/Main')




func _ready():
	#Variavel para checar se o jogo terminou (vai junto com a quantidade de crianças)
	Socket.connect_to_server()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Main.game_start = false
	pass 



func _process(_delta):
	pass


func _on_Button_pressed():
	var _path = get_tree().change_scene("res://Main.tscn")
	#POO vcs sabem como é olhem na main
	Main.Modo(200,100,0,[1,1,2,2,3,3,4,4],[1,1,2,2,3,3,4,4],0.17,1.5)
	pass 


func _on_Button2_pressed():
	var _path = get_tree().change_scene("res://Main.tscn")
	Main.Modo(200,100,1,[1,1,2,2,3,3,4,4,5,5,6,6],[1,1,2,2,3,3,4,4,5,5,6,6],0.17,1.2)
	pass 


func _on_Button3_pressed():
	var _path = get_tree().change_scene("res://Main.tscn")
	Main.Modo(200,100,2,[1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8],[1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8],0.17,1)
	pass 








func _on_Medio_area_entered(_area):
	_on_Button2_pressed()


func _on_Dificil_area_entered(_area):
	_on_Button3_pressed()



func _on_Facil_area_entered(_area):
	_on_Button_pressed()
