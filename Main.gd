extends Node2D

#Basicamente x e y sao as posições
#var x = 0
#var y = 0
#Salva a primeira carta
var Carta_da_vez = null
var Som_da_vez = null
#Variavel que eu disse na Main_Certa
var game_start = false

signal oi

func _ready():
	pass 
	
	
#Uma unica função que recebe os valores dados na outra cena(feito para nao ter que fazer 50 funções)
func Modo(x,y,modo,_som,valores,escala,dist):
	#x e y são posições
	#modo = fundo da carta
	#valores = quantidade de cartas
	#escalas = duh
	#dist = distancia
	game_start = false
	var x1 = x
	var y1 = y
	randomize()
	var auxiliar = 1
	for _i in range(len(valores)):
		var scene = load("res://Cartas/Carta.tscn")
		var carta = scene.instance()
		carta.scale = Vector2(escala,escala)
		carta.position = Vector2(x1,y1)
		#retira um valor aleatorio do array
		var posicao_sorteada = randi()% valores.size()
		Carta_da_vez = valores[posicao_sorteada]
		Som_da_vez = valores[posicao_sorteada]
		#apaga o valor
		valores.erase(Carta_da_vez)
		#define os valores 
		carta.j = Carta_da_vez
		carta.b = modo
		#cria a carta
		add_child(carta)
		#posicionamento
		if auxiliar == 4:
			y1 += 100 * dist
			x1 = x 
			auxiliar = 0
		else:
			x1 += 100 * dist
		auxiliar += 1
	
	#basicamente variaveis auxiliares
	Carta_da_vez = null
	game_start = true
	pass

#Basicamente relação pra ver se ambas cartas sao iguais
func Carta_Atual(Carta):
	if Carta_da_vez == null:
		Carta_da_vez = Carta
	else:
		if Carta_da_vez.j == Carta.j:
			print("igual")
			#$Correct_Sound.play()
			Carta.audio_correct.play()
			Socket.write_text("A\n")
			yield(get_tree().create_timer(1),"timeout")
			Carta_da_vez.queue_free()
			#Carta_da_vez.set_visible(false)
			Carta.queue_free()
			#Carta.set_visible(false)
			Carta_da_vez = null
			Carta = null
		else:
			print("diferente")
			Carta.audio_wrong.play()
			yield(get_tree().create_timer(1),"timeout")
			#$Wrong_Sound.play()
			Carta_da_vez.flip()
			Carta.flip()
			Carta_da_vez = null
		if get_child_count() == 0 and game_start == true:
			print("ENTROU")
			emit_signal("oi")
	pass

func _process(_delta):
	if get_child_count() == 0 and game_start == true:
		var _path = get_tree().change_scene("res://Ending_Screen.tscn")
		game_start = false
	#else:
		#print("k")
		#pass
	#pass


func _on_Main_oi():
	var _path = get_tree().change_scene("res://Ending_Screen.tscn")
