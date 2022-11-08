using Godot;
using System;

public class Player : KinematicBody2D
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";

	int speed = 700;

	public override void _PhysicsProcess(float _delta)
	{
		var input_vector = new Vector2(
			Input.GetActionStrength("ui_right") - Input.GetActionStrength("ui_left"),
			Input.GetActionStrength("ui_down") - Input.GetActionStrength("ui_up")
		);

		Console.WriteLine(input_vector);

		var move_direction = input_vector.Normalized();
		MoveAndSlide(speed * move_direction);
	}

	// Called when the node enters the scene tree for the first time.
	//	public override void _Ready()
	//	{

	//	}

	//  // Called every frame. 'delta' is the elapsed time since the previous frame.
	//  public override void _Process(float delta)
	//  {
	//      
	//  }
}
