package com.qianfeng.action;

import com.qianfeng.model.Order;
import com.qianfeng.model.ShopCar;
import com.qianfeng.service.IShopCarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class shopcarAction {
@Autowired
    private IShopCarService shopcarservice;
    @ResponseBody
    @RequestMapping(value="/addShopCar",method= RequestMethod.POST)
    public Integer  addShopCar(Integer uid,Integer pid){
       return shopcarservice.addShopCar(uid,pid);
    }

    @RequestMapping(value="/CheckShopCar",method= RequestMethod.GET)
    public String  CheckShopCar(Integer uid, Model model){
        List<ShopCar> shopCars = shopcarservice.CheckShopCar(uid);
        model.addAttribute("shopCars",shopCars);
        return "ShopCar";
    }

    @ResponseBody
    @RequestMapping(value="/delAll",method= RequestMethod.POST)
    public Integer  delAll(HttpServletRequest request){
        String[] delBoxes = request.getParameterValues("delBox");
        Integer it = shopcarservice.delAll(delBoxes);
        return it;
    }
    @ResponseBody
    @RequestMapping(value="/deleteShopCar",method= RequestMethod.POST)
    public Integer  deleteShopCar(Integer car_id){
        return shopcarservice.deleteShopCar(car_id);
    }

    @RequestMapping(value="/settingOrder",method= RequestMethod.POST)
    public String  settingOrder(HttpServletRequest request, HttpSession session,Model model){
        String[] delBoxes = request.getParameterValues("delBox");
        session.setAttribute("delBoxes",delBoxes);
        String sumPrice = request.getParameter("sumPrice");
        List<Integer> productIds = shopcarservice.selectIdbyCar(delBoxes);
        session.setAttribute("productIds",productIds);
       model.addAttribute("sumPrice",sumPrice);
        return "settingOrder";
    }
    @ResponseBody
    @RequestMapping(value="/shopcar/addOrder",method= RequestMethod.POST)
    public Integer   addOrders( HttpSession session, Model model,Order order){
        Integer it = shopcarservice.addorders(session, order);
         return it;
    }

    @RequestMapping(value="/checkOrder",method= RequestMethod.GET)
    public String  checkOrder(Integer uid,Model model){
        List<Order> orderList = shopcarservice.checkOrder(uid);
        model.addAttribute("orderList",orderList);
        return "Orders";
    }

    @ResponseBody
    @RequestMapping(value="/order/removeOrder",method= RequestMethod.GET)
    public Integer   removeOrder(String oid){
        Integer it=null;
         it = shopcarservice.removeOrder(oid);
        return it;
    }

    @ResponseBody
    @RequestMapping(value="/order/removeOrders",method= RequestMethod.POST)
    public Integer  removeOrders(HttpServletRequest request){
        String[] oids = request.getParameterValues("delBox");
        Integer it = shopcarservice.removeOrders(oids);
        return it;
    }
}
