package com.hibernate.example.controller;

import com.hibernate.example.Member;
import com.hibernate.example.jpa.JpaMemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/test")
public class TestController {

    @Autowired
    private JpaMemberRepository jpaMemberRepository;
    

    @RequestMapping("{id}")
    public Member get(@PathVariable Integer id) {
        return jpaMemberRepository.find(id);
    }

    @RequestMapping
    public String getAll() {

        return "Hello World!";
    }


    //@RequestMapping(method=RequestMethod.POST)
    //#public Route post(@RequestBody Route route) {
      //  return jpaRouteRepository.save(route);
    //}

}
