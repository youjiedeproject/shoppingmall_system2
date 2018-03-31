package com.qianfeng.mapper;

import com.qianfeng.model.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
      User selectByName(User user);
     List<Category> selectAllCategory();
     Integer selectCount(Search search);
     List<Product> selectPage(Search search);
     void insertAll(User user);
     Product selectProductById(Integer pid);
     List<Product> selectAllItems(@Param("p") Page page,@Param("q") Query query);
     Long selectItemsNum(@Param("q") Query query);
    Integer updateStatusByIds(Integer id);
    List<Category> selectCategory(Page page);
    Long selectCategoryNum();
    List<User> selectAllUser(@Param("p") Page page,@Param("q") Query query);
    Long selectUserNum(@Param("q") Query query);
    Integer updateUserStatus(Integer id);
    List<User> selectRecoverUser(@Param("p") Page page,@Param("q") Query query);
    Long selectRecoverUserNum(@Param("q") Query query);
    Integer updateRecoverUserStatus(Integer id);
    Integer updateCategoryStatus(Integer id);
    List<Order> selectOrderList(@Param("p") Page page,@Param("q") Query query);
    Long selectOrderNum(@Param("q") Query query);
    Integer updateOrderDelete(Integer id);
    List<User> selectAllAdmin(@Param("p") Page page,@Param("q") Query query);
    Long selectAdminNum(@Param("q") Query query);
    Integer updateAdminStatus(Integer id);
    Integer updateProduct(Product product);
    List<User> selectPowerUser(@Param("p") Page page,@Param("q") Query query);
    Long selectPowerNum(@Param("q") Query query);
    Integer userAdd(User user);
    Integer addProduct(Product product);
    Category  verifierCategory(Category category);
    Integer addCategory(Category category);
    Integer adminadd(User user);
    Integer useredit(User user);
    Integer categoryEdit(Category category);
    List<User>  userSelect();
    Integer orderEdit(Order order);
    Integer adminEdit(User user);
    Integer powerEdit(User user);
}
