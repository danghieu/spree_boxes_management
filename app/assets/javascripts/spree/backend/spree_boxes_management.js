// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/backend/all.js'
Spree.routes.products_search_by_dish_type_and_name= Spree.pathFor('api/products_search_by_dish_type_and_name')
Spree.routes.box_product_create= Spree.pathFor('api/box_product_create')

$(document).ready(function() {
    'use strict';

    $(".select-dish").hide();

    $("body").on('click', '#dish_field', function() {
      var dish_type = $(this).attr('data-dish-type');
      $(".select-dish").hide();
      $("#select-dish-" + dish_type).show();
    })
    
    $("body").on('keyup', '#q', function() {
      var index = $(this).parent().attr('data-id');
      var serve_date = $(this).parent().attr("data-date");
      $("#search-result-"+ index+ serve_date).show();
      var q = $(this).val();
      updateSearchListDishType(q, index, serve_date);
    });

    $("body").on('click', '.box-product-select', function() {
      var product_id_new = $(this).attr('data-id');
      var data_box = $(this).parent().parent().parent().attr("data-box");
      var data_index = $(this).parent().parent().parent().attr("data-index");
      var product_id_old = $(this).parent().parent().parent().attr("data-product-id-old");
      var serve_date = $(this).parent().parent().parent().attr("data-date");
      addDishToBox(product_id_new, product_id_old, data_box, data_index, serve_date);
    });

  });

  function addDishToBox(product_id_new, product_id_old, box_id, index,serve_date) {
    Url = Spree.routes.box_product_create;
    $.ajax({
      url: Url,
      type: "post",
      data: {
        token: Spree.api_key,
        product_id_old: product_id_old,
        box_id: box_id,
        product_id_new: product_id_new,
        serve_date:serve_date
      },
      success: function(data_result) {
        dish = data_result.products
        var dish_image;
        if (dish.images[0] != null)
          dish_image = dish.images[0].product_url;
        else dish_image = "/assets/noimage/large.png";
        var name = "#box-dish-" + index;
        $(name).html("");
        $(name).append(
          "<div class='image'><img src='" + dish_image + "'></div>\
           <div class='product-name'>" + dish.name + "</div>\
           <span class='icon icon-chevron-down' style='padding-top: 20px;float: right;''></span>"
        );
        $("#search-result-"+index + serve_date).attr("data-product-id-old", dish.id);

        var divname = "#box-dish-"+product_id_old+"-"+serve_date;
        $(divname).html(
          "<p class='product_name'>" +dish.dish_type.name + "</p>\
            <div class='image'> <img src='"+ dish_image +"'</div>\
            <p class='product_name'>"+dish.name+"</p>\
            "
        );
        $(divname).attr("id","box-dish-"+dish.id+"-"+serve_date);
        //window.location.reload(true);
      },
      error: function(result) {
        alert("Something is Wrong!")

      }
    });
  }

  function updateSearchListDishType(q, dish_type,serve_date) {
    Url = Spree.routes.products_search_by_dish_type_and_name;
    console.log(dish_type);
    console.log(serve_date);
    $.ajax({
      url: Url,
      type: "post",
      async: false,
      data: {
        token: Spree.api_key,
        "q": q,
        "dish_type": dish_type,
        serve_date:serve_date
      },
      success: function(result) {
        var html = "";
        if (result == null || result.products.length == 0)
          $("#search-result-"+dish_type+serve_date).html(html);
        else {

          var html = "<table class='table table-hover table-striped table-search'>";
          $.each(result.products, function(idx, dish) {
            var dish_image;
            if (dish.images[0] != null)
              dish_image = dish.images[0].product_url;
            else dish_image = "/assets/noimage/large.png";
            html += "<tr class='box-product-select' data-id='" + dish.id + "'>\
                      <td class ='product-image'><img src='" + dish_image + "'></td>\
                      <td class ='product-image'>" + dish.name + "</td>\
                    </tr>";
          });
          html += " </table>";
          $("#search-result-"+dish_type+serve_date).html(html);
        }

      },
      error: function(result) {
        alert(result);
      }
    });
  }