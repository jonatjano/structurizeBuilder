import std.stdio;
import nbt;
import Blueprint;
import fileReader;

void main() {
	auto nbt = parseBytes(getFileBytes("/code/tavern1.blueprint"));
	// auto bp = fromNbt(nbt);
	// bp.mcVersion.writeln;
	nbt.toJson(true).writeln;
}
