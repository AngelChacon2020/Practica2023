package com.example.ControlActividades;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import javax.annotation.PostConstruct;
import java.util.TimeZone;

@SpringBootApplication
public class ControlActividadesApplication {

	public static void main(String[] args) {
		SpringApplication.run(ControlActividadesApplication.class, args);
	}

	@PostConstruct
	public void init(){
		TimeZone.setDefault(TimeZone.getTimeZone("America/Guatemala"));
	}


}
