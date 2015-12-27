File.open("test_list.txt").each do |line| puts line end

test = gets.chomp

File.open("test_list.txt", "a") do
	|line| line.puts "\r" + test
end