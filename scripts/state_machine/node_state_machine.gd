# Defines a custom class called NodeStateMachine that can be used in other scripts
class_name NodeStateMachine
# Makes this class inherit from the Node class in Godot
extends Node

# Exports a variable to be set in the editor, specifying the initial state of the state machine
# NodeState is a custom class that defines the base state behavior with _on_enter(), _on_exit(), _on_process(), _on_physics_process(), and _on_next_transitions()
@export var initial_node_state : NodeState

# Dictionary to store all state nodes, with state names as keys and NodeState objects as values
# Each NodeState can emit a "transition" signal to trigger state changes
var node_states : Dictionary = {}
# Reference to the currently active NodeState instance
var current_node_state : NodeState
# Stores the name of the current state for easy reference
var current_node_state_name : String

# Called when the node is ready (initialized)
func _ready() -> void:
	# Loop through all child nodes of this state machine
	for child in get_children():
		# Check if the child is a NodeState instance
		if child is NodeState:
			# Store the state in the dictionary with its lowercase name as the key
			node_states[child.name.to_lower()] = child
			# Connect the NodeState's transition signal to the transition_to function
			# When a state emits its transition signal, it will trigger this state machine's transition_to method
			child.transition.connect(transition_to)
	
	# If an initial state was specified in the editor
	if initial_node_state:
		# Call the NodeState's enter function which can be overridden by child classes
		initial_node_state._on_enter()
		# Set it as the current state
		current_node_state = initial_node_state
		current_node_state_name = current_node_state.name.to_lower()


# Called every frame for non-physics updates
func _process(delta : float) -> void:
	# If there is a current state, call its process function
	# This calls the NodeState's _on_process method which can be overridden by child classes
	if current_node_state:
		current_node_state._on_process(delta)


# Called every physics frame for physics-based updates
func _physics_process(delta: float) -> void:
	# If there is a current state
	if current_node_state:
		# Call the NodeState's physics process function which can be overridden by child classes
		current_node_state._on_physics_process(delta)
		# Check for possible state transitions by calling the NodeState's transition check method
		current_node_state._on_next_transitions()
		print("Current State: ", current_node_state_name)


# Function to handle state transitions, called when a NodeState emits its transition signal
func transition_to(node_state_name : String) -> void:
	# If trying to transition to the same state, do nothing
	if node_state_name == current_node_state.name.to_lower():
		return
	
	# Try to get the new NodeState instance from the dictionary
	var new_node_state = node_states.get(node_state_name.to_lower())
	
	# If the state doesn't exist, do nothing
	if !new_node_state:
		return
	
	# If there is a current state, call its exit function
	# This triggers the NodeState's _on_exit method which can be overridden by child classes
	if current_node_state:
		current_node_state._on_exit()
	
	# Call the enter function of the new state
	# This triggers the NodeState's _on_enter method which can be overridden by child classes
	new_node_state._on_enter()
	
	# Update the current state references
	current_node_state = new_node_state
	current_node_state_name = current_node_state.name.to_lower()
	# Print debug information about the state change
	#print("Current State: ", current_node_state_name)
