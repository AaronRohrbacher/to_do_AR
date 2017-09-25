require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/task")
require("pg")

get('/') do
  @tasks = Task.all()
  erb(:index)
end

post('/') do
  task = Task.new({:description => params["name"], :due_date => dd = params["dd"]})
  task.save
  erb(:index)
  @tasks = Task.all()
end

get('/tasks/:id/edit') do
  @task = Task.find(params.fetch("id").to_i())
  erb(:task_edit)
end

patch("/tasks/:id") do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i())
  @task.update({:description => description})
  @tasks = Task.all()
  erb(:index)
end
