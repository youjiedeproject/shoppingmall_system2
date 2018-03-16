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
    void updateStatusByIds(Integer id);
    List<Category> selectCategory(Page page);
    Long selectCategoryNum();
}
