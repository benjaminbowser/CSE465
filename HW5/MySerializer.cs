using System;
using System.Collections.Generic;
using System.Reflection;

namespace Serializer {
	public class MySerializer {
		
		public static string Serialize(Object obj) {
			String s = "";
			FieldInfo[] info = obj.GetType().GetFields();
			
			int i = 0;
			while (i < info.Length) {
				s += info[i].FieldType + "\t";
				s += info[i].Name + "\t";
				s += info[i].GetValue(obj) + "\n";
				i++;
			}
			
			return s;
		}
		public static T Deserialize<T>(string str) {
			Type type = typeof(T);
			ConstructorInfo ctor = type.GetConstructor(new Type[] { });
			T obj = (T)ctor.Invoke(new Object[] { });

			List<string> vars = new List<string>(str.Split('\t', '\n')); 
	
			int i = 0;
			
			while (i < vars.Count - 3){
				string t = vars[i];
				string n = vars[i+1];
				string v = vars[i+2];
				FieldInfo info = type.GetField(n);

				if (t == "System.Int32") {info.SetValue(obj, Int32.Parse(v));}
				if (t == "System.Double") {info.SetValue(obj, Double.Parse(v));}
				if (t == "System.Boolean") {info.SetValue(obj, Boolean.Parse(v));}
				i += 3;
			}
			
			return obj;
		}
	}
	public class Point {
		public int x, y;
		public Point() {
			x = y = 0;
		}
		public Point(int X, int Y) {
			x = X;
			y = Y;
		}
		public override string ToString() {
			return "x: " + x + "\ny: " + y;
		}
			
	}
	public class Test {
		public static void Main(String [] args) {	
			Point p1 = new Point(2, 3);
			String str1 = MySerializer.Serialize(p1);
			Console.WriteLine(str1);
			Point newPt = MySerializer.Deserialize<Point>(str1);
			Console.WriteLine(newPt);
		}
	}
}