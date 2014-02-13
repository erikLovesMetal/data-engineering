require 'csv'

class ParsesController < ApplicationController

  def new
    @parse = Parse.new
  end

  def create
    amounts = []

    #created new parse entry in table, this will store th file attributes
    @parse = Parse.new(parse_params)
    # set the name to the uploaded file name
    @parse.name =  @parse.file.file.filename
    # get the type of file extension
    fileExtension = @parse.file.file.filename.split('.')[1]
    # save it so we can retieve later
    @parse.save

    # only do all parsing if file saved/uploaded, make sure its a .tab file too
    if @parse.save && fileExtension == 'tab'
      # get the carrierwave obj , so we can retrieve the file
      uploader = @parse.file
      # retrieve the uploaded file
      uploader.retrieve_from_store!(File.basename(uploader.url))
      # process/parse the uploaded file and create new record and make a array of each row amounts
      CSV.foreach(uploader.file.path, :headers => true,col_sep:"\t") do |csv_row|
        # each csv row is now parsed, just set each column in the Item record
        Item.create(:purchaser_name => csv_row['purchaser name'], :item_description => csv_row['item description'], :price => csv_row['item price'], :count => csv_row['purchase count'], :merchant_address => csv_row['merchant address'], :merchant_name => csv_row['merchant name'])
        # push the price * count calculation for earch row to a container array
        amounts << csv_row['item price'].to_i * csv_row['purchase count'].to_i
      end
      # get the sum of the values in the amounts array, pass that to the view
      @grossAmt = amounts.inject(0) {|sum, i| sum + i}
      render "complete"
    else
      flash[:error] = "There was a error uploading and parsing file.  Please upload a file with .tab file extension."
      redirect_to '/'
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def parse_params
      params.require(:parse).permit(:name,:file)
    end
end
