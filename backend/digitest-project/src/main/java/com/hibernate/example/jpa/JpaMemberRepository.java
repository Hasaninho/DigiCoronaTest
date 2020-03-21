package com.hibernate.example.jpa;


import com.hibernate.example.VVP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;

@Repository
public class JpaMemberRepository {

    // custom query return a list
    //@Query("select c from Mp_bilddatei c where c.bd_intid = :bd_intid")
    //List<Mp_bilddatei> findByBD_INTID(Integer bd_intid);
    @Autowired
    private EntityManager entityManager;

    public List<VVP> findAll() {

        TypedQuery<VVP> query = entityManager.createQuery("select r from VVP r",VVP.class);
        return query.getResultList();
    }

    public VVP find(String id) {
        return entityManager.find(VVP.class, id);
    }
}