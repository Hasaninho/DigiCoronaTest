package com.hibernate.example.controller;

import java.util.List;

import com.hibernate.example.Member;
import com.hibernate.example.jpa.JpaMemberRepository;
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

    @PostMapping(value = "/register", consumes = "application/json", produces = "application/json")
    public ResponseEntity createPatientData(@RequestBody PatientData patientData){
        Member member = new Member();
        member.setPassword(patientData.getHashedPassword());
        member.setData(patientData.getData());

        try {
            jpaMemberRepository.save(member);
            return ResponseEntity.ok("successfully created TestPatient for "+ member.getId());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("could not create TestPatient");
        }

    }
    
}
