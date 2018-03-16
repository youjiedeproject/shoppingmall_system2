package com.qianfeng.service;

import com.qianfeng.mapper.UserMapper;
import com.qianfeng.model.Category;
import com.qianfeng.model.Page;
import com.qianfeng.model.Product;
import com.qianfeng.model.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    public void updateStatusByIds(List<Integer> ids) {
        for (Integer i: ids) {
            mapper.updateStatusByIds(i);
        }
    }

    @Override
    public List<Category> selectCategory(Page page) {
        return mapper.selectCategory(page);
    }

    @Override
    public Long selectCategoryNum() {
        return mapper.selectCategoryNum();
    }
}
