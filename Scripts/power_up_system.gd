extends Node

class_name PowerUpSystem

var player: Player

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var bomb_placement_system: BombPlacementSystem = $"../BombPlacementSystem"
@onready var speed_up_timer: Timer = $SpeedUpTimer

const SPEED_MULTIPLIER = 3

func _ready() -> void:
	player = get_parent()

func enable_power_up(power_up_type: Utils.PowerUpType):
	match power_up_type:
		Utils.PowerUpType.BOMB_UP:
			player.max_bombs_at_once += 1
		Utils.PowerUpType.FIRE_UP:
			bomb_placement_system.explosion_size += 1
		Utils.PowerUpType.SPEED_UP:
			player.movement_speed *= SPEED_MULTIPLIER
			animated_sprite_2d.speed_scale = 3
			speed_up_timer.start()
		Utils.PowerUpType.WALL_PASS:
			var raycast_nodes = get_tree().get_nodes_in_group("raycasts") as Array[RayCast2D]
			for raycast in raycast_nodes:
				raycast.set_collision_mask_value(3, false)


func _on_speed_up_timer_timeout() -> void:
	player.movement_speed /= SPEED_MULTIPLIER
	animated_sprite_2d.speed_scale = 1
