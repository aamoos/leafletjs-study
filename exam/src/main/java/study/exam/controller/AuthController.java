package study.exam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.RequiredArgsConstructor;
import study.exam.dto.UserDto;
import study.exam.service.UserService;

import java.util.Map;

import javax.validation.Valid;

/** 회원 로그인, 가입 controller */
@Controller
@RequiredArgsConstructor
public class AuthController {

	private final UserService userService;
	
	/** 로그인 */
	@GetMapping("/auth/login")
	public String login() {
		return "/tiles/view/auth/login";
	}
	
	/** 회원가입 */
	@GetMapping("/auth/join")
	public String join() {
		return "/tiles/view/auth/join";
	}
	
	@PostMapping("/auth/join")
	public String joinSubmit(@Valid UserDto userDto, Errors errors, Model model) {
		if (errors.hasErrors()) {
			// 회원가입 실패시, 입력 데이터를 유지
			model.addAttribute("userDto", userDto);

			// 유효성 통과 못한 필드와 메시지를 핸들링
			Map<String, String> validatorResult = userService.validateHandling(errors);
			for (String key : validatorResult.keySet()) {
				model.addAttribute(key, validatorResult.get(key));
			}
			return "/signup";
		}
		
//		userService.signUp(userDto);
		return "redirect:/auth/login";
	}
}
