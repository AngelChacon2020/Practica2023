package com.example.ControlActividades.controller.actividades;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/plan-trabajo")
public class ConsultarPlanTrabajoController {

    @GetMapping(value = "/consultar")
    public String ConsultarPlan(Model model){
        return "actividades/consultar-plan";
    }


}
