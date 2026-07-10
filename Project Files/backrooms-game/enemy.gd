class_name PartyGoer extends CharacterBody3D

var player = null
var state_machine

const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const ATTACK_RANGE = 2.0
const Too_Far_Away = 7.0


@export var player_path : NodePath

@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $"A-Pose/AnimationTree"
@onready var collisionshape = $CollisionShape3D
@onready var raycast = $RayCast

func _ready() -> void:
	player = get_node(player_path)
	state_machine = anim_tree.get("parameters/playback")

func _physics_process(_delta: float) -> void:
	match state_machine.get_current_node():
		"Idle":
			# get the direction vector pointing from enemy to player
			# get the forward direction vector for the enemy (this is probably Vector3.FORWARD)
			# compute the dot product of the two
			# if it's greater than zero, go ahead and do the raycast stuff
			# otherwise don't do the raycast stuff
			raycast.look_at(player.global_position, Vector3.UP)
			if raycast.is_colliding():
				if raycast.get_collider() == player: 
					if Global.in_combat == false and !too_far():
						anim_tree.set("parameters/conditions/Walk", true)

		"Walk":
			if Global.in_combat == false and !too_far():
				velocity = Vector3.ZERO
				
				nav_agent.set_target_position(player.global_position)
				var next_nav_point = nav_agent.get_next_path_position()
				velocity = (next_nav_point - global_position).normalized() * SPEED
				look_at(Vector3(next_nav_point.x, global_position.y, next_nav_point.z), Vector3.UP)
				anim_tree.set("parameters/conditions/Attack", target_in_range())

				move_and_slide()
			if too_far():
				pass
			
		"Attack":
			anim_tree.set("parameters/conditions/Walk", !target_in_range())
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
			
func target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE
	

func too_far():
	return global_position.distance_to(player.global_position) > Too_Far_Away

func _on_animation_tree_animation_finished(_anim_name: StringName) -> void:
	$Area3D/CollisionShape3D.disabled = false


func _on_player_3d_delete_partygoer() -> void:
	queue_free()
