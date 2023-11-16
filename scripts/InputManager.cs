using System.Linq;
using Godot;
using W0rld.scripts.Objs.Abstract;
using W0rld.scripts.Objs.Interfaces;

namespace W0rld.scripts;

public partial class InputManager : Node2D
{
    private RayCast2D _rayCast2D;

    private MovableObj _currentObj;

    private MovableObj _currentDragObj;

    private int _dragZIndex = 1;

    private float _speedFactor = 20;

    private Label _infoLabel;

    private bool IsDragging => _currentDragObj != null;

    private Vector2 _lastMousePos;

    public override void _Ready()
    {
        _rayCast2D = GetNode<RayCast2D>("RayCast2D");
        _currentObj = null;
        _currentDragObj = null;
        _infoLabel = GetParent().GetNode<Label>("CanvasLayer/Label");
        _lastMousePos = Vector2.Zero;
    }

    public override void _Process(double delta)
    {
        _infoLabel.Text = _currentObj != null ? _currentObj.Information : string.Empty;
    }

    public override void _PhysicsProcess(double delta)
    {
        // update ray pos;
        var mousePosition = GetViewport().GetMousePosition();
        _rayCast2D.Position = mousePosition;

        if (mousePosition != _lastMousePos)
        {
            if (!IsDragging)
            {
                // detect if coll
                if (_rayCast2D.IsColliding() && _rayCast2D.GetCollider() is MovableObj obj)
                {
                    _currentObj = obj;
                }
                else _currentObj = null;
            }
            else
            {
                // keep drag node move
                var windowSize = GetViewport().GetVisibleRect().Size;
                if (mousePosition.X < windowSize.X && mousePosition.X > 0 &&
                    mousePosition.Y < windowSize.Y && mousePosition.Y > 0)
                {
                    var currentDragObj = (RigidBody2D)_currentDragObj;
                    var distanceTo = currentDragObj.Position.DistanceTo(mousePosition);
                    var directionTo = currentDragObj.Position.DirectionTo(mousePosition);

                    currentDragObj.LinearVelocity = directionTo * distanceTo * _speedFactor;
                }
            }
        }

        _lastMousePos = mousePosition;
    }

    public override void _Input(InputEvent @event)
    {
        if (@event is InputEventMouseButton e)
        {
            if (e.IsPressed() && e.ButtonIndex == MouseButton.Left) OnLeftMouseDown();

            if (e.IsReleased() && e.ButtonIndex == MouseButton.Left) OnLeftMouseUp();
        }
    }

    private void OnLeftMouseUp()
    {
        if (IsDragging)
        {
            if (_currentDragObj is IOnThrow onThrow)
            {
                onThrow.OnThrow(_currentDragObj.LinearVelocity);
            }

            _currentDragObj = null;
        }
    }

    private void OnLeftMouseDown()
    {
        if (!IsDragging && _currentObj != null)
        {
            _currentDragObj = _currentObj;
            _currentDragObj.SetOrder(_dragZIndex);
            _dragZIndex++;

            if (_currentObj is IClickable clickable)
            {
                var isDestroy = clickable.OnClick();
                if (isDestroy)
                {
                    _currentObj.QueueFree();
                    _currentObj = null;
                    _currentDragObj = null;
                }
            }
        }
    }
}