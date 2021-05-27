extends Sprite

var j
var b
onready var audio_correct = get_node("Correct_Sound")
onready var audio_wrong = get_node("Wrong_Sound")
onready var audio_Soundtrack = get_node("Soundtrack")
#bagaceira mas confiem em mim isso substitui 11 if else
var modo = ['res://Cartas/PARTE TRAS CARTA ROSA.png','res://Cartas/PARTE TRAS CARTA LARANJA.png','res://Cartas/PARTE TRAS CARTA VERMELHA.png']
var carta = ['res://Cartas_Certas/CARD CORUJA NOME PNG.png','res://Cartas_Certas/card elefante nome certo.png',
'res://Cartas_Certas/cARD LEAO COM NOME.jpg','res://Cartas_Certas/CARD MACACO NOME.jpg',
'res://Cartas_Certas/CARD PINTINHO NOME.png','res://Cartas_Certas/card porco com nome .png',
'res://Cartas_Certas/CARD TIGRE NOME.png','res://Cartas_Certas/card rato com nome.png']
var som = ['res://Assets/Owl_Sound.wav', 'res://Assets/Elephant_Sound.wav',
'res://Assets/Lion_And_Tiger_Sound.wav', 'res://Assets/Monkey_Sound.wav',
'res://Assets/Chicken_Sound.wav', 'res://Assets/Pig_Sound.wav',
'res://Assets/Lion_And_Tiger_Sound.wav', 'res://Assets/Mouse_Sound.wav']



var t = Timer.new() 
var h = Timer.new()
func _ready():
	#Cartas piscam
	audio_Soundtrack.play()
	
	get_node("Button").icon  = load(modo[b])
	t.set_wait_time(1)
	add_child(t)
	t.start() 
	yield(t, "timeout")
	
	$AnimationPlayer.play("Gira")
	h.set_wait_time(0.3)
	add_child(h)
	h.start()
	yield(h, "timeout")
	get_node("Button").icon = load(carta[j-1])
	yield(get_tree().create_timer(5),"timeout")

	#t.set_wait_time(5)
	#add_child(t)
	#t.start() 
	#yield(t, "timeout")
	
	$AnimationPlayer.play("Gira")
	yield(get_tree().create_timer(0.3),"timeout")
	#h.set_wait_time(0.3)
	#add_child(h)
	#h.start()
	#yield(h, "timeout")
	#carta virada
	get_node("Button").icon  = load(modo[b])
	
	pass 

#Carta apertada e envia um valor para a main
func _on_Button_pressed():
 
	var Main = get_node('/root/Main')
	$AnimationPlayer.play("Gira")
	yield(get_tree().create_timer(0.3),"timeout")
	#h.set_wait_time(0.3)
	#add_child(h)
	#h.start()
	#yield(h, "timeout")
	get_node("AudioStreamPlayer2D").stream = load(som[j-1])
	get_node("AudioStreamPlayer2D").play()
	get_node("Button").icon = load(carta[j-1])
	
	yield(get_tree().create_timer(1),"timeout")
	#t.set_wait_time(1)
	#add_child(t)
	#t.start() 
	#yield(t, "timeout")
	Main.Carta_Atual(self)
	pass
	
func flip():
	$AnimationPlayer.play("Gira")
	yield(get_tree().create_timer(0.3),"timeout")
	#h.set_wait_time(0.3)
	#add_child(h)
	#h.start()
	#yield(h, "timeout")
	#toca o som
	get_node("Button").icon  = load(modo[b])
	
	pass 



func _on_Area2D_area_entered(_area):
	_on_Button_pressed()
