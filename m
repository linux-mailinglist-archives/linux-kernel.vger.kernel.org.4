Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D366D50E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjDCSo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjDCSo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:44:27 -0400
Received: from sonic304-15.consmr.mail.bf2.yahoo.com (sonic304-15.consmr.mail.bf2.yahoo.com [74.6.128.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663D510A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680547465; bh=wpTgHGzfxkxOToAdK3NH6iOJYYle5WxajOZcS2SxIyE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tpT66Cewjt9Y05Jgi7/zmlADeqwvYqDhHJjeGxAqxwHc8JvfKA118GUZVmcVAWPVa6fmtYZkkoOC+BDC2McYlYuEvgnmp8WE9wTOXatNxNf3OI4Dkurneru7X1Jc+V9rNvFehVHZcNtrA2Ue+PWxTv7u/DH3v4j0jTVtTcxI4JxYRkdK0Bpc0GK66BVTxnWQv6cNOrM6vGYUsgyusgLMdAwiqHkmV437YO4yXmE+smAHopquMKIMHXzn0vxu1zPG/6lLiF6rFHTj6Nof2saeASNt+zNlaHfeXwelcYOhmciqWfbNUnECpnAuIVjohawHDucpKa2j2lrw2f4YwuOGBg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680547465; bh=VXbsrmb33bkGiYZk7p6InHCtZ28VXjoqGRMBZCh1fRX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rJjx/jkwqfVVMZsiw6vAQbRQ8UV7x9pEwowb87dntLL9ebnNqDkaglHny3qmL17TE1X1eDbd3z+ORKv+HAw/MrimFiEj5VaW89Jp+wr8dgwsS1O6afwINat9HYfpkYW4dyXAxf6aWV+ExICl4HDT9aqgvl2JLwcQC/jdgENvLU3epPsGqn3mPQ5hrY3WpsPzO9AezIwyVRZj3JKK5caCSv+XIbw/T87uxVvh8p6Fj2hljob4uat1mRF1Qi46+uBDEp0DOPaKOe7wZsYKFzB51P9FqBcPEusn+nBso7aFA8N0wtiSX4SwM2V9Utx6NomeFAKZOxIx2+kl1Vq9/oAK2Q==
X-YMail-OSG: 0LwdmCsVM1mTKreM.P2XqpeuybfQI6rpIJMq6S9k.JBWMqPxa93zORXEoMGO3xz
 YTb12fFd_yRalPh7UUgTPrBT6QUDSMs1XLfb6lCToAN0EbDMO8e5drSNZFNJ_bE4.4dtK_7jkkWv
 bHwaHCJZuXSZ_hihf.bfOfzg1wnXAJYQ_l0UUvf1LktQVndmutG9ZM8pRbk7TjdFDV_BFp4HW29v
 XYpcCUeo1xB.cvQr0i4GwXwGVjIR9PR8imygg1wTRY0qrXNmeWV6AYAk8ioHfqmzkuXd17gTgnnO
 jBM..AbhmwY01dBrll1FKwOKAsWwWvnFyV40JWf39YhHqVQj06s.KkviY7RyGOrwRAP2sQfc.Zg1
 dbxo1KPbs_9EMXkc1P2mV1Y3o6cLNszEjP2.cZkyaFjtgpyo.o0pay3FfPgv1weT1GcfjNa0GA6c
 cgmgkFBEy5RSw6r3hmJ2Kuo69T5Fg8KmSTm8OliO20CUqGcoMChY12gyybhnWhWy7HnlymAjiAWS
 Nm604H243n2onDPnS0saNaOwcUTmdy6eDvi2T0L9PAjHG8eUfmwS1cTxjofCj.VDarIq64qmq4Aq
 7KoKfh8jYGH2D50__SgrE57V3EW6L66j0dz6y1LB4XelGf6EBvp2UW7zkhDTJc6guZCG_WvL2Ey5
 xanxKJvNkHrEYffJ28iRfph7EzyzzxlWaBdMUNXRGILcXP65F1onLIqTWPLwjjuy2Q5j5x3ko9RK
 0MGm1s5x_mGBEBmc2G27DQGj7T6CmbgKRY3Uo_Fifg_V7g5c.oToa31aC_nri0e1EpOvJanWJ29U
 4OLKnoWOcfKyWQu_LkPvsvQ527Mlt2jNbqe19tM9pdl7wIvky7enE.TNBBDMjvHepbQ4w1nqH3Xb
 YeIAJPFyfThK2MjAdiA_UMqFN34wmNCNR7NDsorcl4g4zsova0v4QbWWdT.iF7lcU20QvsM1dUQf
 1wsNQvJxnaXZX1ZK1LSd7_2abtvEhu5HiRLObtIsYZ39HuiUY_ld4Lkdf5JZP7.ksy5tfyE3YbiS
 vUmjo9hF4Dg25eKQl7Txno_uKH9rqkip.77X9gad5Oo8EC8Yhh1rylSJ0sIuByliVdNkV67cGBei
 cTlEIc4P7_9X_e91oHvw0gh6sTzGl0yvnX_v83PxU5fykNRgsgfkwbiKa4Z_PURmk_XA5F8ojm.7
 iz6K1ta1E1_HHgbOXJpr8AcQ2Eq5dE7GqQ64P3AtYRHfRDIsTemUwhMXDcZRUXdgmN0w5Ze4Aadf
 bzpPdyo2pF3XKSoRdb5FTmAux6S4gn8KCQW2UDHG.1T_fE6bX5yRJGylf4UzJW_BOUqDBcQeftM3
 R8L2eECuead_CBEBm_Dly5.zGkSR8elNvWCA0knL9UO_Py2xYAbx0KpHWu_zLdroyTErD9Ja8P6H
 XmaMI2O4i5Zgxg1EbulUbof4Z.cuG8RrLvaYvOGX4wakTVE4kRboKfrxI05GOXJdr_rZ7vtBTb4Q
 XF4k9mCm6UxAOemvbb2KIJ7hBKkxcdljxlsMN4gULFiVSOxX.Oi6.RPMBEcQzD4DmeMETsANk3SZ
 pvV0R.pSPCyEWN2VEvbIHlDcEQm6uSs.pA0y3jMdUOqGry7cVhGBZX.b7Dj2gmm_k59wKk571jhi
 U6mE18Y.TshTLX3emhr1h3962zQmEN6zqwvqWM1YHaZgD9q9ScmKcNb0_Bi8WkSxKqsDaXR35HbF
 4_YwbVn0r4Zh8AXE_IphmFF02FzfBlj2_ejNlnOBZHBmSpNKhNfGczcEmbhcdWRH8wzn50SUVnS1
 uzvj1tEZhpouuU5UtGomd3KP7ECxV4I4forB9lsCxBIbGAH8emtmuJzWZmnma7d4i27QdgNgkbiQ
 Ctfv.5UZMBx1oeUihThLDWYtYK.DIr0Jq.wTUzEhHR7vJHiAAAsV5v5txx_3_mrSpcbmgcFN1S_q
 PPtZvQFrR59eCpZqA1sPhOpB0mAbsK_97PH.9LMPHTsI8PzAGQCqNyD47WpOCx0d1waoj12g3M3_
 uHU3cJQKTgNSetLlNjlItfj.Uafqf_w97YGqwsYM9VbS2gUXvILn.fDVRGOl205zuqNLlDOUI4e3
 90GyocrZvJ9VpqxDZrPb5IAYWMlePyiJtL4qixOtekY5j0LAz6Fi2o3JsQuH1daVa4G_XENrXFxh
 ONzJQSW2pnJGAZG7u7ZBYW8CNvqNlRge1sIgMGiyv5zHm5NdowQMwhpEfVPynkjvGdEugdSZD60o
 tKiyZrF5a7Ut34bE7TsKuh9wi1Dw1v_0boYrGUG.SACGPWYskU7CBHDziy4RyB0N2KkiuONytoc2
 M.Smao1jvV96hMHwXfw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7b5a653f-deae-4fe6-ad1b-625f8db54753
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Mon, 3 Apr 2023 18:44:25 +0000
Received: by hermes--production-bf1-5f9df5c5c4-dxcv9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID af00eb186ab4bd0725e08329263794c3;
          Mon, 03 Apr 2023 18:33:53 +0000 (UTC)
Message-ID: <186c5de2-a07c-7401-bf8e-863defaff5ba@schaufler-ca.com>
Date:   Mon, 3 Apr 2023 11:33:51 -0700
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
 <bbd6abb7-7443-0f34-788b-0e441dc5afee@schaufler-ca.com>
 <6af85c04-0388-026a-e4ee-08d9aad6b86a@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <6af85c04-0388-026a-e4ee-08d9aad6b86a@digikod.net>
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

On 4/3/2023 11:06 AM, Mickaël Salaün wrote:
>
> On 03/04/2023 20:03, Casey Schaufler wrote:
>> On 4/3/2023 2:47 AM, Mickaël Salaün wrote:
>>>
>>> On 15/03/2023 23:47, Casey Schaufler wrote:
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
>>>>    include/linux/security.h | 13 ++++++++++
>>>>    security/lsm_syscalls.c  | 51
>>>> ++++++++++++++++++++++++++++++++++++++++
>>>>    security/security.c      | 31 ++++++++++++++++++++++++
>>>>    3 files changed, 95 insertions(+)
>>>
>>> [...]
>>>
>>>> diff --git a/security/security.c b/security/security.c
>>>> index 2c57fe28c4f7..f7b814a3940c 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -753,6 +753,37 @@ static int lsm_superblock_alloc(struct
>>>> super_block *sb)
>>>>        return 0;
>>>>    }
>>>>    +/**
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
>>>> +              size_t context_size, u64 id, u64 flags)
>>>> +{
>>>> +    struct lsm_ctx local;
>>>> +    void __user *vc = ctx;
>>>> +
>>>> +    local.id = id;
>>>> +    local.flags = flags;
>>>> +    local.ctx_len = context_size;
>>>> +    local.len = context_size + sizeof(local);
>>>> +    vc += sizeof(local);
>>>> +    if (copy_to_user(ctx, &local, sizeof(local)))
>>>> +        return -EFAULT;
>>>> +    if (context_size > 0 && copy_to_user(vc, context, context_size))
>>>> +        return -EFAULT;
>>>
>>> Can we do a single copy_to_user() call?
>>
>> It would be possible, but would require allocating memory and copying
>> the context. I don't see that as an improvement.
>>
>>> That would avoid inconsistent user space data, could speed up a bit
>>> the operation, and make the code easier to understand. To use the
>>> stack, we need to know the maximum size of context_size for all use
>>> cases, which seems reasonable and can be checked at build time (on
>>> each LSM side, and potentially with specific context type passed as
>>> enum instead of context_size) and run time (for this generic helper).
>>
>> Knowning the maximum size of attributes for all LSMs and hard coding
>> that here would make maintaining this code really painful.
>
> Hmm, I forgot about variable-length strings, but maybe a reasonable
> common maximum size (that could fit on the stack) could be found?

Putting a maximum size limit on LSM attributes just to reduce the
number of copy_to_user() calls in this helper function does not make
a whole lot of sense to me.

>
>>
>>>
>>>
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    /*
>>>>     * The default value of the LSM hook is defined in
>>>> linux/lsm_hook_defs.h and
>>>>     * can be accessed with:
