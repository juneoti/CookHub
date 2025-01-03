package com.dishcovery.project.domain;

import lombok.*;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class MemberVO {
    private int memberId;
    private String email;
    private String password;
    private String name;
    private String phone;
    private Date createdAt;
    private Date updatedAt;
    private String authKey;
    private int authStatus;
}
