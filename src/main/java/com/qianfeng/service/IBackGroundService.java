package com.qianfeng.service;

import com.qianfeng.model.Category;
import com.qianfeng.model.Page;
import com.qianfeng.model.Product;
import com.qianfeng.model.Query;

import java.util.List;

public interface IBackGroundService {
        List<Product> selectAllItems(Page page,Query query);
        Long selectItemsNum(Query query);
        void updateStatusByIds(List<Integer> ids);
        List<Category> selectCategory(Page page);
        Long selectCategoryNum();
}
