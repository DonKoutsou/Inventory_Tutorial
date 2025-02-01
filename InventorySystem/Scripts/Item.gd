extends Resource

class_name Item

@export var _ItemName : String
@export var _ItemDescription : String
@export var _ItemWeight : float
@export var _ItemIcon : Texture

func GetItemName() -> String:
	return _ItemName

func GetItemDescription() -> String:
	return _ItemDescription

func GetItemWeight() -> float:
	return _ItemWeight

func GetItemIcon() -> Texture:
	return _ItemIcon

func CanStack() -> bool:
	return true
