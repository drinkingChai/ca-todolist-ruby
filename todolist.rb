class Todolist
	def initialize
		@task_file = "test_list.txt"
		@completed_file = "completed_tasks.txt"
		update_task_array
	end

	def update_task_array
		@tasks = []
		File.open(@task_file).each do |item| @tasks.push(item) end
	end

	def update_file
		file = File.open(@task_file, "w")
		@tasks.each do
			|item| file.write(item)
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
		File.open("completed_tasks.txt", "a") do |file| file.puts @tasks[task_num_i] end
		@tasks.delete_at(task_num_i)
		update_file
	end
end

todolist = Todolist.new

loop do 
	puts "
	watchu wanna do
	1. View todolist
	2. Add new task
	3. Mark task complete
	4. Remove task
	5. Exit"

	option = gets.chomp
	
	case option
	when "1"
		todolist.view
	when "2"
		new_task = gets.chomp
		todolist.add(new_task)
		puts new_task + " has been added"
	when "3"
		todolist.view
		todolist.complete(gets.chomp)
	when "4"
		todolist.view
		todolist.remove(gets.chomp)
	when "5"
		break
	end
end