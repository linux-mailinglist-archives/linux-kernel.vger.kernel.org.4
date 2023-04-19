Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63656E8524
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjDSWoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjDSWoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:44:19 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D433426A2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681944194; bh=aSold790iIFBdC8z4K+bYyXd6pqgIE8gjXw+bOy50tI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=B/cP7IIwF5RVu8HdDhqOXtNn9L4W69IaJCXAAD8vILz89TBbDJbwZOgMFv/pemg72wyCpXNV6+2/+PB9JC5bialXeWfEJZz24ms+vlb0sQXxYR3YMb8Ete9XzsPx9mVW4dyOBXUeIPImCSb54iK7jknsLCnMqRiI4ndbNOjBNtqE9rLEhjj/6E9loFBv0Q46UKVVDYwIamJR6W9VSoo8q4W56WmrhEhaKNvJ4lPaxSKfu+D0NvHVpb38x3DCidGCy7jUb+Idkn3uid50lYIBblU53/QSBbtH2VsfkfN8AhmwIQKZn7cf0vfVa7mZEaEP7ksXKVAf4qVzFdnFh/bnAQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681944194; bh=XbTz+XVt07a0Vae6EW6gqggew345TBi1HU33eu+Bmal=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ecwyFbs8Ml9TxTyEQVTLrWhzr2ad3OQ7SQllVffd/Xtb/TvUx5V9c8aukVFk+TXuh88H3yZcsPhO/mJyx0igYhiCqudMwsCLnw9Mx4ZIlc3AVgqbUwg089t+0hcKya7+mIFT/W1WObo9FbrFx5XE3+yV1uUZq3DvzRd3j5Rl7oIDbUt8NYiDR3CzwbHBHvpOIHeofpJ6lPuaV18tDJcHY4kIdS5IHyG0Cq9ZvouhvXp836l9PcssxZiRqy34+ZmIxUShm8MGHGVUD5K8e+k1HVblJg//lreH4qph0kHLf6xWQTF3uTJcF6mtyThVkd3R06FWJmwZ1YA4Rr/niHvtrg==
X-YMail-OSG: WAmE6TUVM1nuSeBfV_IcibnQZnRaewdcD9OKlw2SZsT9YZ8QhtH_Ztt07XO7_Dj
 3cuhXBlZWLY4HnBAwALciM6Sd7UyAGVkz46waOJct0HbPDH0e55NWo_54ol23BCS7nNgfO5zXAwE
 5SJOvqiIs7NLIwmpLDyeR0fL9sF_vuw8OmfvIK6_KT7Difoh92A77VnkFbqDudW2MTR6wU2Yxeqm
 dLLxThBGwRS3H17hmuTIrkYo31ZYSNCkbJaRUQX0GdrMXVuER6SdsQTZN2GBwalP7X1wkUM2m9lW
 g6.66XyaNw_rPbda7BEoF606QoKW1kstDCNHF8xAgXfxaTQchrHzSeXqmkTZsPdfDJOeTFeq1Hb1
 5I1WeCdsJ2GrktOtr3pK4zCFekroQsxBgphZUo4eMhhZEUyysmUNR.WlFkm.dmRVrQkot.8YJ6mr
 DuHMNs.KGFnxG4oz4mcuxfjJjupYtEW_nyp883KUg3Z7WqoyI_md3WW3hY6WYjlgYelXvedwJy4s
 PZDDJwGPUqOIvMG4quEqkO47Sg1chZ0cFKoswI.b2h8NJwdIFEfld0pTF6jkOvV_dopExN8ooiEF
 kHIgcYIjD__i1eD5G9DHS3uHY3Wu.x8xCNptMOvBUvcE3_9Vtgbtqfz9EbsUWVE6RY1KYocghep0
 AOMtfWHl1.VWCjGML72T.toEE_gH9ygXeRag1LaOEVbQD.6L4QaGZpLZ6mo2ASajWA_l7dubzDw_
 jxpBeTc8eIT5ANM0zYCs3bRWHN5lF3wRwkrj5K6.qKcAlQLpRV5UjrWJ46w0fqjVu29Qr9lBDz4e
 GzlKxuyV1tRERKE.My2PYTy7p3hbrO_KXf8RUigENH6dZWnvM7qrDGtxDPRisUWObS3NJ2sxOa.g
 nGVqh_KLXy_5ExCud4v4ZOXL.VC1vdN6Q.JkzfmD_nFQy5uWRjXxMOpfrd2naT3oi2ObW03i6lko
 cch12D6SEKKphtwbg91Ynd9il1L2gCTDqorS63Qpm.gxR_FHDTkjVeEySAD7wRCm5j6yyFNqhOEl
 ltAuQWnxLqMBGdTJVjm4iAQjRNOfYKBRdzhasQhHfyL8rPBAqbusYNeQ420rcWLzgtynsUGtL55H
 0z8wVinlN5QDIC5UsobnWI4_N5JILlG3cFSHENGBSQJtIAoPqFQ.7fAKrGlJ0xia3WY..ck8G1wK
 8HosnqORofLtpcYwqL8gLxsT0MZa.I3z6VQvEUeDfAMe_jZu5dGMs04s8_9BW3fJ4.hNAWBn3bCL
 Ls6soTT8ZmO4EfY0IyjD7Bx4SMizO4lIt1u9wOTMJ0mA3MZUdNwyJ3mIpGxKqSoKZMDc303T7_GJ
 CKWgf5uWepkzOWmXX5.IFxCJ6HDu45n6FsVRYETjj2s9sFbe5mW.uB20xvso8GSvBFzzZAhFbI_S
 V4VO2QjgKfzQsBYfgsGn43sBEb0aQNRDZQbh.zWq7xJ.5xyp5qgj4cUy3KgbjtAHmMVSpfgBSAXv
 S0Xa7Wq2hflqcFsd8FfgFGi.JSassOJ5J1r7lnKDgTv5DvrwwTOdgc8VxKScgyh98LEdB94nJMrm
 .Sp6HQP3ITTrN_MBtsGcyVwwsaRiZhLOviJOymzln87G_3gJUSlXD6iejI6Wf1fdbfwMPNKlnYAh
 xyIKjAWc_HJFZAlp53CJtIC6vtIRQ.IqPcGLNkoe98PPgtu5DfHc5SHTtw6b7TT70MaZFeyFqf4J
 tr.mLFh.VcY0cKJgHvMh3hLbh_XAQuTg186_OoQjj0ZBdAf3V6Lq3_lokv5VkLHDsc_NL3QHpf5I
 KVfHeLuOZgl2pejQpO3_.2rPOzUcq97pDRZqhH6JohHxM_lPgkwKGQK.oSStE_RMhh0jofl.82xH
 kLYgHUsK46zUuJp61Phe8OMxliJiOoJg3GBgzqACmCJ9RUYoB3OuE17fH13_7lThB6W1P1aHx3HN
 sC.F75q3XcZEYkkQr8a4MEeQl7TgGBYFDnrlNhjkd2bq8HzCocXi2xoxAqRDGb75h2JK_.3Iq1F0
 Kq4s7ZD5F12Jdw853rwAG8KD7pKtvcIKppQJDURTW1GwChimA8FOgW2TBGOdOcqaKI9yXleNcRR3
 IGPHdS5w2eesC3pocAIX3p1w86KnVBlyhSVAxpLbskkxl_uBxdTIBgSW3AXux62JmTA2d4dBs.N6
 KBvh5qmegp4kmXUXCRdKbG0IulhZ8DzQ_KDRYE9tgAHrylxnKLE9vbB7COEH0SLepdFe2PMMgi7.
 7Kc9F8X4IVmoz_Uc3M2NwaaVB.l9O8TsvV4aFqopnOwuRzeDdB5DY8LJR6g4PZItMnzmKGfHJoXp
 5CqSm3sLqv_Y-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 34405ddd-e74d-4453-9a33-fb61d41c6ac2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Apr 2023 22:43:14 +0000
Received: by hermes--production-bf1-5f9df5c5c4-p5s6l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d7e3d8c07fd19407715f678c13c2aa39;
          Wed, 19 Apr 2023 22:19:52 +0000 (UTC)
Message-ID: <4894d787-9849-91e0-7fa8-566dc42dd85e@schaufler-ca.com>
Date:   Wed, 19 Apr 2023 15:19:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 07/11] LSM: Helpers for attribute names and filling an
 lsm_ctx
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20230411155921.14716-1-casey@schaufler-ca.com>
 <20230411155921.14716-8-casey@schaufler-ca.com>
 <CAHC9VhTX-JnS11Ywfwf2aTvh1J3KBdsfCp3k1C=8WyLcgRNDig@mail.gmail.com>
 <5acc0c6c-0ef6-bc92-0af9-dc33d8a21afa@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <5acc0c6c-0ef6-bc92-0af9-dc33d8a21afa@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/2023 3:43 PM, Casey Schaufler wrote:
> On 4/18/2023 2:51 PM, Paul Moore wrote:
>> On Tue, Apr 11, 2023 at 12:02 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> Add lsm_name_to_attr(), which translates a text string to a
>>> LSM_ATTR value if one is available.
>>>
>>> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
>>> the trailing attribute value. The .len value is padded to a multiple
>>> of the size of the structure for alignment.
>>>
>>> All are used in module specific components of LSM system calls.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>  include/linux/security.h | 13 +++++++++++
>>>  security/lsm_syscalls.c  | 24 ++++++++++++++++++++
>>>  security/security.c      | 48 ++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 85 insertions(+)
>> ..
>>
>>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>>> index 6efbe244d304..67106f642422 100644
>>> --- a/security/lsm_syscalls.c
>>> +++ b/security/lsm_syscalls.c
>>> @@ -17,6 +17,30 @@
>>>  #include <linux/lsm_hooks.h>
>>>  #include <uapi/linux/lsm.h>
>>>
>>> +/**
>>> + * lsm_name_to_attr - map an LSM attribute name to its ID
>>> + * @name: name of the attribute
>>> + *
>>> + * Returns the LSM attribute value associated with @name, or 0 if
>>> + * there is no mapping.
>>> + */
>>> +u64 lsm_name_to_attr(const char *name)
>>> +{
>>> +       if (!strcmp(name, "current"))
>>> +               return LSM_ATTR_CURRENT;
>>> +       if (!strcmp(name, "exec"))
>>> +               return LSM_ATTR_EXEC;
>>> +       if (!strcmp(name, "fscreate"))
>>> +               return LSM_ATTR_FSCREATE;
>>> +       if (!strcmp(name, "keycreate"))
>>> +               return LSM_ATTR_KEYCREATE;
>>> +       if (!strcmp(name, "prev"))
>>> +               return LSM_ATTR_PREV;
>>> +       if (!strcmp(name, "sockcreate"))
>>> +               return LSM_ATTR_SOCKCREATE;
>>> +       return 0;
>>> +}
>> Thank you :)
> It didn't hurt all that badly.
>
>>>  /**
>>>   * sys_lsm_set_self_attr - Set current task's security module attribute
>>>   * @attr: which attribute to set
>>> diff --git a/security/security.c b/security/security.c
>>> index bfe9a1a426b2..453f3ff591ec 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -752,6 +752,54 @@ static int lsm_superblock_alloc(struct super_block *sb)
>>>         return 0;
>>>  }
>>>
>>> +/**
>>> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
>>> + * @ctx: an LSM context to be filled
>>> + * @context: the new context value
>>> + * @context_size: the size of the new context value
>>> + * @id: LSM id
>>> + * @flags: LSM defined flags
>>> + *
>>> + * Fill all of the fields in a user space lsm_ctx structure.
>>> + * Caller is assumed to have verified that @ctx has enough space
>>> + * for @context.
>>> + *
>>> + * The total length is padded to an integral number of lsm_ctx.
>> Considering that lsm_ctx is variable length I'm not sure that makes a
>> lot of sense, how about we pad the total length so that the @ctx entry
>> is a multiple of 64-bits?
> 64 is fine.
>
>>   If needed we can always change this later
>> as the lsm_ctx struct is inherently variable in length and userspace
>> will need to deal with the buffer regardless of alignment.
>>
>>> + * Returns 0 on success, -EFAULT on a copyout error.
>>> + */
>>> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
>>> +                     size_t context_size, u64 id, u64 flags)
>>> +{
>>> +       struct lsm_ctx *lctx;
>>> +       size_t locallen;
>>> +       u8 *composite;
>>> +       int rc = 0;
>>> +
>>> +       locallen = sizeof(*ctx);
>>> +       if (context_size)
>>> +               locallen += sizeof(*ctx) * ((context_size / sizeof(*ctx)) + 1);
>> It seems cleaner to use the kernel's ALIGN() macro:
> Indeed. I'll do it.
>
>>   /* ensure the lsm_ctx length is a multiple of 64-bits */
>>   locallen = ALIGN(sizeof(*ctx) + context_size, 8);
>>   lctx = kzalloc(locallen, GFP_KERNEL)
>>   if (!lctx)
>>     return -ENOMEM;
>>
>>> +       composite = kzalloc(locallen, GFP_KERNEL);
>>> +       if (composite == NULL)
>>> +               return -ENOMEM;
>>> +
>>> +       lctx = (struct lsm_ctx *)composite;
>>> +       lctx->id = id;
>>> +       lctx->flags = flags;
>>> +       lctx->ctx_len = context_size;
>>> +       lctx->len = locallen;
>>> +
>>> +       memcpy(composite + sizeof(*lctx), context, context_size);
>> Is there a problem with doing `memcpy(lctx->ctx, context,
>> context_size)` in place of the memcpy above?
> Nope.
>
>>   That is easier to read
>> and we can get rid of @composite.
> Point.
>
>>> +       if (copy_to_user(ctx, composite, locallen))
>>> +               rc = -EFAULT;
>>> +
>>> +       kfree(composite);
>>> +
>>> +       return rc;
>>> +}
>> I understand Mickaël asked you to do a single copy_to_user(), but I'm
>> not sure it is worth it if we have to add a temporary buffer
>> allocation like that.  How about something like below (v7 with some
>> tweaks/padding)?  You could be a bit more clever with the memset if
>> you want, I was just typing this up quickly ...
> I prefer two copies to the allocation myself. I'll incorporate this.

After further review ...

The tweaks required for padding aren't as clean as all that, and memset()
isn't going to work for __user memory. I'm having trouble coming up with a
way to deal with the padding that doesn't require either allocation or a
third copy_to_user(). The inclusion of padding makes the kzalloc() and
single copy_to_user() pretty attractive. 

>
>> int lsm_fill_user_ctx(...)
>> {
>>   struct lsm_ctx lctx;
>>
>>   /* ensure the lctx length is a multiple of 64-bits */
>>   lctx.len = ALIGN(sizeof(lctx) + context_size, 8);
>>
>>   lctx.id = id;
>>   lctx.flags = flags;
>>   lctx.ctx_len = context_size;
>>
>>   memset(ctx, 0, lctx.len);
>>   if (copy_to_user(ctx, &lctx, sizeof(lctx))
>>     return -EFAULT;
>>   if (copy_to_user(&ctx[1], context, context_size)
>>     return -EFAULT;
>>
>>   return 0;
>> }
>>
>> --
>> paul-moore.com
