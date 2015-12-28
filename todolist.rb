class Todolist
	@@completed_file = "completed_tasks.txt"

	def initialize(filename)
		@task_file = filename
		unless File.exists?(filename) 
			File.open(filename, "w+") end
		update_task_array
	end

	def update_task_array
		@tasks = []
		File.open(@task_file).each do |item| @tasks.push(item) end
	end

	def update_file
		file = File.open(@task_file, "w")
		File.open(@task_file, "a") do
			|file| 
			@tasks.each do |item| file.puts item + "\n" end
		end
	end

	def view
		item_no = 0
		@tasks.each do |item|
			puts item_no.to_s + " " + item
			item_no += 1
		end
	end

	def view_completed
		File.open(@@completed_file).each do |line| puts line end
	end

	def add(task)
		File.open(@task_file, "a") do |file| file.puts task + "\n" end
		update_task_array
	end

	def remove(task_num)
		task_num_i = task_num.to_i	
		@tasks.delete_at(task_num_i)
		update_file
	end

	def complete(task_num)
		task_num_i = task_num.to_i
		File.open(@@completed_file, "a") do |file| file.puts @tasks[task_num_i] end
		@tasks.delete_at(task_num_i)
		update_file
	end
end

currentlist = false

loop do 
	puts "
	watchu wanna do
	1. Create new list
	2. Open a list
	3. View todolist
	4. Add new task
	5. Mark task complete
	6. Remove task
	7. View completed
	8. Exit"

	option = gets.chomp
	
	case option
	when "1"
		puts "gimme a filename"
		currentlist = Todolist.new(gets.chomp)
	when "2"
		puts "filename?"
		name = gets.chomp
		if File.exists?(name)
			currentlist = Todolist.new(name)
		else
			puts "we don't got that list"
		end
	when "3"
		if currentlist
			currentlist.view
		else 
			puts "no list open"
		end
	when "4"
		new_task = gets.chomp
		currentlist.add(new_task)
		puts new_task + " has been added"
	when "5"
		currentlist.view
		currentlist.complete(gets.chomp)
	when "6"
		currentlist.view
		currentlist.remove(gets.chomp)
	when "7"
		Todolist.view_completed
	when "8"
		break
	end
end