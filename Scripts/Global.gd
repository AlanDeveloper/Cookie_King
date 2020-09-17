extends Node

var savefile = File.new()
var savepath = "user://savegame.save"
var savedata = {
	"cookie": {
		"amount": 0,
		"per_second": 0,
		"chance_normal": 15,
		"chance_gold": 5,
		"time_of_generate": 1
	},
	"store": [{
		"name": "Employee",
		"initial": 10,
		"level": 0,
		"gain": 1,
		"unlock_level": true
	}, {
		"name": "Market",
		"initial": 400,
		"level": 0,
		"gain": 5,
		"unlock_level": false
	}, {
		"name": "Farm",
		"initial": 3000,
		"level": 0,
		"gain": 8,
		"unlock_level": false
	}, {
		"name": "Industry",
		"initial": 6000,
		"level": 0,
		"gain": 10,
		"unlock_level": false
	}]
}

func _ready():
	if savefile.file_exists(savepath):
		save()
	read()
	
func save():
	savefile.open(savepath, File.WRITE)
	savefile.store_var(savedata)
	savefile.close()

func read():
	savefile.open(savepath, File.READ)
	savedata = savefile.get_var()
	savefile.close()

func cookie_click():
	savedata["cookie"]["amount"] += 1
	save()

func cookie_gain(gain):
	savedata["cookie"]["amount"] += gain
	save()

func buy(price, type):
	if savedata["cookie"]["amount"] >= price:
		savedata["cookie"]["amount"] -= price
		savedata["cookie"]["per_second"] += type["gain"]
		type["level"] += 1
		save()
		return true
	else:
		return false
