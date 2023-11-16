using Godot;

namespace W0rld.scripts.Global;

public partial class AudioUnit : Resource
{
    [Export] public AudioStream audio;
    [Export] public float velocity;
}