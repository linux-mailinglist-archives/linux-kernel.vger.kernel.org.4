Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CB66F0868
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbjD0Pbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbjD0Pbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:31:48 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C07115
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682609505; bh=LLUumwE/USPAEw5xI40HJcdqlVWuORilp2k3JOcjz1g=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Mhb9kRH2HZVWjPe4JypPaesnW3edsWUVoAn+/ru5EOshA6J4W13M8cE6rf2vn5KxZyVfv9gZi7MJJJdBNMJ1bl3tgIpGE70VSMgSUB1bfyx5x1A1m2pZAG7kG+hGVKx4w7z7zWll5Atypuqy4IcBKrZoPjZdSY/S8wPa0Ff21jqYopTstQzvfi1FWxoaAb04q1dH265mrdr8LqFAZjSMFjM1LsTMG6UGZZrJjiYx3FPA/QgjF9dQJkfn5kAwdysos/y1EX/v6/5vXfMLg7YSYf8eUg4dhpspilSyUO93yaIM99zdZFsli5Yf49pOjeHgswSpcPRHl6+5cHy6cXBsMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682609505; bh=JJraOksP8YchFB0Qj0jBTPbn4FAWcGvFRQm3x+vFcmY=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JtXXi87XUr1yEpG36XWALNlCB+ecbOuXqGIGofoqoaSa6KfHdgeHzP94LyYsLCWakmjuqFkxH+5+FHP2WARbhHH+vB0h0o3n3Vs5weVUn+eHrP8+nFAjfN3GydwCRcvBNAXBESU/2U7ABmY8P0mk8/rHMkGy2teeRBB7aZXp1FLG98uZQwles6uTLka95OmrKBWbbuE3R73nE4Vtin9DhDmdOkE8Qb6kDuKDqCiXaIqNHE5vlhqzOMjNfObREr0jXnCU8tCB1jXiIRc755cD4vfo0jryloIm1fle8eSpaY0DGS/WT+qCHY30XeAT3SkoNLm9nSGbCiIixy06cddJYw==
X-YMail-OSG: 7Bc6bwEVM1lU9OnOJ.NaBXv7oZINBpGEV19ozyrDLG43VMtDx1mgD5yL9cqc2jB
 TqmxNid7dRarlrgxdOCTK7k9XpyG_37bQ8Sn5yOdS6AkhpNfqpixzIyR2PjkVEzBrNZ9d4Nk8DSs
 aXjSRAlB2aLjuy2SZHvTjBkJTOTk_Zkk3oe_dwYv3XrR1QcPItIGG_iljVBjV7wznVeZ4B8Rsxui
 shy5Zz8AF4h_StgpSN7NY8isebNRGZd7D.yvlSoEJFiUhMa8V1nP_rbeOVvKaiXu_X6OIad8NCaA
 alZaHzqevE81FRciz3nVFqh63QBDqCINwjzpLuEe18rDQdIjfRvXod0LdCzhWSwffQaIRPplQO0Y
 FesFpNUYCWBpdBV73dH2I_Yqvk0WMkJHKc.jKHD97FfJurrdZQdH6wViTK88ekvuJq9oeSl29aym
 .Wk2Mm0ICEMmhic45wxkx4YIMaNf3h_mNyfm3vQEZigFNS.Zu7ObBIjzWpJ.TYD3IatxCmntUazT
 4XlBfy8VFkx6rfDp.H.kgxRXZhHI4BDpCUEUrSuTgVrPK6pWlCeJDTM7lSRXFtvxNvLBWDzms628
 0osVORoBMLEbMwni3WTmNgNLCHgRiEuPzRnDo44wDcaSYZvafqDLzW8sqBpl6fJ1dOF_w4zM5bId
 CaRdE8DQ7OrwaZydKf8DH7hpb2yt4MfpE_nhY7skFT_10y5DZvFJsqnlfznn0y645FDrTfWvfFZf
 22vA.caunTZKFnqlyrgnzGNs85KnzgxOck6TFy5RIwAyJZV88vOElDKmJEJyOzP0Uin70rW9ZPQd
 IW6sRR_YkZASvC7C95f9v4nuus.CJe1V40tr5PvkystHwdR9MGdUWRTXwGYo3agsbQfR.BpR1R2C
 EPwiZuYN4XcuhMulL.1YTFnQ5E.wdyoxngP.j_MjaxuoeYwlbpOmpdO4bQVbIBXH8mOqDlNH85F6
 CJ_23TvDR5VCncCpvH7TJ0UpbbNmxHnZj_49q3pXJNsMy442BK6S2IJpHO2wUjY1WZiYSGVYzIlH
 chtkegVqmJrI9tUyzAgh11J2n4_.Q5fsPTkEaS58mEMeyCSoGg_9Rmg0Q_vLv8tkcXXYiQ4aSSz_
 89UqfaBtS2eEKV.OoEQIRjrnGg0AsSzX_9ahcbAjtE200JdBe0jODPelPSea8fzUlNzNdwQvchOl
 B9jFNeiUkfDHqbSNUNZKGcep7hDgEswePwhsAu0lVn.UPuOk_HDnD5C5mpROLVC3JN95xImj7Aib
 xx5A4Ztg5SK1Tu62u_NsWDWoAB_al8c1ECU3EQOVs652dnIesxJPlrL_RxjNe.gibgNQyR6jSuAr
 9yT6PwoNmqFnpSVpMC092nZkw8rTtl5Ah6B.krg1ARTcptNXfIxHYnO.v2mbrs_NkXuVYjuYDmY0
 K5us8mUQCZyaWEwIzc5OqWSWiP4KMLTaOQ6JTPklE0IdgEIM30576G0P8fk1rvkq_kq4GPuP.Cd6
 FzqbS9seLlXqTairJ3HbwqlRICyhugqTozPRQiWiK9N6Y6SfHqzBrxEZOYsBpT78jMpm.pGlogG0
 QwBWqie7iQrwoP3TCYuT3W98vtpQE7GNnkCMsr9MxYwDJRRe01dwWapSkrQLkdaEYGiH1Hsn76q0
 mZRS7M0Dx1HdklgkbZpECyXcRZI_On2MVWs86uNb0nUEAqrbPf5SwDg8SUlDaM8UURo0._AqFSEO
 lSi2tWMEsVq3NXevk4rXI1SSF1DTcrKTqnR_OBJPTljogCyckNcrGDE3fB6.7NqkEtU_PoIVbQjf
 yJF3M1jhfmuXkdh.9uCXaIJ9eiIDbs8p2fYk1dIZNYJctE5QFW9ibynKnac6Vzj1tIFy5IXtLJr0
 DvNtk_bCaj0OROlN_t8NehR1fGuF1LRtetNHxPsmtw35JscA1fO_50YVBuhx8Yy9yVWUtT5ExiH9
 fUY_Ih9D8OYmgpqb1x_DyJfzNX3J8RLVOLUNlNGkmkynCllXvQNU0rIC2xWMA98_lpxe9gSQnnje
 ePMeKeWe_9ywjKZOAtT5Cs28kYiaBeLCRDXDIOCZTwbXFV64.J1zS12_.YtywBo03pyO4MeDbdn5
 9rHqkudkQDGXi9okac.NaBkxu4lisCR9.9OPwh_rZYH9Rl60oXJE_VVMPdMwoNWaHbNTJ6xIYnOx
 PA5NvsyDB4tAeiXgI0PI5cjymb8dAt0IKeGuIO3XOm54hKQ_V7GnfzMk9FB0vJn95nCxL3bHa.7j
 J4UEGGFjshVYi1iCAVdltWzRF_Ryhsc.R9HIh7GAI6_r4pvCGYqVOJh5RUgHFb8mnBR6Y85HWOvR
 lz3k-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7b403dfc-5119-483c-b029-38ffd09e7fb8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Apr 2023 15:31:45 +0000
Received: by hermes--production-bf1-5f9df5c5c4-t7bzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1e2f07faefe03c7672f3f4ce25c50e68;
          Thu, 27 Apr 2023 15:31:43 +0000 (UTC)
Message-ID: <aa69bd39-3574-ac5e-b63a-af4ab10b0018@schaufler-ca.com>
Date:   Thu, 27 Apr 2023 08:31:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 02/11] LSM: Maintain a table of LSM attribute data
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-3-casey@schaufler-ca.com>
 <6442e1f7.620a0220.b44ce.7a42@mx.google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <6442e1f7.620a0220.b44ce.7a42@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/2023 12:20 PM, Kees Cook wrote:
> On Fri, Apr 21, 2023 at 10:42:50AM -0700, Casey Schaufler wrote:
>> As LSMs are registered add their lsm_id pointers to a table.
>> This will be used later for attribute reporting.
>>
>> Determine the number of possible security modules based on
>> their respective CONFIG options. This allows the number to be
>> known at build time. This allows data structures and tables
>> to use the constant.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Nit below...
>
>> [...]
>> @@ -513,6 +531,15 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>>  {
>>  	int i;
>>  
>> +	if (lsm_active_cnt >= LSM_COUNT)
>> +		panic("%s Too many LSMs registered.\n", __func__);
>> +	/*
>> +	 * A security module may call security_add_hooks() more
>> +	 * than once. Landlock is one such case.
>> +	 */
>> +	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid)
>> +		lsm_idlist[lsm_active_cnt++] = lsmid;
>> +
> I find this logic hard to parse. I think this might be better, since
> lsm_idlist will be entirely initialized to LSM_UNDEF, yes?
>
> 	/*
> 	 * A security module may call security_add_hooks() more
> 	 * than once during initialization, and LSM initialization
> 	 * is serialized. Landlock is one such case.
> 	 */
> 	if (lsm_idlist[lsm_active_cnt] != lsmid)
> 		lsm_idlist[lsm_active_cnt++] = lsmid;

This code won't do the job. lsm_active_count indexes the first unset
entry, not the last set entry.


