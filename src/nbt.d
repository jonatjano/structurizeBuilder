import std.conv : to;
import std.math : pow;
import std.algorithm.mutation : swap;
import std.array : replicate;

import std.stdio : writeln, write;

int depth = 0;

abstract class Nbt {
	enum Type {
		End = 0,
		Byte = 1,
		Short = 2,
		Int = 3,
		Long = 4,
		Float = 5,
		Double = 6,
		ByteArray = 7,
		String = 8,
		List = 9,
		Compound = 10,
		IntArray = 11,
		LongArray = 12
	}
	
	abstract Type getType() const;
	
    abstract void toString(scope void delegate(const(char)[]) sink) const;
	abstract string toJson(bool humanReadable = false) const;
}

class NbtByte : Nbt {
	ubyte value;
	
	this(ubyte value) {
		this.value = value;
	}

	override Type getType() const {return Type.Byte;}
	
    override void toString(scope void delegate(const(char)[]) sink) const
    {
    	sink("TAG_BYTE { ");
    	sink(value.to!string);
    	sink(" }");
    }

	override string toJson(bool humanReadable = false) const {
		return value.to!string;
	}
}

class NbtShort : Nbt {
	ushort value;
	
	this(ushort value) {
		this.value = value;
	}
	
	override Type getType() const {return Type.Short;}
	
    override void toString(scope void delegate(const(char)[]) sink) const
    {
    	sink("TAG_SHORT { ");
    	sink(value.to!string);
    	sink(" }");
    }

	override string toJson(bool humanReadable = false) const {
		return value.to!string;
	}
}

class NbtInt : Nbt {
	uint value;
	
	this(uint value) {
		this.value = value;
	}
	
	override Type getType() const {return Type.Int;}
	
    override void toString(scope void delegate(const(char)[]) sink) const
    {
    	sink("TAG_INT { ");
    	sink(value.to!string);
    	sink(" }");
    }

	override string toJson(bool humanReadable = false) const {
		return value.to!string;
	}
}

class NbtLong : Nbt {
	ulong value;
	
	this(ulong value) {
		this.value = value;
	}
	
	override Type getType() const {return Type.Long;}
	
    override void toString(scope void delegate(const(char)[]) sink) const
    {
    	sink("TAG_LONG { ");
    	sink(value.to!string);
    	sink(" }");
    }

	override string toJson(bool humanReadable = false) const {
		return value.to!string;
	}
}

class NbtFloat : Nbt {
	override Type getType() const {return Type.Float;}
	
    override void toString(scope void delegate(const(char)[]) sink) const
    {
    	sink("TAG_FLOAT { ");
    	// sink(value.to!string);
    	sink(" }");
    }

	override string toJson(bool humanReadable = false) const {
		assert(0);
		return "";
	}
}

class NbtDouble : Nbt {
	override Type getType() const {return Type.Double;}
	
    override void toString(scope void delegate(const(char)[]) sink) const
    {
    	sink("TAG_DOUBLE { ");
    	// sink(value.to!string);
    	sink(" }");
    }

	override string toJson(bool humanReadable = false) const {
		assert(0);
		return "";
	}
}

class NbtByteArray : Nbt {
	override Type getType() const {return Type.ByteArray;}
	
    override void toString(scope void delegate(const(char)[]) sink) const
    {
    	sink("TAG_BYTE_ARRAY { ");
    	// sink(value.to!string);
    	sink(" }");
    }

	override string toJson(bool humanReadable = false) const {
		assert(0);
		return "";
	}
}

class NbtString : Nbt {
	public string value;
	
	this(string value) {
		this.value = value;
	}
	
	override Type getType() const {return Type.String;}
	
    override void toString(scope void delegate(const(char)[]) sink) const
    {
    	sink("TAG_STRING { ");
    	sink(value);
    	sink(" }");
    }

	override string toJson(bool humanReadable = false) const {
		return "\"" ~ value ~ "\"";
	}
}

class NbtList : Nbt {
	public Nbt[] values;
	private Nbt.Type _subType;
	
	this(Nbt.Type type) {
		_subType = type;
		values = [];
	}
	
	void push(Nbt value) {
		values ~= value;
	}

	override Type getType() const {return Type.List;}
	Nbt.Type subType() const { return _subType; }
	
    override void toString(scope void delegate(const(char)[]) sink) const
    {
    	sink("list <");
    	sink(subType.to!string);
    	sink("> {");
    	foreach (value; values) {
    		sink(value.to!string);
    	}
    	sink("}");
    }

	override string toJson(bool humanReadable = false) const {
		string ret = "[";

		foreach(i, item; values)
		{
		 	if (i != 0) {
				ret ~= ",";
				if (humanReadable) {
					if (subType == Type.List || subType == Type.ByteArray || subType == Type.IntArray || subType == Type.LongArray || subType == Type.Compound) {
						ret ~= "\n";
					} else {
						ret ~= " ";
					}
				}
			}
			ret ~= item.toJson(humanReadable);
		}
		
		return ret ~ "]";
	}
}

class NbtCompound : Nbt {
	public Nbt[NbtString] values;
	
	void set(NbtString key, Nbt value) {
		values[key] = value;
	}
	
	NbtString getString(NbtString key) {
		return cast(NbtString)values[key];
	}

	override Type getType() const {return Type.Compound;}
	
    override void toString(scope void delegate(const(char)[]) sink) const
    {
    	sink("compound {");
    	foreach (pair; values.byKeyValue) {
    		sink(pair.key.to!string);
    		sink(": ");
    		sink(pair.value.to!string);
    	}
    	sink("}");
    }

	override string toJson(bool humanReadable = false) const {
		bool newLine = true;
		string ret = humanReadable ? ("\t".replicate(depth++) ~ "{" ~ (newLine ? "\n" : "")) : "{";

		size_t i = 0;
		foreach (pair; values.byKeyValue)
		{
			if (i++ != 0) {
				ret ~= ",";
				if (newLine) {
					ret ~= "\n";
				}
			}
			ret ~= (newLine ? "\t".replicate(depth) : "") ~ pair.key.toJson ~ (humanReadable ? ": " : ":") ~ pair.value.toJson(humanReadable);
		}

		if (humanReadable) {
			depth--;
		}
		return ret ~ (newLine ? "\n" ~ "\t".replicate(depth) ~ "}" : "}");
	}
}

class NbtIntArray : Nbt {
	public NbtInt[] values;
	
	this() {
		values = [];
	}
	
	void push(NbtInt value) {
		values ~= value;
	}

	override Type getType() const {return Type.IntArray;}
	
    override void toString(scope void delegate(const(char)[]) sink) const
    {
    	sink("intArray ");
    	foreach (value; values) {
    		sink(value.to!string);
    	}
    	sink("}");
    }

	override string toJson(bool humanReadable = false) const {
		string ret = "[";

		foreach(i, item; values)
		{
			if (i != 0) {
				ret ~= ",";
				if (humanReadable) {
					ret ~= " ";
				}
			}
			ret ~= item.toJson;
		}

		return ret ~ "]";
	}
}

class NbtLongArray : Nbt {
	public NbtLong[] values;
	
	this() {
		values = [];
	}
	
	void push(NbtLong value) {
		values ~= value;
	}

	override Type getType() const {return Type.LongArray;}
	
    override void toString(scope void delegate(const(char)[]) sink) const
    {
    	sink("longArray ");
    	foreach (value; values) {
    		sink(value.to!string);
    	}
    	sink("}");
    }

	override string toJson(bool humanReadable = false) const {
		string ret = "[";

		foreach(i, item; values)
		{
			if (i != 0) {
				ret ~= ",";
				if (humanReadable) {
					ret ~= " ";
				}
			}
			ret ~= item.toJson;
		}

		return ret ~ "]";
	}
}

private abstract class NbtParser {
	static private ubyte[] payload;
	static private size_t index;
  
	static ubyte nextByte() {
		if (index < payload.length) {
			// payload[index].to!string.writeln;
			return payload[index++];
		}
		return 0;
	}

	mixin template nextNumByteMixin(Type, int Value = 1) {
		static Type nextNumByte(size_t size : Value)() {
			string merged = "";
			size_t i = size;
			while (i-- > 0) {
			  merged ~= nextByte().to!string(16);
			}
			return merged.to!Type(16);
		}
	}
	mixin nextNumByteMixin!(ubyte, 1);
	mixin nextNumByteMixin!(ushort, 2);
	mixin nextNumByteMixin!(uint, 4);
	mixin nextNumByteMixin!(ulong, 8);

	static short nextSignedShort() {
  		auto signedLimit = pow(2, 15);
  		auto value = nextNumByte!2;
		if (value >= signedLimit) {
			value -= signedLimit * 2;
		}
		return value;
	}
	

	static string nextCharByte(size_t size = 1) {
		ubyte[] list;
		while (size--) {
		  list ~= (nextNumByte!(1)).to!ubyte;
		}
		return list.to!string;
	}
	
	static NbtByte readData(Nbt.Type t : Nbt.Type.Byte)() {
		return new NbtByte(nextNumByte!1);
	}
	
	static NbtShort readData(Nbt.Type t : Nbt.Type.Short)() {
		return new NbtShort(nextNumByte!2);
	}
	
	static NbtInt readData(Nbt.Type t : Nbt.Type.Int)() {
		return new NbtInt(nextNumByte!4);
	}
	
	static NbtLong readData(Nbt.Type t : Nbt.Type.Long)() {
		return new NbtLong(nextNumByte!8);
	}
	
	static NbtFloat readData(Nbt.Type t : Nbt.Type.Float)() {
		assert(0);
		return new NbtFloat();
	}
	
	static NbtDouble readData(Nbt.Type t : Nbt.Type.Double)() {
		assert(0);
		return new NbtDouble();
	}
	
	static NbtByteArray readData(Nbt.Type t : Nbt.Type.ByteArray)() {
		assert(0);
		return new NbtByteArray();
	}
	
	static NbtString readData(Nbt.Type t : Nbt.Type.String)() {
		short size = nextSignedShort();
		string value = "";
		while (size--) {
			value ~= nextByte;
		}
		return new NbtString(value);
	}
	
	static NbtList readData(Nbt.Type t : Nbt.Type.List)() {
		Nbt.Type valueType = cast(Nbt.Type)(readData!(Nbt.Type.Byte).value);
		NbtList list = new NbtList(valueType);
		
		size_t size = readData!(Nbt.Type.Int).value;
		
		while (size--) {
			switch (valueType) {
				case Nbt.Type.Byte: list.push(readData!(Nbt.Type.Byte)); break;
				case Nbt.Type.String: list.push(readData!(Nbt.Type.String)); break;
				case Nbt.Type.Compound: list.push(readData!(Nbt.Type.Compound)); break;
				default: assert(0, "WIP list " ~ valueType.to!string); 
			}
		}
		
		return list;
	}
	
	static NbtCompound readData(Nbt.Type t : Nbt.Type.Compound)() {
	/*
      const obj = {}
      let subValueType = this.readData(types.byte)
      while (subValueType !== types.end) {
        const subValueName = this.readData(types.string)
        const subValue = this.readData(subValueType)
         
        obj[subValueName] = subValue
        
        subValueType = this.readData(types.byte)
      }
      return obj
	*/
		auto ret = new NbtCompound;
		
		NbtByte subValueTypeByte = readData!(Nbt.Type.Byte);
		Nbt.Type subValueType = cast(Nbt.Type)(subValueTypeByte.value);
		
		while (subValueType != Nbt.Type.End) {
			NbtString subValueName = readData!(Nbt.Type.String);
			// subValueName.writeln;
			
			Nbt subValue = new NbtByte(0);
			switch (subValueType) {
				case Nbt.Type.Byte: subValue = readData!(Nbt.Type.Byte); break;
				case Nbt.Type.Short: subValue = readData!(Nbt.Type.Short); break;
				case Nbt.Type.Int: subValue = readData!(Nbt.Type.Int); break;
				case Nbt.Type.String: subValue = readData!(Nbt.Type.String); break;
				case Nbt.Type.List: subValue = readData!(Nbt.Type.List); break;
				case Nbt.Type.Compound: subValue = readData!(Nbt.Type.Compound); break;
				case Nbt.Type.IntArray: subValue = readData!(Nbt.Type.IntArray); break;
				case Nbt.Type.LongArray: subValue = readData!(Nbt.Type.LongArray); break;
				default: assert(0, "WIP " ~ subValueType.to!string);
			}
			
			ret.set(subValueName, subValue);
			
			subValueTypeByte = readData!(Nbt.Type.Byte);
			subValueType = cast(Nbt.Type)(subValueTypeByte.value);
		}
		return ret;
	}
	
	static NbtIntArray readData(Nbt.Type t : Nbt.Type.IntArray)() {
		auto array = new NbtIntArray;
		
		size_t size = readData!(Nbt.Type.Int).value;
		
		while (size--) {
			array.push(readData!(Nbt.Type.Int));
		}
		
		return array;
	}
	
	static NbtLongArray readData(Nbt.Type t : Nbt.Type.LongArray)() {
		auto array = new NbtLongArray;
		
		size_t size = readData!(Nbt.Type.Int).value;
		
		while (size--) {
			array.push(readData!(Nbt.Type.Long));
		}
		
		return array;
	}
	
	static NbtCompound parseAll(ubyte[] input) {
		payload = input.dup;
		index = 0;
		nextNumByte!1;
		nextByte;
		nextByte;
		return readData!(Nbt.Type.Compound);
	}
}


NbtCompound parseBytes(ubyte[] fileData) {

	ubyte[] sanitizedData = fileData.dup;
    /*
    sanitizedData.writeln;
    for (size_t i = 0; i < sanitizedData.length - 1; i += 2) {
    	swap(sanitizedData[i], sanitizedData[i+1]);
    }
    sanitizedData.writeln;
    */
    
    return NbtParser.parseAll(sanitizedData);
}

