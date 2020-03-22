package com.hibernate.example.jpa;


import com.hibernate.example.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.Query;
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

    public Member update(Member member){
        entityManager.merge(member);
        return member;
    }

    public Member find(Integer id) {
        return entityManager.find(Member.class, id);
    }

    public String getStatus(Integer id) {
        Query query = entityManager.createQuery("select r.status from Member r where r.id = :id");
        query.setParameter("id",id);
        return query.getSingleResult().toString();
    }
}