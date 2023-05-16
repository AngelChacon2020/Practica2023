package com.example.ControlActividades.controller.alumno;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/alumno")
public class AlumnoController {
    @GetMapping(value = "/nuevo")

    public String NuevoAlumno (Model model){

        return "alumno/registrar-alumno";
    }
}
