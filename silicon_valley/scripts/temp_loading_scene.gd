extends Control

@export var next_scene: PackedScene = preload("uid://cs4drhmc1bql5")
@export var phrases: Array[String] = [
	"If you want your car you have to search it.",
	"Tubozzi.",
	"Una signora pizza.",
	"O la Vica, se preferisci...",
	"Coltivo un sentimento di rancore.",
	"Sai cosa ci vuole in questi momenti?\nUn bell'abbraccio.",
	"Evvai!",
	"Mansogna.",
	"Posticiperemo la live di 1, 2, 3, 4, 5...\nFatemi sapere.",
	"Heil Pace.",
	"Carta Lampo.",
	"Kago, il cattivo della quarta.",
	"Fino a prova contraire.",
	"Che succede se accendo qui?",
	"NOO, LA ZONA FORNI!",
	"BANJO E CAZZO!",
	"HO LA PESTEEEE!",
	"UE' CIOLINO!",
	"Lo sapevi?\nI libri di pongo, sono fatti di pongo.",
	"Hey, avventuriero!",
	"Della tua vita fanne un carpentiere.",
	"Mi usurpa.",
	"...Burbo?",
	"Palmo Cosmico.",
	"Il contrario di \"con\"?:\nCan",
	"\"Party\" in Italiano:\n\"Par...ta\".",
	"10mila Api Incazzate Approvano Questo Gioco.",
	"L'errata convinzione che...",
	"Pompilio Numanzio\nBombasto Marcellino\nDei Mortacci",
	"Quack. 🪿",
	"Giovanni Furla... Ma dove sei?",
	"Una massiccia con salsiccia.",
	"Pensa pure al vostro backup dati.",
	"Gemma del Sudan.",
	"Buleone Dance.",
	"Rimborso Cane.",
	"Fungro.",
	"We are soapy… soapy moments.",
	"Fighini.",
	"U' Cantuccio Muldavo.",
	"Carbo :(",
	"Granito.",
	"Io amo i fottuti Pokemon.",
	"Io non so... Se si può...",
	"Mangiar pasta a mezzogiorno.",
	"I looove you boy, you are my loooving toy.",
	"Von Winterfelt.",
	"Ne ho letto a riguardo.",
	"Marco e Daniele e Daniele e Marco.",
	"Fallout Boys ma uno dorme a New Vegas.",
	"Corde di Salame.",
	"Per fortuna non era una piada agnagnagnagna."
]
@export var time_per_character: float = 0.05
@export var finished_wait_time: float = 2.0
@export var fade_in_duration: float = 0.5
@export var fade_out_duration: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	fadeInTween()
	await writingAnimation2(phrases.pick_random())
	
	await get_tree().create_timer(finished_wait_time, true, false, true).timeout
	await fadeOutTween()
	
	get_tree().change_scene_to_packed(next_scene)

func writingAnimation(new_text: String) -> void:
	%textLabel.text = new_text
	
	var tween: Tween = create_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	
	var total_duration: float = new_text.length() * time_per_character
	
	tween.tween_property(%textLabel, "visible_ratio", 1.25, total_duration)
	
	await tween.finished


func writingAnimation2(new_text: String) -> void:
	%textLabel.text = new_text
	%textLabel.visible_ratio = 0  # Inizia con il testo invisibile
	
	# Invece di usare un tween, usiamo un ciclo per controllare ogni carattere
	for i: int in range(new_text.length() + 1):
		%textLabel.visible_ratio = float(i) / new_text.length()
		
		if i < new_text.length():
			SfxPlayer.play(6, 0.95, 1.05)
		
		# Aspetta il tempo per ogni carattere
		await get_tree().create_timer(time_per_character, true, false, true).timeout
	
	# Assicuriamoci che alla fine sia completamente visibile
	%textLabel.visible_ratio = 1.0

func fadeInTween() -> void:
	var tween: Tween = create_tween()
	
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_EXPO)
	
	tween.tween_property(%textLabel, "modulate", Color.WHITE, fade_in_duration).from(Color.TRANSPARENT)

func fadeOutTween() -> void:
	var tween: Tween = create_tween()
	
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	
	tween.tween_property(%textLabel, "modulate", Color.TRANSPARENT, fade_out_duration)
	
	await tween.finished
