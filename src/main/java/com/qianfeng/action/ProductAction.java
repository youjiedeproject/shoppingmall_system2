package com.qianfeng.action;


import com.qianfeng.model.Category;
import com.qianfeng.model.PageBean;
import com.qianfeng.model.Product;
import com.qianfeng.model.Search;
import com.qianfeng.service.IBackGroundService;
import com.qianfeng.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/product")
public class ProductAction {
@Autowired
    private IUserService service;
    @Autowired
    private IBackGroundService service2;
    @RequestMapping(value="/")
    public String homePage(HttpSession session){
        List<Category> categoryList = service.selectAllCategory();
        session.setAttribute("categoryList",categoryList);
        Integer currentCount=12;
        Integer currentPage=1;
        Search search = new Search();
        search.setCurrentPage(currentPage);
        search.setCurrentCount(currentCount);
        PageBean<Product> pageBean = service.Paging(currentCount,search);
        session.setAttribute("pageBean",pageBean);

        return "homePage";
    }

    @RequestMapping(value="/index.do")
    public String index(){
        return "index";
    }
    @RequestMapping(value="/searchProduct")
    public String searchProduct(String pname,HttpSession session){
        Integer currentCount=12;
        Integer currentPage=1;
        Search search = new Search();
        search.setCurrentPage(currentPage);
        search.setPname(pname);
        search.setCurrentCount(currentCount);
        PageBean<Product> pageBean = service.Paging(currentCount,search);
        session.setAttribute("pageBean",pageBean);
        session.setAttribute("pname",pname);
        return "SearchPage";
    }
    @RequestMapping(value="/paging")
    public String paging(Integer currentPage,String pname,Integer cid, Model model){
        Integer currentCount=12;
        Search search = new Search();
        search.setCurrentPage(currentPage);
        if(pname!=null&&!"".equals(pname)){
            search.setPname(pname);
        }
        if(cid!=null&&!"".equals(cid)){
            search.setCid(cid);
        }
        search.setCurrentCount(currentCount);
        PageBean<Product> pageBean = service.Paging(currentCount,search);
        model.addAttribute("pageBean",pageBean);
        if(pname!=null&&!"".equals(pname)){
            return "SearchPage";
        }
        return "CategoryPage";
    }
    @RequestMapping(value="/categoryProduct")
    public String categoryProduct(Integer cid,HttpSession session){
        Integer currentCount=12;
        Integer currentPage=1;
        Search search = new Search();
        search.setCurrentPage(currentPage);
        search.setCid(cid);
        search.setCurrentCount(currentCount);
        PageBean<Product> pageBean = service.Paging(currentCount,search);
        session.setAttribute("pageBean",pageBean);
        session.setAttribute("cid",cid);
        return "CategoryPage";
    }
    @RequestMapping(value="/checkProduct")
    public String checkProduct(Integer pid,HttpSession session){
        Product Product = service.selectProductById(pid);
        session.setAttribute("Product",Product);
        return "CheckProduct";
    }

    @ResponseBody
    @RequestMapping(value = "/categorySelect", method = RequestMethod.GET)
    public  List<Category>   categorySelect() {
        List<Category> categoryList = service.selectAllCategory();
        return categoryList;
    }
    @ResponseBody
    @RequestMapping(value = "/product_edit", method = RequestMethod.POST)
    public Integer  product_edit(Integer pid,String pname,Double marketprice,Double shopprice,Integer cid,Integer is_hot,String pdate,String productdesc,String statusName) {
           Integer it=null;
            Product product=new Product();
            product.setCid(cid);
            product.setIs_hot(is_hot);
            product.setMarket_price(marketprice);
            product.setPdate(pdate);
            product.setShop_price(shopprice);
            if("正常".equals(statusName)){
                product.setStatus(1);
            }else{
                product.setStatus(2);
            }
            product.setPdesc(productdesc);
            product.setPid(pid);
            product.setPname(pname);
         it = service2.updateProduct(product);
        return it;
    }

}


