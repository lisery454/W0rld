using Godot;

namespace W0rld.scripts;

public partial class Boom : Node2D
{
    private AnimatedSprite2D _animatedSprite2D;
    private AudioStreamPlayer2D _audioStreamPlayer;

    public override void _Ready()
    {
        _animatedSprite2D = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
        _audioStreamPlayer = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");
    }

    public void Play(Vector2 size)
    {
        _animatedSprite2D ??= GetNode<AnimatedSprite2D>("AnimatedSprite2D");

        Scale = size;
        _animatedSprite2D.Play();
        _audioStreamPlayer.Play();
        _animatedSprite2D.AnimationFinished += QueueFree;
    }
}