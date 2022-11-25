Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE8638FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKYS1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKYS1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:27:13 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FF92528C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 10:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669400826; bh=/NUNrlZGnZR4OqxJFp+PWjokf/uZSsS2KyVxQlEK3tM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Q9OwkSnEMRvKD/lxN+9hw77bE3Z8v19owUiTFHVNNtzkGJvrcbFl0p4LcL0epiqCnSyc51r1W9/hsP92n0lgye8+cF8sqLyVW91zSNNJ0loI/Crd0A4Zq4dV165d0g9K0oyBk5nXBmcGAD8orqhvoOAI8+1ZQJ8WgM9PoTTTOoQOjbATMq6k0pXtXytakqPr3VtMWp90JQlwF0okg+ACLATssMzM2dNSE4A+MGuhkfJmW2i2plDRNZsLhialRjhuKESpTe1WPK9miMCdslE92WFtGeWUYucRXL0i/Xflshl7eQdoX1yVn8jJp54x0ovmvm71W1pJWsSgm8Am9w1e5w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669400826; bh=azES7AsXg3ID91BhuRdwp+fxapC9mJn9FGYf+OlIV7j=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jiyOOsm9LLa9e5OpeiayRNZDrcWgVLMBjmEk0hjMkAA54poc+sKJtHBlwvWJU8++wmVrPebZ43qgpbHzzzepVY4YxEU1pJYAQjlM/XuG/MT9Rxm36PeGyUKURnuP6iv29Tl2jChZaeS3BjBYAdoo9l9qGR/VruMKEZojYRJQOZjZ1gqdjRJSAjSxsT6X/5Sc6/VDJS4JIKwk3J+gMO+1DmwcgHsTeQUuim227Kk1fLNEKKEXww4kRqw/YcuRXL8Xtt8NDAN+Vwl74N13mCCtFamFhLhIL9GH8ARM44weTyPfdmz3x7ScJIuXPrFFFs6gyYNrdzZfzsSWlKx9x58Iog==
X-YMail-OSG: 6XnPz10VM1kZTsP92foonxN3asjLlibf.B1D87Ypl3N0MmPAZ0G1alIttFz0eXX
 .13s51op3l6P3xs5C86_JGryPV5l18kA0w8YTHiTSkDbNUE8AY0qxDNZ6OwwqYsktjVdfGW8vZv9
 lL6JQuDgc5NXPQG.bOymNi3KWBlqXWB1AjzDWX7EVKFUO_YWB5aqYoN6UEna0MVhOSXAg.Vk2Q.d
 .Vje_xPgwhScfKEYBKz5xuVqnDuDK40jOHmDtNvT4Cuexpm.Sqi8VLvZroCkHSr2Q.xi0rkSt6vl
 bTl3DDnI9WadErqn7SxqTweq5m9gx9nsEPlr83djoQg5uTaG8kwuugoW_HHzyonT55vRL0YUbYEb
 bINoaOYAHblcvoGk_lIOs9Hk4VC3sz6.NeR0GfQsUqRkimwkBGxfDnZrAFvrlj987qHRvNG5S7o5
 1u7l3VDcmCd9j0lEg8_hKZMQnoG4LApJRDMn6CT_5jAGcy59B1iOe0UR4J1ibIo0cRLJhTOaAowP
 YPi5RtDIi53hoKtvJ5do4kO6f1TbOXyEv.gemkUGhK_sEvia.3g6hyH2hGODYtjoCWaOXezTw4PS
 clkHHO9mZvnCeKihFKOniPd8iaKvGdGH9D1nsHlMuL9a0lkCJOdTPX15VB66MUnSNpLH0F8LlAgt
 ucPdAauY7ihD6J5UDbaH2a.OQypQGgkqXPCXGjJNtBYmFe3.0k1mIG5h9yg5oUn_H_EMF9wiJtja
 WFrJ_yQhsOitiPo3QO3__Na1Cf_fwXpYb6jsd8JsJsKm7N.XwWXxhevgOvL9PXe4ntnvVD8bnX_c
 q7J9uHs06YQdX2GeBRJ91LG9sSSGGAOcvaKbAqPUUkxaq15C5097Ij0tuCKXKPBEBju5iZJxvjO1
 HcJx46e0cgvYGQYypXnH8VG8e1FWeQPY1zyXsCPMQRK8ZnShmWkcs4NrkBc8VcZAE5F1O.fMqx_v
 UPOqzS.iS1dUY_vQMMkKh4YiRdt5NcvESBGHSu60q2WFRPiVCQ_cWy8ITjzJPkR4vSAiIsOXantA
 Lv0IAXfi5Knz4kHj7HH2ucnZqZ9K8d8qlk89zgm6HdjKXpmpyjgAAbDMV9JzRTjdkqXdLR4t9pto
 l6z_XVEgLAHhQSh0QjLvItE2SwE4FP1EmQeru9cl4dCWSByUq36_VZLVztWh32iJwzWw1GqYdBw2
 _79JR9__UF0T3el.lxykX9lwVYDNDhjqKS4XbCUj2JSoT6rydaEBHFE.7ys2oGW9W4rdxPLlF.15
 kcNKExFCYCKcVL52dWNJ10dJOw1O0JRFH27oNvwYxYo6Kr3FAy95HpQ6HrcTdgp77X_dTIPQHxEP
 ty64wgMEW1Ewf86gOt3yyRYHmAIUklGmlzNEjHTWStL.TZRPRB6AXpzSPzF_YpUrlYY73_WvrXXM
 6SS5V6_7Y3.TtUpBgUEPPlkYxpQDtQ0UIqrDnsnjBZy3oY1KQQ2MalQGgE0CmlPr90gc0XvXiAbw
 oTf_H5uLr_qQNfavxFC0CTBwZBB2pMmh_jSH.jO1J0iAaksklcNNuwxOJh.riIi_E7KlJVAaEqj_
 1.hsU6BRcDvbYYOsRHvH6Q2YMIo_aIc660h_8VzhyQiZBSju0r3dfqTKZma1LrdffPErx4ujmzqB
 hF4WPLMpXBk7EjzH_1ZHPlVn2uxG6I._cGHcoRYu4VmPe5JQfdrrn4Udb.nwg1bfC0WWiqF5x3UL
 zrEHYvpsh7zdHM5BgmuEH0Q1NCXNCZRHBQcSrxeMC.u2KzO7Bfr.RlbhKWVfCokftoTAyqY29Ubc
 .uEWm4BspOlN5ghZ5VuUYP9wsWgwkyxsDY1UGa5EgbB3CpLZlgl3VeRYv1k71YC8Zfh7nSNnfYdv
 JjqKvyquG3hk612hOITDKVrF4krRHyvLn7a1biVUd9yowmRAD2AF9ER9QUHqpKNALh.ELdiS00wc
 dWU0UbM5PywsEAVexdv4QrU4V4rfZ08i2jtc_IPjvBoIC_bR_huGR6Oo.AYcO289ZuNUXl0IZUjZ
 eiUZT4AjQvlmUmGxLR0PZ0MSlReodZIEjS.ADciokogQWmY_.hNvf8vUgXiNQYNoY5Usb148Yzi8
 37xUZzAtXvNc4TpuQEMjTNkBuzhDTEuaQj.IKRU0asJtLIhlKCoe0FculVt9zefp4jHTSqcsxGGj
 g4MzHxp6SZQ4DaYtGYYKZ3FXH9ZY5AN6KzLphR_zTntfNchMV0juGKCUt1IRT.5zLmUjC03c.bT6
 FwDxsZNbLxCbFq94SE0ZdpNGc
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 25 Nov 2022 18:27:06 +0000
Received: by hermes--production-gq1-579bc4bddd-lqm2b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8d8dc2da86bb2b4cc8e4755f9cf9f779;
          Fri, 25 Nov 2022 18:27:04 +0000 (UTC)
Message-ID: <e75185e6-9b16-82a8-5d9b-cdfdc60962bf@schaufler-ca.com>
Date:   Fri, 25 Nov 2022 10:27:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/9] LSM: Identify the process attributes for each
 module
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, casey@schaufler-ca.com
References: <20221123201552.7865-1-casey@schaufler-ca.com>
 <20221123201552.7865-3-casey@schaufler-ca.com>
 <a94f2bf6-1429-af6d-64a2-3403f60c8ba3@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <a94f2bf6-1429-af6d-64a2-3403f60c8ba3@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20863 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/2022 8:41 AM, Mickaël Salaün wrote:
>
> On 23/11/2022 21:15, Casey Schaufler wrote:
>> Add an integer member "attrs_used" to the struct lsm_id which
>> identifies the API related data associated with each security
>> module. The initial set of features maps to information that
>> has traditionaly been available in /proc/self/attr. They are
>> documented in a new userspace-api file.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   Documentation/userspace-api/index.rst |  1 +
>>   Documentation/userspace-api/lsm.rst   | 55 +++++++++++++++++++++++++++
>>   include/linux/lsm_hooks.h             |  2 +
>>   include/uapi/linux/lsm.h              | 12 ++++++
>>   security/apparmor/lsm.c               |  1 +
>>   security/selinux/hooks.c              |  2 +
>>   security/smack/smack_lsm.c            |  1 +
>>   7 files changed, 74 insertions(+)
>>   create mode 100644 Documentation/userspace-api/lsm.rst
>>
>> diff --git a/Documentation/userspace-api/index.rst
>> b/Documentation/userspace-api/index.rst
>> index c78da9ce0ec4..6feff0fcd88f 100644
>> --- a/Documentation/userspace-api/index.rst
>> +++ b/Documentation/userspace-api/index.rst
>> @@ -30,6 +30,7 @@ place where this information is gathered.
>>      sysfs-platform_profile
>>      vduse
>>      futex2
>> +   lsm
>>     .. only::  subproject and html
>>   diff --git a/Documentation/userspace-api/lsm.rst
>> b/Documentation/userspace-api/lsm.rst
>> new file mode 100644
>> index 000000000000..6ddf5506110b
>> --- /dev/null
>> +++ b/Documentation/userspace-api/lsm.rst
>> @@ -0,0 +1,55 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
>> +.. Copyright (C) 2022 Intel Corporation
>> +
>> +=====================================
>> +Linux Security Modules
>> +=====================================
>> +
>> +:Author: Casey Schaufler
>> +:Date: November 2022
>> +
>> +Linux security modules (LSM) provide a mechanism to implement
>> +additional access controls to the Linux security policies.
>> +
>> +The various security modules may support any of these attributes:
>> +
>> +``LSM_ATTR_CURRENT`` is the current, active security context of the
>> +process.
>> +The proc filesystem provides this value in ``/proc/self/attr/current``.
>> +This is supported by the SELinux, Smack and AppArmor security modules.
>> +Smack also provides this value in ``/proc/self/attr/smack/current``.
>> +AppArmor also provides this value in
>> ``/proc/self/attr/apparmor/current``.
>> +
>> +``LSM_ATTR_EXEC`` is the security context of the process at the time
>> the
>> +current image was executed.
>> +The proc filesystem provides this value in ``/proc/self/attr/exec``.
>> +This is supported by the SELinux and AppArmor security modules.
>> +AppArmor also provides this value in ``/proc/self/attr/apparmor/exec``.
>> +
>> +``LSM_ATTR_FSCREATE`` is the security context of the process used when
>> +creating file system objects.
>> +The proc filesystem provides this value in
>> ``/proc/self/attr/fscreate``.
>> +This is supported by the SELinux security module.
>> +
>> +``LSM_ATTR_KEYCREATE`` is the security context of the process used when
>> +creating key objects.
>> +The proc filesystem provides this value in
>> ``/proc/self/attr/keycreate``.
>> +This is supported by the SELinux security module.
>> +
>> +``LSM_ATTR_PREV`` is the security context of the process at the time
>> the
>> +current security context was set.
>> +The proc filesystem provides this value in ``/proc/self/attr/prev``.
>> +This is supported by the SELinux and AppArmor security modules.
>> +AppArmor also provides this value in ``/proc/self/attr/apparmor/prev``.
>> +
>> +``LSM_ATTR_SOCKCREATE`` is the security context of the process used
>> when
>> +creating socket objects.
>> +The proc filesystem provides this value in
>> ``/proc/self/attr/sockcreate``.
>> +This is supported by the SELinux security module.
>> +
>> +Additional documentation
>> +========================
>> +
>> +* Documentation/security/lsm.rst
>> +* Documentation/security/lsm-development.rst
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index d306db1044d1..7e88acc37a29 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1606,12 +1606,14 @@ struct security_hook_heads {
>>    * struct lsm_id - identify a Linux Security Module.
>>    * @lsm: Name of the LSM. Must be approved by the LSM maintainers.
>>    * @id: LSM ID number from uapi/linux/lsm.h
>> + * @attrs_used: Which attributes this LSM supports.
>>    *
>>    * Contains the information that identifies the LSM.
>>    */
>>   struct lsm_id {
>>       const u8    *lsm;
>>       u32        id;
>> +    u64        attrs_used;
>
> I'd prefer this field to be part of the previous patch. This doesn't
> change much but it is to highlight that the struct lsm_id size should
> not change unless properly handled by userspace.

Sigh. Given my druthers there would be a lot fewer, but somewhat larger, patches
in this set. I will happily make this change, but fear reprisal from those who
want a bizzilion tiny patches. (You know who you are) Also note that this is not
an externally visible structure, and that the lsm_ctx structure that is user
visible hasn't been introduced yet.

>
>
>>   };
>>     /*
>> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
>> index 47791c330cbf..8e9124bf622c 100644
>> --- a/include/uapi/linux/lsm.h
>> +++ b/include/uapi/linux/lsm.h
>> @@ -29,4 +29,16 @@
>>   #define LSM_ID_BPF        110
>>   #define LSM_ID_LANDLOCK        111
>>   +/*
>> + * LSM_ATTR_XXX values identify the /proc/.../attr entry that the
>> + * context represents. Not all security modules provide all of these
>> + * values. Some security modules provide none of them.
>> + */
>> +#define LSM_ATTR_CURRENT    0x0001
>> +#define LSM_ATTR_EXEC        0x0002
>> +#define LSM_ATTR_FSCREATE    0x0004
>> +#define LSM_ATTR_KEYCREATE    0x0008
>> +#define LSM_ATTR_PREV        0x0010
>> +#define LSM_ATTR_SOCKCREATE    0x0020
>> +
>>   #endif /* _UAPI_LINUX_LSM_H */
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index b859b1af6c75..3a6bf4f95d84 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -1206,6 +1206,7 @@ struct lsm_blob_sizes apparmor_blob_sizes
>> __lsm_ro_after_init = {
>>   static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
>>       .lsm = "apparmor",
>>       .id = LSM_ID_APPARMOR,
>> +    .attrs_used = LSM_ATTR_CURRENT | LSM_ATTR_PREV | LSM_ATTR_EXEC,
>>   };
>>     static struct security_hook_list apparmor_hooks[]
>> __lsm_ro_after_init = {
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 5fcce36267bd..e831d9c38c54 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -7018,6 +7018,8 @@ static int selinux_uring_cmd(struct
>> io_uring_cmd *ioucmd)
>>   static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
>>       .lsm = "selinux",
>>       .id = LSM_ID_SELINUX,
>> +    .attrs_used = LSM_ATTR_CURRENT | LSM_ATTR_EXEC |
>> LSM_ATTR_FSCREATE |
>> +              LSM_ATTR_KEYCREATE | LSM_ATTR_PREV | LSM_ATTR_SOCKCREATE,
>>   };
>>     /*
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index c7ba80e20b8d..c2a05217bde4 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -4791,6 +4791,7 @@ struct lsm_blob_sizes smack_blob_sizes
>> __lsm_ro_after_init = {
>>   static struct lsm_id smack_lsmid __lsm_ro_after_init = {
>>       .lsm = "smack",
>>       .id = LSM_ID_SMACK,
>> +    .attrs_used = LSM_ATTR_CURRENT,
>>   };
>>     static struct security_hook_list smack_hooks[]
>> __lsm_ro_after_init = {
