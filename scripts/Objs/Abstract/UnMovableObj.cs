using Godot;
using W0rld.scripts.Objs.Interfaces;

namespace W0rld.scripts.Objs.Abstract;

public partial class UnMovableObj : StaticBody2D, IObj
{
    public string Information { get; set; }
}