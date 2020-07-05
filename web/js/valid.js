$(document).ready(function(){
    $('#button').on('click', function () {
        var name = $('#n').val().trim();
        var surname = $('#s').val().trim();
        var email = $('#e').val().trim();
        var password = $('#pass').val().trim();
        var type = $('#t').val().trim();

        if (name == ""){
            name.style.border = "2px solid red";
             return false;
        }else
        if (surname == ""){
            surname.style.border = "2px solid red";
            $('#p').innerHTML = "please input surname"
            return false;
        }else

        if (email == ""){
            email.style.border = "2px solid red";
            $('#p').innerHTML = "please input email"
            return false;
        }else
        if (password == ""){
            password.style.border = "2px solid red";
            $('#p').innerHTML = "please input password"
            return false;
        }else
        if (type == ""){
            type.style.border = "2px solid red";
            $('#p').innerHTML = "please input type"
            return false;
        }

        $('#p').innerHTML = ""

    })
})