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
      },
      error: function () {},
      complete: function () {},
    });
  });
});
