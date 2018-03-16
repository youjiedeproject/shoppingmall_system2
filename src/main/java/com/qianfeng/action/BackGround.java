package com.qianfeng.action;

import com.qianfeng.model.*;
import com.qianfeng.service.IBackGroundService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
    public void updateStatusByIds(@RequestParam ("ids[]") List<Integer> ids) {
        service.updateStatusByIds(ids);
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
}
