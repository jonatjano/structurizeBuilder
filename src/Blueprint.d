import nbt;
import std.algorithm : map;
import std.array : array;

class Blueprint {
	string[] requiredMods;
	
	Point3D size;
	
	BlockState[] palette;
	string name;
	
	int mcVersion;
	
	short[][][] structure;
	
	NbtCompound[] tileEntities;
	
	Point3D primaryOffset;
	
	this(NbtCompound nbt) {
		mcVersion = nbt.get!NbtInt("mcversion").value;
		
		size = Point3D(
			nbt.get!NbtShort("size_x").value,
			nbt.get!NbtShort("size_y").value,
			nbt.get!NbtShort("size_z").value
		);
		
		requiredMods = nbt.get!NbtList("required_mods").values.map!(nbtStr => (cast(NbtString)nbtStr).value).array;
		
		palette = nbt.get!NbtList("palette").values.map!(nbtVal => BlockState(cast(NbtCompound)nbtVal)).array;
	}
}



NbtCompound toNbt(Blueprint bp) {
    return new NbtCompound;
}

struct BlockState {
	string name;
	string[string] properties;
	
	this(NbtCompound nbt) {
		name = nbt.get!NbtString("Name").value;
		
		foreach(pair; nbt.get!NbtCompound("Properties").values.byKeyValue) {
			properties[pair.key] = (cast(NbtString)pair.value).value;
		}
	}
}


NbtCompound toNbt(BlockState bs) {
	auto ret = new NbtCompound;
	ret.set("Name", bs.name);
	
	if (bs.properties.length != 0) {
		auto props = new NbtCompound;
		foreach(pair; bs.properties.byKeyValue) {
			props.set(pair.key, pair.value);
		}
		ret.set("Properties", props);
	}
	
	return ret;
}

struct Point3D {
	short x;
	short y;
	short z;
}
