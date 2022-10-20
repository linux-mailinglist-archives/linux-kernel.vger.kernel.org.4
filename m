Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B404E606984
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJTU2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTU2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:28:18 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109B41A8532
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666297695; bh=+tyY5sZrXLwAhCdaSbNTlOcUin0w9IxudybQ+MEuOE0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bAh/2ZfQ/JzxQvQFfDCohw6muAxgDXSoXrMs9nsImFUoYQQDXOeQR0dGs524ce9H3B5hwO9tQWmwoZGqg7+M/Be7rH7CHWon5QsVkSYyNzHeYw+MBG78I8QkeLIm9Pt+CvHOHdZHPl8DtOH9x2fFOgVD1PS/cmtciGPspVdzMzhztMri9XORDmEYzgQ05+UI0vQb0OmvfWCYDGlMQY0VFy6XJRxl+1hhQD+rUKOjT+gp6xu9rNlbkNDJIZUp6Gv4Czx5n9HPJKq5gXa7D3bCtP/LDjdfTo52qzo0dZ7vQRSFmEt2IIY6LgX3lc4ggICI5Ustwach9m9PUx+4yX9a0g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666297695; bh=ZxaXy+bDElOXIXiZeJk5uYN44O5wk4r33IPu+efq0Sz=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tsrI8bTL5iaFMIQEYVcJSPFSWO2aik2EklegxNHdEtatpHGbrMlk/VcX3O9Qg7eyCrDqn4Iqa7xkqaNUdfNW7T86gQx1zkcj0s4EWZvUYS/1pV1yjGkyDpl3/qE01Pu/+0/fZOF9a/HL/udtzGEJ8oJU9CbNIIMLHCMkeIQavWM9/r17PL5121ZtreDyDzhIa1GeUpcqRGEiLx9qoEsXqFOWUOLpKxrZx9EE22/ZgPHUaKxLK67FF8itUvIrRUUij/9gbwba7CFN0rRmE4lCOK3G1y4LcLi91TMNJxOvwDQH+VAlnwVgS+R4YtICbweR+grHgvYE+MYEWBX5UT63pg==
X-YMail-OSG: eM73XZgVM1l2c9nCXchAix.KRYTdqgGU4T4z1DJI0cmRTlXZTZ0SHBkevR6cPlI
 RCCbB.3QhxQH7eafm.nUzAqG8s1N36twLYSSmGxtRMEP2QzDOUegBcY2g1JEi9dxxy7.heeyGmaq
 iuxap53pt.2rLEFmYF5ad8fI2exV_aoVAbLNAUHnem7VJn.BdjB8BMSdDEQUrEWDZR5faaPnqwlI
 jEPt8Xc8Q8E9JOo_UPrjdzLX6vJK5HIwgWjo_iSU5M4AJI018TwLNJDJnVC1r.kqm7X1r74DJcwU
 BT776hJGk.IwHWOEDJLbl0wOifwUpD1TD.FbuJjD1QK6L6u0iThaRfUkLr9V2oUyqrEWWicnRPkR
 Q_o92EE4YoTDN0kIVt5wynBDy0QxYlk516CBpOmtknOpq5qkwwYzhgMAAuB6iT19Jh6a8tSLOVb4
 HY_sAq1YbulQQ.oT9llfsoN01KT3cUJig_d5mWI4PtvXCVgmodvqYsMbnYK1wLh1g323d3hs2s.P
 L.7C_lj_ZBNUcInrQJsdrgCf.NvpIEhysjlWQO9uQmx_1BTj6K9LNOWzoKm4COies9virLpiv35F
 wttGnWE2e7vziL_LYky.mDB2APHwKYWAfJYg.xdyJzS4.6nYK9hJvCKjYPPjVcUWUrTpZKxxn7Nq
 feCT33REuAzLgTuh00XSOGIqDMHrcX72Ye09yrY0kN5pESgdOr_Y3N1gDIMe0jXx2srJhe6_IRNJ
 OEph3GijC23DMuZpn0xHMIZ5rO6Van806TBUJ.OVXCxdYa3zj9Nhtu0r0teAKTOpCvN7uaGzSo_5
 imelI_1LnOY0x10db._xqhHmZJ11NhuAEfXY5jSzWBHq_DlbSU5vGG9CfaJ2MMNyytVijXotbEzF
 4.2DgdhvSmgLy1jMHUFPaLBx_gejs44nu0ILnLDiUYO.XOl_jEz_FC5xFcLbZEgU4w1heKKaoA6.
 WQ9LOwxpAP6qsdbcREEp9mOFMQALRtDll8FKU9l6fK_lAQAVR9C_2rZhnOb6K6j3zInfJrqo8ip9
 M36U0wee0_gPFI3OBuM9v0OQtmDLL.LN6nyl.Ju88BmgqMy_USoksW.CvqHKRb_Lbd86VvHCIgf.
 JyghAt3K6CF5KoeYn2JXdUkk.HIIDm9pFQ9ZY6XWDtu5dhY032NajS57CeFjXNSlBWBZmR5cvk3B
 XkpfFu4EpgdWFMElZflwpcj2l8a7imZLTNWHOEEpGWZdXE_bAhZkrbpDqpvSxh.H7EtJ7G8Lrtyq
 9kJjZVS11ovvS5Hg3Am8PKY7ztEJzBK4j0F3tGIrGtBXzHriAIPykA0aJV.lLPGiwvvuDZBttsd5
 hY6EBn9zD1W2vrEg81vAv3SGRqBqfCUx3IWe0acpftVBz4nhUoVTUplBBk8jVDJdUog4Js_ZFUJH
 B0nv3tFIDJ7wLiSQx9cFyhNPtppxmu4QinZGUNWZHflj9fM2R3AN7Ugw5sqO3AgDfDTr1fIxTNgn
 DGci03IfQJr0BEJIVc4QlOw2Ohim7knZ1ZIsD16_nns7uc8EDArgCmsln64QLUBywKTI4Ku4vNdj
 yhSkFfdYgXSLe8nz0XOOeLRmtxju9GvkPmMKXsvqlzg0wlwINw0hoGzeQ1hoW0Bih9yvMLRyWMty
 6YTWvPTJGNpgQaZDSMHik598XLYF0EF06afxIORHnPL1_CZghGVp.yirmzMzzcUWV7odlGU4ngMC
 9y_LjL0H8uz7lIMHwP_ZKy.czMl9n3YQpGoOYrbFrQBFpRVoA7qehFpXAA8v73SFR4VNJa3ctHrY
 p2XzGKCccXdwbevXb8xC0OWX5HsG2xlAAvsAYBTzY1l6sihk4nA4A1Q7xTtd6WdUlNCpf3U0qEwz
 xSdpkucFMw7zn_Z7UiDNFTIzit6zN6sLdrc1m0XOLsX.SU2jLG3rtaFfzEZ5nmWTOrivA5KJE6Su
 LJENWNqWJICfy7bTDURYldYqcErYOVNRZv4hxobyKvMe72rSAbDfy3hi5KnhQVy_jdeUq7d2Ni7Y
 nWMt9cx6FWXufUsFV9yjrOSqY2MQiH4qPGQlzb8pY0dXvzNpwgjE5.5ndafAyW2_SCaGplU7ecvd
 81SLeBKPa6xUAcexn.bLrnKariljAI.dHO.g9BnF9v.bAfe_ECayt25.hbYfGyxZ53yiOpilmwR8
 9CpsuBZt7be2fl1LCLR7aS8HuXS1EHUORfXWVsJf7pSVYJcr.jnrBShqP3xCF3Q5ilq8ZqeVgVlt
 FKob6s.ITPKyN1V99a_dzRBwzladkSSN.GqCBxLh0MPOZsE8h.xw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Oct 2022 20:28:15 +0000
Received: by hermes--production-gq1-754cb59848-xxkcq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cbca692a7390198ae42fc445457227f9;
          Thu, 20 Oct 2022 20:28:09 +0000 (UTC)
Message-ID: <ebbfa551-c4fd-cc9f-c66f-682ba3a7ba14@schaufler-ca.com>
Date:   Thu, 20 Oct 2022 13:28:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v38 39/39] LSM: Create lsm_module_list system call
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, casey@schaufler-ca.com
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927203155.15060-1-casey@schaufler-ca.com>
 <13ab134b-e7a9-fe3f-a05a-7cece1d52403@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <13ab134b-e7a9-fe3f-a05a-7cece1d52403@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2022 2:19 PM, Mickaël Salaün wrote:
>
> On 27/09/2022 22:31, Casey Schaufler wrote:
>> Create a system call to report the list of Linux Security Modules
>> that are active on the system. The list is provided as an array
>> of LSM ID numbers.
>
> With lsm_self_attr(), this would look like a dir/file structure.

I'm not sure I understand what you mean by this. I think you're suggesting
that lsm_module_list() shows the list of possibilities and lsm_self_attr()
shows the data. That's roughly correct. Note that many security modules
will never provide any data in lsm_self_attr(), and that others will
only provide it when it has been explicitly set. 

>
> Would it be useful for user space to list all the currently used LSMs
> instead of only retrieving information about a known (list of) LSM?

I believe so. User space tends to lag behind kernel features. ps(1) can report
the "current" value for any LSM without knowing which module supplied the value
today by using the /proc/self/attr/current interface. id(1) could do the same
were it not unnecessarily coded to be SELinux specific. lsm_module_list(2), like
the existing /sys/kernel/security/lsm interface, allows an application to know
if it should address the modules it knows about. It also provides the LSM order,
which could be significant to systemd, dbus, auditd or other sophisticated system
services.


> What is the use case for this syscall?

1. Identify if a specific LSM is in the list.
	Used by ps(1) to format the -Z output correctly
	Used by systemd(1) to determine which service start options to support
	Used by dbus to identify what policy to enforce at runtime
2. Identify the order of LSMs in the list.
	Will AppArmor data show up in /proc/self/attr/current, or will Smack data?

>
>
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>>   include/linux/syscalls.h               |  1 +
>>   include/uapi/asm-generic/unistd.h      |  5 ++-
>>   kernel/sys_ni.c                        |  1 +
>>   security/lsm_syscalls.c                | 50 ++++++++++++++++++++++++++
>>   5 files changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl
>> b/arch/x86/entry/syscalls/syscall_64.tbl
>> index 56d5c5202fd0..40b35e7069a7 100644
>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>> @@ -373,6 +373,7 @@
>>   449    common    futex_waitv        sys_futex_waitv
>>   450    common    set_mempolicy_home_node   
>> sys_set_mempolicy_home_node
>>   451    common    lsm_self_attr        sys_lsm_self_attr
>> +452    common    lsm_module_list        sys_lsm_module_list
>
> As for the other syscall, this should also be in the same dedicated
> "wire syscalls" patch.
>
>
>>     #
>>   # Due to a historical design error, certain syscalls are numbered
>> differently
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index 7f87ef8be546..e2e2a9e93e8c 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -1057,6 +1057,7 @@ asmlinkage long
>> sys_set_mempolicy_home_node(unsigned long start, unsigned long l
>>                           unsigned long home_node,
>>                           unsigned long flags);
>>   asmlinkage long sys_lsm_self_attr(struct lsm_ctx *ctx, size_t
>> *size, int flags);
>> +asmlinkage long sys_lsm_module_list(unsigned int *ids, size_t *size,
>> int flags);
>>     /*
>>    * Architecture-specific system calls
>> diff --git a/include/uapi/asm-generic/unistd.h
>> b/include/uapi/asm-generic/unistd.h
>> index aa66718e1b48..090617a9a53a 100644
>> --- a/include/uapi/asm-generic/unistd.h
>> +++ b/include/uapi/asm-generic/unistd.h
>> @@ -889,8 +889,11 @@ __SYSCALL(__NR_set_mempolicy_home_node,
>> sys_set_mempolicy_home_node)
>>   #define __NR_lsm_self_attr 451
>>   __SYSCALL(__NR_lsm_self_attr, sys_lsm_self_attr)
>>   +#define __NR_lsm_module_list 452
>> +__SYSCALL(__NR_lsm_module_list, sys_lsm_module_list)
>> +
>>   #undef __NR_syscalls
>> -#define __NR_syscalls 452
>> +#define __NR_syscalls 453
>
> Same here.
>
>
>>     /*
>>    * 32 bit systems traditionally used different
>> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
>> index 0fdb0341251d..bde9e74a3473 100644
>> --- a/kernel/sys_ni.c
>> +++ b/kernel/sys_ni.c
>> @@ -264,6 +264,7 @@ COND_SYSCALL(mremap);
>>     /* security/lsm_syscalls.c */
>>   COND_SYSCALL(lsm_self_attr);
>> +COND_SYSCALL(lsm_module_list);
>>     /* security/keys/keyctl.c */
>>   COND_SYSCALL(add_key);
>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>> index da0fab7065e2..41d9ef945ede 100644
>> --- a/security/lsm_syscalls.c
>> +++ b/security/lsm_syscalls.c
>> @@ -154,3 +154,53 @@ SYSCALL_DEFINE3(lsm_self_attr,
>>       kfree(final);
>>       return rc;
>>   }
>> +
>> +/**
>> + * lsm_module_list - Return a list of the active security modules
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
>> +           unsigned int __user *, ids,
>> +           size_t __user *, size,
>> +           int, flags)
>> +{
>> +    unsigned int *interum;
>> +    size_t total_size = lsm_id * sizeof(*interum);
>> +    size_t usize;
>> +    int rc;
>> +    int i;
>> +
>> +    if (get_user(usize, size))
>> +        return -EFAULT;
>> +
>> +    if (usize < total_size) {
>> +        if (put_user(total_size, size) != 0)
>> +            return -EFAULT;
>> +        return -E2BIG;
>> +    }
>> +
>> +    interum = kzalloc(total_size, GFP_KERNEL);
>> +    if (interum == NULL)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < lsm_id; i++)
>> +        interum[i] = lsm_idlist[i]->id;
>> +
>> +    if (copy_to_user(ids, interum, total_size) != 0 ||
>> +        put_user(total_size, size) != 0)
>> +        rc = -EFAULT;
>> +    else
>> +        rc = lsm_id;
>> +
>> +    kfree(interum);
>> +    return rc;
>> +}
