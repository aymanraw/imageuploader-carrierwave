# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
	template_h = $('#template').html()
	pool_of_items = $('.pool')
	$(document).on 'click', '.delete',(event) ->
		if confirm('Are you sure you want to delete ?')
			console.log "delete"
			$(this).parent().remove()
		else
			console.log "dont delete"
		event.preventDefault()
	$('.add_more_ajax').on 'click', (event) ->
		clicked = $(this)
		console.log "clicked"
		if clicked.hasClass('disabled') then return false
		$.ajax 
		   url: '/products/picture_in'
		   ,data:{}
		   ,method: 'get'
		   ,beforeSend: ->
		        clicked.addClass('disabled')
		   ,success: (data, textStatus, jqXHR) -> 
		        form_data = $(data).children('.picture-uploader').html()
		        pool_of_items.append(form_data)
		    ,error: (jqXHR, textStatus, error_thrown) ->
		        alert('Error')
		     ,complete: -> 
		       clicked.removeClass('disabled')
   
		