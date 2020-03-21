package com.hibernate.example.controller;

import java.util.List;

import com.hibernate.example.Member;
import com.hibernate.example.jpa.JpaMemberRepository;
import com.hibernate.example.models.Credentials;
import com.hibernate.example.models.PatientData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping(value = "/createTestPatient", consumes = "application/json", produces = "application/json")
    public ResponseEntity createPatientData(@RequestBody PatientData patientData){
        Member member = new Member();
        member.setId(patientData.getUserId());
        member.setStatus(patientData.getStatus());

        try {
            jpaMemberRepository.save(member);
            return ResponseEntity.ok("successfully created TestPatient for "+ patientData.getUserId());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("could not create TestPatient");
        }

    }




    //@RequestMapping(method=RequestMethod.POST)
    //#public Route post(@RequestBody Route route) {
      //  return jpaRouteRepository.save(route);
    //}

}
