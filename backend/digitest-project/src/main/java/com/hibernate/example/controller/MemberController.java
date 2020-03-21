package com.hibernate.example.controller;

import java.util.List;

import com.hibernate.example.Member;
import com.hibernate.example.jpa.JpaMemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@Transactional
@RestController
@RequestMapping("/members")
public class MemberController {

    @Autowired
    private JpaMemberRepository jpaMemberRepository;


    @RequestMapping("{id}")
    public Member get(@PathVariable String id) {
        return jpaMemberRepository.find(id);
    }

    @RequestMapping
    public List<Member> getAll() {

        return jpaMemberRepository.findAll();
    }

    @RequestMapping(value = "/id/{id}/data/{data}/password/{password}")
    @ResponseBody
    public Member postMember
            (@PathVariable Integer id, @PathVariable String data, @PathVariable String password ) {
        Member member = new Member();
        member.setId(id);
        member.setData(data);
        member.setPassword(password);
        return jpaMemberRepository.save(member);
    }


    //@RequestMapping(method=RequestMethod.POST)
    //#public Route post(@RequestBody Route route) {
      //  return jpaRouteRepository.save(route);
    //}

}
