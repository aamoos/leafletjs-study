package study.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/** 메인 controller */
@Controller
public class MainController {

	@GetMapping("/")
	public String main() {
		return "/tiles/view/main";
	}
	
}
