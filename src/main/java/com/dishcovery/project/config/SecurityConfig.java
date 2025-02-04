package com.dishcovery.project.config;

import com.dishcovery.project.service.CustomUserDetailsService;
import com.dishcovery.project.service.CustomAuthenticationFailureHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.multipart.support.MultipartFilter;

import java.util.concurrent.Executor;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private CustomAuthenticationFailureHandler customAuthenticationFailureHandler;

    // 비밀번호 암호화를 위한 BCryptPasswordEncoder를 빈으로 생성
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // HttpSecurity 객체를 통해 HTTP 보안 기능을 구성
    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity.authorizeRequests()
				.antMatchers("/member/detail").access("hasRole('ROLE_MEMBER') or hasRole('ROLE_ADMIN')")
				.antMatchers("/member/update").access("hasRole('ROLE_MEMBER') or hasRole('ROLE_ADMIN')")
                .antMatchers("/recipeboard/register").authenticated()
        		.antMatchers("/recipeboard/update/**").access("hasRole('ROLE_MEMBER')")
        		.antMatchers("/recipeboard/delete/**").access("hasRole('ROLE_MEMBER')")
        		.antMatchers("/recipeboard/detail").permitAll();


        // 접근 제한 경로 설정
        httpSecurity.exceptionHandling().accessDeniedPage("/auth/accessDenied");

        httpSecurity.formLogin().loginPage("/auth/login") // 커스텀 로그인 URL 설정
                .usernameParameter("email") // 이메일 파라미터 설정
                .passwordParameter("password") // 비밀번호 파라미터 설정
                .failureHandler(customAuthenticationFailureHandler) // 사용자 정의 AuthenticationFailureHandler 적용
                .defaultSuccessUrl("/recipeboard/list"); // 로그인 성공 시 이동할 URL 설정

        httpSecurity.logout().logoutUrl("/auth/logout") // 로그아웃 URL 설정
                .logoutSuccessUrl("/recipeboard/list") // 로그아웃 성공 시 이동할 URL 설정
                .invalidateHttpSession(true); // 세션 무효화 설정

        // Encoding 필터를 Csrf 필터보다 먼저 실행
        httpSecurity.addFilterBefore(encodingFilter(), CsrfFilter.class);
        httpSecurity.addFilterBefore(multipartFilter(), CsrfFilter.class);
    }

    // AuthenticationManagerBuilder 객체를 통해 인증 기능을 구성
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService()); // CustomUserDetailsService 빈 적용
    }

    // 사용자 정의 로그인 클래스인 CustomUserDetailsService를 빈으로 생성
    @Bean
    public UserDetailsService userDetailsService() {
        return new CustomUserDetailsService();
    }

    // CharacterEncodingFilter 빈 생성
    @Bean
    public CharacterEncodingFilter encodingFilter() {
        CharacterEncodingFilter filter = new CharacterEncodingFilter();
        filter.setEncoding("UTF-8");
        filter.setForceEncoding(true);
        return filter;
    }
    
    @Bean
    public MultipartFilter multipartFilter() {
        MultipartFilter multipartFilter = new MultipartFilter();
        multipartFilter.setMultipartResolverBeanName("multipartResolver");
        return multipartFilter;
    }

    // 스레드 풀 설정
    public Executor mailExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(5); // 기본 스레드 수
        executor.setMaxPoolSize(10); // 최대 스레드 수
        executor.setThreadNamePrefix("email-thread");
        executor.initialize();
        return executor;
    }
}
