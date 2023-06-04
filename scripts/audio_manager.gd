extends Node

var time_begin
var time_delay

#func _ready():
#	time_begin = Time.get_ticks_usec()
#	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
#	$BackgroundPlayer.play()

# func _process(delta):
#	var time = (Time.get_ticks_usec() - time_begin) / 1000000.0
#	time -= time_delay
#	time = max(0, time)
#	print("Time is: ", time)
