extends AudioStreamPlayer

## Ambience will still play even if paused, to change this behavior,
## you can change the process mode from "always" to "inherit".

const Ambiences: Array[AudioStream] = [
	preload("uid://bsdt08ayvd5ms") # 0: "res://Audio/Ambience/ambient_loop2-49433.mp3"
]

func transitionFromCurrentToNew(new_stream: AudioStream, total_duration: float) -> void:
	var tween1: Tween = create_tween()
	
	tween1.set_ease(Tween.EASE_IN_OUT)
	tween1.set_trans(Tween.TRANS_LINEAR)
	
	# If stream isn't empty
	if stream:
		# Fade out
		tween1.tween_property(self, "volume_db", -80.0, total_duration / 2.0).from_current()
		
		# Cambio stream e riavvio
		tween1.chain().tween_callback(func() -> void: 
			set_stream(new_stream)
			play())
		
		# Fade in
		tween1.chain().tween_property(self, "volume_db", 0.0, total_duration / 2.0).from(-80.0)
	else:
		tween1.tween_callback(func() -> void: 
			set_stream(new_stream)
			play())
		
		# Fade in
		tween1.chain().tween_property(self, "volume_db", 0.0, total_duration).from(-80.0)

func changeAmbience(ambience_ID: int, trans_duration: float = 0.15, forced_override: bool = true) -> void:
	if ambience_ID >= 0 and ambience_ID < Ambiences.size():
		if forced_override: # If forced_override ON (overrides stream even if same as current stream)
			transitionFromCurrentToNew(Ambiences[ambience_ID], trans_duration)
		elif Ambiences[ambience_ID] != stream: # If forced_override OFF && current stream isn't equal to the new
			transitionFromCurrentToNew(Ambiences[ambience_ID], trans_duration)

func quitAmbience() -> void:
	stop()
	stream = null

## TODO: WIP
func quitAmbienceSmooth() -> void:
	stop()
	stream = null
