package study.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class openlayersController {

	@GetMapping("/openlayers")
	public String openlayersMain() {
		return "/tiles/view/openlayers/openlayers";
	}
	
}
