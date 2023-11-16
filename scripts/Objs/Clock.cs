using System.Threading.Tasks;
using Godot;
using W0rld.scripts.Objs.Interfaces;

namespace W0rld.scripts.Objs;

public partial class Clock : Abstract.MovableObj, IClickable
{
    private AnimatedSprite2D _sprite2D;
    private AudioStreamPlayer2D _beepPlayer;
    private AudioStreamPlayer2D _closePlayer;
    private Marker2D _marker2D;

    private int _destroyCount = 3;
    private int _currentCount = 0;
    private float _waitTime = 8f;

    [Export] private PackedScene _boomPrefab;
    [Export] private PackedScene _hourHandPrefab;

    private float _boomSize = 1.2f;

    private bool _isDestroy = false;

    private bool IsPlay
    {
        get => _sprite2D.IsPlaying();
        set
        {
            if (_sprite2D.IsPlaying())
            {
                if (!value)
                {
                    _sprite2D.Stop();
                    _beepPlayer.Stop();
                    _closePlayer.Play();
                    _currentCount++;
                    if (_currentCount < _destroyCount)
                    {
                        var _ = WaitForNextBeep();
                    }
                    else
                    {
                        var boom = _boomPrefab.Instantiate<Boom>();
                        GetParent().AddChild(boom);
                        boom.GlobalPosition = _marker2D.GlobalPosition;
                        boom.Play(Vector2.One * _boomSize);
                        var hourHand = _hourHandPrefab.Instantiate<HourHand>();
                        GetParent().AddChild(hourHand);
                        hourHand.GlobalPosition = _marker2D.GlobalPosition;
                        _isDestroy = true;
                    }
                }
            }
            else
            {
                if (value)
                {
                    _sprite2D.Play();
                    _beepPlayer.Play();
                }
            }
        }
    }


    public override void _Ready()
    {
        base._Ready();
        Information = "this is a Clock.";
        _sprite2D = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
        _beepPlayer = GetNode<AudioStreamPlayer2D>("beep");
        _closePlayer = GetNode<AudioStreamPlayer2D>("close");
        _marker2D = GetNode<Marker2D>("Marker2D");
        IsPlay = true;
    }

    // public override void SetOrder(bool isFront)
    // {
    //     // GetNode<AnimatedSprite2D>("AnimatedSprite2D").ZIndex = isFront ? 1 : 0;
    // }

    public bool OnClick()
    {
        IsPlay = false;
        return _isDestroy;
    }

    private async Task WaitForNextBeep()
    {
        await Task.Delay((int)(_waitTime * 1000));
        IsPlay = true;
    }
}