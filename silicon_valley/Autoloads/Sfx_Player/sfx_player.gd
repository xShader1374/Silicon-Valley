extends Node

const SFXs: Array[AudioStream] = [
	preload("uid://cuksmyapbuq27"), # 0: "res://Audio/SFXs/Main_Menu/fried fish.mp3"
	preload("uid://b1ly8tavxc5t8"), # 1: "res://Audio/SFXs/Main_Menu/tubozzi-1.mp3"
	preload("uid://lsxfdntg1cey"),  # 2: "res://Audio/SFXs/Buttons/button-select.wav"
	preload("uid://8vi21twlmo6o"),  # 3: "res://Audio/SFXs/Buttons/button-press.wav"
	preload("uid://dgs08qbc3w07h"), # 4: "res://Audio/SFXs/Character/defend_sfx.mp3"
	preload("uid://bn0i85jpdy2jk"), # 5: "res://Audio/SFXs/Character/parry_sfx.mp3"
]

## Plays a sound effect with the sound effect id, if the pitch min and max are used as args,
## it will use randomized pitch in a range between min and max.
func play(SFX_ID: int, pitch_min: float = 1.0, pitch_max: float = 1.0) -> void:
	if SFX_ID >= 0 and SFX_ID < SFXs.size():
		var newAudioSFXNode: AudioStreamPlayer = AudioStreamPlayer.new()
		
		newAudioSFXNode.finished.connect(_sfx_ended.bind(newAudioSFXNode))
		newAudioSFXNode.bus = "Sfx"
		newAudioSFXNode.stream = SFXs[SFX_ID]
		
		if !(pitch_min == 1.0 and pitch_max == 1.0):
			newAudioSFXNode.pitch_scale = randf_range(pitch_min, pitch_max)
		
		add_child(newAudioSFXNode)
		newAudioSFXNode.play()

## Essentially a copy of the 3D function, but 2D.
func play_2D(
		SFX_ID: int,
		pitch_min: float = 1.0,
		pitch_max: float = 1.0,
		global_position: Vector2 = Vector2.ZERO,
		parent_node: Node3D = null,
		volume_db: float = 0.0,
		unit_size: float = 10.0,
		max_distance: float = 0.0,
		panning_strength: float = 1.0
	) -> void:
	
	if ( SFX_ID >= 0 and SFX_ID < SFXs.size() ) and ( global_position != Vector2.ZERO and parent_node ):
		var newAudioSFXNode: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
		
		newAudioSFXNode.finished.connect(_sfx_3D_ended.bind(newAudioSFXNode))
		newAudioSFXNode.bus = "Sfx"
		newAudioSFXNode.stream = SFXs[SFX_ID]
		newAudioSFXNode.volume_db = volume_db # FIXME: Se è sbagliato, usare this -> db_to_linear(volume_db)
		newAudioSFXNode.unit_size = unit_size
		newAudioSFXNode.max_distance = max_distance
		newAudioSFXNode.panning_strength = panning_strength
		
		if !(pitch_min == 1.0 and pitch_max == 1.0):
			newAudioSFXNode.pitch_scale = randf_range(pitch_min, pitch_max)
		
		if global_position != Vector2.ZERO and !parent_node:
			%"2DSFXsContainer".add_child(newAudioSFXNode)
		elif parent_node:
			parent_node.add_child(newAudioSFXNode)
		
		newAudioSFXNode.play()

## Per far partire un suono singolo(Es. Impatto, Pugno, Caduta di X oggetto, un uovo che si frantuma a terra,
## un cane che sbatte contro un palo e quindi il suono c'è solo nel punto di impatto ecc.):
## lasciare vuoto il "parent_node" e riempire "global position", altrimenti se deve essere un suono che segue qualcosa,
## ad esempio un personaggio che parla ecc., allora si deve fare il contrario:
## riempire il parent_node e lasciare vuoto il global_position
func play_3D(
		SFX_ID: int,
		pitch_min: float = 1.0,
		pitch_max: float = 1.0,
		global_position: Vector3 = Vector3.ZERO,
		parent_node: Node3D = null,
		volume_db: float = 0.0,
		unit_size: float = 10.0,
		max_distance: float = 0.0,
		panning_strength: float = 1.0
	) -> void:
	
	if ( SFX_ID >= 0 and SFX_ID < SFXs.size() ) and ( global_position != Vector3.ZERO and parent_node ):
		var newAudioSFXNode: AudioStreamPlayer3D = AudioStreamPlayer3D.new()
		
		newAudioSFXNode.finished.connect(_sfx_3D_ended.bind(newAudioSFXNode))
		newAudioSFXNode.bus = "Sfx"
		newAudioSFXNode.stream = SFXs[SFX_ID]
		newAudioSFXNode.volume_db = volume_db # FIXME: Se è sbagliato, usare this -> db_to_linear(volume_db)
		newAudioSFXNode.unit_size = unit_size
		newAudioSFXNode.max_distance = max_distance
		newAudioSFXNode.panning_strength = panning_strength
		
		if !(pitch_min == 1.0 and pitch_max == 1.0):
			newAudioSFXNode.pitch_scale = randf_range(pitch_min, pitch_max)
		
		if global_position != Vector3.ZERO and !parent_node:
			%"3DSFXsContainer".add_child(newAudioSFXNode)
		elif parent_node:
			parent_node.add_child(newAudioSFXNode)
		
		newAudioSFXNode.play()


## This function ensures the SFX Player gets deleted once finished playing the SFX
func _sfx_ended(AudioSFXNode: AudioStreamPlayer) -> void:
	AudioSFXNode.queue_free()

## This function ensures the SFX Player 2D gets deleted once finished playing the SFX
func _sfx_2D_ended(AudioSFXNode: AudioStreamPlayer2D) -> void:
	AudioSFXNode.queue_free()

## This function ensures the SFX Player 3D gets deleted once finished playing the SFX
func _sfx_3D_ended(AudioSFXNode: AudioStreamPlayer3D) -> void:
	AudioSFXNode.queue_free()
