Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09C5606B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJTWsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJTWr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:47:58 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE8A22D5C0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666306075; bh=SONCEp9ccP0cXsvFMACK+mFZ7GFLiyc46gxkPdyMAnM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LNz2hTYvWAAvjqMjPQgSU3fMTUEP1OB+bLAzsnsVpArIFkmPe4cwzE5WGmtLGXa+wIDqWJzA7tTr5lVd26nzXHj98Lx8jMIw4VLq5Z0UeHgltfF7hBbnCRsACd/L+DW80DY0/eXspen1o+3FqQCbNoRAaKcMZvUBFhFRd8s5RznZNjb0xhzKa4sISj+HXsX6ZIEWRolHM7Ykj2n4mpKlJExV27DLUMMaTXepXF92H5R1LdVmiEObUzSXgdEVt3h8kJnFC+EY00F1gBBL94+k9VmePu5IIzfhKDta10QoLHsr55k1IHK06OHMpNIjfk2GLNMzx7LWSDq68p4RqUrx9g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666306075; bh=/jiBOyYCSR6aF3dZgjXZdCgaovTwVodnwNyQtAWJJdP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YjNgjN0gQcKKdIM7+/Qvjx5SJBJBHWuBIE66qUx8tAAZGkuO7UPV8Bu3E7TpSqBCz3c1AgCiBIOW4xzcQmWyebWPdFctX+YjtaFkP7iyIMucF+BrgYTxP/Q97vINiFyRLv0PomYdr/VoOUXSC0UACYBzvsTvriHyfZnU2T6Sp/BxQEL/ovKS8agDmcLqn2ruYP2pRM0CXWOIEEZmj4mTG/McEHYT8MMmSAnW8QqDvfg0BmElAG/9qihvjBkxaW0czcb/mG5UHlPyS0qxJObcmCw8pvI/DujZ0RJwBnGW3glm1aHjb5OVU9VBLRzY0N4ke/fx76O4zNHlGcI+HBQXlQ==
X-YMail-OSG: BW8ESToVM1me.Tx7dB63psyoKZpTVJBWTA1DoBvYHlZpXwxHdEMzoKQ0I1khkN.
 d15lfFUecwWRiMllh93WWarVQnyA6rqZqXGiI1epyDcpi07zYtbwMkqR7y2MfT5iGIsQ3lAeBsvs
 qmCMIQqNRlyj..EKxUpSaqthYSxmdz2jpSSQRl3Lon7izS2sjAfswavoGesuHY_MXtIMtXXmCkIg
 HfazHwBF7jWSXmSVv40f2Rc.nJwoAYx6A6YiSoAgSgzvL8QAqXaMazvBDzGjZQ9xTv.pIvVshGV2
 TIkFrkRQZTGOwLFOs9eYYPWjfqeGNVTyTgDt1y2B8W6dHA6kQyEJuAIt.O0XTXGHjDD62IyTayxa
 Nx7G5IOv5yZWrgBXpPjJEQMc2cI3KGxFDMJAawyWEddUQ_HmRft_51D3.6KRSPXP.zkZgAtdxCff
 SOhDddlOQ0GyXPjoQPk2cDsMJQQ2qToIlYJxGpUdVXU59r_sbP_uvEZ8.2VM5PL_3U3strZ9BAdv
 og5QNUFUfKtbI.LAvxfITCHlWTkGFkwxU8xexeuVZ0lAcgO3UpAO8ocqYhubrBtVAAf4B50RXMeY
 Yv2mttdH.k43Z8D5.5BOzBJzd.dDCMONOOL1Myy6LoojwYfqwX0bGHt5FyZN_0mag5STzkDauB7V
 He2FBRBYgEh4wj5DkQwmYLZmnDCwCUxMuBfFH8SfDFeyBz_l.IoUXYw0Bd9zUQZyLcpXyyfBzH2f
 QeXWMWriacN8q2xTBbwOoh40asUg1NZmErxIK3C_aVL7.578C0IDkAf_yASE3iwaw67cmgHzwDv.
 n4ejf66wpktl6ZH8G9WdpL70i61mOSh4sAUwGRYRJGzBDHgbvCnEUFuKO7YrPOw6Evfje6wnuAFI
 eVTVw69LMHzdvz8BviYDC9.mRe8SBZM__f6yLdBZ0fdnKYshnbCT.Wv9rFc_sjigPK0K63BcjmhR
 YKCMemTYKJRSZORmbt3mG_pOj1V0r3C6z5FQ5Y4kq9fvyXri9EMoJg64mUOEhv8Io_27oBZNNMRR
 V0DCKAK6s_b6oODlrbYwj4WkXv.j9kIvdso1cLvtf_bHTykN5L9Korw._l80NU6Kr88oC_J4QKJf
 5u.UvOt5Ul5_TGJFK7kooNuzCLp62601X8UOZlfvyYUQGQBhzseaYIAPlhcwiFuGjCYDRk9kJKle
 sS8Z7.1XmCOby0kDt5Ud7eXIX928T9R4FH8BxiMMaOJ7CyKlG9V4zlJ70.PS1.BAScM4PV_BCg1P
 mzwD8xQAME4FpSB_rczPEdqp.mftDyR1d26OzGyGwPYJ8_iFOjiGqQWeS1To6arsHw3vTROOF_Nk
 KD_e7y77GN2GBq2MUydY9p8RIVaO_95tNZUr1m1HskpZIXg_bDT0LfqL5_3TXXVgUsyMAVkQnncD
 2_XqHEf9HiiqHzbbtEr13flYz1ipuu_KGvGCTtioNSJ9g2ccS5zWeAcnujzj4mtRuHj5ZmhSb5bh
 oeCWdDSXrzjflVin9VYE4OaIMPJ983aWeac8bpVoe9FE2BoBq7eojU9Z1_7ARwHruxUXYG7BRpep
 EAaWS81ryGVD5IkxNpVoZYvo9fmYF9F2FZACpIZ58LQjINcBWOj_1j0ASGX3uemdU9k.ZjRLb1C6
 p01QZ0UPCH.dMsG1xwzOSdwUkqf69zUMGbQsQhLLQCvdOcCGacczC5cjDHRT4TwwuJzSrw2ljNVY
 ZBZWWZqNJh2LFOAcxwZRN_epqsrp8HQ5svKLhezZ7A0RI0pj4KaeTCXCy95fI2Q8XKl3tGFvb1yN
 xQJLAU9kZnk8OBAHwpbe41G3x3Ezp2lPeNjW8VtsAMw1ljZ.C4yHW5enhc9V2nDuHCvD0lyu2MH1
 d2uqrVkro_I6a2AuEaOIkSGJagR86aCoLm0zfUvugBX4itUfYhooD5zXq8xEK2frTJFO8v3WXbD9
 Y9E9RH..izKdHJ7gh4kflwvEOPUFnf1fi0Hb49mQVHXLptJuQiFPS5nhXqaObXahELSALTcGYW29
 WpyX84J5525E6AaiXfy3.jJG8szp1jXNGBYDDLojL1SKA6T.R2DJxQwXh7t4ZzGMJBKQXx_o2Wzz
 QDH0joBHUPa_O6lAhp3eUyQ3J9EMbh8FU80iwdF9.qmQmgkIcsKiezYQfFhBvZgzEIMTvLkb0GYH
 SaVyEDIv4NhyzWakjx0tBvSUKixBypIxTtVkzGA6xo3rbsPLp2y5bwEH6Kw7_yBTztJZYqF2JWAi
 pSOBrnWT1ZmKHOgE80u8f3WeucNHwKz6iVTT_gWWjjiJ.on90ozdmmMHj_Lir3oflI1.2sivCHzM
 GAzAYa1gf_3z5pDX5dRoSnnRv4El9BWk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Oct 2022 22:47:55 +0000
Received: by hermes--production-gq1-754cb59848-glwn5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d561348802d5aa77c822511d6c534fc2;
          Thu, 20 Oct 2022 22:47:52 +0000 (UTC)
Message-ID: <4aa57cc6-84d6-31d1-67d1-02703cc4ec8b@schaufler-ca.com>
Date:   Thu, 20 Oct 2022 15:47:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v38 02/39] LSM: Add an LSM identifier for external use
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927195421.14713-3-casey@schaufler-ca.com>
 <00f438de-3591-1d3e-905b-1df267da8833@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <00f438de-3591-1d3e-905b-1df267da8833@digikod.net>
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

On 10/12/2022 2:14 PM, Mickaël Salaün wrote:
>
> On 27/09/2022 21:53, Casey Schaufler wrote:
>> Add an integer member "id" to the struct lsm_id. This value is
>> a unique identifier associated with each security module. The
>> values are defined in a new UAPI header file. Each existing LSM
>> has been updated to include it's LSMID in the lsm_id.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   include/linux/lsm_hooks.h    |  1 +
>>   include/uapi/linux/lsm.h     | 32 ++++++++++++++++++++++++++++++++
>>   security/apparmor/lsm.c      |  2 ++
>>   security/bpf/hooks.c         |  2 ++
>>   security/commoncap.c         |  2 ++
>>   security/landlock/setup.c    |  2 ++
>>   security/loadpin/loadpin.c   |  2 ++
>>   security/lockdown/lockdown.c |  4 +++-
>>   security/safesetid/lsm.c     |  2 ++
>>   security/selinux/hooks.c     |  2 ++
>>   security/smack/smack_lsm.c   |  2 ++
>>   security/tomoyo/tomoyo.c     |  2 ++
>>   security/yama/yama_lsm.c     |  2 ++
>>   13 files changed, 56 insertions(+), 1 deletion(-)
>>   create mode 100644 include/uapi/linux/lsm.h
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 23054881eb08..407f57aaa6ef 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1603,6 +1603,7 @@ struct security_hook_heads {
>>    */
>>   struct lsm_id {
>>       const char    *lsm;        /* Name of the LSM */
>> +    int        id;        /* LSM ID */
>>   };
>>     /*
>> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
>> new file mode 100644
>> index 000000000000..5647c3e220c0
>> --- /dev/null
>> +++ b/include/uapi/linux/lsm.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Linus Security Modules (LSM) - User space API
>> + *
>> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
>> + * Copyright (C) Intel Corporation
>> + */
>> +
>> +#ifndef _UAPI_LINUX_LSM_H
>> +#define _UAPI_LINUX_LSM_H
>> +
>> +/*
>> + * ID values to identify security modules.
>> + * A system may use more than one security module.
>> + *
>> + * LSM_ID_XXX values 32 and below are reserved for future use
>
> What do you have in mind? Why not "reserve" higher bits instead and
> start with SELinux at 1?

I don't know what (if anything) Paul had in mind when he suggested the reserved values.
It's not like there's a shortage of numbers, and as it's part of the ABI and can't
change I'll err on the side of caution.

>
>
>> + */
>> +#define LSM_ID_INVALID        -1
>> +#define LSM_ID_SELINUX        33
>> +#define LSM_ID_SMACK        34
>> +#define LSM_ID_TOMOYO        35
>> +#define LSM_ID_IMA        36
>> +#define LSM_ID_APPARMOR        37
>> +#define LSM_ID_YAMA        38
>> +#define LSM_ID_LOADPIN        39
>> +#define LSM_ID_SAFESETID    40
>> +#define LSM_ID_LOCKDOWN        41
>> +#define LSM_ID_BPF        42
>> +#define LSM_ID_LANDLOCK        43
>> +#define LSM_ID_CAPABILITY    44
>
> Out of curiosity, why this order?

Order of inclusion upstream. Except for capability. In the next version
I plan to fix the order by putting LSM_ID_CAPABILITY first at 32 and
changing the comment. If we wanted something less mundane we could hex
encode the first 4 letters of the name, but except for hacker style debugging
that doesn't gain anything.

>
>
>> +
>> +#endif /* _UAPI_LINUX_LSM_H */
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index b71f7d4159d7..fb6c7edd5393 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/zlib.h>
>>   #include <net/sock.h>
>>   #include <uapi/linux/mount.h>
>> +#include <uapi/linux/lsm.h>
>>     #include "include/apparmor.h"
>>   #include "include/apparmorfs.h"
>> @@ -1204,6 +1205,7 @@ struct lsm_blob_sizes apparmor_blob_sizes
>> __lsm_ro_after_init = {
>>     static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
>>       .lsm      = "apparmor",
>> +    .id       = LSM_ID_APPARMOR,
>>   };
>>     static struct security_hook_list apparmor_hooks[]
>> __lsm_ro_after_init = {
>> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
>> index e50de3abfde2..c462fc41dd57 100644
>> --- a/security/bpf/hooks.c
>> +++ b/security/bpf/hooks.c
>> @@ -5,6 +5,7 @@
>>    */
>>   #include <linux/lsm_hooks.h>
>>   #include <linux/bpf_lsm.h>
>> +#include <uapi/linux/lsm.h>
>>     static struct security_hook_list bpf_lsm_hooks[]
>> __lsm_ro_after_init = {
>>       #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>> @@ -21,6 +22,7 @@ static struct security_hook_list bpf_lsm_hooks[]
>> __lsm_ro_after_init = {
>>    */
>>   struct lsm_id bpf_lsmid __lsm_ro_after_init = {
>>       .lsm      = "bpf",
>> +    .id       = LSM_ID_BPF,
>>   };
>>     static int __init bpf_lsm_init(void)
>> diff --git a/security/commoncap.c b/security/commoncap.c
>> index dab1b5f5e6aa..4e9b140159d8 100644
>> --- a/security/commoncap.c
>> +++ b/security/commoncap.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/binfmts.h>
>>   #include <linux/personality.h>
>>   #include <linux/mnt_idmapping.h>
>> +#include <uapi/linux/lsm.h>
>>     /*
>>    * If a non-root user executes a setuid-root binary in
>> @@ -1448,6 +1449,7 @@ int cap_mmap_file(struct file *file, unsigned
>> long reqprot,
>>     static struct lsm_id capability_lsmid __lsm_ro_after_init = {
>>       .lsm      = "capability",
>> +    .id       = LSM_ID_CAPABILITY,
>>   };
>>     static struct security_hook_list capability_hooks[]
>> __lsm_ro_after_init = {
>> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
>> index fc7b69c5839e..1242c61c9de4 100644
>> --- a/security/landlock/setup.c
>> +++ b/security/landlock/setup.c
>> @@ -8,6 +8,7 @@
>>     #include <linux/init.h>
>>   #include <linux/lsm_hooks.h>
>> +#include <uapi/linux/lsm.h>
>>     #include "common.h"
>>   #include "cred.h"
>> @@ -25,6 +26,7 @@ struct lsm_blob_sizes landlock_blob_sizes
>> __lsm_ro_after_init = {
>>     struct lsm_id landlock_lsmid __lsm_ro_after_init = {
>>       .lsm      = LANDLOCK_NAME,
>> +    .id       = LSM_ID_LANDLOCK,
>
> Please only use one space after ".id"

Yeah, I got that from the comments on 01/39. I will make that change
throughout the set.

