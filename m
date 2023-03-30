Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A06D1037
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjC3UnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjC3UnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:43:00 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716DD11179
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680208970; bh=6WERiZkoJdykB9mciKe8S/KWSb5CUzRm1Sr2f/WWYos=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=EHFkZQ7fX56aS0/emxmTVUN21OV5tLyGz640Tf9zf6n6ODmlS1KuzIgQ8q/Khn7uKQ0Ai+PT3YGyS1IQ0THVawkA+hk9RS/ARzDSLulnlesMNmdN6muDqg3IEe2iXZix10IlVpCViH/IsDH8wQS4GzJ2io8RkxeBLX9AI9yQ0EAMb4KBU6T4Is4YrNibvm0/M34UcbEhv/NeZ0t/BQzpM1Q57ESxqCFcsL4q3pIYAx1FXz9KtDWq35whmhoOzFIsEdK2aNPZMrodfeB12m9wy/Uy2F2t4DCrR/NkmgDHr3lcaWMG7NmsrTDupKNfwyB282/arB5s4cFkdJb9ve7bww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680208970; bh=ffMd0yRq58Q6Qt/aHft7MXZLyBGa7rEzEzRXJGoOcp9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AxYnC9O/CaCx89zYTv++ZEJkzSZEYdIXFTeg1mie0ZIIYG9GwJIk7DHxLQUuWqLS3tcWM0o7NJrhObonFT6zmKaHR5gZpW/fP3HYRBepWehCVei6an0VdTSGEZbR9BaAvGBATZ1SZikDP1hgXg60riHl56xfggB0GqZQhw5W5IJe7act9gYNVcp5XHGxcqTx4LYvLfVpDlinVho7JzsDJ/DkAdCNvzFgTpi/MvOTm0t5bfvj4XSLMpde1BOsbxCeI/BufLMAfk3UNfHCJm1UIFJ64Ncm6+hxPE1DAQOIH+mpjFHVdFLqbP7LAqy0ieo19yoFz3MDv8bFNR65418cnQ==
X-YMail-OSG: 4qruGGMVM1kitb1H4z_3qET1sMgU8zeRqMG1uhxKIMbHikcZ4lwTU1Os7Zy9aTu
 fpXSbvqtKrHbpjj3yrpHr_koWmtsu3W4KSNATICXnXs8eOeF84dn45EbEi8k0acRothFQs3Zx9A8
 8uBcABCtKXI5av0KsvyvUtdKKYKLfHH.kOdp3LAh.CpdIgIfLUh8ALXMSXv4BS.lnuqIg9U5R1Ua
 gTkE5a9m9EocthdnWEMsEiphsqI05biLHlBH8aiRSfg5tpmk2ZLRbXDuWarsJhdfDlPL7wJt3aP8
 JxX52l824EkXKUm3FnqFu2u20RGY37fEd.EmrK51aTskQfTrVmfBqSZwtStxdBSVE5eoyLHiU8hn
 TjXOPje_Zvnti2E1DwXz4kFMOej74JP6qjcesmSbORLjCBlTAbAYH4BoTE9PMhV.Giwnby3DrEia
 ASJP6K4LJZNdtRnIXIzHmBNLmo.DjD3iZCDSImAJTcFfsTpofr776CpiStNvG1e1u1rIuAqjPstk
 KfcFoz4FiJkpeYRP9lYQgfeX2iPCwE6MtGxlzD46eJbK_wha18BKi7gpHnpZxqUag5Vq4bQP6rxN
 0tIC.d.1qZ7LrWxw_DBcEaf1rA1.C8W74NpjmufYQQf07JwcEf8VAiIwyATv_f43M7pd7Maemioc
 YZnM0u.zmt3rKTHOy7KNsepWGRKQIC.ssgJm99ekf1Hij5LOCDOH8Vv38P.F0lWs8rXp3YkPYZH8
 8dVzR1ubRLO1iWkwMadu7xYp3qqqmHn0wP47SZG5WTuCdeGICxiwhb64uGsHvngtqY44WYFT0Szg
 tYq08.jHt9lZP3rC95u3x1rdVzYFe8NF8oP0db.E0NPdAb9lo_UYFpTaFrvb7RdzBGj8ovxwTPSJ
 gVrNN9i7lAFMZgvfZQGXY9LYVp4Zw.UoxSdb3fUtOln9kOnQIaW6dFNNwDKtn7pqq4WWZqy3lqAK
 0UIzSbm5jWLsQn__VJ.6JiR2JcsoKsuFNe11RiUJ4h_a5fQUL808yGLvUY2YtzxQWPcHr2izfvQi
 aJ95C8yC_wG59AjfBF6CqBWGdW3W84b.8WXbxjR8KpTvNtPM4B7ZBz4tahV16ss2r6HsxN.NO_sY
 mcMHGkSkgCYG704vFwhXYowHolNEV0F7v3tKK8.NpsUw6puSOxNhAf0rhUtHKvVcU6GjewDuhr9T
 13dDvfF_ZDCv.0mwX68RlRwwl9QLe8rjwloe7_lDRGVDR1hCb9XNqgVIUC19fmZTNd4tZf3sBBA0
 UdIDSP7X9flXMSh6XHD4PRDSKqoW4XKmsxw6f6NhshGNTkWcG80juPDX4b5zPGSdB.36K52I0cBw
 2Ba1Geh20dwqsUWAIk3ukEUDopgoX5DoB9FqA1bHAXGc8ZTCIDlGof9wMMQ6x8giCkyueH6N.bPW
 EzvopnuWNicCFvRXiE9mOmt44Q4oCbmKJj0S.wTtscwWhp.IIQr9zMI4ySuNHXER6HZXZfm3s1xS
 b7lJ0YHxKpcqDY4sz2kAJI__83nnzG..BuJmtleSqvday4g_VXMoryvmvRl_CLVytXpSynmI_o5L
 F_SLJriNVWJvzpS2wVgX28Jdd4cwTgl0LV_HvkDv1FvzMujHm3DD6U77vrqs9_Kfw1AM3MxX4kns
 l9jAYrOUdE8bMtkolZqwAe6i80KwNdQM2.MRIHgF8oHsCjSSON3CeuJJrlCYjv2gBSNsUt0ZL8_9
 bOEZoiOG0NSTGP8S0xfDIIkIv54k42D4oO73e51zBc_6rX2kFN2XPu3r3_I8BfhxMg2tO2u0Rsid
 tRzUFjLfzvIti31w4EJWI4r.D_Jnf6Peq_RUV5sj9DNiRS_gl9bSqSwfNMF.V438jrl67cgiqg.7
 TjyzoXeSPea._VHfjHE60eA4R54SRaQPcLkF0u8zooZxmk.2sZsK8UpvU4GCOsuRfhYOPKvlbnhI
 lrXgNxhBeo4rltck61HpgOdfu6kCUVBdta4ois7iWsGIj.UWerh2EZe8gdWsiCthN8KH5Ol18w_Y
 wVttCpv1LZhc9nWO3g7BR8qkIk8YPNQxi9R3W6IpZL5GZLM8VfzdmxLsks5OmhqCFodeuwoHk7m2
 nd4CcpdbtYQcMdm3TA_SMtEvyUSYfpPLffO_pOH2eVuE_ouGSNuVK0xW28xu1htT9rFQw.jddGiH
 EI6BhQoLHJNBPWeBztWNmh3r_Vp_1c7I.GFUrFs07NyDzmR2OGAS7bhkmpc1awiaW228WxfGM5b5
 XEwm8cb9iBMPXMhsvoH8aniOSKDLcHKScq5TzuS9Wj5tLi9TqoCknikz7eeFQWT27i6NUrFMV7Mc
 Lke6ureBfIw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b1bcf264-2b78-42c1-a8a0-88cbe8a6d67c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Mar 2023 20:42:50 +0000
Received: by hermes--production-bf1-5f9df5c5c4-8dccp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 37ba0f9e80e345426b02bddd1162c7b4;
          Thu, 30 Mar 2023 20:42:48 +0000 (UTC)
Message-ID: <c79a66f4-53c0-66f5-4539-4994365aa656@schaufler-ca.com>
Date:   Thu, 30 Mar 2023 13:42:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhT9j78jC66xv-pV1iPmgEK6=fHddFVaAS8Qmm_WyYMypQ@mail.gmail.com>
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

On 3/29/2023 6:13 PM, Paul Moore wrote:
> On Wed, Mar 15, 2023 at 6:50 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add lsm_name_to_attr(), which translates a text string to a
>> LSM_ATTR value if one is available.
>>
>> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
>> the trailing attribute value.
>>
>> All are used in module specific components of LSM system calls.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/security.h | 13 ++++++++++
>>  security/lsm_syscalls.c  | 51 ++++++++++++++++++++++++++++++++++++++++
>>  security/security.c      | 31 ++++++++++++++++++++++++
>>  3 files changed, 95 insertions(+)
> ..
>
>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>> index 6efbe244d304..55d849ad5d6e 100644
>> --- a/security/lsm_syscalls.c
>> +++ b/security/lsm_syscalls.c
>> @@ -17,6 +17,57 @@
>>  #include <linux/lsm_hooks.h>
>>  #include <uapi/linux/lsm.h>
>>
>> +struct attr_map {
>> +       char *name;
>> +       u64 attr;
>> +};
>> +
>> +static const struct attr_map lsm_attr_names[] = {
>> +       {
>> +               .name = "current",
>> +               .attr = LSM_ATTR_CURRENT,
>> +       },
>> +       {
>> +               .name = "exec",
>> +               .attr = LSM_ATTR_EXEC,
>> +       },
>> +       {
>> +               .name = "fscreate",
>> +               .attr = LSM_ATTR_FSCREATE,
>> +       },
>> +       {
>> +               .name = "keycreate",
>> +               .attr = LSM_ATTR_KEYCREATE,
>> +       },
>> +       {
>> +               .name = "prev",
>> +               .attr = LSM_ATTR_PREV,
>> +       },
>> +       {
>> +               .name = "sockcreate",
>> +               .attr = LSM_ATTR_SOCKCREATE,
>> +       },
>> +};
>> +
>> +/**
>> + * lsm_name_to_attr - map an LSM attribute name to its ID
>> + * @name: name of the attribute
>> + *
>> + * Look the given @name up in the table of know attribute names.
>> + *
>> + * Returns the LSM attribute value associated with @name, or 0 if
>> + * there is no mapping.
>> + */
>> +u64 lsm_name_to_attr(const char *name)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(lsm_attr_names); i++)
>> +               if (!strcmp(name, lsm_attr_names[i].name))
>> +                       return lsm_attr_names[i].attr;
> I'm pretty sure this is the only place where @lsm_attr_names is used,
> right?  If true, when coupled with the idea that these syscalls are
> going to close the door on new LSM attributes in procfs I think we can
> just put the mapping directly in this function via a series of
> if-statements.

Ick. You're not wrong, but the hard coded if-statement approach goes
against all sorts of coding principles. I'll do it, but I can't say I
like it.

>> +       return 0;
>> +}
>> +
>>  /**
>>   * sys_lsm_set_self_attr - Set current task's security module attribute
>>   * @attr: which attribute to set
>> diff --git a/security/security.c b/security/security.c
>> index 2c57fe28c4f7..f7b814a3940c 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -753,6 +753,37 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
>> + * Returns 0 on success, -EFAULT on a copyout error.
>> + */
>> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
>> +                     size_t context_size, u64 id, u64 flags)
>> +{
>> +       struct lsm_ctx local;
>> +       void __user *vc = ctx;
>> +
>> +       local.id = id;
>> +       local.flags = flags;
>> +       local.ctx_len = context_size;
>> +       local.len = context_size + sizeof(local);
>> +       vc += sizeof(local);
> See my prior comments about void pointer math.
>
>> +       if (copy_to_user(ctx, &local, sizeof(local)))
>> +               return -EFAULT;
>> +       if (context_size > 0 && copy_to_user(vc, context, context_size))
>> +               return -EFAULT;
> Should we handle the padding in this function?

This function fills in a lsm_ctx. The padding, if any, is in addition to
the lsm_ctx, not part of it.

>> +       return 0;
>> +}
> --
> paul-moore.com
