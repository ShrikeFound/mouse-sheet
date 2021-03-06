class TraitAdvancementsController < ApplicationController
  def new 
    @character = Character.find(params[:character])
    @trait_advancement = TraitAdvancement.new
    @traits = Trait.all
  end

  def create 
    @character = Character.find(params[:trait_advancement][:character_id])
    trait_name = (params[:trait_advancement][:name]).downcase
    @trait = Trait.find_or_create_by(name: trait_name)
    puts @trait.id
    @trait_advancement = @character.trait_advancements.new 
    @trait_advancement.trait = @trait
    @trait_advancement.level = params[:trait_advancement][:level] 
    @trait_advancement.save

    flash.notice = "'#{@trait.name}' trait added."
    redirect_to character_path(@character)
  end

  def destroy 
    @trait_advancement = TraitAdvancement.find(params[:id])
    @trait_advancement.destroy 

    flash.notice = "'#{@trait_advancement.trait.name}' trait removed."
    redirect_to character_path(@trait_advancement.character)
  end

  def increment 
    @trait_advancement = TraitAdvancement.find(params[:trait_advancement_id])
    @trait_advancement.level += 1 
    @trait_advancement.save 

    flash.notice = "'#{@trait_advancement.trait.name}' trait increased."
    redirect_to character_path(@trait_advancement.character)
  end

  def decrement
    @trait_advancement = TraitAdvancement.find(params[:trait_advancement_id])
    @trait_advancement.level -= 1
    flash.notice = "'#{@trait_advancement.trait.name}' trait decreased."
    if @trait_advancement.level < 0 
      @trait_advancement.level = 0 
      flash.notice = "'#{@trait_advancement.trait.name}' trait already at 0."
    end 
    @trait_advancement.save 

    redirect_to character_path(@trait_advancement.character)
  end

end