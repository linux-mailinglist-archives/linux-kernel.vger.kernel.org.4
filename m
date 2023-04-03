Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785D66D5052
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjDCS2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjDCS2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:28:35 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com (sonic303-9.consmr.mail.bf2.yahoo.com [74.6.131.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39A030D0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680546510; bh=CG88yJ4LrRejKL/fV3Cp6CJwAy0DEEWdlL4WnRG9D64=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qLIK+ecmyvHTYDav9PYB9K3q9sSJf0OhDN/Pz+9Kzi98BjYyLNS0tnEo0CA0j3IBgiZCU3+VPj9lR5m/0udV0qclJTTRsSGjouz6SsjHFGyyJQ8cBo2AyGuD3G2YV7+EW8KDU81uzehdDbQMYl0324UDXPcjr49m7ymaSyXPzfHGDGTsGy6ChkxzBbj8Tqa7OEAPKeI+Yw4T+BPb0h3vjV4nNHC7VZX7h8+PAOeQmKBkNEA/XPf1ILH+UK1A+DIvWKZr3RUM6HZQQR1Co4Mf9oRJOKTqZT2PPFphmcjHdkYrgx2XaHpIm3pHNSWIaBodGYNSYMazPs42brxk1u/Qdg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680546510; bh=mtSCpTfagjf28eXTDNp9LlViEtXqbho2U5NalUPdDPe=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Yx/sqHs7nnPXSasd504xGuIcZLagkjAMANzBdK716yJRE0PtWZtzmNO+0G/3GZ2hkieRRQhetcsM0aV2cZmg9N3dMO+/FgZ3qxNlE5k3FuWrXaqPqQPMonX6UMVElMFkPZawDpsJfFUonuHhYYUYVdQgBE50WX9bRPByqJ1GeyQtEoJy/8dLX1Z+uCm9Lfe8Bzd5P/HiEq5qGM6/JX5cTs4qLHPBu6f9A1M2a9skELfml+G2+xdxhKkO0JEHgnH+3rXc+EHW+5TkU64auMBa8Y1x8ExRM2JqZKuUvhdOXD149AGH5k/BEuObKtfIcY3FnLbeJITC7mRlozyFHETW4Q==
X-YMail-OSG: Cj7LQ3YVM1lYWRO6EtTxJb1n7w2s8WJGqbUN3PF8b9j36wwt5MmJbSDmKSEVRPs
 D_BKdTHsnAD6mPsWyQymVaVxIYNJlXEszG5NYnGvW5Dnc6gwUgwGpC9ORl1YiG2kJZck9nq8e2TP
 x9sXLpKEQEE9VbjQ2J2sVxtyQAaZZTPg9x3sJfJ.H_YLHBBD9UBAYYvZBk8DekIxr16lB1iPYOJ7
 O_myZG5WTycXSaDLQv84QHmQhVMCEJaKioia8ja48nF2KrZI2dbC1Hb32WUD.PzlZKuGkb3y4qq2
 MyZ0GPj8sXXeErhm0kNzyn1TBAK.6sCg7bkdw9yLYp8EoQmg3mz_XZpu.pyCFadci2YEPspT2vBx
 cUxtAlOAfJXTRer1TaUhieydLQW_TMXqf18v2HQD_TazPUHd7_kRVj5cK.Nc8xuKhsKjvSuq.x6b
 CoeXjqfgMhMvUGiifxnSfbrWTCNToxCwte7xaacQQQKefReBpsWWjSCqLvIShBTwrau8gqqLMZhJ
 2lFb4PbKA3PsJlZf5BEDSXQ_6Vkn3SKFiuZdiQqDxmELIxFFX4lljbZA_k_uDH_CxYC6IA5o5K3a
 eS.xDGAqyQal3IYCjTKM3nhRbLGkfUSLuEe6xtiiC8vnDTeR1.xZa3p6HRFqEvhQFgLciiCyNoBI
 SdtnaqkYL8uGYvtLxCPsekt.XmNLZfObWbbjPGUWORnAIj0cyTY3Q_u0lQJu_9myCqrkeCLAbAZ8
 ChhWPij0V5oL5bIaohL_pTl009__sXvHQC7G5xv.ibWmsXmOmrOvTloSWM8dRFRPZgxDLW5jGkRM
 JWgkdXgBVfVPTG9FCOT9unmL7IVr3lfDBRn95yFXLxkk9jgZj4czGHLW9ROwZQ0wRWuLdOMFqKCt
 0MydZjv4JCdYz7Ix6NV4NIeTB7zL1nmLjuSTlkD5nF3AonMiwjDz3Xfm6U_m7gtOn1VEJxwqKU1_
 TH1JiIckptp9kAowWX.qGJJlq4qQSbqvPKm7l4CsLsuRfFwMq0zjV7XYn8tV7r_ov1oh7NLybuqf
 tgE2SSf3vF1izhXIX1px747iO7EbBQkDPKMJmdWlBdhFXqy2jT7.krqY8AVjyBCnlPoMvTyiKE1Z
 G17MDQL0NI4fMCL4387tSb3kBFbmSVcQo3HV2.alU90NbTRl.oSQBq9q93LNxQocig0N6g4rtYKF
 NdtMtQN0c7V2v6GHhP0Twq9Zs9sdfw5TqCH8UQebfV9KJLV6eU4JUg3J4d_t6nx2oqvNBtEqWpxI
 IiNrHhNHqsCfehSNJrV_KZM.Z.YCdEN3YmGVYkwpth7lrql3JrmPMpuFLLk7AgvKbbHPZkx1rJYh
 RaKn1fEFNGI7nvFCd3faVnaV7wtEAkIMQh0zmtNg0pTcpoKpa_Lvhk5ljg4e6EGYLQfxgjLt4N4V
 PMj_XqiVVLYEbQODq4WrVnmbCxJzK5ybFOLhrxbJatRJTprOZezk7244FeHHTcl3.SVAR7Yu3kme
 QfntBI9wrWoW4up5uwEAn2djDLu5hbYV6EmC0RTJqc5_PfowoHFiOJH0tZg9pu4i.WicsjTnBal4
 kH5__P17j1TEc2.WyyCUYPTmlh54_GR55Qbsleb2ZX7BXN_CuUhjq1Q64o2PNeRddgNjwChLZ9HI
 ZQ8pl4TZNvxjEFluVJoeVwi1Ys1fq9EFFsGhRfKwiFPQwI20VwNTTSF.QPWoMdgCg_tdqtfZECgX
 3aPJMfGw7W3jIj9qih3EstkqnCJssaMHEkoJmjFeo7BUo1BVe0L0wK9RuqQfqQEZcBNWCXd7m76n
 f0zu0QE0sv8G5uvGNJEQ7JqnkZpfWBjphx75cNN5DRbJuvUl6iaPRvfMWUL52wh.BYagWMFfbFLa
 QzxqnVZUBz9nZPLa7GV9a_IrqXBiE.r_n4UP0EAZGcVKtR0ob1W3G9Nzw.Y9VTYryYZb3jQRYq9Z
 xRVji67Cp9tAjtU99d53XVaeV6aMDAjunDIEXsjVtld0Ttjn0UydI27QvVvsN7FkgVwnHd4S63cf
 LhSmSRgsKPektnGBkutXuCdF32RD4agvjWGJBkto1f0_gmdPSiww2S1Hsi146d1V44ndbL8SjthJ
 VKd6KAkRK5kkTHqhhC5ujPSJbGsUqr2kxgHAilPEqJBrI8EU3iMS4TdLUwWLChRPk0fpkaSj2LEU
 As8emUnY04vyC8.t4Arwh5.2WfjZj9DLWDtjNLvIwXA0MBFa6f8z.oGAm.t6G7GnF1vzeC6yPaC7
 jnv75BDosa1eQH.Wec1fieLp76xtx8OxDCtzJDyk.JQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 564e8e57-7da7-4a79-91b9-f92fb7869997
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Mon, 3 Apr 2023 18:28:30 +0000
Received: by hermes--production-bf1-5f9df5c5c4-5d8pl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 92c2ae3bf16770a144f8e095cee2aac8;
          Mon, 03 Apr 2023 18:28:25 +0000 (UTC)
Message-ID: <b94069c5-7b52-42ac-5072-180a01879894@schaufler-ca.com>
Date:   Mon, 3 Apr 2023 11:28:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
 <20230315224704.2672-5-casey@schaufler-ca.com>
 <b63f1957-d3d5-28f9-fd27-c0e629456a9f@digikod.net>
 <521dd15c-1dbb-77ed-0c97-0ea38688e219@schaufler-ca.com>
 <f8faa0c2-83aa-ddfa-5a4c-a4dc3c4c7ed9@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <f8faa0c2-83aa-ddfa-5a4c-a4dc3c4c7ed9@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/2023 11:04 AM, Mickaël Salaün wrote:
>
> On 03/04/2023 19:36, Casey Schaufler wrote:
>> On 4/3/2023 5:04 AM, Mickaël Salaün wrote:
>>>
>>> On 15/03/2023 23:46, Casey Schaufler wrote:
>>>> Create a system call lsm_get_self_attr() to provide the security
>>>> module maintained attributes of the current process.
>>>> Create a system call lsm_set_self_attr() to set a security
>>>> module maintained attribute of the current process.
>>>> Historically these attributes have been exposed to user space via
>>>> entries in procfs under /proc/self/attr.
>>>>
>>>> The attribute value is provided in a lsm_ctx structure. The structure
>>>> identifys the size of the attribute, and the attribute value. The
>>>> format
>>>> of the attribute value is defined by the security module. A flags
>>>> field
>>>> is included for LSM specific information. It is currently unused and
>>>> must
>>>> be 0. The total size of the data, including the lsm_ctx structure and
>>>> any
>>>> padding, is maintained as well.
>>>>
>>>> struct lsm_ctx {
>>>>           __u64   id;
>>>>           __u64   flags;
>>>>           __u64   len;
>>>>           __u64   ctx_len;
>>>>           __u8    ctx[];
>>>> };
>>>>
>>>> Two new LSM hooks are used to interface with the LSMs.
>>>> security_getselfattr() collects the lsm_ctx values from the
>>>> LSMs that support the hook, accounting for space requirements.
>>>> security_setselfattr() identifies which LSM the attribute is
>>>> intended for and passes it along.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>>>    Documentation/userspace-api/lsm.rst | 15 +++++
>>>>    include/linux/lsm_hook_defs.h       |  4 ++
>>>>    include/linux/lsm_hooks.h           |  9 +++
>>>>    include/linux/security.h            | 19 ++++++
>>>>    include/linux/syscalls.h            |  5 ++
>>>>    include/uapi/linux/lsm.h            | 33 ++++++++++
>>>>    kernel/sys_ni.c                     |  4 ++
>>>>    security/Makefile                   |  1 +
>>>>    security/lsm_syscalls.c             | 55 ++++++++++++++++
>>>>    security/security.c                 | 97
>>>> +++++++++++++++++++++++++++++
>>>>    10 files changed, 242 insertions(+)
>>>>    create mode 100644 security/lsm_syscalls.c
>>>
>>> [...]
>>>
>>>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>>>> new file mode 100644
>>>> index 000000000000..feee31600219
>>>> --- /dev/null
>>>> +++ b/security/lsm_syscalls.c
>>>> @@ -0,0 +1,55 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * System calls implementing the Linux Security Module API.
>>>> + *
>>>> + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
>>>> + *  Copyright (C) 2022 Intel Corporation
>>>> + */
>>>> +
>>>> +#include <asm/current.h>
>>>> +#include <linux/compiler_types.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/errno.h>
>>>> +#include <linux/security.h>
>>>> +#include <linux/stddef.h>
>>>> +#include <linux/syscalls.h>
>>>> +#include <linux/types.h>
>>>> +#include <linux/lsm_hooks.h>
>>>> +#include <uapi/linux/lsm.h>
>>>> +
>>>> +/**
>>>> + * sys_lsm_set_self_attr - Set current task's security module
>>>> attribute
>>>> + * @attr: which attribute to set
>>>> + * @ctx: the LSM contexts
>>>> + * @size: size of @ctx
>>>> + * @flags: reserved for future use
>>>> + *
>>>> + * Sets the calling task's LSM context. On success this function
>>>> + * returns 0. If the attribute specified cannot be set a negative
>>>> + * value indicating the reason for the error is returned.
>>>
>>> Do you think it is really worth it to implement syscalls that can get
>>> and set attributes to several LSMs at the same time, instead of one at
>>> a time?
>>
>> Setting the values for more than one LSM is impractical due to the
>> possibility
>> that the Nth value may fail, and unwinding the N-1 values may not be
>> possible.
>
> Indeed, so unless I missed something, why not passing the LSM ID as a
> syscall argument for lsm_set_self_attr() and lsm_get_self_attr(), and
> avoid managing a set of contexts but instead only managing one context
> at a time (to get or set)?

The LSM ID is already in the lsm_attr being passed. An additional argument
would be redundant and introduce a potential error when the two values don't
match.

>
>
>>
>>> LSM-specific tools don't care about other LSMs.
>>
>> That's part of the problem. Are systemd, dbusd, ps and id LSM
>> specific tools?
>> They shouldn't be.
>>
>>> I still think it would be much simpler (for kernel and user space) to
>>> pass an LSM ID to both syscalls. This would avoid dealing with
>>> variable arrays of variable element lengths, to both get or set
>>> attributes.
>>
>> ps and id should both work regardless of which and how many LSMs provide
>> context attributes. They shouldn't need to know which LSMs are active in
>> advance. If a new LSM is introduced, they shouldn't need to be
>> updated to
>> support it.
>
> I agree, and making the syscalls simpler doesn't change that.
>
>>
>>>
>>> Furthermore, considering the hypotetical LSM_ATTR_MAGICFD that was
>>> previously talked about, getting an unknown number of file descriptor
>>> doesn't look good neither.
>>
>> If you have multiple LSM_ATTR_MAGICFD values and can only get one at
>> a time you have to do something convoluted with flags to get them all.
>> I don't see that as a good thing.
>
> Yes, that was another argument to *not* deal with a set of contexts.

User space is going to have to deal with multiple values somehow,
either by fetching each possible value independently or by getting
them all at once in a set. Neither is pretty.

>
>>
>>>
>>>
>>>> + */
>>>> +SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct
>>>> lsm_ctx __user *,
>>>> +        ctx, size_t __user, size, u32, flags)
>>>> +{
>>>> +    return security_setselfattr(attr, ctx, size, flags);
>>>> +}
>>>> +
>>>> +/**
>>>> + * sys_lsm_get_self_attr - Return current task's security module
>>>> attributes
>>>> + * @attr: which attribute to set
>>>
>>> attribute to *get*
>>>
>>>> + * @ctx: the LSM contexts
>>>> + * @size: size of @ctx, updated on return
>>>
>>> I suggest to use a dedicated argument to read the allocated size, and
>>> another to write the actual/written size.
>>>
>>> This would not be required with an LSM ID passed to the syscall
>>> because attribute sizes should be known by user space, and there is no
>>> need to help them probe this information.
>>>
>>>
>>>> + * @flags: reserved for future use
>>>> + *
>>>> + * Returns the calling task's LSM contexts. On success this
>>>> + * function returns the number of @ctx array elements. This value
>>>> + * may be zero if there are no LSM contexts assigned. If @size is
>>>> + * insufficient to contain the return data -E2BIG is returned and
>>>> + * @size is set to the minimum required size.
>>>
>>> Doing something (updating a buffer) even when returning an error
>>> doesn't look right. These sizes should be well-known to user space and
>>> part of the ABI/UAPI.
>>
>> No. The size of attributes is not well known to user space.
>> They are usually text strings. The maximum size will be known,
>> but that's putting additional burden on user space to know
>> about all possible LSMs. It's not always necessary.
>
> Right, I forgot the strings stuff… The lsm_get_self_attr() syscall
> could then return a ctx_actual_size (as one argument), and a ctx
> pointer (as another argument). Similarly, the lsm_set_self_attr()
> syscall could use a dedicated argument for ctx_size and another for
> the ctx pointer.

That does not meet the design requirement. Paul wants a lsm_attr structure.
I'm not going to deviate from that.

>
>>
>>>
>>>
>>>> In all other cases
>>>> + * a negative value indicating the error is returned.
>>>> + */
>>>> +SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct
>>>> lsm_ctx __user *,
>>>> +        ctx, size_t __user *, size, u32, flags)
>>>> +{
>>>> +    return security_getselfattr(attr, ctx, size, flags);
>>>> +}
>>>> diff --git a/security/security.c b/security/security.c
>>>> index 87c8796c3c46..2c57fe28c4f7 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -2168,6 +2168,103 @@ void security_d_instantiate(struct dentry
>>>> *dentry, struct inode *inode)
>>>>    }
>>>>    EXPORT_SYMBOL(security_d_instantiate);
>>>>    +/**
>>>> + * security_getselfattr - Read an LSM attribute of the current
>>>> process.
>>>> + * @attr: which attribute to return
>>>> + * @ctx: the user-space destination for the information, or NULL
>>>> + * @size: the size of space available to receive the data
>>>> + * @flags: reserved for future use, must be 0
>>>> + *
>>>> + * Returns the number of attributes found on success, negative value
>>>> + * on error. @size is reset to the total size of the data.
>>>> + * If @size is insufficient to contain the data -E2BIG is returned.
>>>> + */
>>>> +int security_getselfattr(unsigned int __user attr, struct lsm_ctx
>>>> __user *ctx,
>>>> +             size_t __user *size, u32 __user flags)
>>>> +{
>>>> +    struct security_hook_list *hp;
>>>> +    void __user *base = (void *)ctx;
>>>> +    size_t total = 0;
>>>> +    size_t this;
>>>> +    size_t left;
>>>> +    bool istoobig = false;
>>>> +    int count = 0;
>>>> +    int rc;
>>>> +
>>>> +    if (attr == 0)
>>>> +        return -EINVAL;
>>>> +    if (flags != 0)
>>>> +        return -EINVAL;
>>>> +    if (size == NULL)
>>>> +        return -EINVAL;
>>>> +    if (get_user(left, size))
>>>> +        return -EFAULT;
>>>> +
>>>> +    hlist_for_each_entry(hp, &security_hook_heads.getselfattr,
>>>> list) {
>>>> +        this = left;
>>>> +        if (base)
>>>> +            ctx = (struct lsm_ctx __user *)(base + total);
>>>> +        rc = hp->hook.getselfattr(attr, ctx, &this, flags);
>>>> +        switch (rc) {
>>>> +        case -EOPNOTSUPP:
>>>> +            rc = 0;
>>>> +            continue;
>>>> +        case -E2BIG:
>>>> +            istoobig = true;
>>>> +            left = 0;
>>>> +            break;
>>>
>>> These two error cases could be directly handled by
>>> security_getselfattr() instead of relying on each LSM-specific
>>> implementations. See my suggestion on patch 7/11 (lsm_get_attr_size).
>>
>> Yes, they could. My understanding is that Paul wants the LSM layer
>> to be "thin". Where possible and not insane, the logic should be in
>> the LSM, not the infrastructure.
>
> FWIW, since we are defining new syscalls to make user space's life
> easier, I'm in favor of a well defined common behavior (e.g. returned
> errno) and factoring common code to make each LSM-specific code thin.

I appreciate the viewpoint. It's not what I understand the maintainer wants.

>
>>
>>>
>>>
>>>> +        case 0:
>>>> +            left -= this;
>>>> +            break;
>>>> +        default:
>>>> +            return rc;
>>>> +        }
>>>> +        total += this;
>>>> +        count++;
>>>> +    }
>>>> +    if (count == 0)
>>>> +        return LSM_RET_DEFAULT(getselfattr);
>>>> +    if (put_user(total, size))
>>>> +        return -EFAULT;
>>>> +    if (rc)
>>>> +        return rc;
>>>> +    if (istoobig)
>>>> +        return -E2BIG;
>>>> +    return count;
>>>> +}
>>>> +
>>>> +/**
>>>> + * security_setselfattr - Set an LSM attribute on the current
>>>> process.
>>>> + * @attr: which attribute to set
>>>> + * @ctx: the user-space source for the information
>>>> + * @size: the size of the data
>>>> + * @flags: reserved for future use, must be 0
>>>> + *
>>>> + * Set an LSM attribute for the current process. The LSM, attribute
>>>> + * and new value are included in @ctx.
>>>> + *
>>>> + * Returns 0 on success, an LSM specific value on failure.
>>>> + */
>>>> +int security_setselfattr(unsigned int __user attr, struct lsm_ctx
>>>> __user *ctx,
>>>> +             size_t __user size, u32 __user flags)
>>>> +{
>>>> +    struct security_hook_list *hp;
>>>> +    struct lsm_ctx lctx;
>>>> +
>>>> +    if (flags != 0)
>>>> +        return -EINVAL;
>>>> +    if (size < sizeof(*ctx))
>>>> +        return -EINVAL;
>>>> +    if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
>>>> +        return -EFAULT;
>>>> +
>>>> +    hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
>>>> +        if ((hp->lsmid->id) == lctx.id)
>>>> +            return hp->hook.setselfattr(attr, ctx, size, flags);
>>>> +
>>>> +    return LSM_RET_DEFAULT(setselfattr);
>>>> +}
>>>> +
>>>>    int security_getprocattr(struct task_struct *p, int lsmid, const
>>>> char *name,
>>>>                 char **value)
>>>>    {
