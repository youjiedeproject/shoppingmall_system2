package com.qianfeng.service;

import com.qianfeng.mapper.UserMapper;
import com.qianfeng.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class UserService implements IUserService {
    @Autowired
    private UserMapper mapper;
    public User selectByName(User user){
        return mapper.selectByName(user);
    }
    public List<Category> selectAllCategory(){
      return  mapper.selectAllCategory();
    }
    public PageBean<Product> Paging(Integer currentCount,Search search){
        Integer currentPage = search.getCurrentPage();
        PageBean<Product> pageBean = new PageBean<Product>();
        int totalCount = mapper.selectCount(search);
        int totalPage=(int)Math.ceil(totalCount/(currentCount*1.0));
        int pageIndex=(currentPage-1)* currentCount;
        search.setPageIndex(pageIndex);
        List<Product> pagelist = mapper.selectPage(search);
        pageBean.setPageData(pagelist);
        pageBean.setCurrentPage(currentPage);
        pageBean.setCurrentCount(currentCount);
        pageBean.setTotalCount(totalCount);
        pageBean.setTotalPage(totalPage);
        return pageBean;
    }
    public void insertAll(User user){
        Date day=new Date();
        SimpleDateFormat df= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String format = df.format(day);
        user.setUdate(format);
        user.setIsadmin("2");
        user.setStatus("1");
        mapper.insertAll(user);
    }
    public Product selectProductById(Integer pid){
      return  mapper.selectProductById(pid);
    }
 }
