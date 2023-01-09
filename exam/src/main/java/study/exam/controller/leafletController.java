package study.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class leafletController {
	
	@GetMapping("/leaflet")
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
	
	@GetMapping("/leaflet/exam03")
	public String leafletExam03() {
		return "/tiles/view/leaflet/leaflet-exam03";
	}
	
	@GetMapping("/leaflet/exam04")
	public String leafletExam04() {
		return "/tiles/view/leaflet/leaflet-exam04";
	}
	
	@GetMapping("/leaflet/exam05")
	public String leafletExam05() {
		return "/tiles/view/leaflet/leaflet-exam05";
	}
	
	@GetMapping("/leaflet/exam06")
	public String leafletExam06() {
		return "/tiles/view/leaflet/leaflet-exam06";
	}
	
	@GetMapping("/leaflet/exam07")
	public String leafletExam07() {
		return "/tiles/view/leaflet/leaflet-exam07";
	}
	
}
