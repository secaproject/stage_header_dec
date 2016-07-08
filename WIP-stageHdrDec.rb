file = "stage.dat"

xor_key = IO.binread(file, 4, 0).unpack("V*").join.to_i

save = File.new("stage.hdr", "wb")
save.write IO.binread(file, 4, 0)

to_xor = IO.binread(file, 4, 0).unpack("V*").join.to_i

for loop in 1..512-1
 seed = to_xor * ??????
 bytes_to_decode = IO.binread(file, 4, loop * 4).unpack("V*").join.to_i
 save.write [(bytes_to_decode ^ to_xor).to_i.to_s(16).split(//).last(8).join.rjust(8, "0").scan(/(..)(..)(..)(..)/).map(&:reverse).join].pack("H*")
 to_xor = seed + (xor_key ^ 0xf0f0)
 puts
end
save.close
