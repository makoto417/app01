$(function(){

	var i = 0;
	$('.profile-text').each(function() {
		sHeight = $('.profile-text').get(i).scrollHeight;
		oHeight = $('.profile-text').get(i).offsetHeight;
		hiddenDiff = sHeight - oHeight;

		if(hiddenDiff > 0){
		$(this).parent().append('<div class="read-more" >... 続きを見る</div>')
		}

		i++;
	});

	$(".read-more").click(function() {
		//get data
		txt_height = parseInt($(this).parent().find(".profile-text").css('height'),10);

		sHeight = $(this).parent().find(".profile-text").get(0).scrollHeight;
		oHeight = $(this).parent().find(".profile-text").get(0).offsetHeight;
		hiddenDiff = sHeight - oHeight;

		new_txt_height = txt_height + hiddenDiff;
		$(this).parent().find(".profile-text").animate({ height: new_txt_height}, 200 );
		$(this).slideUp();
	});

});
