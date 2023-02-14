Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFD696C53
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBNSGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjBNSGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:06:20 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C31BA8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676397974; bh=wCH+u0/LEXEQVzu9z2jNCUPlBtz//wct/yPPKwav+5Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bP+xfHfhuYQJRyLuoE48GpngBVCFdKrZQgF/rLARvSLQhKViP43F34yX324EmC1eNicqFMLfElczlWB9NnyhDx+XrL4swKQuU3Ks7EZXHbBBxTEGTUyc9oKqprpB2QrpV1jKCLCKNmZBjdRAFgglLfGVUgPn0Sl6qLW7sxvnWZD2gXIejYeQE26M0WuB+ZADbYZ9MLWehw/WVKm9eal4SQ3emcLIGvnQI3ECFyCMaeM+iLRgSNwqtBxUw4C4gLhhqGiqGPyvmYVzdflnwOim82PKLlKT0GVSHgQPNzUsZhTbZtNgD47DdXwqvOf1Yt+hSmoNKdsl5XvDMeD1P7eXfA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676397974; bh=pRnv4rRzLSflbq7aRPuTHbPdafdCACJponBogYLgFgA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Fju46XvmivpzLWgUZBwetjlBQUlYr7xEHeyDIOW2NKt5sUAdY/qWuYL5Fc+tw7dTGSEZD4vWy6dnbSvmBhsz8+t594RxpGRPuYY4FJZOwIn2rkfH94Ahl3H/b4EkSL8GAzhId4cKKL0PIo3fqaHHF51P09kp1tkkSTdRtFNuxFUO4km00JoQxUHl7PYaYQWfc/9KbaJfRjBDNWigN0W0wI7QpjkNNgEgmGD+tNWIS0TKmX8bUfu+FIIzzrWuhSD+uVSElTDqWJG5uy1P0RSglQ/q07YvzCNwu9/IHpLjyj0CVKm1HLNSALT3Sm3BaDjoI12ndXy8HDWfrci1VhLuvg==
X-YMail-OSG: PI4V1kIVM1mPgP.ugV.egUTt7LD4EG6sN5S6uPi6F.LamxL7aCrp4EakMEdgkc1
 dPCcFVvdKJd44Iss8sY_avoxfO9slbeWYa8n4UCl8MWw89B44mZtgNacH6o0XrRaOCxAqe3g97S.
 cf6UqIsiR0eWR7mhm2C9J9RDkeO4lLUhS.8GvlTzOXfSh.jb6_oKZuTJhpu18hVms8lTRSsh3cYC
 bRBe9zzmmT9KMyF5XgFKCrtRPneqYEWwh0ZKPCeE32BD6bVp6nbDpxjgXWFP0ZPUwafAUPMCwTTA
 q1cRhvBjh4o6FLcuCATi3Ds33N8zFTKhOWnG5VvLg.SoeVxEmxDc4PTxsG4GLy7gx9fJ7E.hLA3d
 XK8ifRZ898pXc9ikcEl07v.D3JVDw_YCXMngJsNMxcYYcqo.usKOPXCi9kB_m.q2tZ023WzEnZYV
 8l33GmGRXwHnksq2ghKq2xwDW090tt.MU9pnAPAow5jxj8XcvEBWL4xbdgour6_f.0NW48bNPulU
 XyaxlZyhUnzS5P2EoOzT9KtwmRnqhAQHsCOfZO8G7QCgpfFCo.m83YcvqWCaT9ZRxOY5A6_GO3iT
 xmcCUSruJIsHzoEM5GXORAVtZa72317KLiebBJaKte8i6Av2e0SyBDs_qg9xzxVSIZ9d7HesEfnK
 7XaK5oGt24CtLIfSF2SheUCbmzOLrg8o9Vsawv3siuNz1S89PJ7Guq2B7WZGlzVtBRZoKpw60J8x
 QTLS0tVj5yCICHc5Yb9xuQ5G7ImYznbEc0kZAh4t8g63Pk.ve9Wy4gAafXonSpXgivfEO8UPuyoh
 WIhZ.eUOzXzgrlraDD7K_o4Gqys0GZS2VmkaRd954H2XkvZCqS0gha93xlEgFWVNkPaWwqo6lOb6
 YXhrfVAaZx_7B.RCFn0Cx07LhynXnYM_T5cQiiLXrlaebDzJoiwWsaPT4Ht.Z.CEBwiLb1jhsW22
 RzZ5J6nLeSMXXIMMB0fthOAyuj2iRXljk.R9I9D7.MkuGqRK91JSnbaa.zDl_B1GYd0Q3KzuWZcf
 Gxckc4L.fechTsjAhNnFwXFdR9ac4ghXiKTveQutuaW6P.EiJNgkFUPo4HwmUC5DWEabfo.hWN2M
 f8crWOu9GvcWFxB8gft3WCQA8VPTcbzRGEm8CCZpQrdst0G.rA2fSjus_MsuF.I9bolSqbaLLL1L
 6532gxIk_vpnFDAL4ZYW2H40NOQ9l9VBxCbyvxxDtaHq3adZKteNyIZfBIV8ZZYKoUAJlapnOJov
 i4snJL6j9VszMZvvRWPZzkwxvKS83MHIz8kcisLXO40KkMzg9xWMkwTdGubYxg1ncm4Lycmlt1J1
 cEa8AyEMTfoeFpjvRPAy0UVwLd8q0vb1h52XJYmBtKZJdmoEn7UF7DOIB45XUJCxx9ycCdxkTe4Z
 _uRsodEtMqN3iS4741a7eCEgqk9OsdmZrlMJkwWSJXo4gyuunp.9UBhY9YciEBhWamF4apgILbcW
 qdqS9jgVRl.GaX_v0ok6Vh5.8scRrVzuX8XZPVsR35XPFJUBxEsGxUY.FBzeORsMGxeqV_Ut3fqf
 RHzpfdIHm5cRLoPtcaKdstsLSkoLcQP.iGbliyjDxsFTdQh8G6Dy3Cke2zdcnkHxjA3aBMlv9f0x
 CLDQVCKpg99lVJYw7iue.H7BLq_sn.LTMv.fBnXAe8t8I5ZPhLDC0LP2uwuGrStjFdhH3pnKVW_G
 o3EDeulIzYQO8a7zrW9ZWRQwaRDUIxNJ.5TpvIsP7IpdjA5MhQJ1U_54MSHFmlqqEQswUUM2FdVH
 fJdD3yAnCzxuQCFdY.n3lZb8OlnhFNaIjh6aPYB32tcJoifaDVRIqOjdnnBraZ_gbOkJJ7k2Sqmn
 XXb77MgWkictWXAVCrJg6vVpcM39v5FQqqwDlPneLgLPZL0U6WnM_UaUhwU8mYDf5zIEpvnju0i4
 MaK_93sFqWd4XoYurBJ5x2uGo16.yjDxBsAXZCEbk5uSYsRekVBCySYdXC.Kjv1UmibogJ2P.EEz
 j3pCmWRxW9yVfP8_Nl9B4WsMwgjhKMiGbHABsle1B.JQYqz_ENwKCdwzxWmaNzbTaIOXWIwD9ug_
 76YPKb5u1GpBvMIlntloxnHdcXY6bxFAGVK.tNOyphSypi4uZWzqL2.dxUbXrB5Y1Ju6Djdp0hBc
 V7gsGAS0CKr_nrfMwYCHh3Zo81iSAkcmQrAWFhr6Ayb1dsp.kz367_oeKribhLtA61aAFk1R5NgY
 jZwDbsKRaTOZ.jbBzVnfSxiiasjtFOq4VxQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Feb 2023 18:06:14 +0000
Received: by hermes--production-gq1-655ddccc9-j6kw5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 73003d98f66f93508a520a49ba284bc8;
          Tue, 14 Feb 2023 18:06:10 +0000 (UTC)
Message-ID: <5b334b57-3fcf-9cfa-7745-5f6895be9768@schaufler-ca.com>
Date:   Tue, 14 Feb 2023 10:06:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 4/8] LSM: lsm_get_self_attr syscall for LSM self
 attributes
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, casey@schaufler-ca.com
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-5-casey@schaufler-ca.com>
 <3977d478-cb41-832b-7b5e-73dd247f267d@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <3977d478-cb41-832b-7b5e-73dd247f267d@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/2023 9:41 AM, Mickaël Salaün wrote:
>
> On 09/01/2023 19:07, Casey Schaufler wrote:
>> Create a system call lsm_get_self_attr() to provide the security
>> module maintained attributes of the current process. Historically
>> these attributes have been exposed to user space via entries in
>> procfs under /proc/self/attr.
>>
>> Attributes are provided as a collection of lsm_ctx structures
>> which are placed into a user supplied buffer. Each structure
>> identifys the size of the attribute, and the attribute value.
>> The format of the attribute value is defined by the security
>> module, but will always be \0 terminated. The ctx_len value
>> will always be strlen(ctx)+1.
>>
>>          ---------------------------
>>          | __u32 id                |
>>          ---------------------------
>>          | __u64 flags             |
>>          ---------------------------
>>          | __kernel_size_t ctx_len |
>>          ---------------------------
>>          | __u8 ctx[ctx_len]       |
>>          ---------------------------
>>          | __u32 id                |
>>          ---------------------------
>>          | __u64 flags             |
>>          ---------------------------
>>          | __kernel_size_t ctx_len |
>>          ---------------------------
>>          | __u8 ctx[ctx_len]       |
>>          ---------------------------
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   Documentation/userspace-api/lsm.rst |   9 ++
>>   include/linux/syscalls.h            |   3 +
>>   include/uapi/linux/lsm.h            |  21 ++++
>>   kernel/sys_ni.c                     |   3 +
>>   security/Makefile                   |   1 +
>>   security/lsm_syscalls.c             | 182 ++++++++++++++++++++++++++++
>>   6 files changed, 219 insertions(+)
>>   create mode 100644 security/lsm_syscalls.c
>
> For new files (e.g. lsm_syscalls.c), it would be nice to auto-format
> them with clang-format. It helps maintenance by keeping a consistent
> style across commits, which should also help backports, and it avoids
> nitpicking on style issues.

Good idea.


