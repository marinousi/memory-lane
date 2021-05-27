extends Node

var client
var wrapped_client
var connected = false
var Mov = [0,0,0,0,0]
var text = ""

signal cima()
signal baixo()
signal esquerda()
signal direita()
signal ataque()

func _ready():
	client = StreamPeerTCP.new()
	client.set_no_delay(true)
	
func _exit_tree():
	disconnect_from_server()

func connect_to_server():
	var ip = "192.168.0.64"
	var port = 80
	print("Connecting to server: %s : %s" % [ip, str(port)])
	var _connect = client.connect_to_host(ip, port)
	if client.is_connected_to_host():
		connected = true
		print("Connected!")
	
func disconnect_from_server():
	connected = false
	client.disconnect_from_host()

func _process(_delta):
	if not connected:
		pass
	if connected and not client.is_connected_to_host():
		connected = false
	if client.is_connected_to_host():
		poll_server()


func poll_server():
	while client.get_available_bytes() > 0:
		var msg = client.get_utf8_string(client.get_available_bytes())
		if msg == null:
			continue;
			
		if msg.length() > 0:
			for c in msg:
				if c == "\n":
					on_text_received(text)
					text = ""
				else:
					text+=c

func on_text_received(text): #"1 Sobe"
	print(Mov)
	var command_array = text.split(" ")
	Mov = command_array
	print(len(Mov))
	if command_array.size() < 2:
		return
		
	if str(command_array[0]) == "1":
		emit_signal("cima")
	elif command_array[0] == "2":
		emit_signal("baixo")
	elif command_array[0] == "3":
		emit_signal("esquerda")
	elif command_array[0] == "4":
		emit_signal("direita")
	elif command_array[0] == "5":
		emit_signal("ataque")


func write_text(text):
	if connected and client.is_connected_to_host():
		print("Sending: %s" % text)
		client.put_data(text.to_ascii())
