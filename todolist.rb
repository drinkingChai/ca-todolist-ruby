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
		File.open(@task_file).each do |item| @tasks.push(item) if item.delete(" ").delete("\n").length != 0 end	#skip if it's a new line
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
		File.open(@@completed_file).each do |line| puts line if line.delete(" ").delete("\n").length != 0 end
	end

	def add(task)
		File.open(@task_file, "a") do |file| file.puts task + "\n" end
		update_task_array
	end

	def remove(task_num)
		if task_num > @tasks.length || task_num < 0
			puts "task index not found"
			return
		end
		puts @tasks[task_num].delete("\n") + " has been removed"
		@tasks.delete_at(task_num)
		update_file
	end

	def complete(task_num)
		if task_num > @tasks.length || task_num < 0
			puts "task index not found"
			return
		end
		File.open(@@completed_file, "a") do |file| file.puts @tasks[task_num] end
		puts @tasks[task_num].delete("\n") + " has been marked complete"
		@tasks.delete_at(task_num)
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
		unless currentlist
			next
		end
		currentlist.view
	when "4"
		unless currentlist
			next
		end
		puts "task name?"
		new_task = gets.chomp
		if new_task.delete(" ").delete("\n").length != 0
			currentlist.add(new_task)
			puts new_task + " has been added"
		else
			puts "task name cannot be blank!"
		end
	when "5"
		unless currentlist
			next
		end
		currentlist.view
		puts "type the index of what to mark complete"
		currentlist.complete(gets.chomp.to_i)
	when "6"
		unless currentlist
			next
		end
		currentlist.view
		puts "type the index of what to remove"
		currentlist.remove(gets.chomp.to_i)
	when "7"
		unless currentlist
			next
		end
		currentlist.view_completed
	when "8"
		break
	end
end