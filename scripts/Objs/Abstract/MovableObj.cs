using Godot;
using W0rld.scripts.Objs.Interfaces;

namespace W0rld.scripts.Objs.Abstract;

public partial class MovableObj : RigidBody2D, IObj
{
    private float _frictionFactor = 10f;
    private float _velocityThreshold = 10;

    public override void _Ready()
    {
        Information = "this is an apple.";
    }

    public void SetOrder(int order)
    {
        // GetNode<Sprite2D>("Sprite2D").ZIndex = isFront ? 1 : 0;
        ZIndex = order;
    }


    public override void _PhysicsProcess(double delta)
    {
        if (LinearVelocity.Length() < _velocityThreshold)
            LinearVelocity = Vector2.Zero;
        else
        {
            var linearVelocity = LinearVelocity - LinearVelocity.Normalized() * _frictionFactor * _frictionFactor;
            var x = linearVelocity.X * LinearVelocity.X < 0
                ? Mathf.Min(linearVelocity.X, 0)
                : linearVelocity.X;
            var y = linearVelocity.Y * LinearVelocity.Y < 0
                ? Mathf.Min(linearVelocity.Y, 0)
                : linearVelocity.Y;
            
            LinearVelocity = new Vector2(x, y);
        }
    }

    public string Information { get; set; }
}