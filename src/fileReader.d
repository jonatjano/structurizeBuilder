import nbt;
import std.file : read;
import std.zlib : uncompress;

ubyte[] getFileBytes(string filepath) {
	version(unittest) {
    	return [0x00, 0x0a, 0x02, 0x00, 0x06, 0x00, 0x69, 0x73, 0x65, 0x7a, 0x7a, 0x5f, 0x06, 0x00, 0x00, 0x09, 0x72, 0x0d, 0x71, 0x65, 0x69, 0x75, 0x65, 0x72, 0x5f, 0x64, 0x6f, 0x6d, 0x73, 0x64, 0x00, 0x08, 0x00, 0x00, 0x00, 0x01, 0x6d, 0x0c, 0x6e, 0x69, 0x63, 0x65, 0x6c, 0x6f, 0x6e, 0x6f, 0x65, 0x69, 0x09, 0x73, 0x08, 0x00, 0x6e, 0x65, 0x69, 0x74, 0x69, 0x74, 0x73, 0x65, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x06, 0x00, 0x69, 0x73, 0x65, 0x7a, 0x79, 0x5f, 0x05, 0x00, 0x00, 0x0b, 0x62, 0x06, 0x6f, 0x6c, 0x6b, 0x63, 0x00, 0x73, 0x00, 0x00, 0x00, 0x87, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x04, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x05, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x02, 0x03, 0x06, 0x00, 0x69, 0x73, 0x65, 0x7a, 0x78, 0x5f, 0x09, 0x00, 0x00, 0x09, 0x74, 0x0d, 0x6c, 0x69, 0x5f, 0x65, 0x6e, 0x65, 0x69, 0x74, 0x69, 0x74, 0x73, 0x65, 0x00, 0x0a, 0x00, 0x00, 0x03, 0x03, 0x07, 0x00, 0x61, 0x74, 0x53, 0x67, 0x7a, 0x49, 0x00, 0x65, 0x00, 0x00, 0x0a, 0x00, 0x0b, 0x00, 0x65, 0x72, 0x4e, 0x6c, 0x69, 0x65, 0x68, 0x67, 0x6f, 0x62, 0x03, 0x72, 0x01, 0x00, 0x00, 0x78, 0x00, 0x00, 0x03, 0x00, 0x01, 0x00, 0x00, 0x79, 0x00, 0x00, 0x03, 0x00, 0x01, 0x00, 0xff, 0x7a, 0xff, 0xff, 0x00, 0xff, 0x00, 0x08, 0x49, 0x04, 0x65, 0x74, 0x00, 0x6d, 0x0a, 0x00, 0x09, 0x00, 0x6f, 0x46, 0x67, 0x72, 0x44, 0x65, 0x74, 0x61, 0x0a, 0x61, 0x0a, 0x00, 0x70, 0x53, 0x6e, 0x6f, 0x65, 0x67, 0x61, 0x44, 0x61, 0x74, 0x00, 0x00, 0x00, 0x01, 0x69, 0x0b, 0x57, 0x6e, 0x72, 0x61, 0x68, 0x65, 0x75, 0x6f, 0x65, 0x73, 0x0a, 0x00, 0x03, 0x00, 0x6f, 0x70, 0x03, 0x73, 0x01, 0x00, 0x00, 0x78, 0x00, 0x00, 0x03, 0x00, 0x01, 0x00, 0x00, 0x79, 0x00, 0x00, 0x03, 0x00, 0x01, 0x00, 0x00, 0x7a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x78, 0x01, 0x01, 0x00, 0x00, 0x02, 0x79, 0x01, 0x01, 0x00, 0x00, 0x02, 0x7a, 0x01, 0x01, 0x00, 0x00, 0x01, 0x6d, 0x04, 0x69, 0x61, 0x01, 0x6e, 0x00, 0x08, 0x69, 0x02, 0x00, 0x64, 0x6d, 0x11, 0x6e, 0x69, 0x63, 0x65, 0x6c, 0x6f, 0x6e, 0x6f, 0x65, 0x69, 0x3a, 0x73, 0x61, 0x72, 0x6b, 0x63, 0x00, 0x09, 0x69, 0x09, 0x76, 0x6e, 0x6e, 0x65, 0x6f, 0x74, 0x79, 0x72, 0x00, 0x0a, 0x00, 0x00, 0x01, 0x1b, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x00, 0x00, 0x00, 0x03, 0x74, 0x07, 0x67, 0x61, 0x49, 0x53, 0x65, 0x7a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x49, 0x04, 0x65, 0x74, 0x00, 0x6d, 0x0a, 0x00, 0x09, 0x00, 0x6f, 0x46, 0x67, 0x72, 0x44, 0x65, 0x74, 0x61, 0x0a, 0x61, 0x0a, 0x00, 0x70, 0x53, 0x6e, 0x6f, 0x65, 0x67, 0x61, 0x44, 0x61, 0x74, 0x00, 0x00, 0x00, 0x01, 0x69, 0x0b, 0x57, 0x6e, 0x72, 0x61, 0x68, 0x65, 0x75, 0x6f, 0x65, 0x73, 0x0a, 0x00, 0x03, 0x00, 0x6f, 0x70, 0x03, 0x73, 0x01, 0x00, 0x00, 0x78, 0x00, 0x00, 0x03, 0x00, 0x01, 0x00, 0x00, 0x79, 0x00, 0x00, 0x03, 0x00, 0x01, 0x00, 0x00, 0x7a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x78, 0x01, 0x01, 0x00, 0x00, 0x02, 0x79, 0x01, 0x01, 0x00, 0x00, 0x02, 0x7a, 0x01, 0x03, 0x00, 0x00, 0x01, 0x6d, 0x04, 0x69, 0x61, 0x00, 0x6e, 0x00, 0x08, 0x69, 0x02, 0x00, 0x64, 0x6d, 0x11, 0x6e, 0x69, 0x63, 0x65, 0x6c, 0x6f, 0x6e, 0x6f, 0x65, 0x69, 0x3a, 0x73, 0x61, 0x72, 0x6b, 0x63, 0x00, 0x09, 0x69, 0x09, 0x76, 0x6e, 0x6e, 0x65, 0x6f, 0x74, 0x79, 0x72, 0x00, 0x0a, 0x00, 0x00, 0x01, 0x1b, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x00, 0x00, 0x00, 0x01, 0x6d, 0x06, 0x72, 0x69, 0x6f, 0x72, 0x00, 0x72, 0x00, 0x01, 0x69, 0x0b, 0x57, 0x6e, 0x72, 0x61, 0x68, 0x65, 0x75, 0x6f, 0x65, 0x73, 0x03, 0x00, 0x06, 0x00, 0x6f, 0x63, 0x6f, 0x6c, 0x79, 0x6e, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x6d, 0x04, 0x69, 0x61, 0x00, 0x6e, 0x00, 0x09, 0x69, 0x09, 0x76, 0x6e, 0x6e, 0x65, 0x6f, 0x74, 0x79, 0x72, 0x00, 0x0a, 0x00, 0x00, 0x01, 0x1b, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x01, 0x00, 0x05, 0x00, 0x6d, 0x65, 0x74, 0x70, 0x01, 0x79, 0x08, 0x00, 0x04, 0x00, 0x79, 0x74, 0x65, 0x70, 0x0a, 0x00, 0x69, 0x6d, 0x65, 0x6e, 0x72, 0x63, 0x66, 0x61, 0x3a, 0x74, 0x00, 0x03, 0x74, 0x07, 0x67, 0x61, 0x49, 0x53, 0x65, 0x7a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x49, 0x04, 0x65, 0x74, 0x00, 0x6d, 0x0a, 0x00, 0x15, 0x00, 0x6c, 0x62, 0x65, 0x75, 0x72, 0x70, 0x6e, 0x69, 0x44, 0x74, 0x74, 0x61, 0x50, 0x61, 0x6f, 0x72, 0x69, 0x76, 0x65, 0x64, 0x0a, 0x72, 0x07, 0x00, 0x6f, 0x63, 0x6e, 0x72, 0x72, 0x65, 0x03, 0x31, 0x01, 0x00, 0xff, 0x78, 0xff, 0xff, 0x03, 0xfc, 0x01, 0x00, 0xff, 0x79, 0xff, 0xff, 0x03, 0xff, 0x01, 0x00, 0xff, 0x7a, 0xff, 0xff, 0x00, 0xfc, 0x00, 0x0a, 0x63, 0x07, 0x72, 0x6f, 0x65, 0x6e, 0x32, 0x72, 0x00, 0x03, 0x78, 0x01, 0x00, 0x00, 0x04, 0x00, 0x00, 0x03, 0x79, 0x01, 0x00, 0x00, 0x03, 0x00, 0x00, 0x03, 0x7a, 0x01, 0x00, 0x00, 0x01, 0x00, 0x08, 0x00, 0x0d, 0x00, 0x63, 0x73, 0x65, 0x68, 0x61, 0x6d, 0x69, 0x74, 0x4e, 0x63, 0x6d, 0x61, 0x00, 0x65, 0x64, 0x0c, 0x6c, 0x65, 0x76, 0x69, 0x72, 0x65, 0x6d, 0x79, 0x6e, 0x61, 0x09, 0x31, 0x09, 0x00, 0x6f, 0x70, 0x54, 0x73, 0x67, 0x61, 0x61, 0x4d, 0x00, 0x70, 0x00, 0x00, 0x00, 0x00, 0x0a, 0x00, 0x03, 0x00, 0x6f, 0x70, 0x03, 0x73, 0x01, 0x00, 0xff, 0x78, 0xfe, 0xff, 0x03, 0x02, 0x01, 0x00, 0x00, 0x79, 0x00, 0x00, 0x03, 0x2c, 0x01, 0x00, 0xff, 0x7a, 0xff, 0xff, 0x00, 0xcc, 0x00, 0x02, 0x78, 0x01, 0x04, 0x00, 0x00, 0x02, 0x79, 0x01, 0x01, 0x00, 0x00, 0x02, 0x7a, 0x01, 0x04, 0x00, 0x00, 0x08, 0x73, 0x05, 0x79, 0x74, 0x65, 0x6c, 0x00, 0x00, 0x00, 0x08, 0x69, 0x02, 0x00, 0x64, 0x6d, 0x1b, 0x6e, 0x69, 0x63, 0x65, 0x6c, 0x6f, 0x6e, 0x6f, 0x65, 0x69, 0x3a, 0x73, 0x6f, 0x63, 0x6f, 0x6c, 0x79, 0x6e, 0x75, 0x62, 0x6c, 0x69, 0x69, 0x64, 0x67, 0x6e, 0x08, 0x00, 0x04, 0x00, 0x61, 0x6e, 0x65, 0x6d, 0x0c, 0x00, 0x65, 0x64, 0x69, 0x6c, 0x65, 0x76, 0x79, 0x72, 0x61, 0x6d, 0x31, 0x6e, 0x00, 0x09, 0x70, 0x07, 0x6c, 0x61, 0x74, 0x65, 0x65, 0x74, 0x00, 0x0a, 0x00, 0x00, 0x08, 0x09, 0x04, 0x00, 0x61, 0x4e, 0x65, 0x6d, 0x0d, 0x00, 0x69, 0x6d, 0x65, 0x6e, 0x72, 0x63, 0x66, 0x61, 0x3a, 0x74, 0x69, 0x61, 0x00, 0x72, 0x00, 0x08, 0x4e, 0x04, 0x6d, 0x61, 0x00, 0x65, 0x6d, 0x15, 0x6e, 0x69, 0x63, 0x65, 0x61, 0x72, 0x74, 0x66, 0x63, 0x3a, 0x62, 0x6f, 0x6c, 0x62, 0x73, 0x65, 0x6f, 0x74, 0x65, 0x6e, 0x08, 0x00, 0x04, 0x00, 0x61, 0x4e, 0x65, 0x6d, 0x14, 0x00, 0x69, 0x6d, 0x65, 0x6e, 0x72, 0x63, 0x66, 0x61, 0x3a, 0x74, 0x61, 0x6f, 0x5f, 0x6b, 0x6c, 0x70, 0x6e, 0x61, 0x73, 0x6b, 0x0a, 0x00, 0x0a, 0x00, 0x72, 0x50, 0x70, 0x6f, 0x72, 0x65, 0x69, 0x74, 0x73, 0x65, 0x00, 0x08, 0x61, 0x04, 0x69, 0x78, 0x00, 0x73, 0x79, 0x01, 0x08, 0x00, 0x04, 0x00, 0x61, 0x4e, 0x65, 0x6d, 0x11, 0x00, 0x69, 0x6d, 0x65, 0x6e, 0x72, 0x63, 0x66, 0x61, 0x3a, 0x74, 0x61, 0x6f, 0x5f, 0x6b, 0x6f, 0x6c, 0x00, 0x67, 0x00, 0x0a, 0x50, 0x0a, 0x6f, 0x72, 0x65, 0x70, 0x74, 0x72, 0x65, 0x69, 0x08, 0x73, 0x05, 0x00, 0x69, 0x68, 0x67, 0x6e, 0x00, 0x65, 0x72, 0x05, 0x67, 0x69, 0x74, 0x68, 0x00, 0x08, 0x68, 0x04, 0x6c, 0x61, 0x00, 0x66, 0x6c, 0x05, 0x77, 0x6f, 0x72, 0x65, 0x00, 0x08, 0x70, 0x07, 0x77, 0x6f, 0x72, 0x65, 0x64, 0x65, 0x05, 0x00, 0x61, 0x66, 0x73, 0x6c, 0x08, 0x65, 0x06, 0x00, 0x61, 0x66, 0x69, 0x63, 0x67, 0x6e, 0x05, 0x00, 0x6f, 0x6e, 0x74, 0x72, 0x08, 0x68, 0x04, 0x00, 0x70, 0x6f, 0x6e, 0x65, 0x05, 0x00, 0x61, 0x66, 0x73, 0x6c, 0x00, 0x65, 0x00, 0x08, 0x4e, 0x04, 0x6d, 0x61, 0x00, 0x65, 0x6d, 0x12, 0x6e, 0x69, 0x63, 0x65, 0x61, 0x72, 0x74, 0x66, 0x6f, 0x3a, 0x6b, 0x61, 0x64, 0x5f, 0x6f, 0x6f, 0x00, 0x72, 0x00, 0x0a, 0x50, 0x0a, 0x6f, 0x72, 0x65, 0x70, 0x74, 0x72, 0x65, 0x69, 0x08, 0x73, 0x05, 0x00, 0x69, 0x68, 0x67, 0x6e, 0x00, 0x65, 0x72, 0x05, 0x67, 0x69, 0x74, 0x68, 0x00, 0x08, 0x68, 0x04, 0x6c, 0x61, 0x00, 0x66, 0x75, 0x05, 0x70, 0x70, 0x72, 0x65, 0x00, 0x08, 0x70, 0x07, 0x77, 0x6f, 0x72, 0x65, 0x64, 0x65, 0x05, 0x00, 0x61, 0x66, 0x73, 0x6c, 0x08, 0x65, 0x06, 0x00, 0x61, 0x66, 0x69, 0x63, 0x67, 0x6e, 0x05, 0x00, 0x6f, 0x6e, 0x74, 0x72, 0x08, 0x68, 0x04, 0x00, 0x70, 0x6f, 0x6e, 0x65, 0x05, 0x00, 0x61, 0x66, 0x73, 0x6c, 0x00, 0x65, 0x00, 0x08, 0x4e, 0x04, 0x6d, 0x61, 0x00, 0x65, 0x6d, 0x12, 0x6e, 0x69, 0x63, 0x65, 0x61, 0x72, 0x74, 0x66, 0x6f, 0x3a, 0x6b, 0x61, 0x64, 0x5f, 0x6f, 0x6f, 0x00, 0x72, 0x00, 0x0a, 0x50, 0x0a, 0x6f, 0x72, 0x65, 0x70, 0x74, 0x72, 0x65, 0x69, 0x08, 0x73, 0x07, 0x00, 0x61, 0x76, 0x69, 0x72, 0x6e, 0x61, 0x00, 0x74, 0x62, 0x14, 0x6f, 0x6c, 0x6b, 0x63, 0x61, 0x72, 0x6b, 0x63, 0x6d, 0x65, 0x74, 0x70, 0x73, 0x79, 0x6e, 0x69, 0x6c, 0x67, 0x08, 0x65, 0x06, 0x00, 0x61, 0x66, 0x69, 0x63, 0x67, 0x6e, 0x04, 0x00, 0x61, 0x65, 0x74, 0x73, 0x08, 0x00, 0x04, 0x00, 0x61, 0x4e, 0x65, 0x6d, 0x22, 0x00, 0x69, 0x6d, 0x65, 0x6e, 0x6f, 0x63, 0x6f, 0x6c, 0x69, 0x6e, 0x73, 0x65, 0x62, 0x3a, 0x6f, 0x6c, 0x6b, 0x63, 0x69, 0x6d, 0x65, 0x6e, 0x6f, 0x63, 0x6f, 0x6c, 0x69, 0x6e, 0x73, 0x65, 0x61, 0x72, 0x6b, 0x63, 0x0a, 0x00, 0x0a, 0x00, 0x72, 0x50, 0x70, 0x6f, 0x72, 0x65, 0x69, 0x74, 0x73, 0x65, 0x00, 0x08, 0x66, 0x06, 0x63, 0x61, 0x6e, 0x69, 0x00, 0x67, 0x73, 0x05, 0x75, 0x6f, 0x68, 0x74, 0x08, 0x00, 0x04, 0x00, 0x61, 0x4e, 0x65, 0x6d, 0x14, 0x00, 0x69, 0x6d, 0x65, 0x6e, 0x72, 0x63, 0x66, 0x61, 0x3a, 0x74, 0x61, 0x77, 0x6c, 0x6c, 0x74, 0x5f, 0x72, 0x6f, 0x68, 0x63, 0x0a, 0x00, 0x0a, 0x00, 0x72, 0x50, 0x70, 0x6f, 0x72, 0x65, 0x69, 0x74, 0x73, 0x65, 0x00, 0x08, 0x66, 0x06, 0x63, 0x61, 0x6e, 0x69, 0x00, 0x67, 0x65, 0x04, 0x73, 0x61, 0x00, 0x74, 0x00, 0x08, 0x4e, 0x04, 0x6d, 0x61, 0x00, 0x65, 0x6d, 0x20, 0x6e, 0x69, 0x63, 0x65, 0x6c, 0x6f, 0x6e, 0x6f, 0x65, 0x69, 0x3a, 0x73, 0x6c, 0x62, 0x63, 0x6f, 0x68, 0x6b, 0x74, 0x75, 0x65, 0x64, 0x69, 0x6c, 0x65, 0x76, 0x79, 0x72, 0x61, 0x6d, 0x00, 0x6e, 0x00, 0x01, 0x76, 0x07, 0x72, 0x65, 0x69, 0x73, 0x6e, 0x6f, 0x03, 0x01, 0x09, 0x00, 0x63, 0x6d, 0x65, 0x76, 0x73, 0x72, 0x6f, 0x69, 0x00, 0x6e, 0x0a, 0x00, 0x0a, 0xaa, 0x0d, 0x00, 0x70, 0x6f, 0x69, 0x74, 0x6e, 0x6f, 0x6c, 0x61, 0x64, 0x5f, 0x74, 0x61, 0x0a, 0x61, 0x0b, 0x00, 0x74, 0x73, 0x75, 0x72, 0x74, 0x63, 0x72, 0x75, 0x7a, 0x69, 0x0a, 0x65, 0x0e, 0x00, 0x72, 0x70, 0x6d, 0x69, 0x72, 0x61, 0x5f, 0x79, 0x66, 0x6f, 0x73, 0x66, 0x74, 0x65, 0x00, 0x03, 0x78, 0x01, 0x00, 0x00, 0x04, 0x00, 0x00, 0x03, 0x79, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x03, 0x7a, 0x01, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00];
    }
    
    auto fileContent = read(filepath);
    return cast(ubyte[]) uncompress(fileContent, 0, 16);
}