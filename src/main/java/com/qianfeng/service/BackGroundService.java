package com.qianfeng.service;

import com.qianfeng.mapper.UserMapper;
import com.qianfeng.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Service
public class BackGroundService implements IBackGroundService {
    @Autowired
    private UserMapper mapper;
    public List<Product> selectAllItems(Page page,Query query){
      return   mapper.selectAllItems(page,query);
    }

    @Override
    public Long selectItemsNum(Query query) {
        return mapper.selectItemsNum(query);
    }

    @Override
    public List<Integer> updateStatusByIds(List<Integer> ids) {
        List<Integer> statusList=null;
        for (Integer i: ids) {
            Integer statusByIds = mapper.updateStatusByIds(i);
             statusList=new ArrayList<>();
            statusList.add(statusByIds);
        }
        return statusList;
    }

    @Override
    public List<Category> selectCategory(Page page) {
        return mapper.selectCategory(page);
    }

    @Override
    public Long selectCategoryNum() {
        return mapper.selectCategoryNum();
    }

    @Override
    public MessageResult<User> selectAllUser(Page page, Query query) {
        List<User> userList = mapper.selectAllUser(page, query);
        Long num = mapper.selectUserNum(query);
        MessageResult<User> resultList = new MessageResult<>();
        resultList.setCode(0);
        resultList.setCount(num);
        resultList.setMsg("success");
        resultList.setData(userList);
        return resultList;
    }

    @Override
    public List<Integer> updateUserStatus(List<Integer> ids) {
        List<Integer> statusList=null;
        for (Integer i: ids) {
            Integer it = mapper.updateUserStatus(i);
            statusList=new ArrayList<>();
            statusList.add(it);
        }
        return statusList;
    }

    @Override
    public MessageResult<User> selectRecoverUser(Page page, Query query) {
        List<User> userList = mapper.selectRecoverUser(page, query);
        Long num = mapper.selectRecoverUserNum(query);
        MessageResult<User> resultList = new MessageResult<>();
        resultList.setCode(0);
        resultList.setCount(num);
        resultList.setMsg("success");
        resultList.setData(userList);
        return resultList;
    }

    @Override
    public List<Integer>  updateRecoverUserStatus(List<Integer> ids) {
        List<Integer> statusList=null;
        for (Integer i: ids) {
            Integer it = mapper.updateRecoverUserStatus(i);
            statusList=new ArrayList<>();
            statusList.add(it);
        }
        return statusList;
    }

    @Override
    public  List<Integer> updateCategoryStatus(List<Integer> ids) {
        List<Integer> statusList=null;
        for (Integer i: ids) {
            Integer it = mapper.updateCategoryStatus(i);
            statusList=new ArrayList<>();
            statusList.add(it);
        }
      return statusList;
    }

    @Override
    public MessageResult<Order> selectOrderList(Page page, Query query) {
        List<Order> orderList = mapper.selectOrderList(page, query);
        Long num = mapper.selectOrderNum(query);
        MessageResult<Order> resultList = new MessageResult<>();
        resultList.setCode(0);
        resultList.setCount(num);
        resultList.setMsg("success");
        resultList.setData(orderList);
        return resultList;

    }

    @Override
    public List<Integer> updateOrderDelete(List<Integer> ids) {
        List<Integer> orderList=null;
        for (Integer i: ids) {
            Integer it = mapper.updateOrderDelete(i);
            orderList=new ArrayList<>();
            orderList.add(it);
        }
        return orderList;
    }

    @Override
    public MessageResult<User> selectAllAdmin(Page page, Query query) {
        List<User> userList = mapper.selectAllAdmin(page, query);
        Long num = mapper.selectAdminNum(query);
        MessageResult<User> resultList = new MessageResult<>();
        resultList.setCode(0);
        resultList.setCount(num);
        resultList.setMsg("success");
        resultList.setData(userList);
        return resultList;
    }

    @Override
    public List<Integer> updateAdminStatus(List<Integer> ids) {
        List<Integer> adminList=null;
        for (Integer i: ids) {
            Integer it = mapper.updateAdminStatus(i);
            adminList=new ArrayList<>();
            adminList.add(it);
        }
        return adminList;
    }

    @Override
    public Integer updateProduct(Product product) {
        Integer it = mapper.updateProduct(product);
        return it;
    }

    @Override
    public MessageResult<User> selectPowerUser(Page page, Query query) {
        List<User> userList = mapper.selectPowerUser(page, query);
        Long num = mapper.selectPowerNum(query);
        MessageResult<User> resultList = new MessageResult<>();
        resultList.setCode(0);
        resultList.setCount(num);
        resultList.setMsg("success");
        resultList.setData(userList);
        return resultList;
    }

    @Override
    public Integer userAdd(User user) {
       Integer it=null;
        Date day=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        user.setUdate(df.format(day));
        user.setStatus("1");
        user.setIsadmin("2");
        it = mapper.userAdd(user);
        return it;
    }

    @Override
    public Integer adminadd(User user) {
        Integer it=null;
        Date day=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        user.setUdate(df.format(day));
        user.setStatus("1");
        user.setIsadmin("1");
       it= mapper.adminadd(user);
        return it;
    }

    @Override
    public Integer addProduct(Product product,MultipartFile file,HttpServletRequest request) {
        Integer it=null;
        Date day=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        product.setPdate(df.format(day));
            if (!file.isEmpty()) {
                try {
                    file.transferTo(new File("D:/java学习资料/spring复习2/"+request.getContextPath() + "/src/main/webapp/images/products/1/" + file.getOriginalFilename()));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            product.setPimage("products/1/" + file.getOriginalFilename());
        product.setStatus(1);
         it = mapper.addProduct(product);
        return it;
    }

    @Override
    public Category verifierCategory(Category category) {
        Category category1 = mapper.verifierCategory(category);
        return category1;
    }

    @Override
    public Integer addCategory(Category category) {
        Integer it;
        it = mapper.addCategory(category);
        return  it;
    }

    @Override
    public Integer useredit(User user) {
        if("男".equals(user.getSex())){
            user.setSex("1");
        }else{
            user.setSex("2");
        }
       return  mapper.useredit(user);
    }

    @Override
    public Integer categoryEdit(Category category) {
        return mapper.categoryEdit(category);
    }

    @Override
    public List<User> userSelect() {
        return mapper.userSelect();
    }

    @Override
    public Integer orderEdit(Order order) {
        if("已支付".equals(order.getPaystatus())){
            order.setPaystatus("1");
        }else{
            order.setPaystatus("2");
        }
        if("顺丰快递".equals(order.getDelivery())){
            order.setDelivery("1");
        }else if("圆通快递".equals(order.getDelivery())){
            order.setDelivery("2");
        }else{
            order.setDelivery("3");
        }
        return mapper.orderEdit(order);
    }

    @Override
    public Integer adminEdit(User user) {
        if("男".equals(user.getSex())){
            user.setSex("1");
        }else{
            user.setSex("2");
        }
        return  mapper.adminEdit(user);
    }

    @Override
    public Integer powerEdit(User user) {
        if("管理员".equals(user.getIsadmin())){
            user.setIsadmin("1");
        }else if("普通用户".equals(user.getIsadmin())){
            user.setIsadmin("2");
        }else{
            user.setIsadmin("3");
        }
        return mapper.powerEdit(user);
    }

    @Override
    public User backRegister(User user) {
       return  mapper.selectByName(user);
    }
}
