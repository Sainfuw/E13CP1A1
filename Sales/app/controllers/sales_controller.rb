class SalesController < ApplicationController
  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @discount = @sale.value.to_i * ( @sale.discount.to_f / 100 )
    @total = @sale.value.to_i - @discount
    @sale.total = if @sale.tax.zero?
                    @total * 1.19
                  else
                    @total
                  end
    @sale.save
    redirect_to sales_done_path
  end

  def done
    @sale = Sale.last
    @iva = if @sale.tax.zero?
             "No"
           else
             "Si"
           end
  end

  private
  def sale_params
    params.require(:sale).permit(:cod, :detail, :category, :value, :discount, :tax)
  end
end
