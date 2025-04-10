$(function () {
  $("#title").on("blur", function () {
    validTitle();
  });

  $("#dueDate").on("blur", function () {
    validDueDate();
  });

  $("#wirter").on("blur", function () {
    validWriter();
  });
});

function validTitle() {
  let isValid = false;

  let title = $("#title").val();

  if ((title = "")) {
    $("#titleError").html("제목을 입력하세요");
  } else {
    $("#titleError").html("");
    result = true;
  }

  return result;
}

function validDueDate() {
  // 완료일 : 오늘이나 그 이전 날짜는 입력받지 않도록 한다.
  // 필수
  let result = false;

  let dueDate = $("#dueDate").val();
  // console.log(dueDate == ""); // true

  let today = new Date().toISOString().split("T")[0];
  console.log(today); // 오늘의 날짜만

  if (dueDate == "") {
    $("#dueDateError").html("완료일은 필수항목입니다.");
  } else if (new Date(dueDate) - Date.now() < 0) {
    $("#dueDateError").html("완료일은 오늘 이후로 선택하세요.");
  } else {
    result = true;
  }

  return result;
}

function validWriter() {
  // 작성자는 not null
  let result = false;

  let writer = $("#writer").val();

  if (writer == "") {
    $("#writerError").html("작성자는 필수항목입니다.");
  } else {
    $("#writerError").html("");
    result = true;
  }

  return result;
}

function isValid() {
  let result = false;

  let titleValid = validTitle();
  let dueDateValid = validDueDate();
  let writerValid = validWriter();

  console.log(titleValid, dueDateValid, writerValid);

  if (titleValid && dueDateValid && writerValid) {
    result = true;
  }
  return result;
}

function clearErrors() {
  $("#titleError").html("");
  $("#dueDateError").html("");
  $("#writerError").html("");
}
