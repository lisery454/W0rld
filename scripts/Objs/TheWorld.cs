using Godot;
using W0rld.scripts.Objs.Abstract;
using W0rld.scripts.Objs.Interfaces;

public partial class TheWorld : MovableObj, IOnThrow
{
    private AnimationPlayer _animationPlayer;

    private bool _isFlip;

    public override void _Ready()
    {
        base._Ready();
        Information = "this is a tarot card.";
        _animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
        _isFlip = false;
    }

    public void OnThrow(Vector2 speed)
    {
        if (!_isFlip && Mathf.Abs(speed.X) > 900)
        {
            _animationPlayer.Play("flip");
            _isFlip = true;
            Information = "this is THE WORLD.";
        }
    }
}