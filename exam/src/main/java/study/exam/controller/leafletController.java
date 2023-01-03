package study.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class leafletController {
	
	@GetMapping("/")
	public String leafletTutorial() {
		return "/tiles/view/leaflet/leaflet";
	}
	
	@GetMapping("/leaflet/exam01")
	public String leafletExam01() {
		return "/tiles/view/leaflet/leaflet-exam01";
	}
	
	@GetMapping("/leaflet/exam02")
	public String leafletExam02() {
		return "/tiles/view/leaflet/leaflet-exam02";
	}
	
}
