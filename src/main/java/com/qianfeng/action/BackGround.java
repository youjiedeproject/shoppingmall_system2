package com.qianfeng.action;

import com.qianfeng.model.*;
import com.qianfeng.service.IBackGroundService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class BackGround {
    @Autowired
     private IBackGroundService service;
    @RequestMapping(value = "/{page}", method = RequestMethod.GET)
    public String index(@PathVariable String page) {
        return page;
    }

    @RequestMapping(value = "/pages/{pageName}", method = RequestMethod.GET)
    public String forwardOne(@PathVariable String pageName) {
        return "pages/" + pageName;
    }

    @RequestMapping(value = "/pages/{pageName1}/{pageName2}", method = RequestMethod.GET)
    public String forwardTwo(@PathVariable String pageName1, @PathVariable String pageName2) {
        return "pages/" + pageName1 + "/" + pageName2;
    }
    @ResponseBody
    @RequestMapping(value = "/items", method = RequestMethod.GET)
    public MessageResult<Product> selectAllItems(Page page, Query query) {
        List<Product> productList = service.selectAllItems(page,query);
        Long num = service.selectItemsNum(query);
        MessageResult<Product> resultList = new MessageResult<>();
        resultList.setCode(0);
        resultList.setCount(num);
        resultList.setMsg("success");
        resultList.setData(productList);
        return resultList;
    }
    @ResponseBody
    @RequestMapping(value = "/items/delete", method = RequestMethod.POST)
    public List<Integer> updateStatusByIds(@RequestParam ("ids[]") List<Integer> ids) {
        List<Integer> statusByIds = service.updateStatusByIds(ids);
        return statusByIds;
    }
    @ResponseBody
    @RequestMapping(value = "/items/category", method = RequestMethod.GET)
    public MessageResult<Category> selectCategoty(Page page) {
        MessageResult<Category> resultList = new MessageResult<>();
        List<Category> categoryList = service.selectCategory(page);
        Long num = service.selectCategoryNum();
        resultList.setCode(0);
        resultList.setCount(num);
        resultList.setMsg("success");
        resultList.setData(categoryList);
        return resultList;
    }
    @ResponseBody
    @RequestMapping(value = "/category/delete", method = RequestMethod.POST)
    public  List<Integer>  updateCategoryStatus(@RequestParam ("ids[]") List<Integer> ids) {
        List<Integer> statusList = service.updateCategoryStatus(ids);
        return statusList;
    }
    @ResponseBody
    @RequestMapping(value = "/user/message", method = RequestMethod.GET)
    public MessageResult<User> userMessage(Page page, Query query) {
        MessageResult<User> resultList = service.selectAllUser(page,query);
        return resultList;
    }
    @ResponseBody
    @RequestMapping(value = "/user/delete", method = RequestMethod.POST)
    public List<Integer> updateUserStatus(@RequestParam ("ids[]") List<Integer> ids) {
        List<Integer> userStatus = service.updateUserStatus(ids);
        return userStatus;
    }
    @ResponseBody
    @RequestMapping(value = "/user/recoverlist", method = RequestMethod.GET)
    public MessageResult<User> userRecover(Page page, Query query) {
        MessageResult<User> resultList = service.selectRecoverUser(page,query);
        return resultList;
    }
    @ResponseBody
    @RequestMapping(value = "/user/recover", method = RequestMethod.POST)
    public List<Integer> updateRecoverUserStatus(@RequestParam ("ids[]") List<Integer> ids) {
        List<Integer> userStatus = service.updateRecoverUserStatus(ids);
        return userStatus;
    }
    @ResponseBody
    @RequestMapping(value = "/orders", method = RequestMethod.GET)
    public MessageResult<Order> orderList(Page page, Query query) {
        MessageResult<Order> resultList = service.selectOrderList(page,query);
        return resultList;
    }
    @ResponseBody
    @RequestMapping(value = "/orders/delete", method = RequestMethod.POST)
    public List<Integer> updateOrderDelete(@RequestParam ("ids[]") List<Integer> ids) {
        List<Integer> orderList = service.updateOrderDelete(ids);
        return orderList;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/message", method = RequestMethod.GET)
    public MessageResult<User> adminMessage(Page page, Query query) {
        MessageResult<User> resultList = service.selectAllAdmin(page,query);
        return resultList;
    }
    @ResponseBody
    @RequestMapping(value = "/admin/delete", method = RequestMethod.POST)
    public  List<Integer> updateAdminStatus(@RequestParam ("ids[]") List<Integer> ids) {
        List<Integer> adminList = service.updateAdminStatus(ids);
        return adminList;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/power", method = RequestMethod.GET)
    public MessageResult<User> powerMessage(Page page, Query query) {
        MessageResult<User> resultList = service.selectPowerUser(page,query);
        return resultList;
    }

    @ResponseBody
    @RequestMapping(value = "/user/adminadd", method = RequestMethod.POST)
    public Integer adminadd(User user) {
        Integer adminadd = service.adminadd(user);
        return adminadd;
    }
    @ResponseBody
    @RequestMapping(value = "/user/useradd", method = RequestMethod.POST)
    public Integer useradd(User user) {
        Integer userAdd = service.userAdd(user);
        return userAdd;
    }

    @ResponseBody
    @RequestMapping(value = "/product/addProduct", method = RequestMethod.POST)
    public Integer addProduct(Integer pnumber,String pname,Double market_price,Double shop_price,String pdesc,Integer cid,Integer is_hot, @RequestParam("file") MultipartFile file, HttpServletRequest request){
        Product product = new Product();
        product.setPnumber(pnumber);
        product.setPname(pname);
        product.setMarket_price(market_price);
        product.setShop_price(shop_price);
        product.setPdesc(pdesc);
        product.setCid(cid);
        product.setIs_hot(is_hot);
        Integer addProduct = service.addProduct(product,file,request);
        return addProduct;
    }
    @ResponseBody
    @RequestMapping(value = "/verifierCategory", method = RequestMethod.GET)
    public Integer verifierCategory(Category category) {
        Category category1 = service.verifierCategory(category);
        if(category1!=null){
            return 1;
        }
        if(category.getCname()==""){
            return 1;
        }
        return 0;
    }
    @ResponseBody
    @RequestMapping(value = "/addCategory", method = RequestMethod.POST)
    public Integer addCategory(Category category) {
        category.setStatus("1");
        Integer it = service.addCategory(category);
        return it;
    }

    @ResponseBody
    @RequestMapping(value = "/useredit", method = RequestMethod.POST)
    public Integer useredit(User user) {
       return service.useredit(user);
    }


    @ResponseBody
    @RequestMapping(value = "/categoryEdit", method = RequestMethod.POST)
    public Integer categoryEdit(Category category) {
        return service.categoryEdit(category);
    }

    @ResponseBody
    @RequestMapping(value = "/userSelect", method = RequestMethod.GET)
    public List<User> userSelect() {
        return service.userSelect();
    }

    @ResponseBody
    @RequestMapping(value = "/orderEdit", method = RequestMethod.POST)
    public Integer orderEdit(Order order) {
        return service.orderEdit(order);
    }

    @ResponseBody
    @RequestMapping(value = "/adminEdit", method = RequestMethod.POST)
    public Integer adminEdit(User user) {
        return service.adminEdit(user);
    }

    @ResponseBody
    @RequestMapping(value = "/powerEdit", method = RequestMethod.POST)
    public Integer powerEdit(User user) {
        return service.powerEdit(user);
    }
}
