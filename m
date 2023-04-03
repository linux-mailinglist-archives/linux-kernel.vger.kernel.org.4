Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9FC6D4FE0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjDCSDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjDCSDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:03:09 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com (sonic309-22.consmr.mail.bf2.yahoo.com [74.6.129.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2112134
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680544986; bh=u9lbh9GumEFT64eZOPITulwNMpnnOsF7K/hkLtxfxTY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sPRJ5WVqbempXLiomrPDWMUZ8vHP7kFGARfIGAbbx439/NXvYemlSFSmVWYZMWUrIIC0j2DkW+1UDWdWcINh3RLX/WGV20TUukAvziXkO0cIKlKTRdyT+GyJXXf/kt8qi/EoPheKKg4j2hhy5ktYJjlOlX1Q5ZVcVY07CrTBO7RYk6fm4QF+XDJ7farbk/XaLZbmyTJN/ZUgCW78BDpL9dwamR6ArJ+P5UtzxfAcPpv1qmqe/ELyfE28y7ggCq4XkGkFW/BpnYX8WzuMAz2U5YbgmBCwTztOn9WwO9oCYNiPSXmgHgicnAPPQq2hil0DZQreguKfMeIL4Sfq2gi87A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680544986; bh=V130vTHmuBkHWtsxhFm0U/rxmHYw5wBH5hrpCOcKsbn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cccraiIK3ubJe7gCYAIJ0wEn3/nN6BtxuiC9J8drqXtcSSc0WLZHIKxXFRbSp8OMgvqwJ1DH+f/6KKWhXWd+ZEIQt0SvsmXpGg8SVmD8eRbCWnr25J7knoR24fNRM2AHqv075lrFDG8fbf7tENPhU3wBYP5z3P2+84eDPFRFs2/mWvTCxA7pz+2Mc5xTRXyvBe7qxkDpocJKxe+qfppJZr4cxHLp3iqRJLYMZXjT6eyjCSflj5m1lAwf2GAxI/Ns9i/Ywvmh1Unp+eew+IHtuLG7Y9ACaS04Qt/8Fr6tvxNG7A6MJqasT10xDlikHMAvXnjsDcF0AWgCcnQBT5VgyQ==
X-YMail-OSG: WUBxmm8VM1m4NgTZ0lujZ_v4245zxkyqmEiXXJzN.dYZ743MMqXoNUDjFcAFo7R
 cDTDU8ZAB6QbpDuyvfivefP6UA5izDpbJ6WqHIoYfJULCmD144m2AnNfwMx_X1eKYPZ_0ntC.bWG
 7lV3HFztOdXwBZMklP4_utA4x2bqFRS0_EajW7NRQeS6yifuTIe.Y0q6erUZK9We52FLY.HWallf
 ssd_vUSKavj29wt.aN4RbcQn9dkK2D1VKQ6q3GyuJwWyTHOAFcsWlLExE.Y4m17CPlyWNKB9sJ7U
 IET0cAAdZblajGxWhOEjy3n_ekaXe2efEWbS5mAoPnNDSRYK0fIggd9E1nDktktbgBKMdg8cNLah
 H4Apn9pK45dVAW.924LSqSPiQ3ZfhM0NdT.7o8amNqyfyt8ZGMJgMnkDixxzWcVxQ34sSgyaLE_3
 ccvf87T8VZ4.hAkUvS.mCFoBBDgjNdJxs490S52HeaUuO_xn7p8_OuOzvBbN2WJtYJlS_TR0hnks
 m31ssDDbOJcB40o7mxQNM6mdewvrHby7BM5RN7nAYgDpL_Y._AS12B_AajojTlAC.haXHlx3OK7R
 8UD1u.iJRw1OwVDyuR2rcl0Wgw9VeDTxt4OlTvZKIcqCMZOyT_f.h1nn8I2eUzQGPSFnDGhEhsGS
 nvnEnFqDLh9_8TD8pJQmXAqcc2lnLzr6tGmlwPnElt4y9.O2DP_.EescglHvfPQ9G1Kf8Qwefb7Y
 5juVaSgyMayCQOPz6XuKnOtk64jjMSGiVhci8sxF5QSNfvezwIJ2QQ_FPFSDthBgNmvAZ1.ydHkM
 hZHPxb1nmuDIrjCPsmbeVzZ.JU4t6hejdmeYaXq3XRwrbz4Rs1Wi10MIMBocCXIcnCtJfV4tWEek
 xyuyVAm3G50DiwAaOL56N3KoYGj9aF.xv4Ix6HzaZ8voLkOKjxmLZMrLM9MbKa5Gyj00Wq8v_iiY
 LASD4pksmf6.srn57mDT1iJ6e79aS7Bpql9htKR2q2Zu_ZkDgOnaX1GNOeOBCaQhwslwjnowMfRM
 byTw_uApE85qfWAx8lu5LViN4vfDMApoVtOdxrZ3xaORKel1fJ_kBF2ImaNzjeq6DwC6SwODtjYy
 ovFs8wP6C8U4OsdjH9U9g8AveE.4lFzycHMLVXxRbWQTu71vSogaZbeNqt75U8QuYdUT5PazMhZ1
 tVLfMvNHoWoSyd60P72jv086DuGxWUHkVyHOLD2xsFt3MKHk6.m4KPDaGzZHv1OxdIa8trAwFMnC
 fda_Egu0i.VID25acv9ltki54F20v6xMuKWFdJ3r1Wc8oVV0snPikDQGXjvJpruBOVaOC3jEn9A.
 5H.ObBslbwYA0JZrxcEAuC.PtQKA2.X4Gcgz3YPNHPYOBxY7CTL_e_GeZ47WLvkFpFoaTCO5UKs7
 xu0ukWd.VISUtrgTlQS2atCY.SrGH7nWQYS0aBsdoLnbe3.M2OCf2.vz2M58N6jmnyW2P3jkRuWL
 m1F7dcYsKmyXMTjzBPJ86KVnuRFIQLPnqMV2Om._by8Sq7cXjylgsKINJ791CbNDrCtsNr68NY6C
 IjixNNUMGgsghZ6_1_KsmYnikcu50eUdBwESTwRam_USw_erhDEGHLaE8LJALKPJyAWPBOjBtl8N
 .9h_dTQ1Fe9eN62LoqYPRJMo_icYWXeRJPdCBtSfALumjDYpGtqNSVEvfWuyqDXK9kuCyUCgD.fn
 JVvVRieWhebSqvr5JvFPc.OKs79woiWgwtw6ECsv.E0_vHyDDJ7QZQT_9jX8jzgydzw0iaVmM5US
 CWwq2p3JyXLJDyNxqs7L5m8xJh7v.KA52RVl19iMCQ2o6e_TfVm1rwjC7e9Jo7CISNTJ3XvMpgVU
 ooiwK3In2wYoh_HA.xgdnnx_5kMtHRGCHub8AJv1MPX12TN8QwkBZKescen_ekQJfthc35386xdx
 rQfWZ9w8etD1jZye55l7QFymyH5oq7BTttHdSKUcRPChqgh12wvYD.Lr82wCyHFBUSNPmfJ3YgGx
 6i.Uz3z5FPvQ.3Zi88Yj7WXtcTpMKsv0D_O1JU9RdY1P2yJsRYXHRiPXrHYYf1iSZtYw2A01fNoJ
 c1s0MxFFpxq3vE52h9fKj2RxNRwkpgrKJJN9NR3ELf1nbStlpI8TL0t2.en8zqhYtNXheG8BjtGm
 RusC4OYhfrYlf9DUIg3I4GNOFJmVSgkCj5GKmXof7OlAa57linuVIMhF_9Jx4FlYiJa6LYxPIsZn
 YsCx7saUtspuKrFu8zwi3Rmxif1P0ukSI2Ln1Uds-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4524142a-5c58-4e7e-a4b3-99479e8b8d1b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Mon, 3 Apr 2023 18:03:06 +0000
Received: by hermes--production-bf1-5f9df5c5c4-jfhzs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 31136370d3b33cf68f4bbc73f6f749f2;
          Mon, 03 Apr 2023 18:03:04 +0000 (UTC)
Message-ID: <bbd6abb7-7443-0f34-788b-0e441dc5afee@schaufler-ca.com>
Date:   Mon, 3 Apr 2023 11:03:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 07/11] LSM: Helpers for attribute names and filling an
 lsm_ctx
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
 <20230315224704.2672-8-casey@schaufler-ca.com>
 <544a4809-1a79-9dd7-61a5-5fce1f4a5f10@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <544a4809-1a79-9dd7-61a5-5fce1f4a5f10@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/2023 2:47 AM, Mickaël Salaün wrote:
>
> On 15/03/2023 23:47, Casey Schaufler wrote:
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
>>   include/linux/security.h | 13 ++++++++++
>>   security/lsm_syscalls.c  | 51 ++++++++++++++++++++++++++++++++++++++++
>>   security/security.c      | 31 ++++++++++++++++++++++++
>>   3 files changed, 95 insertions(+)
>
> [...]
>
>> diff --git a/security/security.c b/security/security.c
>> index 2c57fe28c4f7..f7b814a3940c 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -753,6 +753,37 @@ static int lsm_superblock_alloc(struct
>> super_block *sb)
>>       return 0;
>>   }
>>   +/**
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
>> +              size_t context_size, u64 id, u64 flags)
>> +{
>> +    struct lsm_ctx local;
>> +    void __user *vc = ctx;
>> +
>> +    local.id = id;
>> +    local.flags = flags;
>> +    local.ctx_len = context_size;
>> +    local.len = context_size + sizeof(local);
>> +    vc += sizeof(local);
>> +    if (copy_to_user(ctx, &local, sizeof(local)))
>> +        return -EFAULT;
>> +    if (context_size > 0 && copy_to_user(vc, context, context_size))
>> +        return -EFAULT;
>
> Can we do a single copy_to_user() call? 

It would be possible, but would require allocating memory and copying
the context. I don't see that as an improvement.

> That would avoid inconsistent user space data, could speed up a bit
> the operation, and make the code easier to understand. To use the
> stack, we need to know the maximum size of context_size for all use
> cases, which seems reasonable and can be checked at build time (on
> each LSM side, and potentially with specific context type passed as
> enum instead of context_size) and run time (for this generic helper).

Knowning the maximum size of attributes for all LSMs and hard coding
that here would make maintaining this code really painful.

>
>
>> +    return 0;
>> +}
>> +
>>   /*
>>    * The default value of the LSM hook is defined in
>> linux/lsm_hook_defs.h and
>>    * can be accessed with:
