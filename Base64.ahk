Class Base64 {
	/**
	 * Base64编码
	 * @param Buf Buffer Object has Ptr, Size Property
	 * @param Codec CRYPT_STRING_BASE64 0x00000001
	 * CRYPT_STRING_NOCRLF 0x40000000
	 * @returns Base64 String if success, otherwise false
	 * VarIn may contain any binary contents including NUll bytes.
	 */
	static Encode(Buf, Codec := 0x40000001) {
		if (DllCall("crypt32\CryptBinaryToString", "Ptr", Buf, "UInt", Buf.Size, "UInt", Codec, "Ptr", 0, "Uint*", &nSize := 0) &&
			(VarSetStrCapacity(&VarOut, nSize << 1), DllCall("crypt32\CryptBinaryToString", "Ptr", Buf, "UInt", Buf.Size, "UInt", Codec, "Str", VarOut, "Uint*", &nSize)))
			return (VarSetStrCapacity(&VarOut, -1), VarOut)
		return false
	}

	/**
	 * Base64解码
	 * https://docs.microsoft.com/zh-cn/windows/win32/api/wincrypt/nf-wincrypt-cryptstringtobinarya
	 * @param VarIn Variable containing a null-terminated Base64 encoded string
	 * @param Codec CRYPT_STRING_BASE64 0x00000001
	 * @returns buffer if success, otherwise false
	 * VarOut may contain any binary contents including NUll bytes.
	 */
	static Decode(VarIn, Codec := 0x00000001) {
		if (DllCall("Crypt32.dll\CryptStringToBinary", "Str", VarIn, "UInt", 0, "UInt", Codec, "Ptr", 0, "Uint*", &SizeOut := 0, "Ptr", 0, "Ptr", 0) && DllCall("Crypt32.dll\CryptStringToBinary", "Str", VarIn, "UInt", 0, "UInt", Codec, "Ptr", VarOut := BufferAlloc(SizeOut), "Uint*", &SizeOut, "Ptr", 0, "Ptr", 0))
			return VarOut
		return false
	}
}