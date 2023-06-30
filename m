Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3447440EE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjF3RLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjF3RLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:11:50 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C567125
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688145107; bh=mEHt/JqObB3Frlc2IUEbCB2n7vlId/lkmWICPwY56hs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=oZBZ564GVvuSUmwlk6ao74tWl7pVLggMNr0TmAV2gTR0zLegBQzKYeJhlfBJPWPuoEGNRiXtlUcBURC2FTjwvavx1WXEK6gItCsa5u8btd0iZ9z4ghsYiyHZVGIHjtaKsSTITCa2qAX8paaxIZvGzmaVgqnZtnDofhGtELOcmqsg0Bqyepa7zuowb8i+efD3u29T1Pz5OenVq+OYzZHn2n8n2mXbHJhKG5a1qURiyqzDP2M/uFK55QpJt0uzUeZ75ZgU/5SSDYXGtZ6P+l0eDe61uwlRqVpOvZRBV+gOyjirKPnWL5HurkLoTJ84VuEQsyEhzyEcCO3rih8wTGSVpg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688145107; bh=TymhNMgO4qRUs1tebafYC31Zr0VhYFIM5/yJO3p5Ptp=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Auqcxm5V1vDuihNba6pga71GyRk/Z3r44OTzxXbVL80bWurf6lE5xPWsmgObfN0Z5VssUNSCmOZ7T7O8pnmLo4SOvH/SjHFKG8DZS6lxB1aV7RuEY4gcIaNHXJgUwlT6vcDjnLQrNF+ixxEkU8ObEk9Dhx+wGmufYt89vtKYCPflbqrkVDiUwgn+euC8yuqQS+YG1ldggkCdPTJMtc9MHDHnuNOKdv9k7t03AOXgAmSJIon+myQKJgmR+QLCrPfnYoh9V3XlK2rSKhX4U7WUd7j2Lbi9reVkAsqW+pNpwx77AxvqBF/i1nlNdHL1rziwlbexzSIDOkaJRX10nwuajg==
X-YMail-OSG: hPDmIoQVM1mCBJsn4UlQZw5zqgdKKYKhq9LSGVKKPSEjypUlclKITUtzUHnntgT
 3c8NIIm7A.fgTBnPPudNfmHWdT1uPzVxREiY1NXSRcOMGK9CyjUYv5PLsdtKd7Jg0HycuH7r9rDI
 7rFXIPjLgpp9o2I0VujmLxtCA8.NK7UBcsTk5xLdgNMYhWQUUIgSbLkU6.uyzktbXrik4YFYz8By
 1tzNHvPhmQRgngZzHOfiwPX9a_borwcOrNHcJXxqnJV03f.Tid8XFAWG0itq3xH._WxOYrVKgOeD
 mtdMvB7JRVv.9jKMLi3fD2ajNOy44ns1KxCrRRYWHEZtbNLoY3g0O6s0oRsYZUIrsZj_iNAjnQwh
 GA4x.42.XysqWOJazOC1dkMj7OMW_d5uWk8Fp3rBdCzcSlmIt1LA803mKQ1RnUEiLNoeXs2jytEF
 IxUgrdW4t6Jd1AnRjQv6rZPcJ02Z0l8.RokuDoz0ZRxLaUTVw7hihyIxCSq3qtewvyxJsbihBq7_
 TxCbh3a0dAWsJG1PHHxhYVbvOddrXJXxnBld6m5gxVNKAqHbROLnEDl53E5r_Z0f6hLOoDMC99.X
 Q0ithwQroDLgpJcYda8eXcojv9BuadzYTCQ1bG9bEDA3vE098nBdbscercRFNVe.Hs_BBKlZSQex
 ZuLKFkUzsJTH5NRRfdsaR9QoPUtpyq9GFD4zGIdRtC0HYzYahsfdzlwhb_xP9epJg4R_Sg42sJQ_
 QUxgdxoWjWmcaalWWR2yxbDYRjK__SAvck5_LPE3rYc_kZ8ZrM_VWTJRccjc_VwRmlQtvm19MZYa
 t7iwiv_TU2B8Q5xeUrKors2RPOQ9QSrTgq3sKMh_3PBH2xNRT6wiCThgT0Yu64eXqa4oBmE2AqG.
 iS6qaqf.czUC1YSmigxaQQCvy6FAjoLgfKbvt9LX4R0dlWyrNST9vRMfwc6GNGj9qaX6G8CyMEPV
 7lKLe0ZF8ekMYvPxqnirqJAJjXL5Uv4N7QvsQDcl6UUiYxv469xwSdaGuuiWrCRSjFqZh382B9eQ
 AU8avaxQaRcp_OS1nqoMtes2CqdcQN.FWBsHEQOQbjmHlkRanlubdWyXuJmSxhguIx4dS5doIH.h
 DpQEIXH8e4AsdiO0cq4WO_nfD2ffryZsWqedRLb41U.yGjH.vX8wRi7MwThC0ch4XB2rsgK2xVP8
 5x5cZQCgovcdGuPWV1jbZvbP4lQMHO5bvZksA6ExpLncfPO1RJVfWlDbo.QNSTkdwingn846Uk_0
 6VYEn9QcZ78Rvmth3F07SSWVgxijYe7LOy9bv0f.Fot5mp76ru4Mu_5.HD6Ol4h3CKwk.LgROLIK
 LxTAx4Z1cfQo_TKuIK6tVc8Eaf6nBxpPeZKBE8wj2xH5sSY219mS.ag5G7T9LHnmuzSI46MWKKDf
 xJhF5fwKKIJmSjTdYJzzBHn4LZFXUH.EOyMoMSaBPuJiZu_rTybF22mkUWCWUeDq_2.u._XrqZz9
 YvVOBx80gkV_eeepwiSPDZodL9dpW.fSMJ3HlBxT_WB0bydaQSAKNUBXBu44_QlQXxF.hsByKTlC
 UyGf4pFmcDyV3IM.92GLADt7VS0QO6ql11gU5booUIWlnN49keP38lEBHpWjdTcRhuXTef6MEcsC
 PJyCYVNGm0Yzk_9wWkbGvZZDUEBx9Wm4GpR1bwMKmNf1dvXnak0RVcfDyGUJeulATTsAURBpHkxS
 EmVQcBj90UEsEqE1P4tBPl6E.f7Gn7MvQYAnL7E4ySSukUXwTsCt0zuGAFIL1UN34XzYJWs3vjLq
 AnaP00uzUPdxmqPTC3sU9an7Nzugt96ap443DUoTdQgCqCT2ISed1zW9kKty5JXG4XnGJtSw5TnG
 laxki.Bs9t71PIO8ZX_uM31ZJ6AA26IrIbnLecquJYFeJLgAybKVt1BOEHpd7x.0NLuLhLWZFceq
 YngXqIp17MqgObtOISzqTSurp4fpZVZUFb2Bi7NKJk3h8ocjt4VOnMygxbtrhNlYPbM32EjZjXiR
 iGdfhpWhRN7vwRkgRl_KS0vgWy2uOoATMy.malIzbGT.JLX6kACEOeZTXSQcj7x_LOxVuV54Q7cX
 QvZLFwZxHUxnVIy4gRdeULQPHKwk_cFhoayLei791oLPqxpatEa4._dJVyfuAD2LHXwNHyatVDOi
 hS0nIav9BZRPLY8OHdiN7NYRKdRiKOJq3fF3rtyKxIwvVPNw4a7tt9xyLvhR8MVIsxlt8wpH6Ris
 aD3UTHrH7YDr6Z9SrKMPFU52m5VNbPF37fqQXVhi.QP.ttSXvUasOnAjMomTzL2Y7BWTPaQXBTOB
 65maGYg79mTQRcDw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 92000793-78ab-4a46-aceb-c6ee4f47f6b4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Jun 2023 17:11:47 +0000
Received: by hermes--production-bf1-5d96b4b9f-lngg9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1ac61ddcb6798a32091163362680cf0e;
          Fri, 30 Jun 2023 17:11:45 +0000 (UTC)
Message-ID: <d39d5784-058f-9298-1cdb-2f0e550b206a@schaufler-ca.com>
Date:   Fri, 30 Jun 2023 10:11:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v12 7/11] LSM: Helpers for attribute names and filling
 lsm_ctx
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230629195535.2590-8-casey@schaufler-ca.com>
 <b09a9753d31dc4b842cc2e058ae01f34.paul@paul-moore.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <b09a9753d31dc4b842cc2e058ae01f34.paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/2023 7:14 PM, Paul Moore wrote:
> On Jun 29, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add lsm_name_to_attr(), which translates a text string to a
>> LSM_ATTR value if one is available.
>>
>> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
>> the trailing attribute value.
>>
>> All are used in module specific components of LSM system calls.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>> ---
>>  include/linux/security.h | 14 +++++++++++++
>>  security/lsm_syscalls.c  | 24 ++++++++++++++++++++++
>>  security/security.c      | 44 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 82 insertions(+)
> ..
>
>> diff --git a/security/security.c b/security/security.c
>> index 199db23581f1..72ad7197b2c9 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -770,6 +770,50 @@ static int lsm_superblock_alloc(struct super_block *sb)
>>  	return 0;
>>  }
>>  
>> +/**
>> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
>> + * @ctx: an LSM context to be filled
>> + * @context: the new context value
>> + * @context_size: the size of the new context value
>> + * @id: LSM id
>> + * @flags: LSM defined flags
>> + *
>> + * Fill all of the fields in a user space lsm_ctx structure.
>> + * Caller is assumed to have verified that @ctx has enough space
>> + * for @context.
>> + *
>> + * The total length is padded to a multiple of 64 bits to
>> + * accomodate possible alignment issues.
> We should drop the sentence above now that alignment is the caller's
> responsibility, but since that was largely my fault I can fix this up
> during the merge assuming you're okay with that Casey.

I have to fix the error in patch 8/11 anyway. I can fix this, too.

>
>> + * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
>> + * if memory can't be allocated.
>> + */
>> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
>> +		      size_t context_size, u64 id, u64 flags)
>> +{
>> +	struct lsm_ctx *lctx;
>> +	size_t locallen = struct_size(lctx, ctx, context_size);
>> +	int rc = 0;
>> +
>> +	lctx = kzalloc(locallen, GFP_KERNEL);
>> +	if (lctx == NULL)
>> +		return -ENOMEM;
>> +
>> +	lctx->id = id;
>> +	lctx->flags = flags;
>> +	lctx->ctx_len = context_size;
>> +	lctx->len = locallen;
>> +
>> +	memcpy(lctx->ctx, context, context_size);
>> +
>> +	if (copy_to_user(ctx, lctx, locallen))
>> +		rc = -EFAULT;
>> +
>> +	kfree(lctx);
>> +
>> +	return rc;
>> +}
>> +
>>  /*
>>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>>   * can be accessed with:
>> -- 
>> 2.40.1
> --
> paul-moore.com
