package com.qianfeng.service;

import com.qianfeng.mapper.ShopCarMapper;
import com.qianfeng.mapper.UserMapper;
import com.qianfeng.model.Order;
import com.qianfeng.model.Parameter;
import com.qianfeng.model.Product;
import com.qianfeng.model.ShopCar;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Service
public class ShopCarService implements IShopCarService {
@Autowired
    private ShopCarMapper shopmapper;
    @Autowired
    private UserMapper usermapper;
    @Override
    public Integer addShopCar(Integer uid,Integer pid) {
        Product product = usermapper.selectProductById(pid);
        ShopCar car = new ShopCar();
        car.setPid(product.getPid());
        car.setPimage(product.getPimage());
        car.setPname(product.getPname());
        car.setShop_price(product.getShop_price());
        car.setUid(uid);
        return shopmapper.addShopCar(car);
    }

    @Override
    public List<ShopCar> CheckShopCar(Integer uid) {
        return shopmapper.CheckShopCar(uid);
    }

    @Override
    public Integer delAll(String[] delBoxes) {
        Integer it=null;
        for (String car_id:delBoxes) {
           it = shopmapper.deleteAll(car_id);
        }
        return it;
    }

    @Override
    public Integer deleteShopCar(Integer car_id) {
        Integer it=null;
        it = shopmapper.deleteCar(car_id);
        return it;
    }

    @Override
    public Integer addorders(HttpSession session, Order order) {
        Integer it=null;
        List<Integer> productIds = (List<Integer>) session.getAttribute("productIds");
       String[] delBoxes=(String[]) session.getAttribute("delBoxes");
        Random random = new Random();
        String fourRandom = random.nextInt(10000) + "";
        int randLength = fourRandom.length();
        if(randLength<4){
            for(int i=1; i<=4-randLength; i++)
                fourRandom = "0" + fourRandom  ;
        }
        Date day=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat df2= new SimpleDateFormat("yyyyMMdd");
        String format = df.format(day);
        String format2 = df2.format(day);
        String oid =format+fourRandom;
        order.setOid(oid);
        order.setPaystatus("2");
        order.setOrdertime(format2);
        order.setStatus("1");
         it = shopmapper.addorders(order);
        Integer uid = order.getUid();
        Parameter parameter = new Parameter();
        parameter.setOid(oid);
        parameter.setUid(uid);
        for (Integer pid: productIds ) {
            parameter.setPid(pid);
            shopmapper.addorderproduct(parameter);
            shopmapper.reduceNum(pid);
        }
        for (String de: delBoxes) {
            shopmapper.deleteShopCar(de);
        }
        return it;
    }

    @Override
    public List<Integer> selectIdbyCar(String[] delBoxes) {
        List<Integer> productIds = new ArrayList<>();
        for (String  car_id: delBoxes) {
            ShopCar car = shopmapper.selectIdbyCar(car_id);
            productIds.add(car.getPid());
        }

        return productIds;
    }

    @Override
    public List<Order> checkOrder(Integer uid) {
       return  shopmapper.checkOrder(uid);
    }

    @Override
    public Integer removeOrder(String oid) {
        return shopmapper.removeOrder(oid);
    }


    @Override
    public Integer removeOrders(String[] oids) {
        Integer it=null;
        for (String oid:oids) {
             it = shopmapper.removeOrders(oid);
        }
        return it;
    }
}
