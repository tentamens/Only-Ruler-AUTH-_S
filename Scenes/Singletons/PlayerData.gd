extends Node

var Unit_data = "res://PlayerData.json"

var Player_Data



func _ready():
	
	var skill_data_file = File.new()
	skill_data_file.open(Unit_data, File.READ)
	var skill_data_json = JSON.parse(skill_data_file.get_as_text())
	skill_data_file.close()
	Player_Data = skill_data_json.result
	
func SavePlayersIDs():
	var save_file = File.new()
	save_file.open(Unit_data, File.WRITE)
	save_file.store_line(to_json(Player_Data))
	save_file.close()
