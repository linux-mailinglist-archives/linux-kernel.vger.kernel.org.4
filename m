Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26E6D2659
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCaQ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCaQ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:56:11 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CD32116
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680281768; bh=AJiAukCC8U8cuyDn6Yxs5+uEGUTHBK3qlX68PN2Gmcc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Bm7b/KjmLlg3MUwTbpG8N9mIC57M7Z1It9L+Ml3F65fAxB8afoEtVLQ0FvuCORmI26hQaCh5FgYofxZI2UEstgEIIqdny2eNOUPw4vnpoKZBWYrWUevoaO81SIpl50FxSOvzHtnkIcG/Bs7EzZXbcSlqCznpGw7TIZsBbdbqSOToUU9QDyd8ZdbWMTEmkrGhmXtvTy+wQGB67C0ZpjMu9P5cChLAS0m3pgsbYhQZSpsrfNqIuEfpJOp/r1Zo4oouQeG05gWyCboF5CedaMjxfan4Yle84YgEc1tqsJYn4XO4ck8hq+Z5vWcrz2adjhXLaNu+jRzoQ0r5OJcM5SNeGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680281768; bh=Ws3vRXVYYZ3F+eteLxOJnA2FdDEB9nSSic9ajaJ7efM=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rh7FqULxB0t0aBAtmgslfm56z2JHDzjvwbvF03Ia42Jpfp//2xdfe3kurgPESFC3Wq66S9+D8mQgLfsiCkjXLe+AwyeRz09z2udcCqPqK9YvgZxo1wmHlc80VpDO1KJ6fjmFVLd5PH0mKQijUMxZ+NuC2rdHrc+V9UYEdHnKG4l+5uA1u7+g8vTUQaZkhWcfIWi4ynA/kJoe+4BSz1nV3qKMyraocP8bjr9h38pNWqASYTIdc+GZd74ChLfGdGCTG2sa36sDHMcMSmoyXCQrd+IkAndJ9koyh35M7JbOHyRwwYkorPAKLJwOOI7bG8xS/yry8PtJgRWcKgyZhKBrFQ==
X-YMail-OSG: _Z.2GnsVM1lYjdTyDOzIX2vB8tuFWeICkvCHutbtnXR8KJFHc0Akb.kto21bFcg
 r3Q.P050fgwLBda4rLeRCckq.VxgfqmsQ9OvNpzLL1OzVEiAbNtng0CoSzHIVGvMRvmC5Lgs4kra
 CPRvXvhQWIa0C2__diSIOB3djszlKZ_RpmiVnU8GNbff4owlG61XZJ6YcFua6xU8My4Ia6ifnZht
 KCy_f0mdF7700aAG01uS1mZuq_JKdDHklyy2MdZ_DtcXQ0Dm.72UW3L_PpgP8x0Bzcrvtg_5pxaI
 2fYwBiFqDAaWNb8IKmOdiIpRafcixn5KINizbL6VHSynICqdo0I57BKlLaIh8VSuI8SCJ7rQBO.V
 E4f2EHJCnYSRdKuu9Mc0BUnCt1vmaPlCzlfzGvS1a1QeG2Dc9pWFpGPdpk6RlYu1xF8gd8_BoPZO
 wAXTndEae9XK9y7jFubM36UtWDg7SdOEDT6C9T6lSmGLozFvk8c.1zVRbcRREMAkjPjyTkNN6BW.
 pmqjZRbns8xJWCFrVMvxp_s2sROmbGP5ySgKc2hvdrT4szCyXHmcOR81eSzQ3eUapAHgniQuGRU2
 QcOeeQrYAkDF8EuAhLhrtCRKJPzKkvmNJ6ToQa9fCPXnI2rZtCsGJl9LFD3xdXwWJAnoLv5Jsw0M
 HBvK4TU06krSgiHQhjSZvIgCND6aFm3PWQdnGzn3BHVMeMmKXfh2W0nbnXKsIzttaY.rvP87X.hK
 8hOlTQxl715IKXlL.fXRllm8BJG4FiBw12dKtdickphb1SJJxHtGvJmtoepkpTx3_L6hWtGTPLcg
 rc7dL5sydDazaSnpHfeqo8CrNF86glpJCvCgnTOpbuzPDwb23ZMTzKzqgmUrkIHwGI1QkjanGY_D
 nAYDGvjvDyToumzCrk4T3dztnL.dR4GREkB1t.BgpiD.P37zmoFh99G5Br14XenPxSSDspWsLJJO
 4AnnbSHQD27mQxDQuWA7bYr_1K8wRQ2GhH6lY0peBilWqThjcBGPP7inBs1BxHzWjcwd_SXJX9dX
 zGqW4pPvx0AP5CeIEBpLKHaZ4k_Bfd1Dc58b0o5IkklwZQySVjoWu892NaqZ8lT6KNjFy3f40o77
 vzalK1YnN4mAKcR2GzhkPEatjCViVwFRrMljiq0jjf9IM5MT9kFLco._rA8FOnWId5M7WU1pcVvU
 d4naphM7mnP_cN9Qu367vZmVUWLDXYGUK6Tb6V4gs4uvvZzfeAU7jtLTJiV5HslAmWmbgsqf6r7Y
 ZcaOrm5ZPeF92euP36zYwMIsYLFJXzt95Ck79KhFmVC9VNdtUTregeLDlXdBbpLw5uICX3Y7ukhV
 426wZfhMlr7RrEmTTMiSoaZwMAhND4slhcmK4AmrlVVUz6PgGfHd36wZQQ4s55QSjQsv.8kpLHGq
 qaE66PkjMC.hmoUh7CcHoQlIjihRjtiJzQ6jGyxUFKRQ9lz3IiCj0fnWEkaIAd1mJDjhOR2pZdzN
 jkC4SNuak0RtF5gNA5iZ.qgsfgjFeql0cnL32B6V_rRwe9doDPZnFSx.xNj361I5i4fuq6hH9xJB
 jdJv5i66AFEgSwFte5cCumB0Z82GCsCTPHDb1V_PiwQ0nLYTphhh1PVLN8k8y_Gzh4K7riIo7W28
 XkUKAI9DD9OyxjyyH3fg4E4PNCP64u5PTEneHFRwoXGu5TEdbZ2Lh4cIcU45HrwgYMdHyxZAWgff
 noF.8Fwrl6CZTtn40YScfzklF24BjbQC2eL9c7Ev7y2CM97yd_JMCdoBLR.L9VPX5G8gT3wJ3u0g
 j2l2Rxfg34Pqqovx5G_y58GCu4Ch_qfeTj2zJdGVXmHSShA98O9gBWF_RblBuTGuN5KyF53Mc1aD
 lvO2GJqDfVQAY6cu9rDwrnM3DdvuOy2K2oVLBwp1nzmRusvkiQsOrCzY6S146d6UaNl7DzYopq9X
 l3AHPGXtxQyrvq4JNF6GT_DWYg8RwsAZHcoDWlmkk1PAGPeEMZRGVG9Bky_2lQ7Lo7Xcq6fSqsrn
 pGm3g.QYkKvYYw8sdGbyzIzWby3hth543zmYLQBiUyv7ra3e6haoXOVi4cXwKw1vBWvXa17C2dn5
 dJrcKGF3rnh7yWrraPNbuHSjKlnAWy9_Fw3kUEy2Yr090aEkeFAmoFwXMlvMmYKYyx4BYb65JOvd
 Kb.J.OFAExZVM7Zhm5vzEFiGgq40W45Lt0vFI8jZ3t.MQv4UzM1qaQ4n5Vnz7nhZyZPniw3jAfnM
 .BvzCySxT0IgEcP1Yf4cYI33vgAPaeg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1d98ea83-6fc2-45c6-8cc9-493da977cec7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 Mar 2023 16:56:08 +0000
Received: by hermes--production-bf1-5f9df5c5c4-v79q2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 88f1a2f7e522d33700b3bc61befd142f;
          Fri, 31 Mar 2023 16:56:03 +0000 (UTC)
Message-ID: <00efa1f2-e6ae-3ce3-2bf2-03b7846568f7@schaufler-ca.com>
Date:   Fri, 31 Mar 2023 09:56:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 07/11] LSM: Helpers for attribute names and filling an
 lsm_ctx
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
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRVru1xK3SPp80cUX-jtVzpqhtieZ-RABjwJ8xi3GGm9Q@mail.gmail.com>
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

On 3/30/2023 4:28 PM, Paul Moore wrote:
> On Thu, Mar 30, 2023 at 4:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 3/29/2023 6:13 PM, Paul Moore wrote:
>>> On Wed, Mar 15, 2023 at 6:50 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> Add lsm_name_to_attr(), which translates a text string to a
>>>> LSM_ATTR value if one is available.
>>>>
>>>> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
>>>> the trailing attribute value.
>>>>
>>>> All are used in module specific components of LSM system calls.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>>>  include/linux/security.h | 13 ++++++++++
>>>>  security/lsm_syscalls.c  | 51 ++++++++++++++++++++++++++++++++++++++++
>>>>  security/security.c      | 31 ++++++++++++++++++++++++
>>>>  3 files changed, 95 insertions(+)
>>> ..
>>>
>>>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>>>> index 6efbe244d304..55d849ad5d6e 100644
>>>> --- a/security/lsm_syscalls.c
>>>> +++ b/security/lsm_syscalls.c
>>>> @@ -17,6 +17,57 @@
>>>>  #include <linux/lsm_hooks.h>
>>>>  #include <uapi/linux/lsm.h>
>>>>
>>>> +struct attr_map {
>>>> +       char *name;
>>>> +       u64 attr;
>>>> +};
>>>> +
>>>> +static const struct attr_map lsm_attr_names[] = {
>>>> +       {
>>>> +               .name = "current",
>>>> +               .attr = LSM_ATTR_CURRENT,
>>>> +       },
>>>> +       {
>>>> +               .name = "exec",
>>>> +               .attr = LSM_ATTR_EXEC,
>>>> +       },
>>>> +       {
>>>> +               .name = "fscreate",
>>>> +               .attr = LSM_ATTR_FSCREATE,
>>>> +       },
>>>> +       {
>>>> +               .name = "keycreate",
>>>> +               .attr = LSM_ATTR_KEYCREATE,
>>>> +       },
>>>> +       {
>>>> +               .name = "prev",
>>>> +               .attr = LSM_ATTR_PREV,
>>>> +       },
>>>> +       {
>>>> +               .name = "sockcreate",
>>>> +               .attr = LSM_ATTR_SOCKCREATE,
>>>> +       },
>>>> +};
>>>> +
>>>> +/**
>>>> + * lsm_name_to_attr - map an LSM attribute name to its ID
>>>> + * @name: name of the attribute
>>>> + *
>>>> + * Look the given @name up in the table of know attribute names.
>>>> + *
>>>> + * Returns the LSM attribute value associated with @name, or 0 if
>>>> + * there is no mapping.
>>>> + */
>>>> +u64 lsm_name_to_attr(const char *name)
>>>> +{
>>>> +       int i;
>>>> +
>>>> +       for (i = 0; i < ARRAY_SIZE(lsm_attr_names); i++)
>>>> +               if (!strcmp(name, lsm_attr_names[i].name))
>>>> +                       return lsm_attr_names[i].attr;
>>> I'm pretty sure this is the only place where @lsm_attr_names is used,
>>> right?  If true, when coupled with the idea that these syscalls are
>>> going to close the door on new LSM attributes in procfs I think we can
>>> just put the mapping directly in this function via a series of
>>> if-statements.
>> Ick. You're not wrong, but the hard coded if-statement approach goes
>> against all sorts of coding principles. I'll do it, but I can't say I
>> like it.
> If it helps any, I understand and am sympathetic.  I guess I've gotten
> to that point where in addition to "code elegance", I'm also very
> concerned about defending against "code abuse", and something like an
> nicely defined mapping array is ripe for someone to come along and use
> that to justify further use of the attribute string names in some
> other function/API.
>
> If you want to stick with the array - I have no problem with that -
> make it local to lsm_name_to_attr().
>
>>>> +/**
>>>> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
>>>> + * @ctx: an LSM context to be filled
>>>> + * @context: the new context value
>>>> + * @context_size: the size of the new context value
>>>> + * @id: LSM id
>>>> + * @flags: LSM defined flags
>>>> + *
>>>> + * Fill all of the fields in a user space lsm_ctx structure.
>>>> + * Caller is assumed to have verified that @ctx has enough space
>>>> + * for @context.
>>>> + * Returns 0 on success, -EFAULT on a copyout error.
>>>> + */
>>>> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
>>>> +                     size_t context_size, u64 id, u64 flags)
>>>> +{
>>>> +       struct lsm_ctx local;
>>>> +       void __user *vc = ctx;
>>>> +
>>>> +       local.id = id;
>>>> +       local.flags = flags;
>>>> +       local.ctx_len = context_size;
>>>> +       local.len = context_size + sizeof(local);
>>>> +       vc += sizeof(local);
>>> See my prior comments about void pointer math.
>>>
>>>> +       if (copy_to_user(ctx, &local, sizeof(local)))
>>>> +               return -EFAULT;
>>>> +       if (context_size > 0 && copy_to_user(vc, context, context_size))
>>>> +               return -EFAULT;
>>> Should we handle the padding in this function?
>> This function fills in a lsm_ctx. The padding, if any, is in addition to
>> the lsm_ctx, not part of it.
> Okay, so where is the padding managed?  I may have missed it, but I
> don't recall seeing it anywhere in this patchset ...

Padding isn't being managed. There has been talk about using padding to
expand the API, but there is no use for it now. Or is there?

