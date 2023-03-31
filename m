Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211496D2952
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjCaUWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjCaUWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:22:21 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437CACDCC
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680294139; bh=oU/Tdf6sYmTw3aco+axZ7rxCwBOvqFVm9k8nt4J6mdE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=pYcBD+JaiqosRCQveW53L72iqxCYCK7OHohdglOgbyAyVopnZTmZbOvAcJ5hV+KA+cx3KLF+PDT56xEhG6GYTh1H/JQ/Npkcz4nfCss1sVfCtVzNIg8nbbK14NDgIQWnUYyAqDKwveGwI2hHMaZzs16iR9RAq4PmVxILZlATvdMjl/6SfJYoc8gYWuWZpDhNogkRjkaHCYsYmdXPf3sN7Beje1OYFX5gLAhVOCjEie+Pxsf2N3iKORUOARTBm04GHkNawC3PXXMIFqORwJUdJea2mQaEzZNeabGla9LAmxkPpDuyuRe/7PDPybRix9sQ/GhMYj7X3XK/I1QIJA2VXw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680294139; bh=IJGZnE6QhBL7VxH8DhDkGnFKWw3hYDd58HbwKXHyemX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QpZT90UBM+CbAwa7USVahS4GshO4IUvjnMkHGCYP2KFe0TBLOAmVkE2hJWQJOiyaCQ1Tl/7C3D/D2YbLODzQN3EbHAwyV8sINgT55Isn79yy7iioHZeyqCCGUMurVg+YILYAxzJnqJhGJ7u3XSvkUmcFhEdpR/pL0h4GEFrgCh2cnPAUikETom3dGiY7RUy0ndsX3P8JmJEZgeTDe6MO6+0D3uFxCRcuW7T7SIA1eTVWMEd///Rn1JO6+3a5bNeowvLYcucHjPwTDQ7n2cYiTAozZq81ScKZkPYQMjGGG6cnvHKcPA5xuT3eq545fbCgVlOZM6ROp4IUK1eZ6ZzmEQ==
X-YMail-OSG: 4H.nvpQVM1mEeYdrkhq3jKUmifaeOaSkL24rPuGGLbzT5uIo.dIE8nSGku7KBEa
 XZWasjzgIq5AkABisgn81S75B1gCN.2_dVelF5nC_lRAc9NY_GRbMs1GftA44nfJlIr6EaaulynD
 RBQLHjtqpYCujLt9KjR5E_FxA8k0MDAttku9hC8DiNaG2VVrZoZKky.nb0zLcrU8oJs5Qta.gyHB
 MaXpzBvDMgXyx3cN7FJuYXxzfukfzBIZ0xtW4az0caeT2C.OJWXWuhjogFQjmwIkD0SN8lvDZCR0
 Ko3p.aReZNb6dBgfU4RGn5mM5nQSLnnkP7OemQFmXxlTt5ExPTV.FtWgnln3CvJIT_OXWCSy3ggJ
 XMjRv0DWMEsamJGmxlyTepfTs9Pb2s8qPDVaSMF6o4.xdq_n69TiCeQra4BU6jrLwiZAGLBV9pMZ
 bkzY18KADSZZSJUE.d1Wq9ownzbgwhodyH4MWtM9gy1KDAgLpgkZ8wsmulLRuLcg4YUhvXnSX0dk
 kG_jKHSDsWb5hBdW3BtExUZEGlq3CfYrUMF8nNsL2cqDGvzR99HyGfbOINtfCygJc6EwnBAzLi1f
 jpm8MwkjLiAGBpaLYKIHfwtpYTdIcSKY5qoUUIKZhjq5bwrW__BMtLShuuYdLgQqSZPbzGgdStpQ
 dJoDZ1mPfHKsdNEZlxmHu1b.yO_XupP1dz_6SP1JKuHe20Tn420I2Z_aUajbCue1Bu9zygCatBik
 XDoUV7y2tBTzSlHtsLirEnBMq0snZ0uECntE3V9AnIKYxX4eB5IzlFWV68X2zGXFOyp2WhDfK1pR
 55._RQuo_n1C9mdri.AVXoidpXyTY226YQynBPGfHqkJdng_6dIoE3cqYODsaWGjyR3c9oJ7d3ZH
 zU0wggVWIb2jcYiY_2eR.LBoPwJRZcRnYkvYW81Yta8033M9Mg2EWve3VPnXnfg.J6te.gWrPkfF
 6Am2stUDugW5_o59lzA5e9vDOwHD5WqetEqPbuwnfZuqK5IFNkAh4gwNXMUIgvJmZbI_YS6QnCQ_
 qgxi06yXLzSTY4TtKW8deTFWFqnMfduh1E6oucsMxxppI8j6u9rV2Q_U2uYc2BXpYUGbJ4A4pD4v
 m6V5vmU7xojh8Ut1PlOLVm464qAoVJ1IVaI14YsizxAjQNOiIQo7C_uIpMVjSZF2JTabGTF3X9sZ
 VrGcjfMwdA8NRFdtnhsNUKfze.681_gO5mwPIITDYLOXNbZz8K_gAwtWk1eD_tLXi9AE8vclcmSa
 BCLVEV674mhZGoz0yA.1Lw3Monmyo5Ij3NbKpHPQoFVUXwN9_IRI_7Nc9iire6Sp4M0BdY1Xzeii
 dDh.pKG_LLkIbB8V6fmH2pMXhuaNa_mxyaOF0NLQRjAQ13VQxGk43UKRuAS.7scJm0n58pmV1Ovw
 1aWEMLSD9S9rTmTJWnuHXLAND60syYVnU6Wi77I4_VKtGc.i5OPYmDXoIml44rFty0FDYumgcHUK
 oYGc_q3X3vDwVFjhSCgoTE.7K5_vFqLE56x8U3vHMUe0U6mqEs1zQbBbL_4ZHNE8EfzLGi8XgERT
 iNJSnmwxAJwcxEfBiyd7VyJZ6kI5bd_Pk32H97RuzwaiEz8n3dc.orN1JNIHcLJUYCgL4b6YoNHx
 db_nmO80pdXjXYQNyFax6jTYlLxfcdudXt2eEDULfAhvvaBzASTZZcjEkljYDQRseeB3bzCmf7wR
 VhJusvnteiICPLdTPGVkJLWq2RbUYwEjKUYqZw.IPaIvZzgPRfTbYa8SfJRSZF_Tv9va3SBV4YGs
 uqMDI.zcTPLeXz2R0H0s9SvRuBlpafd_mc9nfjLcLrJZo_tlWTlhhb0bk39afZUITUxkG69x0D3x
 jybe13RVgdDXXJb3vMJ8fnFFKTYKLeaatCiLDwBK_GoYvC5wJrWjMtry6DZ0uU3Lb6DkdLQ1nUCL
 1KvP1_QFkGrE0eFDw4LHQOzyfAKywQqLDeGoTgbBGfNWQTwy_zw7CeADi1imjm3BRFQfRZsltRpS
 CsnepI4KkEpt4hfzU.9s553PWuiqcEcq2mI.YaiXtc842jFRD2fW4t2sT_5ifZoUfFUvN0cYIi.A
 JOuAJZ5GZs3C0EKnWt8iQhXdqLfKTDckNOVwlR6yW9YKq.GsyiTOasVI_8SrGC.RoN91z8xEwjkN
 zS61ofpO4.IMS9Wb9VLm0TTCqcjtWOjdHKW7tYRl49IfOWmVgkZ6xpRolhwlg30IgzLpaNnZJRyc
 Cvx2QoLZDDyt4cVSyQT5bsWru70HTgaT8e_8GQ87jMj6Kesc_33UeV378NwA2LkU7aj1dZqUzS1B
 mPXo-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ef5d62f2-06b6-489e-8ef0-412c4d39678d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 Mar 2023 20:22:19 +0000
Received: by hermes--production-bf1-5f9df5c5c4-84ds6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6c3f2bddf4a21a30b25aefd87ebfa34d;
          Fri, 31 Mar 2023 20:22:16 +0000 (UTC)
Message-ID: <07e175ba-bf3c-aff9-7546-4f168bcd69fb@schaufler-ca.com>
Date:   Fri, 31 Mar 2023 13:22:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 07/11] LSM: Helpers for attribute names and filling an
 lsm_ctx
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
 <20230315224704.2672-8-casey@schaufler-ca.com>
 <CAHC9VhT9j78jC66xv-pV1iPmgEK6=fHddFVaAS8Qmm_WyYMypQ@mail.gmail.com>
 <c79a66f4-53c0-66f5-4539-4994365aa656@schaufler-ca.com>
 <CAHC9VhRVru1xK3SPp80cUX-jtVzpqhtieZ-RABjwJ8xi3GGm9Q@mail.gmail.com>
 <00efa1f2-e6ae-3ce3-2bf2-03b7846568f7@schaufler-ca.com>
 <CAHC9VhRPiGs72CrUT1Fhoykfzx8wp13L7XVYEYOmdwoFk=kFnw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRPiGs72CrUT1Fhoykfzx8wp13L7XVYEYOmdwoFk=kFnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/2023 12:24 PM, Paul Moore wrote:
> On Fri, Mar 31, 2023 at 12:56 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 3/30/2023 4:28 PM, Paul Moore wrote:
>>> On Thu, Mar 30, 2023 at 4:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 3/29/2023 6:13 PM, Paul Moore wrote:
>>>>> On Wed, Mar 15, 2023 at 6:50 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>> Add lsm_name_to_attr(), which translates a text string to a
>>>>>> LSM_ATTR value if one is available.
>>>>>>
>>>>>> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
>>>>>> the trailing attribute value.
>>>>>>
>>>>>> All are used in module specific components of LSM system calls.
>>>>>>
>>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>>> ---
>>>>>>  include/linux/security.h | 13 ++++++++++
>>>>>>  security/lsm_syscalls.c  | 51 ++++++++++++++++++++++++++++++++++++++++
>>>>>>  security/security.c      | 31 ++++++++++++++++++++++++
>>>>>>  3 files changed, 95 insertions(+)
>>>>> ..
>>>>>
>>>>>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>>>>>> index 6efbe244d304..55d849ad5d6e 100644
>>>>>> --- a/security/lsm_syscalls.c
>>>>>> +++ b/security/lsm_syscalls.c
>>>>>> @@ -17,6 +17,57 @@
>>>>>>  #include <linux/lsm_hooks.h>
>>>>>>  #include <uapi/linux/lsm.h>
>>>>>>
>>>>>> +struct attr_map {
>>>>>> +       char *name;
>>>>>> +       u64 attr;
>>>>>> +};
>>>>>> +
>>>>>> +static const struct attr_map lsm_attr_names[] = {
>>>>>> +       {
>>>>>> +               .name = "current",
>>>>>> +               .attr = LSM_ATTR_CURRENT,
>>>>>> +       },
>>>>>> +       {
>>>>>> +               .name = "exec",
>>>>>> +               .attr = LSM_ATTR_EXEC,
>>>>>> +       },
>>>>>> +       {
>>>>>> +               .name = "fscreate",
>>>>>> +               .attr = LSM_ATTR_FSCREATE,
>>>>>> +       },
>>>>>> +       {
>>>>>> +               .name = "keycreate",
>>>>>> +               .attr = LSM_ATTR_KEYCREATE,
>>>>>> +       },
>>>>>> +       {
>>>>>> +               .name = "prev",
>>>>>> +               .attr = LSM_ATTR_PREV,
>>>>>> +       },
>>>>>> +       {
>>>>>> +               .name = "sockcreate",
>>>>>> +               .attr = LSM_ATTR_SOCKCREATE,
>>>>>> +       },
>>>>>> +};
>>>>>> +
>>>>>> +/**
>>>>>> + * lsm_name_to_attr - map an LSM attribute name to its ID
>>>>>> + * @name: name of the attribute
>>>>>> + *
>>>>>> + * Look the given @name up in the table of know attribute names.
>>>>>> + *
>>>>>> + * Returns the LSM attribute value associated with @name, or 0 if
>>>>>> + * there is no mapping.
>>>>>> + */
>>>>>> +u64 lsm_name_to_attr(const char *name)
>>>>>> +{
>>>>>> +       int i;
>>>>>> +
>>>>>> +       for (i = 0; i < ARRAY_SIZE(lsm_attr_names); i++)
>>>>>> +               if (!strcmp(name, lsm_attr_names[i].name))
>>>>>> +                       return lsm_attr_names[i].attr;
>>>>> I'm pretty sure this is the only place where @lsm_attr_names is used,
>>>>> right?  If true, when coupled with the idea that these syscalls are
>>>>> going to close the door on new LSM attributes in procfs I think we can
>>>>> just put the mapping directly in this function via a series of
>>>>> if-statements.
>>>> Ick. You're not wrong, but the hard coded if-statement approach goes
>>>> against all sorts of coding principles. I'll do it, but I can't say I
>>>> like it.
>>> If it helps any, I understand and am sympathetic.  I guess I've gotten
>>> to that point where in addition to "code elegance", I'm also very
>>> concerned about defending against "code abuse", and something like an
>>> nicely defined mapping array is ripe for someone to come along and use
>>> that to justify further use of the attribute string names in some
>>> other function/API.
>>>
>>> If you want to stick with the array - I have no problem with that -
>>> make it local to lsm_name_to_attr().
>>>
>>>>>> +/**
>>>>>> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
>>>>>> + * @ctx: an LSM context to be filled
>>>>>> + * @context: the new context value
>>>>>> + * @context_size: the size of the new context value
>>>>>> + * @id: LSM id
>>>>>> + * @flags: LSM defined flags
>>>>>> + *
>>>>>> + * Fill all of the fields in a user space lsm_ctx structure.
>>>>>> + * Caller is assumed to have verified that @ctx has enough space
>>>>>> + * for @context.
>>>>>> + * Returns 0 on success, -EFAULT on a copyout error.
>>>>>> + */
>>>>>> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
>>>>>> +                     size_t context_size, u64 id, u64 flags)
>>>>>> +{
>>>>>> +       struct lsm_ctx local;
>>>>>> +       void __user *vc = ctx;
>>>>>> +
>>>>>> +       local.id = id;
>>>>>> +       local.flags = flags;
>>>>>> +       local.ctx_len = context_size;
>>>>>> +       local.len = context_size + sizeof(local);
>>>>>> +       vc += sizeof(local);
>>>>> See my prior comments about void pointer math.
>>>>>
>>>>>> +       if (copy_to_user(ctx, &local, sizeof(local)))
>>>>>> +               return -EFAULT;
>>>>>> +       if (context_size > 0 && copy_to_user(vc, context, context_size))
>>>>>> +               return -EFAULT;
>>>>> Should we handle the padding in this function?
>>>> This function fills in a lsm_ctx. The padding, if any, is in addition to
>>>> the lsm_ctx, not part of it.
>>> Okay, so where is the padding managed?  I may have missed it, but I
>>> don't recall seeing it anywhere in this patchset ...
>> Padding isn't being managed. There has been talk about using padding to
>> expand the API, but there is no use for it now. Or is there?
> I think two separate ideas are getting conflated, likely because the
> 'len' field is involved in both.
>
> THe first issue is padding at the end of the lsm_ctx struct to ensure
> that the next array element is aligned.  The second issue is the
> potential for extending the lsm_ctx struct on a per-LSM basis through
> creative use of the 'flags' and 'len' fields; in this case additional
> information could be stashed at the end of the lsm_ctx struct after
> the 'ctx' field.  The latter issue (extending the lsm_ctx) isn't
> something we want to jump into, but it is something the syscall/struct
> API would allow, and I don't want to exclude it as a possible future
> solution to a yet unknown future problem.  The former issue (padding
> array elements) isn't a strict requirement as the syscall/struct API
> works either way, but it seems like a good thing to do.

Reasonable. Thanks for the clarification.

