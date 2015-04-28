/* Responsive Menu */

$('#phoneMenuOpen').click(function(){
    $('#phoneMenu').css({display: "block", top: "-100%"}).animate({top: "0%"});
    $('body').css({overflow: "hidden"});
});

$('#phoneMenuClose').click(function(){
    $('#phoneMenu').css({display: "block", top: "0%"}).animate({top: "100%"}, 400, function(){
        $('#phoneMenu').css({display: "none"});
        $('body').css({overflow: "auto"});
    });
});

/* My skills */

jQuery(document).ready(function(){
jQuery('.skillbar').each(function(){
    jQuery(this).find('.skillbar-bar').animate({
        width:jQuery(this).attr('data-percent')
    },4000);
});
});