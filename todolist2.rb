class List
	def initialize(task_filename, complete_filename)
		@task_filename = task_filename
		@complete_filename = complete_filename
		@all_tasks = []
		@complete_tasks = []
		File.open(@task_filename).each do |line|
			@all_tasks << Task.new(line)
		end
		File.open(@complete_filename).each do |line|
			@complete_tasks << Task.new(line)
		end
	end

	def add_task(task)
		@all_tasks << task
	end

	def complete_task(description)
		description += "\n"
		@all_tasks.each do |list_item|
			if list_item.description == (description)
				@complete_tasks.push(@all_tasks.delete_at(@all_tasks.index(list_item)))
				return
			end
		end
	end

	def delete_task(description)
		description += "\n"
		@all_tasks.each do |list_item|
			if list_item.description == (description)
				@all_tasks.delete_at(@all_tasks.index(list_item))
				return
			end
		end
	end

	def update_task(cur_description, new_description)
		cur_description += "\n"
		@all_tasks.each do |list_item|
			if list_item.description == (cur_description)
				list_item.update_description(new_description)
			end
		end
	end

	def show_all_tasks
		puts "== active =="
		@all_tasks.each do |list_item| puts list_item.description end
		puts "== complete =="
		@complete_tasks.each do |list_item| puts list_item.description end
	end

	def save
		list_file = File.open(@task_filename, "w")
		complete_file = File.open(@complete_filename, "w")
		@all_tasks.each do |list_item| list_file.puts list_item.description	end
		@complete_tasks.each do |list_item| complete_file.puts list_item.description end
	end
end

class Task
	attr_reader :description
	def initialize(description)
		@description = description
	end

	def update_description(new_description)
		@description = new_description
	end
end

command, * task_description = ARGV #take a command and task description as input to running the ruby file
task_string = task_description.join(" ")	#join the task description by space to create task string

first_list = List.new("test_list.txt", "complete_list.txt")

case command
when "add"
	task_obj = Task.new(task_string)
	first_list.add_task(task_obj)
	first_list.save
when "complete"
	first_list.complete_task(task_string)
	first_list.save
when "update"
	print "Enter new description: "
	new_description = STDIN.gets.chomp
	unless new_description.length < 0
		first_list.update_task(task_string, STDIN.gets.chomp)
	else
		puts "Task name cannot be empty"
	end
	first_list.save
when "delete"
	first_list.delete_task(task_string)
	first_list.save
when "print"
	first_list.show_all_tasks
end