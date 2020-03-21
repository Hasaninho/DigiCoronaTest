package com.hibernate.example.configuration;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.env.Environment;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.util.HashMap;

@Configuration
@EnableJpaRepositories(
        entityManagerFactoryRef = "entityManagerFactory",
        transactionManagerRef = "transactionManager",
        basePackages = { "com.hibernate.example.vvp" }
)
@EnableTransactionManagement
public class DB2DbConfig {

    @Autowired
    private Environment env;

    @Primary
    @Bean(name = "dbdatasource")
    @ConfigurationProperties(prefix = "spring.db2.datasource")
    public DataSource dataSource() {
        return DataSourceBuilder.create().build();
    }

    @Primary
    @Bean(name = "entityManagerFactory")
    public LocalContainerEntityManagerFactoryBean
    entityManagerFactory(

            @Qualifier("dbdatasource") DataSource dataSource  ) {

        LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();

        //additional config of factory

        entityManagerFactoryBean.setDataSource(dataSource());
        entityManagerFactoryBean.setPackagesToScan(
                new String[] { "com.hibernate.example" });

        HibernateJpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
        entityManagerFactoryBean.setJpaVendorAdapter(vendorAdapter);
        HashMap<String, Object> properties = new HashMap<>();
        properties.put("hibernate.hbm2ddl.auto",
                env.getProperty("spring.jpa.hibernate.ddl-auto"));
        properties.put("hibernate.dialect",
                env.getProperty("hibernate.dialect"));
        entityManagerFactoryBean.setJpaPropertyMap(properties);

        return entityManagerFactoryBean;

    }

    @Primary
    @Bean(name = "transactionManager")
    public PlatformTransactionManager transactionManager(
            @Qualifier("entityManagerFactory") EntityManagerFactory
                    db2EntityManagerFactory
    ) {
        return new JpaTransactionManager(db2EntityManagerFactory);
    }
}