using System.Collections.Generic;
using Godot;

namespace W0rld.scripts.Global;

public partial class AudioManager : Node2D
{
    private Dictionary<string, AudioUnit> _audios;

    private AudioStreamPlayer _bgmPlayer;
    private AudioStreamPlayer _soundPlayer;

    public override void _Ready()
    {
        _bgmPlayer = GetNode<AudioStreamPlayer>("BGMPlayer");
        _soundPlayer = GetNode<AudioStreamPlayer>("SoundPlayer");
        _audios = new Dictionary<string, AudioUnit>
        {
            { "bgm_in", ResourceLoader.Load<AudioUnit>("res://audios/units/bgm_in.tres") },
            { "bgm", ResourceLoader.Load<AudioUnit>("res://audios/units/bgm.tres") },
        };
    }

    public void PlayBgm()
    {
        var audioUnit = _audios["bgm_in"];
        _bgmPlayer.Stream = audioUnit.audio;
        _bgmPlayer.VolumeDb = audioUnit.velocity;
        _bgmPlayer.Play();
        _bgmPlayer.Finished += () =>
        {
            audioUnit = _audios["bgm"];
            _bgmPlayer.Stream = audioUnit.audio;
            _bgmPlayer.VolumeDb = audioUnit.velocity;
            _bgmPlayer.Play();
        };
    }

    public void Play(string name)
    {
        if (_audios.TryGetValue(name, out var audioUnit))
        {
            _soundPlayer.Stream = audioUnit.audio;
            _soundPlayer.VolumeDb = audioUnit.velocity;
            _soundPlayer.Play();
        }
    }
}