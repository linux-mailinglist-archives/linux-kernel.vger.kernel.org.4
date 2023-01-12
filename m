Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8E5666761
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjALAFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjALAF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:05:27 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F24FDFA1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673481925; bh=n+/JUZo4jFbmvojc0+KM/0r4qCuZjLnCZWgaCM6RCdE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=USbC/bv92j6SiByS8yRM98ujJXa90YDwbknzoQR6b6fBs2XjkKBRyH/zpzg8wiP5HwPGnUpRg+DYCkzIR2lHYpEBbnlMhkYVZK1y8PZ1DzbNiy6vT0WQMU9VNZYfXewSvu8vHnBFY45XE8V7LWV8Is22G6z5rUTJB99Jayw8AF/UQiOtJlS4NA/IehO2aPQt2t9pPlZAq/TzvuaQ7rLRThh9Hnidzq8wqnPu8H7yNgIZ2lmhEEYk1U5ocv6JrmzX4pvymtQwOv4WXkq6KwVPll10EXlihu1Deoux7Tdww/lbOtuOdcVma44bh4uFaii8faf09jkViHx9YWJ39VeA3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673481925; bh=ns7DwsFY6YzOWeFLnNv065cjFZfhL7JPSMvv2Ev5uLW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZVfjkQxEACNuofX1fjbPkE3Ysf/zoQl3xDSB1wW2uwCmSzCmYGwKPw6i/TNXATVeRk/mJYhd61Ofd4kzMKvZGgqZN1EBQ0NjePN7RW1kfPWYJDlaLIDVw3sdBoFSu0PjUr+bWJVK2vaoyqDT1KoyxgQCXUO6JZwSzpVJ5X9m3G+VBUcBzyYZF+nL8Ycj0ldHwrexsm051SNpxwrAKro9kFLUCrmpNVQshOXX03UUXQdBDllzRedfFeI4dMWSrS6aZt0waQpJsMOCX+ZVmEZPIl9/WN+PuuVqtIooGP+sow/tBYH6WAXkMFt3XxNEvCKw9VOXZFlg7Pb1wX3yDDCJhA==
X-YMail-OSG: h._urr0VM1l_qv4J14hEqm63MKlZtTuq3NxjGC7fHPcqXpN44jNBgSF90cfpo3y
 D5YLV_T.EEljA3J_7n.AVuxYi4YfHlOZhqpB6vr5_QkexoN7f.OmpxBJKAQqlxR7DLiNJ6tQMjDm
 uHH8YRXrDoi2i74WGPcrnrgmkjYFK2SneTHrGbs.Uy7M5nW89sN2ikYSzH5zINb5SJ44MvUpEVbc
 cmvs22S0tIQ_JTuOSmTgM2ETWclhpYK1zE0X_4hI0SMiJEWKmKdnRFHfurrPau6g0swXzlWZsUXz
 Yad8GLeHLOGkK4f2Xi.AWh8y8U1tW09_cLyJ9HX24AWixHGKCSCXHTJ_K0qw4fxK3XIBzoIWasyN
 4Blf3MZrOGi0GmSNkvUq_Da.LUj3HrWLkqqPz21XZgb4z4O4ivuP9cUuVldfYm8Z99T2lHWM8Ai3
 650KVpL7QGJI8J.2wRGicCXJc5ebnI_g.hPGG2FBWwBbZcRiJYCpIGAe4TuIx1dIj1KtpmNneQsW
 UB9we3.BkRZfvYcC4ovEWtjj96thETUDY2uOHV4sb7HtsPrkmLJmcjNi3DwPDvspTnskBNDm.ZWK
 uS1EP65Ov31JU5PdYjEnoF04xm8mFJi4NsSo1nsfIheQhIAMxmn7SVDlhKwXtM8ziGmgsv3GwO_5
 5z3Rgb.tgJptf8ocPWXXjTtq.QOvfhNyOfzlVX3pvmwBI4AhQyjnKfFzDENQ92gxKc5JvR7Un35b
 aN3br_CZcSBEnap_nHaD5BybHP66HV5Xv7ERXRgsTeymBL7O3VHu_fSPQGHG1zK_URH_uCuUIlyr
 9lrX9uZnQHL6NJMXjVqDSk7HMiRcOkiwej1sbzdcCgHJWI_HkPnD3.sXwQT48oQmWx95F9mCXlUp
 w2LLWc.V9NE8oeouRJJU3t1kng3Y84UQklqjxpdkNHl6_e8302.y97L74U_o_FZE90JOCZx00own
 KddI_BpIOBTsLBXtuMXgn4jTUUvREy7NAVcX7nXzcITbHualeCCe8CM0hu3P6dXTPMpaqCsWZJEc
 ZQ3rxXvQ_0jlhOqEznMFiEx92mVmug5d_v1ezREtd95Wr6MIOxL1YwxwDtzzo0iXD6MNNQwQiijT
 tQep7_NvCMmAdwffTZZZBExKiMvDnLa4kWIR1ALsX6BRR98HQPIGKoYJBgIxB41VzjD3y1e7pr8H
 2NbEO_fFjI1bkuYkhi.6CrykU.CyaYIYGXgXCfKRpfoMJsj5EJf_rRNX7GY5uvmmTrokDO5AdJLw
 am8RgggRYn5DiTNIcaP4LI1b_KxWDcpng9FiqJ.dbHSGj1cpWcffshvson_BXaJFuWKuFT7YJ9S7
 SEsbbxdkdZgC4HSlVhsZhc9gQ12Q.V15Red5tQryo5Uaz339Ok7f6rKdEEs7sEIAffrvaGrTI2Kj
 cDyHHhRLYhv9KMCiUIwZXQvbnE82qmFPWlGquXXJMFvxSPSZeiOvIj75sD7xYik28RtVqCTU6bJq
 LoYrr4StqoYYgBo_OSxO1pUm2oC8U_7SSgv8k1ynib4ipISKEhFxyMYuU3uvZyfLvs.UUuq1D1on
 AcWkAPioibLmGxFf95VyePGgwzjxPyM9_7fgPAUxpH.1LieovyGLN3s_nYfSzr8ttz1qeza1IW4.
 c4cJ2uePgjjnV0RZqIpwaJ7JuossMa.50DZ554SCDrt_XzfdWzRkHHoAC3pMBlf1YzjaPKl5sNPE
 Fgl_AGEqfonD5Zk.vzAOyXA1SAh05Uq9_sOUNqzfHs4zkBSkZI5vT9gHWRKAwIFt6fPD6hXqT78D
 s0Cx8Iq3tlaHuns.g4w02prMeOTQ_iYTgSgIUMEUtvpV_OqQE0iZJS0oJ..d.hw.1_X01fty9y15
 QnGA0pzouqLdhwkh1RVafOCNQBvzAkosbea3ZKzJgj1k9HpZc.z3UBcuNjruhikT0n.UZnOU6Gt9
 n9L2cqTjiMIKsjO8rYYZYJ9GX9Hs_y5FzZ6nWGkYzDn7CJvthHieMhzjP3kiFuFPy5x_wLUWKjIt
 ONn4RkPBL2mwsiOR0oFCTB1RSz1.5MDhgBz4Ss7Gn1uv6UqGd56GMSNZcKFps4S.RyhzaYlDzMHL
 rN7pWDfQ4cHskmY9ex3ioe2PKhCSExnV8iDhOURTY1pYkUdiAeUj0k_J2bEpnZEvuCpK4fnZ3V9j
 FA0EP_OVllDIURckj.gH2ZNHyMhpAG21Nf5.sb3oz4Xy7praHrBRVYqpoLV_02Ck.INkSz304Rmv
 DuS3OtnXCTQI2hAh4M.QF8C8OwsD2s01tAhODqIx5fcjulz9no0hFkKEI0ciofy7QjmTciRW55B8
 RWiwQlWNt
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Jan 2023 00:05:25 +0000
Received: by hermes--production-gq1-5d97db6675-7lt2c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e5006e31fb65e3edc42b6ef150a56d19;
          Thu, 12 Jan 2023 00:05:20 +0000 (UTC)
Message-ID: <53adfcac-15c4-83e6-876f-bc9a880bafa2@schaufler-ca.com>
Date:   Wed, 11 Jan 2023 16:05:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/8] LSM: Identify modules by more than name
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, casey@schaufler-ca.com
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-2-casey@schaufler-ca.com>
 <CAHC9VhRs6BxukV97BaDuj6GDJwhiy+-vCmDfRUyojJiBUV2z1g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRs6BxukV97BaDuj6GDJwhiy+-vCmDfRUyojJiBUV2z1g@mail.gmail.com>
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

On 1/11/2023 1:00 PM, Paul Moore wrote:
> On Mon, Jan 9, 2023 at 1:07 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Create a struct lsm_id to contain identifying information
>> about Linux Security Modules (LSMs). At inception this contains
>> the name of the module, an identifier associated with the security
>> module and an integer member "attrs_used" which identifies the API
>> related data associated with each security module. The initial set
>> of features maps to information that has traditionaly been available
>> in /proc/self/attr. They are documented in a new userspace-api file.
>> Change the security_add_hooks() interface to use this structure.
>> Change the individual modules to maintain their own struct lsm_id
>> and pass it to security_add_hooks().
>>
>> The values are for LSM identifiers are defined in a new UAPI
>> header file linux/lsm.h. Each existing LSM has been updated to
>> include it's LSMID in the lsm_id.
>>
>> The LSM ID values are sequential, with the oldest module
>> LSM_ID_CAPABILITY being the lowest value and the existing modules
>> numbered in the order they were included in the main line kernel.
>> This is an arbitrary convention for assigning the values, but
>> none better presents itself. The value 0 is defined as being invalid.
>> The values 1-99 are reserved for any special case uses which may
>> arise in the future. This may include attributes of the LSM
>> infrastructure itself, possibly related to namespacing or network
>> attribute management. A special range is identified for such attributes
>> to help reduce confusion for developers unfamiliar with LSMs.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  Documentation/userspace-api/index.rst |  1 +
>>  Documentation/userspace-api/lsm.rst   | 55 +++++++++++++++++++++++++++
>>  include/linux/lsm_hooks.h             | 18 ++++++++-
>>  include/uapi/linux/lsm.h              | 55 +++++++++++++++++++++++++++
>>  security/apparmor/lsm.c               |  9 ++++-
>>  security/bpf/hooks.c                  | 13 ++++++-
>>  security/commoncap.c                  |  8 +++-
>>  security/landlock/cred.c              |  2 +-
>>  security/landlock/fs.c                |  2 +-
>>  security/landlock/ptrace.c            |  2 +-
>>  security/landlock/setup.c             |  6 +++
>>  security/landlock/setup.h             |  1 +
>>  security/loadpin/loadpin.c            |  9 ++++-
>>  security/lockdown/lockdown.c          |  8 +++-
>>  security/safesetid/lsm.c              |  9 ++++-
>>  security/security.c                   | 12 +++---
>>  security/selinux/hooks.c              | 11 +++++-
>>  security/smack/smack_lsm.c            |  9 ++++-
>>  security/tomoyo/tomoyo.c              |  9 ++++-
>>  security/yama/yama_lsm.c              |  8 +++-
>>  20 files changed, 226 insertions(+), 21 deletions(-)
>>  create mode 100644 Documentation/userspace-api/lsm.rst
>>  create mode 100644 include/uapi/linux/lsm.h
> Mostly just nitpicky stuff below ...

Nitpicky is fine.

>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 0a5ba81f7367..6f2cabb79ec4 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1665,6 +1665,20 @@ struct security_hook_heads {
>>         #undef LSM_HOOK
>>  } __randomize_layout;
>>
>> +/**
>> + * struct lsm_id - identify a Linux Security Module.
> According to the kernel-doc documentation it looks like "identify"
> should be capitalized.
>
> * https://docs.kernel.org/doc-guide/kernel-doc.html

I'll fix this, and the next as well. Thanks for pointing it out.

>> + * @lsm: Name of the LSM. Must be approved by the LSM maintainers.
>> + * @id: LSM ID number from uapi/linux/lsm.h
>> + * @attrs_used: Which attributes this LSM supports.
> In a bit of a reversal to the above comment, it appears that the
> parameter descriptions should not start with a capital and should not
> end with punctuation:
>
>   * @lsm: name of the LSM, must be approved by the LSM maintainers
>
>> + * Contains the information that identifies the LSM.
>> + */
>> +struct lsm_id {
>> +       const u8        *lsm;
>> +       u32             id;
>> +       u64             attrs_used;
>> +};
>> @@ -1708,7 +1722,7 @@ extern struct security_hook_heads security_hook_heads;
>>  extern char *lsm_names;
>>
>>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
>> -                               const char *lsm);
>> +                              struct lsm_id *lsmid);
> We should be able to mark @lsmid as a const, right?

At this point, yes, but the const would have to come off when
the "slot" field is added to lsm_id in the upcoming stacking patches.
I can mark it const for now if it is important.

>> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
>> new file mode 100644
>> index 000000000000..61a91b7d946f
>> --- /dev/null
>> +++ b/include/uapi/linux/lsm.h
>> @@ -0,0 +1,55 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Linux Security Modules (LSM) - User space API
>> + *
>> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
>> + * Copyright (C) 2022 Intel Corporation
>> + */
> This file should be added to the SECURITY SUBSYSTEM section in MAINTAINERS:
>
>   F: include/uapi/linux/lsm.h

S'truth.

>> +#ifndef _UAPI_LINUX_LSM_H
>> +#define _UAPI_LINUX_LSM_H
>> +
>> +/*
>> + * ID values to identify security modules.
>> + * A system may use more than one security module.
>> + *
>> + * A value of 0 is considered invalid.
>> + * Values 1-99 are reserved for future use.
>> + * The interface is designed to extend to attributes beyond those which
>> + * are active today. Currently all the attributes are specific to the
>> + * individual modules. The LSM infrastructure itself has no variable state,
>> + * but that may change. One proposal would allow loadable modules, in which
>> + * case an attribute such as LSM_IS_LOADABLE might identify the dynamic
>> + * modules. Another potential attribute could be which security modules is
>> + * associated withnetwork labeling using netlabel. Another possible attribute
>> + * could be related to stacking behavior in a namespaced environment.
>> + * While it would be possible to intermingle the LSM infrastructure attribute
>> + * values with the security module provided values, keeping them separate
>> + * provides a clearer distinction.
>> + */
> As this is in a UAPI file, let's avoid speculation and stick to just
> the current facts.  Anything we write here with respect to the future
> is likely to be wrong so let's not tempt fate.

Sure. I'll leave the rationale to the take message.

> Once I reached patch 3/8 I also realized that we may want to have more
> than just 0/invalid as a sentinel value, or at the very least we need
> to redefine 0 as something slightly different if for no other reason
> than we in fs/proc/base.c.  I know it seems a little trivial, but
> since we're talking about values that will be used in the UAPI I think
> we need to give it some thought and discussion.  The only think I can
> think of right now is to redefine 0 as "undefined", which isn't that
> far removed from "invalid" and will not look too terrible in patch 3/8
> - thoughts?

I originally had LSM_ID_INVALID for 0, but there was an objection.
It's not really invalid or undefined, it is reserved as not being an LSM id.
How about LSM_ID_NALSMID or LSM_ID_NOTALSMID for 0? sort of like NAN for
Not A Number.

> With all that in mind, I would suggest something like this:
>
>   /*
>    * ID tokens to identify Linux Security Modules (LSMs)
>    *
>    * These token values are used to uniquely identify specific LSMs
>    * in the kernel as well in the kernel's LSM userspace API.
>    *
>    * A value of zero/0 is considered undefined and should not be used
>    * outside of the kernel, values 1-99 are reserved for potential
>    * future use.
>       */
>   #define LSM_ID_UNDEF 0

Fine, although I'd go with LSM_ID_NALSMID

>> +#define LSM_ID_CAPABILITY      100
>> +#define LSM_ID_SELINUX         101
>> +#define LSM_ID_SMACK           102
>> +#define LSM_ID_TOMOYO          103
>> +#define LSM_ID_IMA             104
>> +#define LSM_ID_APPARMOR                105
>> +#define LSM_ID_YAMA            106
>> +#define LSM_ID_LOADPIN         107
>> +#define LSM_ID_SAFESETID       108
>> +#define LSM_ID_LOCKDOWN                109
>> +#define LSM_ID_BPF             110
>> +#define LSM_ID_LANDLOCK                111
>> +
>> +/*
>> + * LSM_ATTR_XXX values identify the /proc/.../attr entry that the
>> + * context represents. Not all security modules provide all of these
>> + * values. Some security modules provide none of them.
>> + */
> I'd rather see text closer to this:
>
>   /*
>    * LSM attributes
>    *
>    * The LSM_ATTR_XXX definitions identify different LSM
>    * attributes which are used in the kernel's LSM userspace API.
>    * Support for these attributes vary across the different LSMs,
>    * none are required.
>    */

If you like that better I'm completely willing to adopt it.

>> +#define LSM_ATTR_CURRENT       0x0001
>> +#define LSM_ATTR_EXEC          0x0002
>> +#define LSM_ATTR_FSCREATE      0x0004
>> +#define LSM_ATTR_KEYCREATE     0x0008
>> +#define LSM_ATTR_PREV          0x0010
>> +#define LSM_ATTR_SOCKCREATE    0x0020
>> +
>> +#endif /* _UAPI_LINUX_LSM_H */
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index c6728a629437..63ea2a995987 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/zstd.h>
>>  #include <net/sock.h>
>>  #include <uapi/linux/mount.h>
>> +#include <uapi/linux/lsm.h>
>>
>>  #include "include/apparmor.h"
>>  #include "include/apparmorfs.h"
>> @@ -1217,6 +1218,12 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
>>         .lbs_task = sizeof(struct aa_task_ctx),
>>  };
>>
>> +static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
>> +       .lsm = "apparmor",
>> +       .id = LSM_ID_APPARMOR,
>> +       .attrs_used = LSM_ATTR_CURRENT | LSM_ATTR_PREV | LSM_ATTR_EXEC,
>> +};
> Perhaps mark this as const in addition to ro_after_init?  This applies
> to all the other @lsm_id defs in this patch too.

As I mentioned above, the lsm_id will eventually get changed during the
registration process. I can add the const for now, knowing full well that
it will be removed before long.

>> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
>> index e5971fa74fd7..20983ae8d31f 100644
>> --- a/security/bpf/hooks.c
>> +++ b/security/bpf/hooks.c
>> @@ -5,6 +5,7 @@
>>   */
>>  #include <linux/lsm_hooks.h>
>>  #include <linux/bpf_lsm.h>
>> +#include <uapi/linux/lsm.h>
>>
>>  static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
>>         #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>> @@ -15,9 +16,19 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
>>         LSM_HOOK_INIT(task_free, bpf_task_storage_free),
>>  };
>>
>> +/*
>> + * slot has to be LSMBLOB_NEEDED because some of the hooks
>> + * supplied by this module require a slot.
>> + */
> I don't think we need the above comment here, right?

Whoops. I thought I'd gotten that one.

>
> --
> paul-moore.com
