extends Node

var current_level_name: String = "" : set = set_current_level_name
func set_current_level_name(level_name: String) -> void:
	current_level_name = level_name
	DiscordRPC.details = level_name
	DiscordRPC.refresh()

#region Player-Related-Vars
var player_health: int = 5
var can_player_double_jump: bool = false
var can_player_dash: bool = false
var can_player_sprint: bool = false
#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DiscordRPC.app_id = 1360302025715351925
	DiscordRPC.state = "Level 1/23"
	DiscordRPC.large_image = "image_prev_1" # Image key from "Art Assets"
	DiscordRPC.large_image_text = "Try it now!"
	DiscordRPC.small_image = "image_prev_1" # Image key from "Art Assets"
	DiscordRPC.small_image_text = "Playing..."

	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
	# DiscordRPC.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00:00 remaining"

	DiscordRPC.refresh() # Always refresh after changing the values!
