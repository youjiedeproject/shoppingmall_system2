package com.qianfeng.mapper;

import com.qianfeng.model.Order;
import com.qianfeng.model.Parameter;
import com.qianfeng.model.Product;
import com.qianfeng.model.ShopCar;

import java.util.List;

public interface ShopCarMapper {
    Integer addShopCar(ShopCar car);

    List<ShopCar> CheckShopCar(Integer uid);

    Integer deleteAll(String car_id);

    Integer deleteCar(Integer car_id);

    Integer addorders(Order order);

    void addorderproduct(Parameter parameter);

    void deleteShopCar(String de);

    void reduceNum(Integer pid);

    ShopCar selectIdbyCar(String car_id);

    List<Order> checkOrder(Integer uid);

    Integer removeOrder(String oid);

    Integer removeOrders(String oid);

    Order viewOrder(String oid);

    List<Integer> viewProduct(String oid);

    Product selectProductById(Integer pid);
}