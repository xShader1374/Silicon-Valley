extends AudioStreamPlayer

const OSTS: Array[AudioStreamOggVorbis] = [
	
]

func transitionFromCurrentToNew(new_stream: AudioStreamOggVorbis, total_duration: float) -> void:
	var tween1: Tween = create_tween()
	
	tween1.set_ease(Tween.EASE_IN_OUT)
	tween1.set_trans(Tween.TRANS_LINEAR)
	
	# Se stream non è vuoto
	if stream:
		# Fade out
		tween1.tween_property(self, "volume_db", -80.0, total_duration / 2.0).from_current()
		# Cambio stream e riavvio
		tween1.chain().tween_callback(func() -> void: 
			set_stream(new_stream)
			play())
		# Fade in
		tween1.chain().tween_property(self, "volume_db", 0.0, total_duration / 2.0)
	else:
		volume_db = -80.0
		tween1.tween_callback(func() -> void: 
			set_stream(new_stream)
			play())
		# Fade in
		tween1.chain().tween_property(self, "volume_db", 0.0, total_duration)

func changeMusic(music_ID: int, trans_duration: float = 0.15, forced_override: bool = true) -> void:
	if music_ID >= 0 and music_ID < OSTS.size():
		if forced_override: # If forced_override ON (overrides stream even if same as current stream)
			transitionFromCurrentToNew(OSTS[music_ID], trans_duration)
		elif OSTS[music_ID] != stream: # If forced_override OFF && current stream isn't equal to the new
			transitionFromCurrentToNew(OSTS[music_ID], trans_duration)

func quitMusic() -> void:
	stop()
	stream = null

## TODO: WIP
func quitMusicSmooth() -> void:
	stop()
	stream = null
