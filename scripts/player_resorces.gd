extends Node

var money: int
var sap_buckets: int
var maple_syroup_bottles: int
var loaded = false

func change_money(mny):
	money += mny
	get_parent().get_node("Tree_plantation").get_node("Money").text = "Money: $" + str(money)

func change_sap_buckets(amt):
	sap_buckets += amt

func take_grown_state() -> Array:
	var grown_state_list = []
	for child in get_parent().get_node("Tree_plantation").get_children():
		if "Pot" in child.name:
			grown_state_list.append([child.name, child.groth_state])
	return grown_state_list

func save_game() -> void:
	var save_date = {
		"money": money,
		"sap_buckets": sap_buckets,
		"maple_syroup_bottles": maple_syroup_bottles,
		"status": take_grown_state()
	}
	var file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_date))
		file.close()
		print("działa zapis")
	else:
		print("nie działa zapis")

func load_game() -> void:
	if not FileAccess.file_exists("user://savegame.json"):
		print("brak pliku przy load")
	var file = FileAccess.open("user://savegame.json", FileAccess.READ)
	if file:
		var data = JSON.parse_string(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			money = data.get("money")
			sap_buckets = data.get("sap_buckets")
			maple_syroup_bottles = data.get("maple_syroup_bottles")
			var status = data.get("status")
			var list_of_pots = []
			for child in get_parent().get_node("Tree_plantation").get_children():
				if "Pot" in child.name:
					list_of_pots.append(child)
			for s in status:
				for i in list_of_pots:
					if s[0] == i.name:
						i.groth_state = s[1]
						break
			print("load działa")
		else:
			print("load wyjebał się")
	PlayerResorces.loaded = false
