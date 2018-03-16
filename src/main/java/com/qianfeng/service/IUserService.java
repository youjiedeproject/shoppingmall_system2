package com.qianfeng.service;

import com.qianfeng.model.*;

import java.util.List;

public interface IUserService {
    User selectByName(User user);
    List<Category> selectAllCategory();
    PageBean<Product> Paging(Integer currentCount,Search search);
    void insertAll(User user);
    Product selectProductById(Integer pid);
}
