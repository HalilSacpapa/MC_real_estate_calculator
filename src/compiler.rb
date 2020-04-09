source_code = File.open(ARGV[0], 'r')
compiled_code = RubyVM::InstructionSequence.compile(source_code)
binary_code = compiled_code.to_binary
binary_file = File.open(ARGV[0].split('.').first + '.bin', 'w+')
binary_file.puts binary_code
binary_file.close