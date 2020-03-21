package com.hibernate.example.controller;

import java.util.List;

import com.hibernate.example.VVP;
import com.hibernate.example.jpa.JpaMemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/members")
public class MemberController {

    @Autowired
    private JpaMemberRepository jpaMemberRepository;

    @RequestMapping("{id}")
    public VVP get(@PathVariable String id) {
        return jpaMemberRepository.find(id);
    }

    @RequestMapping
    public List<VVP> getAll() {

        return jpaMemberRepository.findAll();
    }


    //@RequestMapping(method=RequestMethod.POST)
    //#public Route post(@RequestBody Route route) {
      //  return jpaRouteRepository.save(route);
    //}

}
