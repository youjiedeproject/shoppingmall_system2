package com.qianfeng.service;

import com.qianfeng.model.Order;
import com.qianfeng.model.ShopCar;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface IShopCarService {
    Integer addShopCar(Integer uid,Integer pid);
    List<ShopCar> CheckShopCar(Integer uid);
    Integer delAll(String[] delBoxes);
    Integer deleteShopCar(Integer car_id);
    Integer addorders(HttpSession session,Order order);
    List<Integer>  selectIdbyCar(String[] delBoxes);
    List<Order> checkOrder(Integer uid);
    Integer removeOrder(String oid);
    Integer removeOrders(String[] oids);
    void viewOrder(String oid, Model model);
}
