using W0rld.scripts.Objs.Abstract;

namespace W0rld.scripts.Objs;

public partial class PiggyBank : MovableObj
{
	public override void _Ready()
	{
		base._Ready();
		Information = "this is a Piggy Bank.";
	}
}
