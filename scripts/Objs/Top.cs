using System;
using System.Collections.Generic;
using Godot;
using W0rld.scripts.Global;

namespace W0rld.scripts.Objs;

public partial class Top : Abstract.MovableObj
{
    private AnimatedSprite2D _animatedSprite2D;

    private bool _isRotating;
    private List<Vector2> _speedRecord;

    private int _recordMaxCount = 15;

    // private float _speedThreshold = 400;
    private float _angleThreshold = 2f;
    private float _energyThreshold = 80f;
    private float _energy;

    public override void _Ready()
    {
        base._Ready();
        Information = "this is a Top.";
        _animatedSprite2D = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
        _speedRecord = new List<Vector2>();
    }

    public override void _PhysicsProcess(double delta)
    {
        base._PhysicsProcess(delta);
        _speedRecord.Add(LinearVelocity);
        if (_speedRecord.Count > _recordMaxCount)
        {
            _speedRecord.RemoveAt(0);
        }

        if (_speedRecord.Count == _recordMaxCount)
        {
            var begin = _speedRecord[0];
            var middle = _speedRecord[(_recordMaxCount - 1) / 2];
            var end = _speedRecord[_recordMaxCount - 1];
            // var speedDelta = Math.Abs((end - middle).Length() - (middle - begin).Length());
            var angleDelta = Math.Abs((end - middle).AngleTo(middle - begin));
            // GD.Print($"speed: {speedDelta} \t angle : {angleDelta}");
            if (angleDelta > _angleThreshold)
            {
                _energy++;
            }
            else _energy--;

            if (_energy < 0) _energy = 0;

            // GD.Print($"{_energy}");
            if (_energy >= _energyThreshold && !_isRotating)
            {
                _animatedSprite2D.Play("play");
                _isRotating = true;
                GetNode<AudioManager>("/root/AudioManager").PlayBgm();
            }
        }
    }
}