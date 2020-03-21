package com.hibernate.example.jpa;


import com.hibernate.example.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

@Transactional
@Repository
public class JpaMemberRepository {

    // custom query return a list
    //@Query("select c from Mp_bilddatei c where c.bd_intid = :bd_intid")
    //List<Mp_bilddatei> findByBD_INTID(Integer bd_intid);
    @Autowired
    private EntityManager entityManager;

    public List<Member> findAll() {

        TypedQuery<Member> query = entityManager.createQuery("select r from Member r", Member.class);
        return query.getResultList();
    }

    public Member save(Member member){
        entityManager.persist(member);
        return member;
    }

    public Member find(String id) {
        return entityManager.find(Member.class, id);
    }
}