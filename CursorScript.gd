extends KinematicBody2D

var MAX_SPEED = 200
var ACELERACAO = 500
var Motion = Vector2.ZERO
var ultimoBotao

func _physics_process(delta):
	var axis = get_input_axis ()
	if axis == Vector2.ZERO:
		apply_friction(ACELERACAO * delta)
	else:
		apply_movement(axis * ACELERACAO * delta)
	Motion = move_and_slide(Motion)
	$Area2D/Toque.set_deferred("disabled", true)
	if int(Socket.Mov[4]) == 1:
		aperta()
	


func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Socket.Mov[2]) - int(Socket.Mov[3])
	axis.y = int(Socket.Mov[1]) - int(Socket.Mov[0])
	return axis.normalized()

	

func aperta():
	print("apertou")
	$Area2D/Toque.set_deferred("disabled", false)


func apply_friction(valor):
	if Motion.length() > valor:
		Motion -= Motion.normalized() * valor
	else:
		Motion = Vector2.ZERO


func apply_movement (aceleracao):
	Motion += aceleracao
	Motion = Motion.clamped(MAX_SPEED)



