package com.dishcovery.project.domain;

import java.security.Provider;
import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class OauthUser {
    private int oauthUserId;
    private int memberId;
    private Provider provider;
    private String providerId;
    private String email;
    private String name;
    private String profileImageUrl;
    private Date createdAt;
    private Date updatedAt;
}
