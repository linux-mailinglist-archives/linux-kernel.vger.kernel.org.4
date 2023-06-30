Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F037440E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjF3RKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjF3RKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:10:41 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529D170E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688145038; bh=9FJikGLBz59ec9LC2kX4GhF0WlW5if2x5j1HXc6dyas=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SqQfHh3JjScx4/HWlkB+yuiHYOHC6zLwEOk8JMeGMZbZgBNObIsbrgFNlXEaM9mwpyJKaLk65xEYPa56War6IhthMW2j2hGysSSQHMapCjm8ScOGTwQ1Z0YhTllGIO+wKd1ICTJeRspRvhbOAS2hxGnhCCrhJm1Xr0pxRiB/zRNDQae03LkGXjeFqX9ISG6EFM6bBFdSEdXtHt534+tCd301iRXdi7VYJYbITWTxZy/kYxy6JQat9wZY3I7vKdJPCiKHdsFAVRz1jrWRZLRNel365waWenUpcP9yEafpZqhprmfgZ3ayvc4vhMA5nF6yp54D3qgFKMej3fXZlC8GOg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688145038; bh=P3ro1g1siZcgGpwJ7lQ+PhANLf1wJP0TnqWuGSdpg5Q=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lBGwHhlEtrehtb1Ew+zzvVhI+RzN8GZCBPF/CBDPf2H9pWB/z/u42z3JA1KMOlBArhP0vv86eURhlJ3VQq4yLLNIFT/Pu4FUfmkGrmfOWWuJnyDuEHyM+mb/ori8FvUnlHZ0kY02T9qikre9NmrfeNmaJzDQJp6RAv+9FJG8ENdUfCXyS/PZkuh66d+VUZYSVYIkKhlnut7Jj43LbKDkeF5CpSVgHUilK1TKP+v/vvy1g945tI3/8NNQ6ynRN36cjwtYY5TmzNtDOPhxxa7H203HQkTzQsjCcQc0NTvni87dR3I9tH5FlcxHdwz2xO1u5nn481Vy45bA0hL7GE0Amw==
X-YMail-OSG: g7a4YqQVM1mq9MlUvaF4c.2xOav95OKASudTDEbotoCm0EpmLT7ip6LCIiZyS04
 XJDXedMJY5hGwl1rIoGo3ZthDSsUbWRdkzTDSntgIVTka6gNdQDHDYADBu_b.ukB7dWoard3eOtP
 Viyznzft63OazbhEL_yxxOnuFycbM7sjZpFRX9ioyo3R1wZvvxbpxOkr28kytbyzxJOUalykFedz
 28ZmY4CGc4v0nCtx7cji4g2DlEjfrHCCt5z8JOQxquj3gxCYJ3bLlla_c7ES1B1itDZXs9kqjfIm
 YMU10xYVbW7eJP_o_gr20PYqvVKRFp1LeBl1e4fx.TmDxyu__eYn1GuotJ7uQLfcGujKWOIDTOhy
 QjfdMzw9t5igerKReXIr2u_dMIzSTnT2BiRBkduNYikbt45EY1o1_9PY_psQ1pVWqbD0D7h8XscF
 xVPFWe3_PnJ03mRd8VSIOCuX6SrRmu8DmXjWGN6swSMeDYRJsGvPteDzCdY_MqSylU4Sjz_HC0g1
 fnmUU9u3R.YUkub_btD9fv_YUDM7BAI8Rfsl.R_qxsZNovVHM0LVJuHFmqBlpusg7lOzqB.U6GBh
 xcSAja2Tno.qvlcWhDibzreI6bJ0_nsZgBkVmUO4KUg_0_FWkgc1bVkuxt1xtRaYWzqIHzpCEFOH
 xtgNJH3M.PQOHTtV3Bwah7.s49XfuNnkCrT8OwpGFw76oViMc8J8FkJdcZUqCA0y.CSYMmx42q5E
 2Lwkfr8hgPCc_KrSoCkX6wxIqBnXMuU4M1y.Pjz4PXgmX4gmM5r6py0CQwyNDf4C4SNCmZiK2aGr
 x4Y3RTbHHndwrPSZxp0aLtz_gYbq4L2TgaKY7eW1I3MaPVcB5t4DssnVe5E0iiZeyfMfkyemI6L0
 K3p.uL8TfUxNglSh2m2zWbUh15bzopeWOfpPLpEXaWRLCkzkfE.kXQGkxtX.MzTJkqOSZ5QLby1U
 YKVflpTgpK9I8MKrXVOaa.6KikJq2YQbrUO4MJPhX2YmwGCILO6Tsv5hDtXdvBO7WYFxr0Vm1c.D
 9iUDg7jRtSe6YAdQ_7Rf8KQS58FiMuGmnTh.6oEJRHyROA95H_7WI9NJOAPqxyM8RvCE7HspMrBU
 3_qAeSfTl1CEmbPwf_Vjt82gdD8xQIprbABWQhdW_Cz.JfPGg.ITGQ2y7qL70L5zHQkaytMJF9Y7
 Grm8Q_RBwFSr3wiHwiQzI0mlUvuCe2xlvuaQ1k3NxvSfuqr4_8TzWpv0rOEMMuHAN4sHYqnGuaCG
 uOb9rk0tWiCr8mDWxKraoW0pQMTrawVl4J.2FgppMGMZ5lxHL53Y3Cm_UEBzM3gG8qMguxcGL1tV
 zzCrdZ1f85e.QeIMtFbeHGfujhrtOCFun0JRUtWPjcPdwlRR2gpZ43ELDeP5iqSOVkX_wW26X4EM
 XzXDiXSN1o2TlmnOiPr6ViahqZBFKeI7Q6SRKnkvoiwJeX7Sf3fPTZjMJv48iicBodUPT09m0tsR
 Q2xX6CvYd5rmkFs84Rv4F5cK1bKe5xclZNGD5pF_F8aVdrhkT1yVcYcaDg6xozTLkqOSW7rjTMVT
 OwPlT1YIpNdgjoMy6jNMD.A7h_CaK08PnoOnS_TDOJV1JHfC2xTY5Z0RSCUr_qyKgd7pRuwwGGl1
 S0GwAtWAkTghmLzY0Ozf865ifRDx5L_wPIcr7CDonAiu8etA9w5SlfKgwAdxpmaL8E8vtQA7ZApa
 FTETDlpkDbE90Mx7RVv6KzHr6HGNZYyfTD4q.ma.mlB88zl7IbXNDtq.c5VC56bvBTFJHPsC3TxA
 oyacHhxYiAR5AAgM2ff7tPJhCFBd455.CHU71IML7vQsZrEYvvIM39cSryZ1KS_eYeruAnor.YlD
 ro3H6ZmSfpQBvQnyUMalvB1qjrQ4bUcmBghoKO9hjsjdKZ5aMySJpDg8wKwj_wv_oNBkKRmXstj4
 8tUphDOpR0HUzM4BybzMxgwxiwVo9sKj5bUebZ.1LruqndbodJUxWaYGk4l533VJrB0Lu3h4SSVC
 7rHHJnuDeTXtKh1TRxRZXDyXL1OEOk.zsUIPw8TAb7Khp3gyVNlWjVcEc76.BCilemprA2iyHsMT
 rCFcL7P9oh8Y3TSQEZel8wE_BrfWK3CMk1u6Ee.PKd.L1H8BLl2GGSRZzzcrSGAE3wSSEk3YAAPb
 0Ent7QYEIUCHmQeyleiH.0Soj2gNpMrdT9ijgdfjbdSrkmC5qVTgGz.JgIZP7rt5pGvaI2Bdq7Fd
 DVQpVQM_sfpAL1Z4yNnWXo7eH8qf_nmESQdx8M0hxHkOJbCjU_i44eLj.1diS_I4S._mqjD0ddY9
 795nGUfnxiQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cfaa1083-b5c3-4a05-844e-3b7b26de0c83
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Jun 2023 17:10:38 +0000
Received: by hermes--production-bf1-5d96b4b9f-fkqjg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b1acd5bb569e8c764ba1b89fdecedb8c;
          Fri, 30 Jun 2023 17:10:33 +0000 (UTC)
Message-ID: <d2165e8a-4b53-c333-ca99-7b4b1c3a06ef@schaufler-ca.com>
Date:   Fri, 30 Jun 2023 10:10:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v12 8/11] Smack: implement setselfattr and getselfattr
 hooks
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230629195535.2590-9-casey@schaufler-ca.com>
 <d1283a1078fd30a2e45915416ae968d2.paul@paul-moore.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <d1283a1078fd30a2e45915416ae968d2.paul@paul-moore.com>
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
>> Implement Smack support for security_[gs]etselfattr.
>> Refactor the setprocattr hook to avoid code duplication.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  security/smack/smack_lsm.c | 106 +++++++++++++++++++++++++++++++++++--
>>  1 file changed, 101 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index cf847cfe5ed8..4a84639e9db9 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
> ..
>
>> @@ -3629,6 +3668,61 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>>  	return size;
>>  }
>>  
>> +/**
>> + * smack_setselfattr - Set a Smack process attribute
>> + * @attr: which attribute to set
>> + * @ctx: buffer containing the data
>> + * @size: size of @ctx
>> + * @flags: unused
>> + *
>> + * Fill the passed user space @ctx with the details of the requested
>> + * attribute.
>> + *
>> + * Returns 0 on success, an error code otherwise.
>> + */
>> +static int smack_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>> +			     size_t size, u32 flags)
>> +{
>> +	struct lsm_ctx *lctx;
>> +	int rc;
>> +
>> +	lctx = kmalloc(size, GFP_KERNEL);
>> +	if (lctx == NULL)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(lctx, ctx, size))
>> +		rc = -EFAULT;
>> +	else if (lctx->ctx_len > size)
>> +		rc = -E2BIG;
>> +	else
>> +		rc = do_setattr(attr, lctx->ctx, lctx->ctx_len);
>> +
>> +	kfree(lctx);
>> +	if (rc > 0)
>> +		return 0;
>> +	return rc;
>> +}
>> +
>> +/**
>> + * smack_setprocattr - Smack process attribute setting
>> + * @name: the name of the attribute in /proc/.../attr
>> + * @value: the value to set
>> + * @size: the size of the value
>> + *
>> + * Sets the Smack value of the task. Only setting self
>> + * is permitted and only with privilege
>> + *
>> + * Returns the length of the smack label or an error code
>> + */
>> +static int smack_setprocattr(const char *name, void *value, size_t size)
>> +{
>> +	int attr = lsm_name_to_attr(name);
>> +
>> +	if (attr == LSM_ATTR_UNDEF)
> That should be '(attr != LSM_ATTR_UNDEF)', right?

Yes, you're right. I'll fix and respin.

>
>> +		return do_setattr(attr, value, size);
>> +	return -EINVAL;
>> +}
>> +
>>  /**
>>   * smack_unix_stream_connect - Smack access on UDS
>>   * @sock: one sock
>> @@ -4939,6 +5033,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>>  
>>  	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
>>  
>> +	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
>> +	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
>>  	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
>>  	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
>>  
>> -- 
>> 2.40.1
> --
> paul-moore.com
