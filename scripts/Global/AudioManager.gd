extends Node2D
class_name AudioManager

var audios = {}

var bgm_player : AudioStreamPlayer
var sound_player : AudioStreamPlayer

func _ready():
	bgm_player = $BGMPlayer;
	sound_player = $SoundPlayer;
	audios["bgm_in"] = ResourceLoader.load("res://audios/units/bgm_in.tres") as AudioUnit
	audios["bgm"] = ResourceLoader.load("res://audios/units/bgm.tres") as AudioUnit
	audios["coin_fall"] = ResourceLoader.load("res://audios/units/coin_fall.tres") as AudioUnit
	audios["card_reverse"] = ResourceLoader.load("res://audios/units/card_reverse.tres") as AudioUnit
	audios["rubik_play"] = ResourceLoader.load("res://audios/units/rubik_play.tres") as AudioUnit


func play_bgm():
	var bgm_in_audio_unit : AudioUnit = audios["bgm_in"]
	bgm_player.stream = bgm_in_audio_unit.audio
	bgm_player.volume_db = bgm_in_audio_unit.velocity
	bgm_player.play()
	bgm_player.finished.connect(
		func on_finished() : 
			var bgm_audio_unit : AudioUnit = audios["bgm"]
			bgm_player.stream = bgm_audio_unit.audio
			bgm_player.volume_db = bgm_audio_unit.velocity
			bgm_player.play()
			)

func play(audio_name: String):
	var audio_unit : AudioUnit = audios[audio_name]
	if audio_unit != null:
		sound_player.stream = audio_unit.audio
		sound_player.volume_db = audio_unit.velocity
		sound_player.play()
	
	

func bgm_louder(factor: float):
	bgm_player.volume_db *= factor
	bgm_player.finished.connect( 
		func () :
			print("hello")
	)
	
	
	
	
