sub setup() {
    object("学生", "名称" => "str", "性别" => "bool", "身高" => "number", "班级" => "object");
    object("班级", "年级" => "int", "编号" => "int");
    theme("bootstrap-yellow");
    home("首页");
}

sub app() {
    page("首页");
    my_menu();
    text("欢迎大家");
    br();
    text("请看右边学生列表", "width" => "50%");
    table("学生", ["姓名"], ["身高" => "asc"]);

    page("关于");
    my_menu();
    text("我们是一个小公司");
}

# reusable widgets
sub my_menu() {
    menu("首页", "关于");
}



