extends Node2D

var letters := ["A","B","C","D","E","F","G","H","I","J","K","L","M",
				"N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
				"0","1","2","3","4","5","6","7","8","9"," "]

var player_name := ["A", "A", "A"]

var current_pos := 0

var is_active: bool = false

signal name_confirmed

func _ready():
	_update_display()

func _unhandled_input(event: InputEvent) -> void:
	if !is_active:
		return
	if event.is_action_pressed("ui_up"):
		_change_letter(-1)
	elif event.is_action_pressed("ui_down"):
		_change_letter(1)
	elif event.is_action_pressed("ui_right"):
		current_pos = clamp(current_pos + 1, 0, 2)
		_update_display()
	elif event.is_action_pressed("ui_left"):
		current_pos = clamp(current_pos - 1, 0, 2)
		_update_display()
	elif event.is_action_pressed("ui_accept"):
		_confirm_name()

func _change_letter(delta: int) -> void:
	var index := letters.find(player_name[current_pos])
	index = (index + delta) % letters.size()
	if index < 0:
		index = letters.size() - 1
	player_name[current_pos] = letters[index]
	_update_display()

func _update_display() -> void:
	$PlayerName/Char1.text = player_name[0]
	$PlayerName/Char2.text = player_name[1]
	$PlayerName/Char3.text = player_name[2]
	
	if current_pos == 0:
		$PlayerName/Arrows.global_position.x = $PlayerName/Char1.global_position.x + 8
	if current_pos == 1:
		$PlayerName/Arrows.global_position.x = $PlayerName/Char2.global_position.x + 8
	if current_pos == 2:
		$PlayerName/Arrows.global_position.x = $PlayerName/Char3.global_position.x + 8


func _confirm_name() -> void:
	is_active = false
	name_confirmed.emit()
