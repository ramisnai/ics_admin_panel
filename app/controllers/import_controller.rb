class ImportController < ApplicationController

	def index
		@data = IotDatum.order(:id)
    respond_to do |format|
      format.html
      format.csv { send_data @data.to_csv }
    end
	end

	def show
	end

	def parts
		puts "parts download"
		@data = PartMaster.order(:id)
    respond_to do |format|
    	format.html
      format.csv { send_data @data.to_csv, file_name: 'Parts_master' }
    end
	end

	def import
		bu = current_user.bu
		case params[:select]
		when 'TVSM Planner'
			if IotDatum.import(params[:file],bu)
	    		redirect_to iot_data_path, notice: 'Data imported.'
	    else
	    		redirect_to import_index_path, notice: 'Part Code Already Assigned for a Device'
	    end
	  when 'RE-Planner'
	    if IotDatum.import(params[:file],bu)
	    		redirect_to iot_data_path, notice: 'Royal Enfield Data imported.'
	    else
	    		redirect_to import_index_path, notice: 'Royal Enfield Data imported.'
	    end  
	  when 'Parts Master'
	  	puts "Part Master"
	  	PartMaster.import(params[:file])
	  	redirect_to root_url, notice: 'Parts Master uploaded Successfully.'
	  when 'Shift Master'
	  	puts "Shift Master"
	  	ShiftMaster.import(params[:file])
	  	redirect_to root_url, notice: 'Shift Master uploaded Successfully..'
	  when 'Workbench Master'
	  	puts "Workbench Master"
	  	WorkbenchMaster.import(params[:file])
	  	redirect_to root_url, notice: 'Workbench Master uploaded Successfully..'
	  end
	end
end