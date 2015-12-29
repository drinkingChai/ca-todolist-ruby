class List
	def initialize(task_filename, complete_filename)
		@task_filename = task_filename	#filename for the task list
		@complete_filename = complete_filename	#filename for the completed task list
		@all_tasks = []	#stores all active tasks
		@complete_tasks = []	#stores all complete tasks
		File.open(@task_filename).each do |line|
			#for each line in task_filename, insert into all tasks
			@all_tasks << Task.new(line)
		end
		File.open(@complete_filename).each do |line|
			#for each line in complete_filename, insert into all tasks
			@complete_tasks << Task.new(line)
		end
	end

	def add_task(task)
		#add task to all tasks
		@all_tasks << task
	end

	def complete_task(description)
		@all_tasks.each do |list_item|
			#search through the list, if the item is found, remove it from the list and push it to completed tasks
			if list_item.description == (description)
				@complete_tasks.push(@all_tasks.delete_at(@all_tasks.index(list_item)))
				return
			end
		end
	end

	def delete_task(description)
		@all_tasks.each do |list_item|
			#search through the list, if the item is found, remove it from the list
			if list_item.description == (description)
				@all_tasks.delete_at(@all_tasks.index(list_item))
				return
			end
		end
	end

	def update_task(cur_description, new_description)
		@all_tasks.each do |list_item|
			#search through the list, if the item is found, change the description
			if list_item.description == (cur_description)
				list_item.update_description(new_description)
			end
		end
	end

	def show_all_tasks
		puts "== active =="
		@all_tasks.each do |list_item| puts list_item.description end	#print active tasks
		puts "== complete =="
		@complete_tasks.each do |list_item| puts list_item.description end	#print completed tasks
	end

	def save
		list_file = File.open(@task_filename, "w") #empty the task file
		complete_file = File.open(@complete_filename, "w") #empty the complete file
		@all_tasks.each do |list_item| list_file.puts list_item.description	end	#write the description of all tasks into task file
		@complete_tasks.each do |list_item| complete_file.puts list_item.description end		#write the description of complete tasks into complete file
	end
end

class Task
	attr_reader :description 	#make description accessible to read
	def initialize(description)
		@description = description.delete("\n") #remove the end of line
	end

	def update_description(new_description)
		#update the description
		@description = new_description.delete("\n") #remove the end of line
	end
end

command, * task_description = ARGV #take a command and task description as input to running the ruby file
task_string = task_description.join(" ")	#join the task description by space to create task string

first_list = List.new("test_list.txt", "complete_list.txt")	#create a list

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

=begin
use
add task description
complete task description
update task description
	enter new description
delete task description
print all tasks
=end