package com.example.ControlActividades.controller.configuracion;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping(value = "/usuario")
public class UsuarioController {
    @GetMapping(value = "/nuevo")
    public String NuevoUsuario(Model model){

        return "configuraciones/registrar-usuario";
    }

}
