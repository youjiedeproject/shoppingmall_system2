package com.qianfeng.action;

import com.qianfeng.model.User;
import com.qianfeng.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/user")
public class UserAction {
    @Autowired
    private IUserService service;
    @RequestMapping(value="/")
    public String toLogin(){
        return "login";
    }
    @RequestMapping(value = "/tologin",produces="plain/text;charset=UTF-8")
    @ResponseBody
    public String selectByName(User user, HttpSession session, HttpServletResponse response){
        User findUser = service.selectByName(user);
        if(findUser!=null){
            if(findUser.getPassword().equals(user.getPassword())){
                session.setAttribute("userlogin",findUser);
                return "1";
            }else{
                return "0";
            }
        }
        return "0";
    }
    @RequestMapping(value="/exitRegister")
    public String exitRegister(HttpServletRequest request,HttpServletResponse response){
        Cookie cookie[]=request.getCookies();
        if (cookie!=null) {
            for (int i = 0; i < cookie.length; i++) {
                Cookie c = cookie[i];
                if ("userlogin".equals(c.getName())) {
                    int seconds=0;
                    c.setMaxAge(seconds);
                    response.addCookie(c);
                }
            }
        }
        return "redirect:/user/";
    }
    @RequestMapping(value="/register")
    public String register(){
        return "Register";
    }
    @RequestMapping(value="/verifierRegister")
    @ResponseBody
    public String verifierRegister(User user){
        User findUser = service.selectByName(user);
        if(findUser!=null){
            return "1";
        }
        return "0";
    }
    @RequestMapping(value="/toRegister")
    public String toRegister(User user){
        service.insertAll(user);
        return "redirect:/product/";
    }
}
