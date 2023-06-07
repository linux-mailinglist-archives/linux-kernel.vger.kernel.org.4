Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319C0727338
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjFGXka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFGXkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:40:20 -0400
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E6E26B8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686181198; bh=MLg3eEIQ6oxa5ubin2En3vP+BFYlpn63vPZqcYHn8/c=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=L/8MkD72LF/Lc0nlDvMsqldR6tGxbQz3xtUxMnnexoh4/yczWF813WrtkaYNqlNBwO834Bu8cJpigYShXpbYLcHyoOyyn69fGBwM9WnG1SEGj419LTUK5QsAtlFaUGTVxfo7bFKY3MoHw1BmflWrLg7ZiXIwB3FFigweISoJhMac99mHDl/aaRklQJ397FvsEuVptW0EhNRZOURnWXEUfPHep4ZX/jU1CB55Ae1AZ1mkqUbtY7YmaL0GUGzjeaARxHgq9WteMManQ1IW/+JAf7M/R+oK07TXWm4ce1QaM+Y8+C+lCeG2Xwk3uiEqimjFFMl4cw8E0T/wMFmiL4/pQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686181198; bh=T8klwkrVKqfnlECaKgGkKbooPwQxUIVUUHSupnXE/Fy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=EYSNA8nZ62hxDRua+4mKwljUmw7Pvie0EdDDL3p4swLATTSJVJJCeKdcbDDA4sutujm4oLRTWVELJkbBxglHqB8vsww5njtMUS+zL8JvPdrSxuMQV3Thgsu8TCSWHK3XKKRpMOlG9ZVGqQBO4V11hwghzbqZ2uQhRQF5yEw0Hl9iX3sNadMJfotyydIkN7eQi69GWN1hZUsOwIRQkFSfHO4yttTJG0PrMR/qy6/5JRv71D71qTKD2CS89ah04544v/rqYQkPSzoDGEb2rIXvRDQ6CJJYMJKMl8t4FXUDTv+M72dEfgUyoNPSpAe6/+yOTRziURHScPcoYC6mghzp3Q==
X-YMail-OSG: 9DZ00UIVM1nf7gHNoSEJ_nQWRcW9g8Xfe_zpCClhZWdUoGLj_c_czAmMX82snG.
 EtXqu9.iP68RkKlYIDDaphvlBZCmGws9fbP4QhqaDyVLSzVGNWxXLVb2MOQVcAry.HF3I52WhI4D
 PKG_tAo_sviZephuG5VTSLYTBMsMPY7xJvJk25w60qIqC62H6UXeYqeg0HdIVd.Us.aysoxmkPxf
 ogF_ILbmys0RhgLlVtr.EhhS7BGJSVOkaTxA02G9S5n1lgQbBXqsedAJ64mkzCG3jQCOJjlmx.Dv
 6y_H7TQGYRRVQql5NQrONSRPZ2YpzkfmqxzDHMv_objgDooc_lrUUzf8UHdpuaPVqY6rpNeU8TOZ
 e5mLjKbYPwp49p37sJpsBPcMNyGHBq7U6hkGLPix84zf1ipMbjOLYfpF7B5a3LHXjAAfHWrvqCcN
 lMffFRTxLeBBjN.vsgm0nBrL5IJUQKGsaie0Q6oezroJWGJ.OR3NL2frCfA4cal9wDEGRkRWGcfW
 iO24EvJ5RL8HkIaPN1DG3y2Io0kWag1b9epoONUrA6zggtd5U479RiczA0vul9evpicsvAMpHbbl
 ITDGSLv5cEu69DRFUYMOGZf6DNhgBhH_Tor9.7gt.FCYxWjpL0rPtCO_CQv1dTSYnJqAY_ypMUad
 hdqW2asKRPaC9dw0zJ22uYfuvf5GgkSfcFJFWzvsoG3eBywJF1rpSfcwKE45ppUV5rGRnJjvpXDQ
 9YFOhypYjgDgZyxH3Ewm.JKJF77YpUouBT9fDtWFqBqV7U5gsoQlW4Vg5Q3npVsnXm9C34lybazL
 P_XpmC2d9NjTPUR3fpDLSYvH26OBYeetWh2ewrfV7kPWSNSOIy5SlP7iHv7_WaAxbsrtR2msS6AC
 Qtb8yxIFH0TP2wE2hd5QJxaKIQGNJm34bej_u.2QpkjRUr1pgAnniF22_EWBrhrhDGqjB55eJZLt
 jgIDr.eiHxoKMfKaBv9vwRs65eygNRDNqIVaAixkt7ho3DiqRTw5CJeJPIIjy8auG2t9iqEo.UcV
 KOHF1yx.J.SL2aATCAltOtvp2uS.kPXV.DB..aaBSogrOBD2WdgGcjKcDrhZNrdy.2zvEObvi_DW
 FvFj1lkvebih76k2HCiuOv_FfcriX48tFjqgAuAOW43.yFnk_PyvjKXBveAEHGIEnURD7jDFcDBY
 yJyY.ndXsula46PI7Pc9Tra7cSC3AY6Ti5wi0fc0d.aJM9YVKQ1FPfjw8CL.q..lJULUpn1Uksk5
 gn.wxf2KdRODJ0Tk7vSUBzHRpsHtuGGvZLnA8DPJypNEAOqbOgONzd5iwyhi8WRlR0OactKXuB3T
 t5wVUbhSU9WLwyDUAxoDhScJLYK_eyiG_HiTh8I96ftIMPwYStsnRLQQt.3erIT31LU105kO0gwf
 1nDpz5vW6jtPcesr6lvz4xm95vysDUZr7_1z_fRF4DqY2vPsYuPsnBzhAXSBEleiGrdBZtt0lWtZ
 P4qbTLNvvnrISQM6OmOUHXactFUmSLnqmgW80oUX9QFPqsb3DQWw5pxe0j7_4dECibAiaJPrUK5K
 8yowLBcUFs5iF5EhnPGh4.03qSKGEbah82axnlMqA.Xl.iPvq0vsDEfO8dWTfcWRkq1LaIkOo4lj
 kuKI9JoK0P9MAdgThuSvlb6hp8s50ykZc_dc606j_HFoUXT_T2YaXWE1Y_gC1fpK53FfW8xrbgul
 dvsVCquT88yypSo6va9qg42R3I3U7ks7yspn2CQodLJ8gu4NOe_Fwnt105YHjmWY9gZnvUmzwLJr
 f5SLOU4QgvMsJ9lCMhRSJcS4cZ841PgNTes5Yx.mi1E3Kl0Lr7Ic40allvm.2TfbQqVovCjkvyq6
 7l.Ot0Im08EswnGuamVZUu6DiINcXAgx54rBdLdtqPOTnGZCbFe4KAclmZETJWuumgxWHyLva.Tb
 1Da6hr0DzkMSiw5IJr_xNJLJtuAkXgIxghOKuoZRP1uow0vJI2q2YEPdNdPw2MlGupEMOJA9hWqC
 y9rohL3BVno3vrHQeyTklM8uzKagPnjJ2mvC7LFbGqqqFjRcmEmUyfHyhb7D33Pllt.a4iPvD5Yu
 eiHRSt75FCH4EzEmyzwCMneLEDQKlfHoIYNDr7sc5po5FVzUIiQP2pVI1E_fMSj4y1h2wdLD3ovs
 TVLef8m_Ug0gSLcpzFYt52HToxDS4pOwtBACGwxqOhczApOKFskW01vy1UVEyXdtV.PcYTwRqfWb
 V_gZQdnheV3reVNzsB.CWOm16ZZPXQVi.VzGIpWDiSHsko9r2PMZ.ORE_bF6AG0OdJwdYwOa.auz
 QPoT0s_qdpN4ooTJffd0v
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: aa61df0c-dead-4c2e-8f62-dac88edc3df4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Jun 2023 23:39:58 +0000
Received: by hermes--production-ne1-574d4b7954-xz2cn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 722d8a43fe0be971fa9347acc11d3ac0;
          Wed, 07 Jun 2023 23:39:57 +0000 (UTC)
Message-ID: <3319126a-c5b5-c9db-dddb-7ed169ac7e83@schaufler-ca.com>
Date:   Wed, 7 Jun 2023 16:39:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 10/11] SELinux: Add selfattr hooks
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230428203417.159874-11-casey@schaufler-ca.com>
 <b09b591926e0f297fe0a3e9d8fcf3a6a.paul@paul-moore.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <b09b591926e0f297fe0a3e9d8fcf3a6a.paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21516 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/2023 3:32 PM, Paul Moore wrote:
> On Apr 28, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add hooks for setselfattr and getselfattr. These hooks are not very
>> different from their setprocattr and getprocattr equivalents, and
>> much of the code is shared.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: selinux@vger.kernel.org
>> Cc: Paul Moore <paul@paul-moore.com>
>> ---
>>  security/selinux/hooks.c | 154 +++++++++++++++++++++++++++++++--------
>>  1 file changed, 124 insertions(+), 30 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 2ee92d3fb79d..e78b955e04f8 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6542,6 +6559,81 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>>  	return error;
>>  }
>>  
>> +static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>> +			       size_t *size, u32 flags)
>> +{
>> +	char *value;
>> +	size_t total_len;
>> +	int len;
>> +	int rc;
>> +
>> +	len = selinux_lsm_getattr(attr, current, &value);
>> +	if (len < 0)
>> +		return len;
>> +
>> +	total_len = ALIGN(struct_size(ctx, ctx, len), 8);
>> +
>> +	if (total_len > *size)
>> +		rc = -E2BIG;
> Hmm.  Since we need to calculate the aligned @total_len value in the
> LSM specific code, perhaps it doesn't make sense to also do the
> alignment in lsm_fill_user_ctx().  My apologies, I know I was the one
> who suggested doing the alignment in a common place previously.

Some future user of lsm_fill_user_ctx() may not need to do the
calculation, so I would be inclined to leave it here. I'm thinking
SO_PEERCONTEXT, or the like. But I'll go with whatever gets the
patchset moving forward.

>
>> +	else if (ctx)
>> +		rc = lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
>> +	else
>> +		rc = 1;
>> +
>> +	*size = total_len;
>> +	if (rc < 0)
>> +		return rc;
>> +	return 1;
>> +}
> --
> paul-moore.com
