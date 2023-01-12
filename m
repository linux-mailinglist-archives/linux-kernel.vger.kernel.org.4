Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1338D666880
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjALBjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjALBj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:39:29 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD6B40C2F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673487567; bh=Gkn85SkUvPbK+z/40R7Wd3ZwyI65DZt4P7v3hN74Oe4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FNeSP04Yv2W01EoNGjzD6Zt9nRDP9TK+kp6pAMtIlCFZhktIur2R7UYI3PL40oC/mtXddZ6aN9bkrn1ZrqD2UhLoV4V8RI9LyG7yMp9sutM+eqlP4Zw9iX46J/nWkreKmB22zeMC8aNtEqyfiPOBGqTpO9Sm0jrbXj6IPl5mHubD1DayfZtK3b8tK8KSOSRpkdAiuxDLq2P/SeacrRQ0TwDxjf2bNMygan3VpUvHjOOorWPTAFJbRu6DUN/6+s29P57HRdp7dtdvngbuHccRtj2jpkeTpM+Bim56YYZM3sFg6qXxobadI4DZj2aDBtGJ4kxVBLI/cjsNw7LqLe4MUQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673487567; bh=GCqb2rhF1iG4k//JkHbF1+siJWfPfCeKg7Uhm3jU7TM=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Iz0pHszL4t8IA354//TnGkT4dVQpSCsYdSZwB62SIKTh1RnqBZKlmj0lEiRoutK7jLToSupu6cYmxkdxRWVSMuDAMEZhxK0k9uyOSS9GMjprmbig5h5Mx0qg34szfLaOeg6hlQuOxdcjmWQb+VaBcN93J7W/BxeexSaZlvpNrrW8rgHxcBLVE2oV+pgPYRwa6tx/35UQZgyvWKLhrceZPbkSxMGhd1A+FIM4B0NNpxxWOUywkHyxCRkvD4NPEv84POyWy9fOUaLXXbwCT0U73Rwt+GggfjHC9KTho4nQtXlyV1BlWPboII3sro3bINUBIN3gaALEX5BX0b8qSL8Tnw==
X-YMail-OSG: hw016NMVM1kGWwUyxgt2PmVBxsh3q551o2m5rVH1Gsh98XIuglfjB77Fy9b9zv0
 9mfN6ZBrO3N2IjnsCKEJsRpukMFB57VTwx.L63JwS788nXMNK7PI6SivmuvY0e0itit_oeul3wRe
 QzbFswllnhz3T87Hu5q0sGOUwfd9siW1RtDXiZfgnj0gB1s81SziHBPMWCKNDX1NapYWTrnKpr9m
 UPvzBiDh_xpLRv0wMdu574TTadHtZtm49nZCi8loSr4jKPljCMwxVvTFsZjaVrFGP6NBRqhxF9l2
 cEiAEPPLXOK.akukSDo1y1NccoGpNzY4O1K_qUJeh9P3Aj584vICyvUHsSkE3BHjdG.h6q4v3M8b
 Yu2LHgJvPBLy2OWxOer1tLwqZ4_qQ5oHZU9mn.cYhCmXGy531_whBXHEQh0smfJdtav7bTjUGibE
 8A_oSA3ceiGjat6j0ZxGyqt73FIVdifnq54J52wQpf7iQUijyf0iPYVWwUqhtnc5TYgaCw21ekNL
 hlseJKynSBBGbeC55saK.dleLAFkYE3YKSGCu1LRBnUwQg_oZYtTq6SwH8jaYsMrdZP1QJg7QnrB
 fGkMWftcq.IzZIi7bDZvP8yoXma4NeI_Zi1wMRsVjBuKvb.QBLqzSS2e0kofH2GC0Wjx2ZlcNd_0
 w4UyPtqSZbqa4_iIa744CEMObUPGVQILk93UHmKst68A9.zbEb6cOztsyuEBg_b4yjaSuk5m5fcv
 1PsAlWJHalw1Y4em2IcKZiigZnd_jjeZpRSmt12AwFC7ZpwUEUqm7fvGdIAqcTfZkOdc8J31YiC4
 Fa3q1eVay5Ee3qkeVcIUA.s9A9OwE7WjMDtapKPc2IG5gbwZrYGvw_7kxHWONMJwGT3Ft6Zs477o
 d3QKq.f1mGw9EfU6uz.8w17B3PfExJllB9ky8UjwGd9FsfqIb6l.qZB6_KQ.j1p1V90t2mRiWBdD
 zLwjqlIkEmpPFyRQ1Y1fBfloF65.LZj75oYCTiRqBlWcIocQ1QRFOQwX84ZjLy4nsam61TrcWKLp
 1soQkl3Lq1SzkPFw2WQWgifYodZZI8QgXDj4_HPKvu0QA2lkX3tR_Q_IIeY4NgC4ZC2CdNSO5PUx
 2UBRD6O2VRE.StFaJ4YyVOI4FI6TIB7w97HwwsIeAfRacYc3plnshJ2CeXOJyaaFA3UX8oVqTjO_
 XOE6YyM9iHIzrXnuIm9TI1CoLP5U4DHydIBqbLdiCZcm6gs8ZlOVpBH1sbYoMvp6sLWy0Xdoj0ks
 MWClBuSLLPfTXU4cWaaAd6p.8gFW0SpVcstcUd77JHFpQAu_HwTWu7Sd1WsO6LIviwMmDt.q0ZBf
 dN6KOnWweeeb9u_CbBpYgoRKUfUfuR6FIRJOuJhWN4NHyK2CnpWJBsGzxBn9vDMaR3amVFzY70in
 JeCo25ouUzBOMv1mOzS_QN8_2MhxRnEg2Ip0ZCP5daKBFrGBfxLcV2.jeTp64juEKlcl3WbLYXVG
 RL9LRnunpbIfpUvZNGAW1Zd_TZO536pw0BGibozJiZ7dwiswHgArabjwn7HYfNILVQaGk88NMQCB
 OF51S_0t.n29dNdJM_lKBM16Z_Im9Ggh2OqzG4sknYCE8V_R0pMO7jktnZAls_5MRt1IV7kBNI68
 ObXkj_ipwu25kg6AqjSdjBfRuwc9qSy_6QOXahGtqnLErt6F0WdhQ9GdUgOY._xmE2L.c..ubyA5
 30OAKdZcabwZLVeaejPzhqxUwuY7nXihKCeG82frlIlRIYMWejhfnrYJ_BX.OiAbduCmlrpjtsTg
 UF5yGaCoaCK1WkcCg7bxrRiX6UG_TriLAOQtTbSRM5n9J3uQ8RDZOtateFUEy4QnKR755w_2kwD4
 SRUrF9ZFmnSbJXgF3ehsPyRv.LWw3Z_9DXBy0jx.JdTLIhmpn5cuCU02mD2ttBwfaaqc3FdmImv5
 XJZ4IMATbuo2Am96l0Uw.YKQ51boXXX0AhKCkll.hEdomu85KTF3X8DpQvhDOJHiuzMqqkGW1cgn
 Ozb.PO8.QZVTyP2KXcpRCQj.f9ZKXysEcBwdVgw9SqUmZ1vDLoWDaJmz8HU9h9XysdWmXwsw4CPg
 yCZd1Gcl_iMu2wIb9lunmaqqu02xEcQAYrNkimFvXBO7KEbwgNoYZvlTJP_Dx37hdWFOgNEbp8li
 6B9H8vLucgfkQsK6pdNSkBuNaOuXsHKVOR.Uyk9aXDRzMMrkWYtIfsrTg9XQHj88DfjE3u4Fbgc6
 OyXZGL5ReHvJnKNO_Qa_U3sWgZ1Ro.fANqoofyUTCfKpErO3ukkYm6TbhZF.jWUlwtl2k_j33Njp
 WFs_ZTQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Jan 2023 01:39:27 +0000
Received: by hermes--production-gq1-5d97db6675-67fl4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 541873f11744f5a551e8d66e8e9e2ee5;
          Thu, 12 Jan 2023 01:39:24 +0000 (UTC)
Message-ID: <8b345948-5b9d-37f9-16df-6d632af41477@schaufler-ca.com>
Date:   Wed, 11 Jan 2023 17:39:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 5/8] LSM: Create lsm_module_list system call
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, casey@schaufler-ca.com
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-6-casey@schaufler-ca.com>
 <CAHC9VhTFRXdRZnnORw-fU4Wo84HMUMw8+JTTJvc4+pv8YELBHw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTFRXdRZnnORw-fU4Wo84HMUMw8+JTTJvc4+pv8YELBHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21062 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2023 1:07 PM, Paul Moore wrote:
> On Mon, Jan 9, 2023 at 1:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Create a system call to report the list of Linux Security Modules
>> that are active on the system. The list is provided as an array
>> of LSM ID numbers.
>>
>> The calling application can use this list determine what LSM
>> specific actions it might take. That might include chosing an
>> output format, determining required privilege or bypassing
>> security module specific behavior.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  Documentation/userspace-api/lsm.rst |  3 +++
>>  include/linux/syscalls.h            |  1 +
>>  kernel/sys_ni.c                     |  1 +
>>  security/lsm_syscalls.c             | 41 +++++++++++++++++++++++++++++
>>  4 files changed, 46 insertions(+)
> ..
>
>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>> index 55e8bf61ac8a..92af1fcaa654 100644
>> --- a/security/lsm_syscalls.c
>> +++ b/security/lsm_syscalls.c
>> @@ -180,3 +180,44 @@ SYSCALL_DEFINE3(lsm_get_self_attr,
>>         kfree(final);
>>         return rc;
>>  }
>> +
>> +/**
>> + * sys_lsm_module_list - Return a list of the active security modules
>> + * @ids: the LSM module ids
>> + * @size: size of @ids, updated on return
>> + * @flags: reserved for future use, must be zero
>> + *
>> + * Returns a list of the active LSM ids. On success this function
>> + * returns the number of @ids array elements. This value may be zero
>> + * if there are no LSMs active. If @size is insufficient to contain
>> + * the return data -E2BIG is returned and @size is set to the minimum
>> + * required size. In all other cases a negative value indicating the
>> + * error is returned.
>> + */
>> +SYSCALL_DEFINE3(lsm_module_list,
>> +               u32 __user *, ids,
>> +               size_t __user *, size,
>> +               u64, flags)
>> +{
>> +       size_t total_size = lsm_active_cnt * sizeof(*ids);
>> +       size_t usize;
>> +       int i;
>> +
>> +       if (flags)
>> +               return -EINVAL;
>> +
>> +       if (get_user(usize, size))
>> +               return -EFAULT;
>> +
>> +       if (put_user(total_size, size) != 0)
>> +               return -EFAULT;
>> +
>> +       if (usize < total_size)
>> +               return -E2BIG;
>> +
>> +       for (i = 0; i < lsm_active_cnt; i++)
>> +               if (put_user(lsm_idlist[i]->id, ids++))
>> +                       return -EFAULT;
>> +
>> +       return lsm_active_cnt;
>> +}
> Similar to my comments in 4/8, I would probably create a new LSM hook
> for this syscall so that the lsm_ctx is passed through the LSM layer
> directly to the target LSM:
>
>   int security_sys_setselfattr(u64 attr, struct lsm_ctx __user *ctx,
> size_t len);

That seems like a whole lot of work when you can just look it up
in an existing table.

> --
> paul-moore.com
