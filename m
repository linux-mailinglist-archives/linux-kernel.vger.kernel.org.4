Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE466B1938
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 03:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCICay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 21:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCICaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 21:30:52 -0500
Received: from sonic316-20.consmr.mail.bf2.yahoo.com (sonic316-20.consmr.mail.bf2.yahoo.com [74.6.130.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D45ECB04D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 18:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678329046; bh=7bmKf4KoblJV/eUS51BYsUlQmxR0NWXMEE13gnaun7c=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FhAd8L/v6uAmPpW2Vvk7KBUta6va5hz0ogAupB7iIYg4gmbgdiY3Hao9eVvmUOCZrGRLzRSP0UDQwL6o6usPdc9rUWf+5wPcUgCCNlVCmpz+/xQRamWVGyRIwPbC00+SbnSfDLa0lL4FW6N7XO0XFAr64wGS1ZbAoF9i2vKzyq3DsXOwJBRfXB9VfxrycmCOsLRZYgrZ+5IAVV3UehegJiEyaEEOmQ6wG5GfZK0dl+LATsZJyrVltvlPp6ve1iH6xAnXAC66y2pT0Wl1BNhRoSxQiWBHl2nbRUCzvyvYSSnG1wZFYXnTVmSe4/kycUOuhbj4ooUq/1fzN+u4vg2thg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678329046; bh=EBnUQtYM33aAPsARz8FsAAjFAK34qw+LxE0/Ev7lE3m=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Bc7nwFi4hcu6gfIVFV/Vo8UEmij2mffypBFwZxg9qcaFvPLPpsKf0f6rcMsIKU/OIlvP/FA/ifbYf3d30hz9EarWKJLwL71unYkLhj0xAy6lHHGhMXf8/Dok8G4UoHgJMW40TY4SwT8vkdRe5IsToqDKq0Pk4CCPiXpmdmykgwtsPK/IsVJI6tbS22xi51qoUABRsVk5Nq7Yzcg0ArIWW8uWrJQ4ZzqskpzBPVjfzHvuZhhJb1p2BocWusHKLWHg2pmUCJfcXg+gsa81pV13/ithGdHdTszuvedFbW91B5uwVVxNssuZF39IZSPwFaBQzbuI4po0rs8x8NXDhgPziw==
X-YMail-OSG: rFSiFhkVM1kBu5Iw13u1auQ76CXU78Jo.6U7FEbJ96ZOyOshRPtlaIzgmR2HzPK
 fiNWHl.osH0UAiBCzmKAFiemmba2Z29Y96hYVHSEpukctKmeHAw11QapGwRajiU0MXckUGhKUcVz
 c21u1.oU.TEaP2SZ.5J8x3.0xV75MXA3_A1bpWJnbq77wdvg6FG4Q7PqCA_uXHJAjhbMlB.0Hn4O
 snO8teq3MEjbPQa9d2NIQ2Qv6l5Jyqih.LMoG6Gqe9p6PcbGXqZ6c7YZP2Pfbab4ItbI5lVBdy6X
 Y.SnFELRp_jsqHvtxt.QCDN_gtb_YEVUeQP9CAZJz17TDU_FPnoP0oNil9yi4jV0_FaVITK2e8AI
 BzjrX7mS9UbXhQ9aGRh18i5itknl1FkeKJ4EK2Vnuym4r3.JWMgd50CfEsJVGgDe2TV9mJ74PCos
 nhn96xsil56DzUpiiQ7ieN4u8SekAKzUr3En4aGQ0Dqun3WqRSMurZAxYRUDGG2GJZU0fvOkIqQP
 CDBlAfO9ubCkf1N52zeJmL3CT_ahCOKH.jiHaFdFoXyn0BVT6k0h6qc9RRW.DzCaPgB8Va1RLOBg
 hSHvKnWyy35qMG6pRSu5nITJU8nelvBKcy0o6zYgWHyE2YF8ynkr9PUKPECUozI.wYhIaJpy5xSC
 OmMqNUHpzsfraabnTqIGYawb4rY.IqNFnTGdKOWLVXnS6zmdJvQflHQ.fZxu4ey2jAs_HSFJ9zu8
 1dRMST89m2ghhcx5LmLGTySnIIZlj6i9iG37tkaJR1Og9r8BGVWEuwPOn6UAZDBNNiX6r8dPKFMX
 H.69WDGfpv69WhZn1Ed5WjnjALtlLj33R.kayQqFwPZPu9AjZLGkTIo9qm0EDWto2M2.JgPukpKY
 6LAFlIFQktdBzNZo6TtZfQolph3_RKlgwKIxrOYPuyCarIMkjyynQ3buWMI.Yy3gtqE2C3shzjTc
 CEjGTyVnGfmK0FVutZbyZ64rZKjSbQTXxTOx1hABKffwa5ELniyJYDFpxhTxYunQ.lo1QsJvhyoD
 5.fb5I7SpXzKzqkaNdhdCATkqOn0Jf3bo8YNYoTfuNMOzMN4.KAsYsiSmWDybiIyY0ZrLZx3.w0Q
 nsOBfzDFSAYi9a3UeXhRIAZ.54MblZ4irgx5lDlTF6KywZuK8dbfn4kDUQO.eoFBnM8KxySmvgbU
 y4kAsvR_WtbHwru5nqWh5Ffj2Mf.NXj5r5WfOfdk1E9uTzswNIqGQ7uUhxl1ezmV3Lb_sWcSvSq.
 qtpy9e6Q0G17CUxRiznZ2s5IxicYeKdoaBSCvaVOvJFD7YGPhr6jEGXzwf7Sppmti2Wzw.ZuEQd4
 Sqg34fD.PjoicoK_7b2WJBSbDQ.CGLLukUZK31aBJib9KMV82McMIeNZcDkxmXBEjA0vZGjaQWvM
 9b8s45k9cTFE7ibmOM0VRPeJOIUzA.srOWuHmlrM9tDPZ7za6keA9g_OxF6rSw0PA52HEIUjV9pv
 TdXphfZKzxjStleXfwiZN0yixoLSOLopfprW7jw9kkYNbpledlydbFHyuxRuNtzRDp9H4gNE5U7t
 I_LcszBo6GoXqWPwbryINc_N8ShzT8ebWehGJngts_mhkHg_yBD6gg.ztt15Q_k72aE69ME3Rp_Z
 7irY_aoq2SGZLem4zKMz5tqXqVcFkou0oKa9MhObXFipntGsUulJGD0gmzDuwPpZMNZ.91Unkm1k
 HlHSVG.Gyu1p2nzRJC4URnD9tKKHXz33aEKNcm0grAprYpWyxlwQmK7nq4LRCOY308Hl1a7AZYo6
 jIMN5vh2SwiBFG7qrrze07JeRYnMB_V1Sq6sq2IMBzrEngmshi5PdYVyN_JxvnlawMHps.AXkPG5
 fwZ_E1XN2CtGXdGbRUXhl3iTNPdTcplM3PEHJP7ob9WwRiJorHBoTjyVVJWo4Q2YUoSurmdIf3RB
 tUEXwSe9NFVNNYqIVwHs29LGvDbpav4KtNBDIXXpvfVRze3f5LHtQwvG_5z44l9NqtG7WSae47Z.
 EdEH5pF21Zi8nlieS2mwkyOj.FrFyy8AdRLLyP7GW_b.gaiyRJw46R2BWlSb93j9Aq_To6Qf1gGj
 PTgSd9y_vYRCHWnD4cCD6mHn55ARtRolL0prNjXvWKp7hFX6eFxZ0yuM5af0WEmTUgIcGjBiKHMG
 4.K9MozSDgRmw8SJ27mS_0u_5r85wYNyYHkEKWBa6O1jCzFiXSEKGyXvFj4J2YHNwfCny6vsW8Im
 NnoNXjw59EE1P6TmSirSroKc4EZA_6yXMMR7cO.v6Ejym5MqDeNb6mT8jzFzmY_k2fkeoGw0QDQA
 WJifR8PUppZ4-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Mar 2023 02:30:46 +0000
Received: by hermes--production-ne1-759c9b8c64-zjkt7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2b96ab4653459fde164fcf70345808a2;
          Thu, 09 Mar 2023 02:30:40 +0000 (UTC)
Message-ID: <a504f6e7-9c67-461c-6e0e-ae6d50623613@schaufler-ca.com>
Date:   Wed, 8 Mar 2023 18:30:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 04/11] LSM: syscalls for current process attributes
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, casey@schaufler-ca.com
References: <20230222200838.8149-1-casey@schaufler-ca.com>
 <20230222200838.8149-5-casey@schaufler-ca.com>
 <405ff748-dea0-794b-fa58-18b0a4703587@digikod.net>
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <405ff748-dea0-794b-fa58-18b0a4703587@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/2023 3:51 AM, Mickaël Salaün wrote:
>
> On 22/02/2023 21:08, Casey Schaufler wrote:
>> Create a system call lsm_get_self_attr() to provide the security
>> module maintained attributes of the current process.
>> Create a system call lsm_set_self_attr() to set a security
>> module maintained attribute of the current process.
>> Historically these attributes have been exposed to user space via
>> entries in procfs under /proc/self/attr.
>>
>> The attribute value is provided in a lsm_ctx structure. The structure
>> identifys the size of the attribute, and the attribute value. The format
>> of the attribute value is defined by the security module. A flags field
>> is included for LSM specific information. It is currently unused and
>> must
>> be 0. The total size of the data, including the lsm_ctx structure and
>> any
>> padding, is maintained as well.
>>
>> struct lsm_ctx {
>>          __u64   id;
>>          __u64   flags;
>>          __u64   len;
>>          __u64   ctx_len;
>>          __u8    ctx[];
>> };
>>
>> Two new LSM hooks are used to interface with the LSMs.
>> security_getselfattr() collects the lsm_ctx values from the
>> LSMs that support the hook, accounting for space requirements.
>> security_setselfattr() identifies which LSM the attribute is
>> intended for and passes it along.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   Documentation/userspace-api/lsm.rst |  15 ++++
>>   include/linux/lsm_hook_defs.h       |   4 ++
>>   include/linux/lsm_hooks.h           |   9 +++
>>   include/linux/security.h            |  19 +++++
>>   include/linux/syscalls.h            |   4 ++
>>   include/uapi/linux/lsm.h            |  33 +++++++++
>>   kernel/sys_ni.c                     |   4 ++
>>   security/Makefile                   |   1 +
>>   security/lsm_syscalls.c             | 104 ++++++++++++++++++++++++++++
>>   security/security.c                 |  82 ++++++++++++++++++++++
>>   10 files changed, 275 insertions(+)
>>   create mode 100644 security/lsm_syscalls.c
>>
>
> [...]
>
>> +/**
>> + * security_setselfattr - Set an LSM attribute on the current process.
>> + * @attr: which attribute to return
>> + * @ctx: the user-space source for the information
>> + * @size: the size of the data
>> + *
>> + * Set an LSM attribute for the current process. The LSM, attribute
>> + * and new value are included in @ctx.
>> + *
>> + * Returns 0 on seccess, an LSM specific value on failure.
>> + */
>> +int security_setselfattr(u64 __user attr, struct lsm_ctx __user *ctx,
>> +             size_t __user size)
>> +{
>> +    struct security_hook_list *hp;
>> +    struct lsm_ctx lctx;
>> +
>> +    if (size < sizeof(*ctx))
>
> If the lsm_ctx struct could grow in the future, we should check the
> size of the struct to the last field for compatibility reasons, see
> Landlock's copy_min_struct_from_user().

Because the lsm_ctx structure ends with the variable length context there's
no way to append new fields to it. The structure can't grow.

>
>
>> +        return -EINVAL;
>> +    if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
>> +        return -EFAULT;
>> +
>> +    hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
>> +        if ((hp->lsmid->id) == lctx.id)
>> +            return hp->hook.setselfattr(attr, ctx, size);
>> +
>> +    return LSM_RET_DEFAULT(setselfattr);
>> +}
>> +
>>   int security_getprocattr(struct task_struct *p, int lsmid, const
>> char *name,
>>                char **value)
>>   {
