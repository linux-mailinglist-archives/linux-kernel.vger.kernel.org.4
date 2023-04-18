Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFC6E6F90
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjDRWnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDRWnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:43:20 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD201FCF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681857799; bh=99HhJLRwh8Hho3O2rjyKF4DLGn7Hth4J30r1JP4kmH0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=P21b5byI9DQvuyQKZDwXvFQH0az2JGoocGSN9BEplsR+STlQTZCpF7uJW/ns9zXQNfHX8fOnBmRF0w4Bjr8F6O2h8WX3PWkOXkJ/G5nzcKvX3SZz3l+0hCb1NfpvihF5U0CT3e7drO3ekE7YrNugaMxUQYN3H6P2eqi0FqTXFVXL9OGYWBtHFANGi+TsuchQzJhJ0gE56vYr3oZJWItpgM5yO1QBI1Cguit50OqPDRUamYYj4fnURMXPQk9PtJJjNd8gyAZ/d+MuwlRhX9KbGzyuhd3gq+vCSjmqpk3ln5d3WiF97/3SLdfXsiCyI7XgwX1XnqFAzpTWH5tzQpnUKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681857799; bh=kTfCzIWxOzsxjgqzKrmVsbF0pgTls8y+Zd+asxqncwT=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SEB1Ey2vOrcO8iTiP6dGqQKcYD4aVUCa99Hv/bRyTObePwdYlq0BkltFaU7s1rZJtY6Uom4BlJOn2L1pn3n6RPTP9fiFjvEvevdQi5t23vAeu2VEcTkhQDnGQm3klbGuQE8AF6tEEmfjFSQFVxBm3RGi2LY5kwYKlufBWZ55asEPITPYv1aTFdPcn+llCrF1/gVFTkDTzsj2p1XpbVcVcLS7DS8uD7I+pDL1ZwtTfUMRAf2/jhWOJr7n+jhvMIWWTojhUKulgn9N7ZOXzBIftK+FXjsSo7gFWYQyvLhPbrdMvdOlsjh3aPGGrwFNQ2ZJBerQBxvKOEvPaDpigmx/qQ==
X-YMail-OSG: JgMWmI8VM1mfyMq6BZyX3sL_jfCucU6jUe4jl7AxlIU5yfDl0CVbejYnfj3oxjp
 j1m5XTSlwsTtEXYF5Axk2tt.wkZk7itDgQGD7Txih_BliC.LaRaJ_TK58LutL.2TC95.b_4i4_KK
 bWPoctuNwWS5E4CQ2l7aV_8VPiiE5PO06S9Tttjbjw6FwkFSog71UoPHjBXYEKYzdx_zhr4BNxWa
 8TbgiFY58DLG3XLT47dRdG06V_CmHSVzDu7n8JNdVAX6QcUZCE_mBBvsqQoItZI1Nu8uKei_OU2D
 BH_h41_s5Foh5VZpSFBkbKWNPKZFNGp6_7CXrtgN6SUkkFfeoq0zjsi6g4hliSbMoo.ozNgg1Xso
 wI0g33uB2bss.ejRzOLzkNYLBerTn6YceP1OTo2yGEBD6pbkRUTaivU32Yu_.BwhpnMm3cqCPuif
 P5mCvlWYbLJaFTLRRRGH26WWLeH8jiJ1n3V8eFHrAkcxIjKVmtrmJVzDUPnrWxdvyX5eFrotj0Vk
 qXjD5Rh7I55yz5lCe9LHcI3Kun3vqwCVLjSPKMHq41_SxAVNGBmSSwH8lVcVWos7RN9V6cCFSE4B
 xd8p2CdBCtrPX0wBS_H4DQWzVQGeSGiU3OnN0snGx0AyjBuKQOGVbRYDDhhIcmwGm67hFYrglSOu
 770xqiTVuciFcBe7r_5GAcpQ5iQbbOPtIaUlcdzsRCX2Gr9Mp8cse5UxFLG3x5msJFblquXd3N6D
 FO1cl7ru7MW94CbQo.T7zvHXIutP76abASIIJ4FoHR674GW0Peuf21NCVJX4OyX96VGyLoJRWdaM
 ogBxrePZzpLAGhzgZavIkm2SoUpAPfryPG0WjD_Ugol2NOThLoRLBL2WLCyG6ZvKc_FqfDlWq8_7
 sBruAX1kBmgKVyC9fUNiG2.cbNoJKI2XP9NMv_OCH7SV8d0nYX7_ck6SyD5j4j9GVMdZvfV3HAjb
 avGOhO1tNka0znyra65fYg4lvTY8.48pUlS4JUMsMtCccXwczbI06LSFvbkFXNO6O0zBa_QO1wBW
 YIstfxGtzszT0rDhfgI1acsJAs9SWlKxGGbdK_I2WeMCZ31h1Pt5HsMYnvpd8qyT3TsuTShCvoLF
 SyF7RW_vWsaCm_rwfHaKJsQ4GSzSWmIO2WepkNs8ycO5g9BOaHX2RWFTgMkUyioFaGJGPktfZq.j
 jGWOo536mtUqg8Tyc6MwVafksFJH4XAF1xU30hw_DY36aGYNAqnnOqGQXrgCbkrmAwvz9RPgDxBM
 WOn.kKEJYEPWBeMHhq9.D6cZlCRlMGB0U3d5LsZsSlLcOx8lLsKpejSmJITY0qBbgdw4vssQrEYU
 vGvY6Q3KCDqiUOAhqRaVGLDgsB8TMDfI61K9QOIu5XBn0Uybl5nwhTEF2qS2GiGsmFMKQhyj.9pL
 XomYjikzdd8tD_4ng58_5IPuk8lZpQlnHFoqZDjVQPXcspQJsZa21KEI_kO_8Aywcz5jPT0wOIIx
 NBeBTveXIRwLQBtBuaBSpAk_.TXgrFaoTp9cjpQfFFFZsE8xVuw2KCIRY5A9rA0RTt4.y.n.rj6A
 0bFpGX.19xv88T7yjvxwOe95_MWU1EU5x_XaK7_VLTRQp3OTr3BkmhZu.JsXYXtfQo70g3JQHoCZ
 lYYcUTNpbyQPLCpVXEUF3m.kJaCeeusqRtLon5bTlSixk0OYnH5sZylDbRUET..t3evgBWtVkDvY
 Zn_Al3mltmgP7osraEAnUAW2onbmRluDvbGtZkKw5oxWcQGnyxYLxXTIfQdALZUCKCa1U6gdR1Ac
 VSmUNMKrd2TyZCadmvdFvYzo1qi5RPXdlcbg2ZLgH7W7KmVSCPTiWeHZCLKm67kRnv5bk75Fjg_J
 now27Ht.5xlEGEpwiqNhQTbXLjCYWpL0dwxQONPYZZkDqLQVA.U3UmbNGwCiQckTkbCvyuShaxtp
 4WWPkiMfchU3psaZ..x5msAQeOo0g_tlPQsevTx33T_c6tcVoVoyeTEjKoIaIn3XGmLLwBbpYo8G
 Wonxz8V4ufGWCxi9xTMcdTavPKXN9fzO32PBvZFYsSnkWo2BFajboguN.U.O5P29QrpHkJ9R5e41
 enQWoFScBvjdcaRB.nHP6B6hdt9h0SJAGwyodmb8aURYyq3xzJ_FoBNFmqkfHXgk2qgwOokBJZUs
 Dh4UZkl6XKT11v3VHEVvMcb8TBLJEpimHgiT4Ajmo8k7yivPC6ekfLRRWN9mJUPRprA6FdfdfY0D
 qNOQO4yARtxrh0jQtrMFwXmlZ0A7sFy.G3wIuwkWl3fUPkunOizv.kDpxrXqFL2m9ZxHTX.IbKwN
 OrWzrV4z13Gg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9c752ce9-aa1e-416e-b6b2-b824f4fceecb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Apr 2023 22:43:19 +0000
Received: by hermes--production-bf1-5f9df5c5c4-qlh82 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fb36ea868971b779f8f3b665cdb69ec9;
          Tue, 18 Apr 2023 22:43:17 +0000 (UTC)
Message-ID: <5acc0c6c-0ef6-bc92-0af9-dc33d8a21afa@schaufler-ca.com>
Date:   Tue, 18 Apr 2023 15:43:14 -0700
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTX-JnS11Ywfwf2aTvh1J3KBdsfCp3k1C=8WyLcgRNDig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/2023 2:51 PM, Paul Moore wrote:
> On Tue, Apr 11, 2023 at 12:02 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add lsm_name_to_attr(), which translates a text string to a
>> LSM_ATTR value if one is available.
>>
>> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
>> the trailing attribute value. The .len value is padded to a multiple
>> of the size of the structure for alignment.
>>
>> All are used in module specific components of LSM system calls.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/security.h | 13 +++++++++++
>>  security/lsm_syscalls.c  | 24 ++++++++++++++++++++
>>  security/security.c      | 48 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 85 insertions(+)
> ..
>
>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>> index 6efbe244d304..67106f642422 100644
>> --- a/security/lsm_syscalls.c
>> +++ b/security/lsm_syscalls.c
>> @@ -17,6 +17,30 @@
>>  #include <linux/lsm_hooks.h>
>>  #include <uapi/linux/lsm.h>
>>
>> +/**
>> + * lsm_name_to_attr - map an LSM attribute name to its ID
>> + * @name: name of the attribute
>> + *
>> + * Returns the LSM attribute value associated with @name, or 0 if
>> + * there is no mapping.
>> + */
>> +u64 lsm_name_to_attr(const char *name)
>> +{
>> +       if (!strcmp(name, "current"))
>> +               return LSM_ATTR_CURRENT;
>> +       if (!strcmp(name, "exec"))
>> +               return LSM_ATTR_EXEC;
>> +       if (!strcmp(name, "fscreate"))
>> +               return LSM_ATTR_FSCREATE;
>> +       if (!strcmp(name, "keycreate"))
>> +               return LSM_ATTR_KEYCREATE;
>> +       if (!strcmp(name, "prev"))
>> +               return LSM_ATTR_PREV;
>> +       if (!strcmp(name, "sockcreate"))
>> +               return LSM_ATTR_SOCKCREATE;
>> +       return 0;
>> +}
> Thank you :)

It didn't hurt all that badly.

>
>>  /**
>>   * sys_lsm_set_self_attr - Set current task's security module attribute
>>   * @attr: which attribute to set
>> diff --git a/security/security.c b/security/security.c
>> index bfe9a1a426b2..453f3ff591ec 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -752,6 +752,54 @@ static int lsm_superblock_alloc(struct super_block *sb)
>>         return 0;
>>  }
>>
>> +/**
>> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
>> + * @ctx: an LSM context to be filled
>> + * @context: the new context value
>> + * @context_size: the size of the new context value
>> + * @id: LSM id
>> + * @flags: LSM defined flags
>> + *
>> + * Fill all of the fields in a user space lsm_ctx structure.
>> + * Caller is assumed to have verified that @ctx has enough space
>> + * for @context.
>> + *
>> + * The total length is padded to an integral number of lsm_ctx.
> Considering that lsm_ctx is variable length I'm not sure that makes a
> lot of sense, how about we pad the total length so that the @ctx entry
> is a multiple of 64-bits?

64 is fine.

>   If needed we can always change this later
> as the lsm_ctx struct is inherently variable in length and userspace
> will need to deal with the buffer regardless of alignment.
>
>> + * Returns 0 on success, -EFAULT on a copyout error.
>> + */
>> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
>> +                     size_t context_size, u64 id, u64 flags)
>> +{
>> +       struct lsm_ctx *lctx;
>> +       size_t locallen;
>> +       u8 *composite;
>> +       int rc = 0;
>> +
>> +       locallen = sizeof(*ctx);
>> +       if (context_size)
>> +               locallen += sizeof(*ctx) * ((context_size / sizeof(*ctx)) + 1);
> It seems cleaner to use the kernel's ALIGN() macro:

Indeed. I'll do it.

>
>   /* ensure the lsm_ctx length is a multiple of 64-bits */
>   locallen = ALIGN(sizeof(*ctx) + context_size, 8);
>   lctx = kzalloc(locallen, GFP_KERNEL)
>   if (!lctx)
>     return -ENOMEM;
>
>> +       composite = kzalloc(locallen, GFP_KERNEL);
>> +       if (composite == NULL)
>> +               return -ENOMEM;
>> +
>> +       lctx = (struct lsm_ctx *)composite;
>> +       lctx->id = id;
>> +       lctx->flags = flags;
>> +       lctx->ctx_len = context_size;
>> +       lctx->len = locallen;
>> +
>> +       memcpy(composite + sizeof(*lctx), context, context_size);
> Is there a problem with doing `memcpy(lctx->ctx, context,
> context_size)` in place of the memcpy above?

Nope.

>   That is easier to read
> and we can get rid of @composite.

Point.

>> +       if (copy_to_user(ctx, composite, locallen))
>> +               rc = -EFAULT;
>> +
>> +       kfree(composite);
>> +
>> +       return rc;
>> +}
> I understand Mickaël asked you to do a single copy_to_user(), but I'm
> not sure it is worth it if we have to add a temporary buffer
> allocation like that.  How about something like below (v7 with some
> tweaks/padding)?  You could be a bit more clever with the memset if
> you want, I was just typing this up quickly ...

I prefer two copies to the allocation myself. I'll incorporate this.

>
> int lsm_fill_user_ctx(...)
> {
>   struct lsm_ctx lctx;
>
>   /* ensure the lctx length is a multiple of 64-bits */
>   lctx.len = ALIGN(sizeof(lctx) + context_size, 8);
>
>   lctx.id = id;
>   lctx.flags = flags;
>   lctx.ctx_len = context_size;
>
>   memset(ctx, 0, lctx.len);
>   if (copy_to_user(ctx, &lctx, sizeof(lctx))
>     return -EFAULT;
>   if (copy_to_user(&ctx[1], context, context_size)
>     return -EFAULT;
>
>   return 0;
> }
>
> --
> paul-moore.com
