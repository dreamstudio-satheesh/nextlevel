$(document).ready(function () {
    $(".sideBarli").removeClass("activeLi");
    $(".actorSideA").addClass("activeLi");

    $("#actorsTable").dataTable({
        autoWidth: false,
        processing: true,
        serverSide: true,
        serverMethod: "post",
        aaSorting: [[0, "desc"]],
        language: {
            paginate: {
                next: '<svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><polyline points="9 18 15 12 9 6"></polyline></svg>',
                previous:
                    '<svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><polyline points="15 18 9 12 15 6"></polyline></svg>',
            },
        },
        columnDefs: [
            {
                targets: "_all",
                orderable: false,
            },
        ],
        ajax: {
            url: `${domainUrl}actorsList`,
            error: (error) => {
                console.log(error);
            },
        },
    });

    $(document).on("submit", "#addNewActorForm", function (e) {
        e.preventDefault();
        checkUserType(function (e) {
            let formData = new FormData($("#addNewActorForm")[0]);
            $.ajax({
                type: "POST",
                url: `${domainUrl}addNewActor`,
                data: formData,
                contentType: false,
                processData: false,
                success: function (response) {
                    if (response.status) {
                        showSuccessToast();
                        $("#actorsTable").DataTable().ajax.reload(null, false);
                        $("#addActorModal").modal("hide");
                    }
                },
            });
        });
    });

    $(document).on("click", ".edit", function (e) {
        e.preventDefault();

        var id = $(this).attr("rel");
        var fullname = $(this).data("fullname");
        var profile_image = $(this).data("profile_image");
        var dob = $(this).data("dob");
        var bio = $(this).data("bio");

        $("#actor_id").val(id);
        $("#edit_fullname").val(fullname);
        $("#edit_dob").val(dob);
        $("#edit_bio").val(bio);

        if (profile_image) {
            $("#edit_profile_image").attr("src", `${profile_image}`);
        } else {
            $("#edit_profile_image").attr(
                "src",
                "assets/img/placeholder-image.png"
            );
        }

        $("#editActorModal").modal("show");
    });

    $(document).on("submit", "#editActorForm", function (e) {
        e.preventDefault();
        var id = $("#actor_id").val();
        checkUserType(function (e) {
            let editformData = new FormData($("#editActorForm")[0]);
            editformData.append("actor_id", id);
            $.ajax({
                type: "POST",
                url: `${domainUrl}updateActor`,
                data: editformData,
                contentType: false,
                processData: false,
                success: function (response) {
                    if (response.status) {
                        showSuccessToast();
                        $("#actorsTable").DataTable().ajax.reload(null, false);
                        $("#editActorModal").modal("hide");
                    } else {
                        somethingWentWrongToast();
                    }
                },
            });
        });
    });

    $(document).on("click", ".delete", function (e) {
        e.preventDefault();
        var id = $(this).attr("rel");
        checkUserType(function (e) {
            swal({
                title: "Are you sure?",
                icon: "error",
                buttons: true,
                dangerMode: true,
                buttons: ["Cancel", "Yes"],
            }).then((deleteValue) => {
                if (deleteValue) {
                    $.ajax({
                        type: "POST",
                        url: `${domainUrl}deleteActor`,
                        dataType: "json",
                        data: {
                            actor_id: id,
                        },
                        success: function (response) {
                            if (response.status) {
                                showSuccessToast();
                                $("#actorsTable")
                                    .DataTable()
                                    .ajax.reload(null, false);
                            } else {
                                somethingWentWrongToast();
                            }
                        },
                    });
                }
            });
        });
    });

    let currentActorPage = 1;
    let totalActorPages = 1;
    const maxVisiblePages = 5;
    $(".pagination-controls").hide();

    function updateActorPaginationControls() {
        $("#prev-page-actor").prop("disabled", currentActorPage === 1);
        $("#next-page-actor").prop(
            "disabled",
            currentActorPage === totalActorPages
        );

        let pageButtonsHtml = "";

        if (totalActorPages <= maxVisiblePages) {
            for (let i = 1; i <= totalActorPages; i++) {
                pageButtonsHtml += `<button class="pagination-ui-actor" data-page="${i}">${i}</button>`;
            }
        } else {
            if (currentActorPage <= Math.ceil(maxVisiblePages / 2)) {
                for (let i = 1; i <= maxVisiblePages - 1; i++) {
                    pageButtonsHtml += `<button class="pagination-ui-actor" data-page="${i}">${i}</button>`;
                }
                pageButtonsHtml += `<span>...</span><button class="pagination-ui-actor" data-page="${totalActorPages}">${totalActorPages}</button>`;
            } else if (
                currentActorPage >=
                totalActorPages - Math.floor(maxVisiblePages / 2)
            ) {
                pageButtonsHtml += `<button class="pagination-ui-actor" data-page="1">1</button><span>...</span>`;
                for (
                    let i = totalActorPages - (maxVisiblePages - 2);
                    i <= totalActorPages;
                    i++
                ) {
                    pageButtonsHtml += `<button class="pagination-ui-actor" data-page="${i}">${i}</button>`;
                }
            } else {
                pageButtonsHtml += `<button class="pagination-ui-actor" data-page="1">1</button><span>...</span>`;
                for (
                    let i =
                        currentActorPage -
                        Math.floor((maxVisiblePages - 2) / 2);
                    i <=
                    currentActorPage + Math.floor((maxVisiblePages - 2) / 2);
                    i++
                ) {
                    pageButtonsHtml += `<button class="pagination-ui-actor" data-page="${i}">${i}</button>`;
                }
                pageButtonsHtml += `<span>...</span><button class="pagination-ui-actor" data-page="${totalActorPages}">${totalActorPages}</button>`;
            }
        }

        $("#actor-page-buttons").html(pageButtonsHtml);

        $(".pagination-ui-actor").removeClass("active");
        $(`.pagination-ui-actor[data-page=${currentActorPage}]`).addClass(
            "active"
        );
    }

    function fetchActors(page) {
        // $(".table-loader-bg").fadeIn("fast");
        // $(".table-loader-bg").addClass("d-none");

        let actorQuery = $("#actorQuery").val();
        let actorQueryURL =
            "https://api.themoviedb.org/3/search/person?query=" +
            actorQuery +
            "&language=en-US&page=" +
            page +
            "&api_key=" +
            TMDB_api_key;

        $.ajax({
            async: true,
            crossDomain: true,
            type: "GET",
            url: actorQueryURL,
            contentType: false,
            processData: false,
            success: function (response) {
                // $(".table-loader-bg").fadeOut("fast");
                // $(".table-loader-bg").addClass("d-none");
                let items = response.results;
                totalActorPages = response.total_pages;

                if (items.length > 0) {
                    let data = [];
                    $.each(items, function (index, item) {
                        let profilePath = item.profile_path
                            ? `https://image.tmdb.org/t/p/w500${item.profile_path}`
                            : "assets/img/placeholder-image.png";

                        data.push([
                            `<div class="d-flex align-items-center">
                            <img src="${profilePath}" ${(profilePath =
                                item.profile_path
                                    ? "data-fancybox"
                                    : "")} class="object-fit-cover border-radius img-border" width="60px" height="60px">
                            <span class="ms-3">${item.name}</span>
                        </div>`,
                            `<div class="text-end"><a href="javascript:;" class="btn btn-primary importContentData" rel="${item.id}"> ${localization.importData} </a></div>`,
                        ]);
                    });

                    $("#resultOfActorTable").DataTable({
                        destroy: true,
                        data: data,
                        columns: [
                            { title: localization.profile },
                            { title: localization.action },
                        ],
                        paging: false,
                        pageLength: 10,
                        lengthChange: false,
                        searching: false,
                        info: false,
                        autoWidth: false,
                        responsive: false,
                        dom: "lrtip",
                        drawCallback: function () {
                            $("html, body").animate(
                                {
                                    scrollTop: $(".main-content").offset().top,
                                },
                                "slow"
                            );
                        },
                    });

                    $(".pagination-actor").show();

                    updateActorPaginationControls();
                } else {
                    let table = $("#resultOfActorTable").DataTable({
                        destroy: true,
                        info: false,
                        paging: false,
                        lengthChange: false,
                        searching: false,
                    });
                    table.clear().draw();
                }
            },
            error: function (response) {
                console.log(response);
            },
        });
    }

    fetchActors(currentActorPage);

    $("#prev-page-actor").on("click", function () {
        if (currentActorPage > 1) {
            currentActorPage--;
            fetchActors(currentActorPage);
        }
    });

    $("#next-page-actor").on("click", function () {
        if (currentActorPage < totalActorPages) {
            currentActorPage++;
            fetchActors(currentActorPage);
        }
    });

    $(document).on("submit", "#searchActorTMDBForm", function (e) {
        e.preventDefault();
        currentActorPage = 1;
        fetchActors(currentActorPage);
    });

    $("#actor-page-buttons").on("click", ".pagination-ui-actor", function () {
        currentActorPage = $(this).data("page");
        fetchActors(currentActorPage);
    });

    $(document).on("click", ".importContentData", function (e) {
        e.preventDefault();

        $(this).addClass("spinning disabled");
        $(".importContentData").addClass("disabled");

        var actorID = $(this).attr("rel");

        var actorDetailURL = `https://api.themoviedb.org/3/person/${actorID}?api_key=${TMDB_api_key}`;

        $.ajax({
            url: actorDetailURL,
            type: "GET",
            success: function (response) {
                $(this).removeClass("spinning disabled");
                let profilePath = response.profile_path
                    ? `https://image.tmdb.org/t/p/w500${response.profile_path}`
                    : "assets/img/placeholder-image.png";

                $("#set_actor_profile").attr("src", profilePath);
                $("#profile_path_url").val(profilePath);

                $("#set_fullname").val(response.name);
                $("#set_bio").val(response.biography);

                 let formattedDate = response.birthday
                     .split("-")
                     .reverse()
                     .join("-");
                 $("#set_dob").val(formattedDate);

                // $("#set_dob").val(response.birthday);

                $(".saveButton").removeClass("spinning disabled");
                $(".importContentData").removeClass("spinning disabled");
                $("#addActorModal").modal("show");
            },
            error: function (error) {
                console.error("Error fetching actor details:", error);
            },
        });
    });

    $(document).on("submit", "#addNewActorFormTMDB", function (e) {
        e.preventDefault();
        checkUserType(function (e) {
            let formData = new FormData($("#addNewActorFormTMDB")[0]);
            $.ajax({
                type: "POST",
                url: `${domainUrl}addNewActor`,
                data: formData,
                contentType: false,
                processData: false,
                success: function (response) {
                    if (response.status) {
                        window.location.href = `${domainUrl}actors`;
                    }
                },
            });
        });
    });
});
