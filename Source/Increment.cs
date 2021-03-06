namespace kCura.PDB.Core
{
	using System;
	using System.Runtime.InteropServices;

	/// <summary>
	/// Note: This class is intended to just make sure that every pdb assembly has "new" code in it 
	/// so that Relativity will mark the dll as changed when it uploads it. File is modified during
	/// build by ForceUpdateDLLS.ps1 
	/// </summary>
	[Guid("fc28e6ae-75e9-41f2-8177-567753ead9fb")]
	public class zClass_2017_12_7_14_7_2
	{
		public Guid IncrementGuid = new Guid("fc28e6ae-75e9-41f2-8177-567753ead9fb");

		private int value;

		public int _method_2017_12_7_14_7_2(int _param_2017_12_7_14_7_2)
		{
			value = 1305892069; // Update this value
			value += _param_2017_12_7_14_7_2;

			return value;
		}

		public int _method2_2017_12_7_14_7_2 => 1305892069; // Update this value
	}


	public class zClass2_2017_12_7_14_7_2
	{
		public string Id { get; set; }
	}
}
