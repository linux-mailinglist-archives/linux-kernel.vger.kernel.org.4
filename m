Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D20460ED16
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiJ0Aib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiJ0Ai1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:38:27 -0400
Received: from sonic309-28.consmr.mail.ne1.yahoo.com (sonic309-28.consmr.mail.ne1.yahoo.com [66.163.184.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232FC5F43
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666831105; bh=P3h0Om4UG4GG3S49z4M0sIKc2KXDqykY8tTQM00c9as=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FvMVELc7mfQ3dUyedIczflsKm+gd8lephJ30mwKneUuodOkRMM+VIAgOH90xobsIArH2t0kFRRt3Jz2J9BCmv1kptOXqbpWJVYxeHWaC3zfzuQyf2f5ywSya7KfWgceFTMJbvAci200EIBPnCiPEtgB0qI5q5sadL7U7nnLreCjs8zqz0gPe2cMiIeBY9X159D8lOCato3VnbMVaFCOrzwz8XI6RCxQ+UYiniViHobCsz6B+dn+azFEzdkc5VCe22Iht0rJS1Z2n2y0CDwvxNhMLU0bo9HyS2f+3ylY17Jj2ikXFI9NlKu9EZ/NBRIGL7e6v/JOVW/mJJKWvmQUisQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666831105; bh=5TcXHQ80SCgG02Lent7I2lvrhHo4iqLspKpNes3vEJH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=aO3BAds/xp6d736xcL5c1AhG6HVgbeRZWtU5A2TqJJym7HY/GpE0IVhjJikQvx+WBAEW8Aunvqxv0/pcDPzEYaM46ggpKq/zvtf4F/bmjJRP6+Jp8flFW8KMUaONBrprUP0kHAkBr7VMpN1rKd/SJQlPJKH8wswVwf7yiqira//jXyHHa3m+GJ2OjyPFkMcMzjqLACv8UDR87J4m2wk9iCJBXmup0YoHw/7f2Nkh/5czsz9GXtNhHBRO9d9+8NkpDbCxs0tgiRwx0jNeE/JQHXzt7uSQO4Va9stXqGJGMLw0j7nh/+ItZBCnt/gyi+Q8nDjCwxaFAcPltyZJlMPrQA==
X-YMail-OSG: Yo7d8uoVM1mtG1uiTwZTHOQi7J8Cuih6OpFnx_mCJfjYZX_KPkqXh9MRhPiXKYw
 GlT8EmezgD4UjZ8mdpaR6CBJa7L3SYEFEfhL3rKj7GyUe4Lklf0Np4GVlxH7I2BXU9E2N1dNPIlt
 J5IC91Gta9tp6r3xFCN_qn10fF0IxWBY.z2UkJjRm_Sy9nOkrETE2NPTXIZo2MXyXTtVremB6R_P
 sStQP7R.jV7mEfiHIkPQsDsIglKHiJi7S_Y8GSZcCY3zwpS6pLPZoRMX_JHBjEofToYZ.NSL.Rgk
 y.rhtjiNJPlGVeldbFM7SdPWgR0TAp7vX26xbHfnsGlGhcbmznx6CtAiclZgwj6lW.stUcnBTGRi
 Qmb4p67.7D1OqQIME15RdNYPgpYrrv6XS.az26YIh6j3SkD5NZK1J3iGbQQ4VIeR7C7twVtbPiwF
 DXqIEGUFBu2dWX2_mvUULsVpcUc7ksD3NZZGd1VogKOXFtm71ACMamcKvfyB88d9pezZMtjZ3Tai
 w.0o52zVX9q2BMlaI4GztYDI0yyXCAHp8aDXYtxXhZE_vpyc.LRfQqMNrotgKhb.Oo0TfIRG6CLx
 L8pgHx2zJqzqfnWODqATgarLsCfxNRRj.PHASeL.FPGirvEj1RG7Wr4mAah5FIIjVMYt39jbQlqz
 _OkdIof2GeXdTb1.iHu46aeGE4_s6eqrZSf5AjlxnJklNqBYmOIp5bEmjvT.WomtImwmmhtipejI
 7ztdY2XHgyNYWyt7.qNzwa6TiL2sN8I6sNmmLq8RWDyRJ7kZxzlaT.RghzDL2AqkowWKjv95YMEr
 Pr.KfiUSgChjqLmNLZXgp4r9AXWfCaA_6iZwU3E5e5eziVKS2SGj1gJBIq7b2VlLxHVjt8p2vikz
 QrbkYngkVQrg4OHmvnSvnxAfSSksdzr7nca7Gvl6hbui8h7XfbonNc0uhUBWjC_3pbs1IOhAyMUF
 h8qshzrK_z7KRXWZIT92yLwmBvs4pWq_sSGIJ1hWMI.WYipNpL2TvfCg0tbkcn5bcgxmG2JjiW.9
 wtDAQxnUV6GhwwqqiVcRPRPAK7efVd24ZcgixeX8ln4Js_9038KMwn0qhfPVJy9r8_krtTqbAkZz
 Wf3Kl7eqYobeGDo_3EPr6i8KiQ_jjdsjFssBqZkeOpM6VQKq6IOI30QVdxneAtoIwKahiTBPz_Ky
 JK0HeNbPMyVxuujRCbBuqtw70_sRQPq7lMhcN8Duv8kdBYVjtAJ9e70.ilK1fzPxJlA50BcQbe7z
 uXI3.eTknRdTCPBE3Z_gDMK9eIQAt1vIFHs8.06HA4cMUZxpiJpvwk7Iw9PXm0Xttt3.wLRaU9.w
 ex7yktkunsA6yHzkj0hIsJBvgC_N7_Y.skpBpnOL6_pgvtety4eAKvYKgWkYtj19uNUlr9j7nE5O
 ZFqPK4OdzOzMljFAPOX7pK5bi0Swyyn143UnjHoqZPOj_G8xmEw3xS3AbGl.mc2Xn7HImbhzPVP0
 C29Aw1zg.hwfh8TVTvmo000jfBL3jW9OuJwtKrlQndZfBrnWeSyIf1oS8nP7q_KZjf9r3oxa1.oV
 n87TG2G9kvjZPElVaPa88EMfptT5WtTxB.MOu61x0sOlDJKz7PXT6E0rpaOgkJDqL9rLR7aMOBg7
 dsdoXR2ucqOA6DTwtjuZuqHU2OtlsxCFomq5O5E_ErwPyCUWLIWxr.seRBjpc4gksZAETvwtX3KU
 uwMwPzKgVSNZnpLbPzHOUphEt70Vi06EkzK3lDRWTTzu25xvM9LeHSK8tnuDyhla3LlgQfSQlxY0
 XugTebYLO390enbIZhqIldeNcP.ipoqqdRrPOhBr5l.jvFZ2GQOfm72GZ8YzEw.qk4petX9Us3Yo
 lMUWFrM_eXxxox_2CxW9NHJr69jXDtXVGLq20S9Rwdaeo.S03g6hNomg5jSTN5wAG03oMHA.PsHu
 5qvI_iDUA5mwInY0FIwoGGzbRibFOEcvUfqAZPGnn6S0ksDLIzbUgnNDlK7fObB99k5p7c2ZzlkD
 Is3_Q6fHQT7ybFngeJl9UmOBS6w.DpG32nuEXJqaZiESxlNte66pWrLTtJuagfNXdVZNb7TtdbER
 2qD1jmqvUlpXqmoUzs2jQCW5evgpYvZXxZU4LjoXhWJpEd4xnfakSESv3bzWw5TTuXEnv4ZbTsFo
 iLxyJ6RpXiPV_VDcPw2gpncb.JQpMqqnRspBqCc8d_r4CHFRlitzKRZni13OzMqPHeZTLNaRAWQz
 IqF8XROukBuiijjruVyVcE65DVr2WTNFx3Rw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Oct 2022 00:38:25 +0000
Received: by hermes--production-bf1-64dccd5d47-k9w9h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 444e18b32aa43c2f0d280ce414cd3705;
          Thu, 27 Oct 2022 00:38:23 +0000 (UTC)
Message-ID: <e3949b66-26fe-807e-a626-79ca78396e8a@schaufler-ca.com>
Date:   Wed, 26 Oct 2022 17:38:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 4/8] LSM: Maintain a table of LSM attribute data
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, casey@schaufler-ca.com
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-5-casey@schaufler-ca.com> <Y1jNGMKfb+NUPrJS@kroah.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <Y1jNGMKfb+NUPrJS@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20783 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2022 11:00 PM, Greg KH wrote:
> On Tue, Oct 25, 2022 at 11:45:15AM -0700, Casey Schaufler wrote:
>> As LSMs are registered add their lsm_id pointers to a table.
>> This will be used later for attribute reporting.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/security.h | 17 +++++++++++++++++
>>  security/security.c      | 18 ++++++++++++++++++
>>  2 files changed, 35 insertions(+)
>>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index ca1b7109c0db..e1678594d983 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -138,6 +138,23 @@ enum lockdown_reason {
>>  
>>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>>  
>> +#define LSMID_ENTRIES ( \
>> +	1 + /* capabilities */ \
> No #define for capabilities?

Nope. There isn't one. CONFIG_SECURITY takes care of it.

>> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
>> +
>> +extern int lsm_id;
> u64?

u32. I doubt we'll get more than 32K security modules.

>
> thanks,
>
> greg k-h
