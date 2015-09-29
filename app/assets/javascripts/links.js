/**
 * Created by Champloo on 15/09/05.
 */
$(function(){
    //Hold id for previous generated edit form
    var past = null;
    //Checks when new edit for is added that it removes any other lingering
    //edit forms and reply forms.
    $('body').on('DOMNodeInserted','.edit_comment', function(){
        if($('.edit_comment').size() == 2){
            var b = $('#'+past).parent();
            b.parent().find('.leading').html($('#'+past).find('#comment_body').val());
        }
        if($('.replying').length){
            $('.replying').hide();
        }
        past = this.id;
    });


    $('#main_new_comment').bind("ajax:send",function(){
        $('#main_new_comment input[type="submit"]').val('Loading');
        $('#main_new_comment input[type="submit"]').prop('disabled',true);
    }).bind("ajax:error", function(e,xhr,status,error){
        var ep = $('<p> '+xhr.responseJSON.error+ ' </p>').css({"font-size": "large","color":"red"});
        $('#main_error').html(ep);
        $('#main_new_comment input[type="submit"]').val('Retry Reply');
        $('#main_new_comment input[type="submit"]').prop('disabled',false);
    });
});