class DosesController < ApplicationController
  def new
    @dose = Dose.new
    @ingredients = Ingredient.all
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = @cocktail.doses.build(dose_params)
    respond_to do |format|
      if @dose.save
        format.html { redirect_to @cocktail, notice: 'Dose was successfully created.' }
        format.json { render :show, status: :created, location: @dose }
      else
        format.html { render :new }
        format.json { render json: @dose.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.find(params[:id])
    @ingredients = Ingredient.all
  end

  def update
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.find(params[:id])
    respond_to do |format|
      if @dose.update(dose_params)
        format.html { redirect_to @cocktail, notice: 'Dose was successfully updated.' }
        format.json { render :show, status: :ok, location: @dose }
      else
        format.html { render :edit }
        format.json { render json: @dose.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    if params[:cocktail_id]
      @cocktail = Cocktail.find(params[:cocktail_id])
      redirect_url = cocktail_url(@cocktail)
    else
      redirect_url = cocktails_url
    end
    @dose.destroy
    respond_to do |format|
      format.html { redirect_to redirect_url, notice: 'Dose was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def dose_params
    params.require(:dose).permit([:description, :ingredient_id])
  end
end
