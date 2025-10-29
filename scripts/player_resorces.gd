extends Node

var money: int
var sap_buckets: int
var maple_syroup_bottles: int

func change_money(mny):
	money += mny
	get_parent().get_node("Tree_plantation").get_node("Money").text = "Money: $" + str(money)

func change_sap_buckets(amt):
	sap_buckets += amt
