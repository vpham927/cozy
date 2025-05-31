class_name Player
extends CharacterBody2D

#This is the current tool the player is using
#We use the DataTypes.Tools enum to define the tools
@export var current_tool : DataTypes.Tools = DataTypes.Tools.None
var player_direction: Vector2
