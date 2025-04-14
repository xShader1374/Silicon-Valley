extends Node3D

@export var level_name: String = ""
@export_category("Ambience")
## Ambience's index:
## -1 for no Ambience Change
## -2 for Ambience Stop
@export var AMBIENCE_ID: int = -1
## The duration of the fade-in
@export_range(-60, 60, 0.01) var ambience_fadein_time: float = 1.0
## Forces the change of the ambience stream, even if it's the same as the current one.
@export var force_ambience_change: bool = false
@export_category("OST")
## OST's index:
## -1 for no OST Change
## -2 for OST Stop
@export var OST_ID: int = -1
## The duration of the fade-in
@export_range(-60, 60, 0.01) var ost_fadein_time: float = 1.0
## Forces the change of the OST stream, even if it's the same as the current one.
@export var force_ost_change: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.current_level_name = level_name
	
	match AMBIENCE_ID:
		-2:
			AmbiencePlayer.quitAmbience()
		-1:
			pass # no change
		_:
			AmbiencePlayer.changeAmbience(AMBIENCE_ID, ambience_fadein_time, force_ambience_change)
	
	match OST_ID:
		-2:
			OstPlayer.quitMusic()
		-1:
			pass # no change
		_:
			OstPlayer.changeMusic(OST_ID, ost_fadein_time, force_ost_change)
