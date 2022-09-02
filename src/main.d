import std.stdio;
import nbt;
import fileReader;

void main() {
	parseBytes(getFileBytes("/code/tavern1.blueprint")).toJson(true).writeln;
}
