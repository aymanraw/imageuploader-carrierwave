# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


cloudinary_upload = (obj)->
	obj.cloudinary_fileupload()
	obj.fileupload(
		  dropZone: obj,
		  start: (e) ->
		        console.log "in progress"
		        $("#imageStatus").text "Starting upload..."
		  ,progress: (e, data) ->
		          $("#imageStatus").text("Uploading... " + Math.round((data.loaded * 100.0) / data.total) + "%")
		   ,fail: (e, data) ->
		         $("#imageStatus").text "Upload failed"
		    ).off("cloudinarydone").on("cloudinarydone", (e, data) ->
		         $("#photo_bytes").val(data.result.bytes)
		         $("#imageStatus").text("")
		         input_name = $(this).data("cloudinary-field")
		         input_field = $(this).parent().parent()
		         $.ajax 
		            url: "/products/save_temp_pic",
		            type: "post",
		            data: {"pic": data.result.public_id, "name": input_name}
		            ,beforeSend: ->
		            	console.log "before send"
		            ,success: (data, textStatus, jqXHR) -> 
		            	console.log "Successed"
		            	input_field.remove()
		            	console.log "text status is: #{textStatus}"
		            	console.log "Data is: #{data}"
		            ,error: (data, textStatus, jqXHR) ->
		            	console.log "error"
		            	console.log data
		            ,complete: ->
		            	console.log "Completed" 
			)

$(document).on 'ready page:load', ->
	cloudinary_upload $(".cloudinary-fileupload")
	obj = $(".cloudinary-fileupload[data-url='https://api.cloudinary.com/v1_1/gosoog/auto/upload']")
	console.log obj.attr('name')
	template_h = $('#template').html()
	pool_of_items = $('.pool')
	$(document).on 'click', '.delete',(event) ->
		if confirm('Are you sure you want to delete ?')
			console.log "delete"
			input_name = $(this).prev().children(".cloudinary-fileupload").data("cloudinary-field")
			$("input[name='#{input_name}']").remove()
			$(this).parent().remove()
		else
			console.log "dont delete"
		event.preventDefault()
	$('.add_more_ajax').on 'click', (event) ->
		clicked = $(this)
		if clicked.hasClass('disabled') then return false
		$.ajax 
		   url: '/products/picture_in'
		   ,data:{}
		   ,method: 'get'
		   ,beforeSend: ->
		        clicked.addClass('disabled')
		   ,success: (data, textStatus, jqXHR) -> 
		        form_data = $(data).children('.picture-uploader')
		        console.log "in success"
		        pool_of_items.append(form_data)
		        cloudinary_upload form_data.find('.cloudinary-fileupload')
		    ,error: (jqXHR, textStatus, error_thrown) ->
		        alert('Error')
		     ,complete: -> 
		       clicked.removeClass('disabled')

	
   
		
		