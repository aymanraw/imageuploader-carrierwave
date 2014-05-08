# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


cloudinary_upload = (obj)->
	obj.cloudinary_fileupload()
	obj.fileupload(
		  dropZone: obj,
		  start: (e) ->
		        console.log "in progress"
		        $("#loader").css("display", "normal")
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
		            	$("#loader").css("display", "normal")
		            ,success: (data, textStatus, jqXHR) -> 
		            	console.log "Successed"
		            	input_field.remove()
		            	console.log "text status is: #{textStatus}"
		            	console.log "Data is: #{data}"
		            ,error: (data, textStatus, jqXHR) ->
		            	console.log "error"
		            	console.log data
		            ,complete: ->
		            	$("#loader").css("display", "none")
		            	console.log "Completed"
		            	$("#loader").css("display", "none") 
			)

$(document).on 'ready page:load', ->
	cloudinary_upload $(".cloudinary-fileupload")
	$('form').on 'click', '.delete', (event) ->
		$(this).prev('input[type=hidden]').val(1)
		$(this).closest('fieldset').hide()
		event.preventDefault()

	$('form').on 'click', '.add-fields', (event) ->
	    time = new Date().getTime()
	    regexp = RegExp($(this).data('id'), 'g')
	    $(this).before($(this).data('fields').replace(regexp, time))
	    event.preventDefault()
	
   
		
		