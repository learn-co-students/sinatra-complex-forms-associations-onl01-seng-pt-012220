class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    #binding.pry
    @pet = Pet.new
    @pet.name = params[:pet_name]
    #binding.pry
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = owner.id
    end
    #binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
  
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    if !params[:pet].keys.include?("owner_ids")
      params[:pet]["owner_ids"] = []
    end
   
      @pet = Pet.find(params[:id])
      @pet.update(params["pet"])
      if !params["owner"]["name"].empty?
        @pet.owners << Owner.create(name: params["owner"]["name"])
      end

    redirect to "pets/#{@pet.id}"
  end
end