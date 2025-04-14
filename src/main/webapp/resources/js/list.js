$(function () {
  $(".finishedCheckbox").change(function () {
    let dno = $(this).data("dno");
    let checked = $(this).is(":checked"); // true | false

    console.log(dno, checked);

    $.ajax({
      url: "/diary/updateFinished", // 데이터가 송수신될 서버의 주소
      type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
      dataType: "text", // 수신받을 데이터 타입 (MIME TYPE)
      // async: false, // 동기 통신 방식
      data: {
        dno: dno,
        finished: checked,
      }, // 보내는 데이터
      success: function (data) {
        // 통신이 성공하면 수행할 함수
        console.log(data);
        if (data == "success") {
          if (checked) {
            $("#dlist-" + dno).addClass("completed");
          } else {
            $("#dlist-" + dno).removeClass("completed");
          }
          window.location = "/diary/list";
        }
      },
      error: function () {},
      complete: function () {},
    });
  });

  // 수정 (title, dueDate)
  $(".modifyBtn").click(function () {
    let dno = $(this).data("dno");
    let title = $(this).data("title");
    let date = $(this).data("date");

    console.log(dno, title, date);

    $("#modifyDno").val(dno);
    $("#modifyTitle").val(title);
    $("#modifyDueDate").val(date);

    $("#modifyModal").show();
  });

  $(".closeModal").click(function () {
    $("#modifyModal").hide();
  });
});

function modifyDiary() {
  let dno = $("#modifyDno").val();
  let title = $("#modifyTitle").val();
  let dueDateStr = $("#modifyDueDate").val();

  // 유효성검사
  if (title == "" || dueDateStr == "") {
    alert("제목, 날짜를 입력하세요");
    return;
  }

  $.ajax({
    url: "/diary/modify", // 데이터가 송수신될 서버의 주소
    type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
    dataType: "text", // 수신받을 데이터 타입 (MIME TYPE)
    async: false, // 동기 통신 방식
    data: {
      dno: dno,
      title: title,
      dueDateStr: dueDateStr,
    }, // 보내는 데이터
    success: function (data) {
      // 통신이 성공하면 수행할 함수
      console.log(data);
      $("#modifyModal").hide();
      self.location = "/diary/list";
    },
    error: function () {},
    complete: function () {},
  });
}
