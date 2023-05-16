package com.example.ControlActividades.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


    @Controller
    public class MainController {

        @RequestMapping(value = "")
        public String index() {
            return "index";
        }

        @GetMapping(value = "/index")
        public String Login() {
            return "index";
        }
    }



