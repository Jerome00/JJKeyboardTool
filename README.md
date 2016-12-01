# JJKeyboardTool
通过这个文件可以快速的为键盘添加toolbar完成textfield之间的切换
使用：将文件拖入项目中，在需要使用该文件的控制其中创建JJKeyboardTool
> JJKeyboardTool *tool=[[JJKeyboardTool alloc]init];    

设置tool.fieldArray,然后将tool.toolbar添加到控制器的view上  
在UItextfield的代理方法中调用 showToolbar：方法  

> -(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.tool showToolBar:textField];
}  

完成
