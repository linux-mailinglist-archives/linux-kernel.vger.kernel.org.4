Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EAA6D9D96
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbjDFQcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbjDFQcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:32:08 -0400
Received: from sonic315-21.consmr.mail.bf2.yahoo.com (sonic315-21.consmr.mail.bf2.yahoo.com [74.6.134.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BFF8690
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680798726; bh=2EEQ5E8g1H3VSKHgc++rDAVAN8lw9f16R+5OH9wR8cg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VQm9jIsFSkwlC4pvzQPdG2IiOoBTChwqa4YUvm067UMkJuXPgicfn52a9/R4YaLYs3/oHPcJ2+e/lmEvwwGDG1kAAP5x0WuPUdKp1anyUjpMuk9QEeRGH54l1wlnU9iDe9SHWPmMXAyTnDSbuLQQpfPRnpSP+aQAIz9XhtciWUaZ/nodMygWQB+GIyehYRzuyxHplDVhiE0O0jqzEPs8D0QdVSAhOoB3ec53BVY2IvM/NPNbWuQxkLXaMiAi4vjTzq1tIfVAfVbcGAegVv/UaHtxYJ4/zT0XwhypDDnXwGjgbtQATmriKrRG2BkRMhhE6IjlTfycVXOAQt3EV++8tQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680798726; bh=reldIx6TIrjgTPm6RaWsjyOEDps90EuKcIWdi7zZpdj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=anO1jl9oPtPvrGQNWppzDEt6VnSli+iGyOEaPNe28G8rJDyygp/bXUzd44VnMWuGWDLQarhbz9ZJI78Cmn6IqUXGRHwtBd/PaBUxxiNezAC5POnlIaj07VnyAPvIJ2Jn2jo3KKKMZGV1wNsdsd3DJN8/oUwLbIhboa9NLha62xJ7v4jTVWZ+NzlW709vOFJYpu3sTCO0Xr+FIu8k41sUHeEua+UaCibPHTZqg95xVJdxY85dyW/bCLr1rmQbDJmmyzQGtfHErR89zUgpHych8BnITFGXCzMPUCTW1Dhzc2oIPWPQeGRwI7OJZghgx5LsAn6kG8dOTlhrjFDZQ+HZjg==
X-YMail-OSG: naSjp1oVM1mHiQBkZnRqts43fOtUBN5JY78azwELz2ex8iwYYT7QpVpnRgUYHjC
 Jm9jtMLdlWHqg2nte3aIgT5vA3QlBvVn1NDdINjONvWc0nFI4NSqEovyXJVa_.xuYOIOnoQzRiAE
 5JY_WerThOSkRtYQ2qk3m_GANGhy6h47XavQMw8G2od14u.imzscgBsKKmLuFwJNGrZ0b5CeReaZ
 z.EbYdPSUt6vXORn5XbL_W3ubNtLSOfrFiidUZ5X69CBMRV7jxVSMWJp.MQVczBibff_fdgkuoPW
 .MOSj1tbaQDP3z8KR2CfYgGyNIsBJx7zRX7LvqbOu1O.vB.EppqipK8VdJOU4Jkrf8r9QIzHCh_B
 56qIhWopAThazJPi5s8xTnEOlz87.hM4z7Dv5JMd8FLssKrSkUu2lvvLRkUjRh9n6OWHZ2mxGPrh
 wh.v.xpdbajFQ0XbH.JzACShqbMm7gLHBxvwyvq3yVfoobYiBQehtH.EZmVAYe39GLv5tXzGeMHe
 RK1i9B17StREPo4sAddlevQn0eidmI64PJ9Q13_q3Z7IFY1IoYnW9FeUB74bH9Wxc9ddFJGgdu9G
 GhCthW09FHlHDqEl1pf3DmFW7DatOVnTzKceYX8Dm7Wz3nq9r1_svvPexpEOD46TMwyxPWcxInGb
 OePILfgdHSk.nSUrYqBG78_bbZknfzSkFD.HoajHGqhW3mkguMNEXJF.ib9.mP3wtIvzjhj8A6uV
 u2nZmB1MCdBqVIIZ3AAQYW0of3vcJ9huUE9GUhoNpL53ypWoyvbBIYaX16Eg8w0lqRFCe12rWrJ8
 jYRQVUOSdUKStKScWhQ_3ufjTAYYdN6Ud1TfcimIn5lNN.xdtqaFq7rf3P1T5uB0wtQlKofZ6OMk
 uWjguhr4XAG3J12xfpzqoW3Lk9qXZrfTZqbxgKPvaLnX9vBbnSdEVUcZ_n9NDzej5sUB9EBei1nB
 4AHRwNkEGm_F7zPaZ2TQnKLYZm7NdHkNU.O4DJwi0u_YIjJqGtgdTqWmFehWSogY.WEEtLg5L0SK
 JS_54q1Mdjte47H4pQx0DBmx18VhUKMX0wvSX4YaP7H.yo1EW7ImPbXOLAhRhoIZ7.8qoLS2GYMZ
 EwI6DynCv03dYrhVWjwkjM0BCt0.dUt7OQ7u1CATOHNUye0fU2sD92mQJpnPRwsCy_VAdi8b2Kf6
 irovuZ_XQzBBikyIKfdD5ahXBOrSqULM5hyH5iDdSJXmS3YADmnvd3rAPY3t_Qog_jtGckZDSouH
 9Jb8g.q7y8wxB1MuOsNpaRuRlS9Hux8ojjr.XFbgD34e45knaePLtqvakCszDF_0td7g87R.Ch8w
 8Lng8WVNK2zEV.SHugpCX9ro.y5z6kxoxGD9.WLu.RNL_Q5GzT6nLihdUHgotF5s6MNHI2uOQygG
 i9hEvr_Er4zws9P9uqzpphLQpgtcwwvzE6z1pfBPWzHUfeheBtqv2i7Hc8XMhBkiMiJEk3JZi_TG
 gLJRoFYovEFT.9im0lwo8iEkgjWtKpaVFw6TSJSnsOBalqjOQnwGLRiCpIzA2KVtHLkEPxq8P1I0
 9DK1MBsJYS8z0FYGzGjAlCjfSArXdyTtnnf.TtcH0IR64kKn485k5JAvDShaNTimXK.IdztS0wnk
 q72NtRdi7ZiNYwkdCOF23LWfvaanbl8RTE8lWshdcFhhx4Ol1h1Jzyin2hlhTg8b_suKDTOJAq_X
 4klv5LAJM5NMoTlycwVRwid4JMLDjGN7RFCu0a96ihXtcCGnA9oSyoUxuFegMikFvd_faIUnuQjs
 7JkJnfCswnvxJmEVoOkSRHisql7BFtPEtmBxczGtBjRt9_9SOSCQfmNWuL_eJgH5LB.gGCXFKFXB
 .PBg77zU7dgge.zJx6GRREM.vnwtHaXtNeHYNyYj6REJ5HeN_EbahDak_qBFS085M7lrLmASrUTO
 zfsqxEOZ0OK4uIgUSUAJNZ_cqPJRTqN4DvP.6UlNQm8fEE1SPamEgo5.H4pz6p8UN9y1ouR69Tcq
 U5YErOMYhcp9bXzL7Htjqxh7y22m2DnpYRHzxo6AO9J9N7iIupQ9S.MWyNZB0etc3WCQpy4iAcvi
 htlCf5SnkRBZbwWb4CQ4FBkc5CDqBZ.nZrEWJNOIzURyyrId2ZOSaWV3n3.a_q2rn7YseYYbFj0A
 wxVr6A4U4b.xzxgtQJkftVEewuLn5A8y8hIrBf8T3T8SKojlNXO_1py2k3Iu0x9XNcZBcQ3LCg90
 EGG3XzFHtXuu0b2d9xp23.aFb.LtvmsAOdLSOsmyEsfS8pRwhiADIieT7ZVv_TpRQM8z95UQWZZQ
 eLGMU9skKm.giYVTz4GJp
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: afeeb1df-d2b2-4fde-b99d-a791b720d2f1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Thu, 6 Apr 2023 16:32:06 +0000
Received: by hermes--production-ne1-7dbd98dd99-84p8v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fe54b9c6177a887473eeae74b12f75c4;
          Thu, 06 Apr 2023 16:32:00 +0000 (UTC)
Message-ID: <8819e4eb-1e99-bb38-6501-638677d3f4cf@schaufler-ca.com>
Date:   Thu, 6 Apr 2023 09:31:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 05/11] LSM: Create lsm_module_list system call
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
 <20230222200838.8149-6-casey@schaufler-ca.com>
 <1ca41f67-ffa1-56c2-b4ee-f5deece95130@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <1ca41f67-ffa1-56c2-b4ee-f5deece95130@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/2023 3:33 AM, Mickaël Salaün wrote:
>
> On 22/02/2023 21:08, Casey Schaufler wrote:
>> Create a system call to report the list of Linux Security Modules
>> that are active on the system. The list is provided as an array
>> of LSM ID numbers.
>>
>> The calling application can use this list determine what LSM
>> specific actions it might take. That might include chosing an
>
> "choosing"

Oops. Thank you.

>
>> output format, determining required privilege or bypassing
>> security module specific behavior.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   Documentation/userspace-api/lsm.rst |  3 ++
>>   include/linux/syscalls.h            |  1 +
>>   kernel/sys_ni.c                     |  1 +
>>   security/lsm_syscalls.c             | 43 ++++++++++++++++++++++++++++-
>>   4 files changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/userspace-api/lsm.rst
>> b/Documentation/userspace-api/lsm.rst
>> index b45e402302b3..ecdf1acd15b1 100644
>> --- a/Documentation/userspace-api/lsm.rst
>> +++ b/Documentation/userspace-api/lsm.rst
>> @@ -63,6 +63,9 @@ Get the specified security attributes of the
>> current process
>>   .. kernel-doc:: security/lsm_syscalls.c
>>       :identifiers: sys_lsm_get_self_attr
>>   +.. kernel-doc:: security/lsm_syscalls.c
>> +    :identifiers: sys_lsm_module_list
>> +
>>   Additional documentation
>>   ========================
>>   diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index 1ef2a3de8ae0..9c947022a411 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -1062,6 +1062,7 @@ asmlinkage long
>> sys_set_mempolicy_home_node(unsigned long start, unsigned long l
>>   asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t
>> *size,
>>                         __u64 flags);
>>   asmlinkage long sys_lsm_set_self_attr(struct lsm_ctx *ctx, __u64
>> flags);
>> +asmlinkage long sys_lsm_module_list(u64 *ids, size_t *size, int flags);
>>     /*
>>    * Architecture-specific system calls
>> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
>> index d03c78ef1562..32784e271fa5 100644
>> --- a/kernel/sys_ni.c
>> +++ b/kernel/sys_ni.c
>> @@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
>>   /* security/lsm_syscalls.c */
>>   COND_SYSCALL(lsm_get_self_attr);
>>   COND_SYSCALL(lsm_set_self_attr);
>> +COND_SYSCALL(lsm_module_list);
>>     /* security/keys/keyctl.c */
>>   COND_SYSCALL(add_key);
>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>> index b89c4e7d009e..ccd3b236670b 100644
>> --- a/security/lsm_syscalls.c
>> +++ b/security/lsm_syscalls.c
>> @@ -19,7 +19,7 @@
>>     struct attrs_map {
>>       char *name;
>> -    int attrs;
>> +    u64 attrs;
>
> Why do we need this change in this patch?

We don't. It's gone in subsequent versions.

>
>>   };
>>     static const struct attrs_map lsm_attr_names[] = {
>> @@ -102,3 +102,44 @@ SYSCALL_DEFINE3(lsm_get_self_attr, struct
>> lsm_ctx __user *, ctx,
>>   {
>>       return security_getselfattr(flags, ctx, size);
>>   }
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
>
> The name of this syscall differ from the two others: there is not
> "get" verb. What about "lsm_get_modules" or "lsm_list_modules"?

lsm_list_modules() it is henceforth.

>
>> +        u64 __user *, ids,
>> +        size_t __user *, size,
>> +        u64, flags)
>
> As Arnd said, flags should be a u32.

Agreed.

>
>> +{
>> +    size_t total_size = lsm_active_cnt * sizeof(*ids);
>> +    size_t usize;
>> +    int i;
>> +
>> +    if (flags)
>> +        return -EINVAL;
>> +
>> +    if (get_user(usize, size))
>> +        return -EFAULT;
>
> I'm not a fan of using the same pointer to read and write. This avoid
> using const pointers and differentiate between input and output
> values. I suggest using a dedicated argument for each.

This is pretty standard practice.

>
>> +
>> +    if (put_user(total_size, size) != 0)
>> +        return -EFAULT;
>> +
>> +    if (usize < total_size)
>> +        return -E2BIG;
>> +
>> +    for (i = 0; i < lsm_active_cnt; i++)
>> +        if (put_user(lsm_idlist[i]->id, ids++))
>
> I'm not sure about it, but it may be better to put the complete list
> of IDs at once. Is it better to set the size before or after?

You may be right. I'll consider it.

>
>
>> +            return -EFAULT;
>> +
>> +    return lsm_active_cnt;
>> +}
