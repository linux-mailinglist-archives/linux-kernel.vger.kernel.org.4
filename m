Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3F86D4F29
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjDCRh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjDCRhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:37:08 -0400
Received: from sonic314-21.consmr.mail.bf2.yahoo.com (sonic314-21.consmr.mail.bf2.yahoo.com [74.6.132.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D833599
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680543403; bh=jUw7cgJb1t34GGb5HW2jKTUIwhaGucsNMMbmcKn1mw4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=oeIw0Lpm2a5u4i8KhdqpfG4bC3PScVGtzfuDlgR7FF9DpQoee6xhu2qkwTnUtrf5s/e5LAWRCAQtysJb+/6SDRwFtXjlV9OYXBLXGnndND2bq1oPeuRKTRbCX4LwJwzbNGjLwUHBXyVSdHF68VczdrqdaVuuyn51OCQs/AkWMkE97jV8lXEBTnjF3XDOB86RLNrvckS558eq5zx6T1t1/RaOO2VqGkDhqaiABUdzqiPldM6EeevMQMu5/c4OcaUQPuCm4YvFDCBVR7H5C6xG93NcD3E4j0nE3Z3+IvjlKavkXBIayycpdVFYDWEpW5g26tlSdCGjgwwh7jvLmY42Ew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680543403; bh=5mpQeCfvyBAGnkGX7En3LzVoJOwW7y/9eIGiVcLK4yq=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=edv4uXjJBvv3WPoyPgMdgfsmVaiCiKM49fCppkRt1dBfgJ9g1+geesVThKleaX+UfrDBSaH/kPrXkbnXhwvbEiZVFAYUPJU2LEnCfSWOz1tm5ziL2pMlvcQ7hT1zBSVjeNDSK4JhiRkui86kNIHkFd6fvB5AEdNMv5zhR0aw8Aki/566OMdZZi25TlxZ/62L44AflxZEx3WupwdVKyF5GLFzOE0W8sh9wG9C3kHDKK6sQqCJrDB2Tpp9m/07CnFHfERYP73IUJcL7f37J7UjpuffuF9LB15Ujm9hG7thftysqx2sVNxA6i1UCGnhS364B+uiGupuxGD+x+gJSOGTHA==
X-YMail-OSG: 8rfwy3oVM1msp9TwMUbDlnjBoHDZvlOXQ0MLPVLDCMlVFDxVkmV6h4wux7BVxtI
 SF1a_pijIlFBRy5AqYkP9EcztPKSZZKoER9OrFzkdUJw1J_FhsYwAycv6_QMVgJQhgb95tRaw_DX
 Ag9vw7wDAxpJuraoXQl8oIs7YpAFF5Uk6tYNp7k2KP3NCvaIdMIpSXBbQb3B_DPK7v7TLwU6kPc5
 7CN9AWW6UhUxGOyPAYcd3GPBK141VQqyALVyjlgBwwb_nzrfDgiK2hNgZVMpPP5o10Vl8HYQNCwq
 Xm34hw81zDjT85YVHBgB1V7SGBB.hURQu_PCXQPajltbLYXFQ2YIL9DG7xmxaVaMQPJ8X8Eos37w
 0OSKTmD85QUbC8nbNDzehOW1aTfDCUDpzBJhubZIiMHJUBrv9pLkRerxuHISmAQxx5MqS9pZJ1_r
 MSGtHgk1bA8WIoo7pLLc2S4OB1YrSrzn_AkDa6aj0HR2LlBKPKcr6umMtEbhDqwOceBbDK1T5Dwa
 U20RLZHXMvf.ceQZzhSFR52WMFRgEazConpgK7cqxPYV2u1oGWk2VonOvWjyotWynZ9sWX7M5Te_
 uBQs3hQnG.jv0QB24MaVOu_q7DPdx3bKZoN1aU34DMY4g7u62_6qd4obmgWjXVcPAZ38k6AKdxhu
 XWPyX2uVGkwGOke1o_.DCmS56YBHTFJRRzhG4FWk5kqWPWrzqcix8NR4z5Fug24sfH7lNnfLaPpe
 OQdjI3ni9TXJ7VSdkkI0uMCZf8XlqybtZm0oeXtnFpzeFa7xQu.WOxCxGZdPhtMY0fheibDhMMQp
 hxaMUoc03Hj0.KjP1_FVYtWsW6xwb1jTQK18aBWnjE7XdGn4Exk1Psco022uYfk1LIxzkKXzrIRh
 KIgyjBt16zmnaq5FtHUbv.0BobtXhU2glD64HxXL1lpudnbSIlRkjUPcq4J7lG3ddOSoeaPCRfew
 cMUNPRyExHIygpT9erWzP8QjlLAuUsilFGVj.239SKyOs1EhC9s3Swob97JYkc9aBZ.pHB4BoGs5
 p3z7vmRCvlHSrfs0k2A84DvNAue5bfj4NfauMgLViV0FHIVgZkShtS3aorikIhA7CtmmG.onKD6a
 JGc5ZjpjduOvtU3zmk5choQ3ky1OVJCqZwAA9xP3PLudKikIoLrngDe18edFRFSo_xWZVcr8hSOd
 GmIIeagI1Zx6P5tyWPUTI1yr6RF1TUzkAwfvWd.71XqNew_nFIMudCAaSV9sSJ8z9TbNtN0rVb.Q
 nCmfjGykeym_SUagS4LJ1EhqYvnfBFh2P5Bi9R2k3FR_I4kMbOGAyt6qsjnFOu1IUlAOd2ppMOO.
 pJv5NI7bCRRfrL0J7WGj.MEM6WkXRRE7wL5XxQQxt78Pa2fNL8bA0ERLXoHQi9k0iWCp63fDSuZ3
 njuqPfLa7k7YPmaos_rACOCmj_bYeavUElxfGLEVXflzhAKf51Qt1.fcitIHCatbak3_doQU7e3C
 QmucFYFgV_JbZ8TGunnIx31FbyXvgsCjpVFczdCOJdRPJoOtbh7yG5sOlPuh2QGbLBwf3OgeLeTA
 CI8t7OSE86pI_VJHqzaT4eiZ29wEP7Ra8olArL97umfbDChUFxiE4Yx1BaSrQkZCbVjH9nsB5x.c
 kp.hAgPHIpel94PzCR2i_t_ALNollwO8btFVX5X_bLLJ4ZuQa5Cz1WSkcICm43jMFVvt6bvYyLMy
 xKkk4lDb.jajGWKOmk2SudDwWtfxI9oyOtpCiP8V8CbbPcto.Vjr_.oeV9iL_ttl0_opW.dIVCWM
 qiKUUiGgeiDv1Y0PgcudibjzLC2xp0uIfuTF8QUcBah7.PJaL02E6WxaNhNkZEqOdcyOwOat3RY2
 vOgLh1p7qjUKcZqxk10qDgYpel0VpySt_1e_7lxlrcbJ38mOcMDbTt77ozNI7VRzl3b2.J3vOOtN
 Q_bmOKln58izzIiaeN.2VcgJgTTVR4RSsZo4WjkJ9gV9P1oj2VukiCqh93TnwpYpurpZeJO_6Y69
 o1xt.aibOKqTQ.tEXTkd.dv89SzG0wrNzNseRabAVDOECZyhgimoW6Vq1G048oirqAR2cgoVSVyR
 bCjgsAt6o5jzB1vIJ1mj_dD4foo_4izoNGa71aHMKLtMhHdqRvTXb9_L.Pt_g89rnUL01BOF4hOb
 Q7MpWhLSJuplNk4g0ABkyB_M9grXMYCImREHhNvrT6B2zkGY8IKIInov1hwpwQR3ThGgyAD_N8Ps
 NDHKMwoBroRD.NlnGlZlxUelYnNHB.d930D64MRoq059SDGsAaWZetz43FEX6J4flqKZbdorNfDu
 j.EM0DpN6lGgCXQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c1981522-0e19-4533-9367-9142779f1914
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Mon, 3 Apr 2023 17:36:43 +0000
Received: by hermes--production-bf1-5f9df5c5c4-qlh82 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 51f0091f82ce05ee470d8585cdb6d285;
          Mon, 03 Apr 2023 17:36:37 +0000 (UTC)
Message-ID: <521dd15c-1dbb-77ed-0c97-0ea38688e219@schaufler-ca.com>
Date:   Mon, 3 Apr 2023 10:36:35 -0700
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <b63f1957-d3d5-28f9-fd27-c0e629456a9f@digikod.net>
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

On 4/3/2023 5:04 AM, Mickaël Salaün wrote:
>
> On 15/03/2023 23:46, Casey Schaufler wrote:
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
>>   Documentation/userspace-api/lsm.rst | 15 +++++
>>   include/linux/lsm_hook_defs.h       |  4 ++
>>   include/linux/lsm_hooks.h           |  9 +++
>>   include/linux/security.h            | 19 ++++++
>>   include/linux/syscalls.h            |  5 ++
>>   include/uapi/linux/lsm.h            | 33 ++++++++++
>>   kernel/sys_ni.c                     |  4 ++
>>   security/Makefile                   |  1 +
>>   security/lsm_syscalls.c             | 55 ++++++++++++++++
>>   security/security.c                 | 97 +++++++++++++++++++++++++++++
>>   10 files changed, 242 insertions(+)
>>   create mode 100644 security/lsm_syscalls.c
>
> [...]
>
>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>> new file mode 100644
>> index 000000000000..feee31600219
>> --- /dev/null
>> +++ b/security/lsm_syscalls.c
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * System calls implementing the Linux Security Module API.
>> + *
>> + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
>> + *  Copyright (C) 2022 Intel Corporation
>> + */
>> +
>> +#include <asm/current.h>
>> +#include <linux/compiler_types.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/security.h>
>> +#include <linux/stddef.h>
>> +#include <linux/syscalls.h>
>> +#include <linux/types.h>
>> +#include <linux/lsm_hooks.h>
>> +#include <uapi/linux/lsm.h>
>> +
>> +/**
>> + * sys_lsm_set_self_attr - Set current task's security module attribute
>> + * @attr: which attribute to set
>> + * @ctx: the LSM contexts
>> + * @size: size of @ctx
>> + * @flags: reserved for future use
>> + *
>> + * Sets the calling task's LSM context. On success this function
>> + * returns 0. If the attribute specified cannot be set a negative
>> + * value indicating the reason for the error is returned.
>
> Do you think it is really worth it to implement syscalls that can get
> and set attributes to several LSMs at the same time, instead of one at
> a time? 

Setting the values for more than one LSM is impractical due to the possibility
that the Nth value may fail, and unwinding the N-1 values may not be possible.

> LSM-specific tools don't care about other LSMs.

That's part of the problem. Are systemd, dbusd, ps and id LSM specific tools?
They shouldn't be.

> I still think it would be much simpler (for kernel and user space) to
> pass an LSM ID to both syscalls. This would avoid dealing with
> variable arrays of variable element lengths, to both get or set
> attributes.

ps and id should both work regardless of which and how many LSMs provide
context attributes. They shouldn't need to know which LSMs are active in
advance. If a new LSM is introduced, they shouldn't need to be updated to
support it.

>
> Furthermore, considering the hypotetical LSM_ATTR_MAGICFD that was
> previously talked about, getting an unknown number of file descriptor
> doesn't look good neither.

If you have multiple LSM_ATTR_MAGICFD values and can only get one at
a time you have to do something convoluted with flags to get them all.
I don't see that as a good thing.

>
>
>> + */
>> +SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct
>> lsm_ctx __user *,
>> +        ctx, size_t __user, size, u32, flags)
>> +{
>> +    return security_setselfattr(attr, ctx, size, flags);
>> +}
>> +
>> +/**
>> + * sys_lsm_get_self_attr - Return current task's security module
>> attributes
>> + * @attr: which attribute to set
>
> attribute to *get*
>
>> + * @ctx: the LSM contexts
>> + * @size: size of @ctx, updated on return
>
> I suggest to use a dedicated argument to read the allocated size, and
> another to write the actual/written size.
>
> This would not be required with an LSM ID passed to the syscall
> because attribute sizes should be known by user space, and there is no
> need to help them probe this information.
>
>
>> + * @flags: reserved for future use
>> + *
>> + * Returns the calling task's LSM contexts. On success this
>> + * function returns the number of @ctx array elements. This value
>> + * may be zero if there are no LSM contexts assigned. If @size is
>> + * insufficient to contain the return data -E2BIG is returned and
>> + * @size is set to the minimum required size.
>
> Doing something (updating a buffer) even when returning an error
> doesn't look right. These sizes should be well-known to user space and
> part of the ABI/UAPI.

No. The size of attributes is not well known to user space.
They are usually text strings. The maximum size will be known,
but that's putting additional burden on user space to know
about all possible LSMs. It's not always necessary.

>
>
>> In all other cases
>> + * a negative value indicating the error is returned.
>> + */
>> +SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct
>> lsm_ctx __user *,
>> +        ctx, size_t __user *, size, u32, flags)
>> +{
>> +    return security_getselfattr(attr, ctx, size, flags);
>> +}
>> diff --git a/security/security.c b/security/security.c
>> index 87c8796c3c46..2c57fe28c4f7 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2168,6 +2168,103 @@ void security_d_instantiate(struct dentry
>> *dentry, struct inode *inode)
>>   }
>>   EXPORT_SYMBOL(security_d_instantiate);
>>   +/**
>> + * security_getselfattr - Read an LSM attribute of the current process.
>> + * @attr: which attribute to return
>> + * @ctx: the user-space destination for the information, or NULL
>> + * @size: the size of space available to receive the data
>> + * @flags: reserved for future use, must be 0
>> + *
>> + * Returns the number of attributes found on success, negative value
>> + * on error. @size is reset to the total size of the data.
>> + * If @size is insufficient to contain the data -E2BIG is returned.
>> + */
>> +int security_getselfattr(unsigned int __user attr, struct lsm_ctx
>> __user *ctx,
>> +             size_t __user *size, u32 __user flags)
>> +{
>> +    struct security_hook_list *hp;
>> +    void __user *base = (void *)ctx;
>> +    size_t total = 0;
>> +    size_t this;
>> +    size_t left;
>> +    bool istoobig = false;
>> +    int count = 0;
>> +    int rc;
>> +
>> +    if (attr == 0)
>> +        return -EINVAL;
>> +    if (flags != 0)
>> +        return -EINVAL;
>> +    if (size == NULL)
>> +        return -EINVAL;
>> +    if (get_user(left, size))
>> +        return -EFAULT;
>> +
>> +    hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
>> +        this = left;
>> +        if (base)
>> +            ctx = (struct lsm_ctx __user *)(base + total);
>> +        rc = hp->hook.getselfattr(attr, ctx, &this, flags);
>> +        switch (rc) {
>> +        case -EOPNOTSUPP:
>> +            rc = 0;
>> +            continue;
>> +        case -E2BIG:
>> +            istoobig = true;
>> +            left = 0;
>> +            break;
>
> These two error cases could be directly handled by
> security_getselfattr() instead of relying on each LSM-specific
> implementations. See my suggestion on patch 7/11 (lsm_get_attr_size).

Yes, they could. My understanding is that Paul wants the LSM layer
to be "thin". Where possible and not insane, the logic should be in
the LSM, not the infrastructure.

>
>
>> +        case 0:
>> +            left -= this;
>> +            break;
>> +        default:
>> +            return rc;
>> +        }
>> +        total += this;
>> +        count++;
>> +    }
>> +    if (count == 0)
>> +        return LSM_RET_DEFAULT(getselfattr);
>> +    if (put_user(total, size))
>> +        return -EFAULT;
>> +    if (rc)
>> +        return rc;
>> +    if (istoobig)
>> +        return -E2BIG;
>> +    return count;
>> +}
>> +
>> +/**
>> + * security_setselfattr - Set an LSM attribute on the current process.
>> + * @attr: which attribute to set
>> + * @ctx: the user-space source for the information
>> + * @size: the size of the data
>> + * @flags: reserved for future use, must be 0
>> + *
>> + * Set an LSM attribute for the current process. The LSM, attribute
>> + * and new value are included in @ctx.
>> + *
>> + * Returns 0 on success, an LSM specific value on failure.
>> + */
>> +int security_setselfattr(unsigned int __user attr, struct lsm_ctx
>> __user *ctx,
>> +             size_t __user size, u32 __user flags)
>> +{
>> +    struct security_hook_list *hp;
>> +    struct lsm_ctx lctx;
>> +
>> +    if (flags != 0)
>> +        return -EINVAL;
>> +    if (size < sizeof(*ctx))
>> +        return -EINVAL;
>> +    if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
>> +        return -EFAULT;
>> +
>> +    hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
>> +        if ((hp->lsmid->id) == lctx.id)
>> +            return hp->hook.setselfattr(attr, ctx, size, flags);
>> +
>> +    return LSM_RET_DEFAULT(setselfattr);
>> +}
>> +
>>   int security_getprocattr(struct task_struct *p, int lsmid, const
>> char *name,
>>                char **value)
>>   {
