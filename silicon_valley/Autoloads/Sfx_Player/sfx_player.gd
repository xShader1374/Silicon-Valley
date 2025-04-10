extends Node

## TODO: Make this system positional in the future, using AudioStreamPlayer2Ds instead of the default ones (if Vector2.ZERO, will still use the default ones)

const SFXs: Array[AudioStream] = [
	preload("uid://cuksmyapbuq27"), # "res://Audio/SFXs/Main_Menu/fried fish.mp3"
	preload("uid://b1ly8tavxc5t8") # "res://Audio/SFXs/Main_Menu/tubozzi-1.mp3"
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

## This function ensures the SFX Player gets deleted once finished playing the SFX
func _sfx_ended(AudioSFXNode: AudioStreamPlayer) -> void:
	AudioSFXNode.queue_free()
