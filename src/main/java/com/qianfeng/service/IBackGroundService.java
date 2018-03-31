package com.qianfeng.service;

import com.qianfeng.model.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface IBackGroundService {
        List<Product> selectAllItems(Page page,Query query);
        Long selectItemsNum(Query query);
        List<Integer> updateStatusByIds(List<Integer> ids);
        List<Category> selectCategory(Page page);
        Long selectCategoryNum();
        MessageResult<User> selectAllUser(Page page,Query query);
        List<Integer> updateUserStatus(List<Integer> ids);
        MessageResult<User> selectRecoverUser(Page page,Query query);
        List<Integer>  updateRecoverUserStatus(List<Integer> ids);
        List<Integer> updateCategoryStatus(List<Integer> ids);
        MessageResult<Order> selectOrderList(Page page,Query query);
        List<Integer> updateOrderDelete(List<Integer> ids);
        MessageResult<User> selectAllAdmin(Page page,Query query);
        List<Integer> updateAdminStatus(List<Integer> ids);
        Integer updateProduct(Product product);
        MessageResult<User> selectPowerUser(Page page,Query query);
        Integer userAdd(User user);
        Integer adminadd(User user);
        Integer addProduct(Product product, MultipartFile file, HttpServletRequest request);
        Category verifierCategory(Category category);
        Integer addCategory(Category category);
       Integer  useredit(User user);
       Integer categoryEdit(Category category);
       List<User> userSelect();
       Integer orderEdit(Order order);
       Integer adminEdit(User user);
       Integer powerEdit(User user);
}
