Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4DE6D4FE6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjDCSFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjDCSFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:05:02 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com (sonic303-9.consmr.mail.bf2.yahoo.com [74.6.131.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008D0212E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680545101; bh=L2zgD0pqstwm9Xl4ku8Wh58y5CPrucwNmj4CIgJMo7k=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NvmQBaBTA/FIqX8fam9qtVRqaBBWlg3rr8rGMvzfOqAQmJW6oL7C0LlklUt85wFnb3mICBbBuhFydMCD2hSnZnUQ5b0ibestBuMTp8Mj8SW6XXhGudFtBhKfvJvew+VF0GhQ6JWtzH3TCKRmFvu18u50gZq63J2yDTuvPBprqecsnj3A3J+DXwXuLpCsHExs5EnW9oXfO+Ug24f4Re4sOoOqb5F30PhRWrGQ6TDES0vcWfzoUChXAA0ym5TwUe242VoEacRvKmL45Ts4WATmVqp8Am0ui3iLpOkqRZ6lIfJiNuQF8gTV/l2s58E07CEmCZ5eh8FPWdSXLPZihyxBsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680545101; bh=Rq8bylJicSEmq9D0pv7x21uD/O3/jbcnEBtv4geXxKd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tL8f0DYiYBpzUa4y4CER6fQWqlbyuGBSghEOOWIhmYRk28glDdWTlItos9VMjrEGvcMIIWc4AdTIS2W+BkzfRSlg660Zzo+mhkpmxgho3Xue4bCTcKCG31A9OWQfmmV8rFie9ezAG1wpDh11M9FI63lpv3JquJmjy3NiDJC4VaofomPTztDrd3Rlob2Een6RzsG7HIAZRBEL8MMlLSn4aNwFiEo8zlPtub3Nfw8l2YYXQUcSgrNSWKNEnbIatBtwo2e8nDN0bRK50S2R1i9gQFqcuO7CahjsKJSirk3j90B1/Eh8/MjoZn3tX5QnnxIA6V4jHblG9esycMyKw9Ps6Q==
X-YMail-OSG: i.J4aD0VM1lFW_WS.gQq.zEanLpKJUaSM41DMPtDjVrChrSBoftDcWHcAlW4.PN
 b4UKj9.EbMjYu6Fs3rDp7F_fzIDydAggjvkDM8VPbnrz7xw39ojpQhXwFoRAx5XVy0vRrjmWyjqE
 iiCoiR8gTC5NFQ5vDe7l09fImbnsbCEYX.hrRtHbeHmX3URCDSo_4KNo9ce_1YVikEKrkfU3eEoJ
 tdZn6rPbJL6Q39GHLvzgHPp09xEzKn_V6sYS37V5JuNtDbseLKekpiv_xkBOafcGk1YWU7wwcVdM
 TV6yGqSyL4kfAvF0WhzfzQYta3bn5w0aE3hG3tx19fIM_NjUwUa32UZBn7ySCBCqh9RibQy8afUt
 G9w9fI8W9iZW0fGPpufj8_9VfPGgYUGIqMgDwxn1cNMamYCySX0OtAF1j3qo3giyWkv3.FtwK3.h
 hqIShDPG1xVPmBNBefq1fNALGAkgZM0W76_hwc0A63H94TxnfbF6zRRGhjjkpcP4yYUeFZXel0j9
 NaZi6mFZ7hNMefyBSF5vTj31hHL1j7JoWLZTC3ygWx62.GQdj46TT_qbH3Oud61ZJmwrG_and2h6
 R2xZYOsTxlhSyGx0DLta5oJcnallAS6tHHvChBtuQH1ItDH.N.E96RgJ9eTz.tBRJo4dArlWWgE.
 t4ljo9lzAKvMlnjLyWqGyUlWiC8gS.afyccPl6PXysgUD1AC7E__xN5EtZJhwke3XOC7VtynhhFQ
 6qjlB1fYhCHfduaU7f5N7iowRnhaTlUNjJoS4Y2jh_jRzP7InAUNvG3a8TP_lKz9fSifwu881JEe
 imsMKHCbfb7O.8AbX3qyRvYjd7p2wF0u9Rmmg9HPl0NgTQHTRQqDNaNsxgCusC0q0pfbWrg2rVUQ
 jP0EzunOo3t9WsTLNhQEOopcYHO8Pzhj4j3qk5teRxFJsz4tee2iAHXeB9KhiNkZy.OejPhRwLOP
 ZLC2tlwiZwk_MNG6A2bYAhDITPaenMW9NYcGdJ2rUNa7AJCmBucPj.5E9M0hjfYoI_OW0ZLSG4zn
 _ICE1DkI.0zbc85MMgwPI.JvpBVlQ_CvPqYMCwAnXGURuwGX4H5Uh_caYrCuCTZmhWZPudQZ2NXM
 w4NYlFpvpAQDzOH7izrTcdmejf5BWeclBcf9qc_lg3Dn6zWmZJYN9qPYsB9YkN_YbckwxIxW2djW
 CYH8WyVACg56LhbkBLjkGDCS.g.olU3hbo3kFtFgrcsuJ8ZYxsjNZZ_tAkMlDqlpIa2XFItzMmuF
 gpRu_Mcn89U7lc88N7lV.IQl6EOoMEYV8xDMWyEdAnlCtn6osz_Wlw341QA.qNAB.mG5xuCaUa2m
 5.UmVhiSeEJXs8vmk50mXQaNNQ1a9VySIDkG6urLvoWx28.rEmrtkMM88wNczUab9Z.ZRSArfEhf
 u9.W.XQlVAmjaTiqk8ZvLmKzpOWTxruk2uSIGPqsScaBN5lLCL85WjJLAjy0V8Z6vYHPIFZbSvxk
 mM5E3JMDt8oRUxrx783FuCuas3bgz47uzJtlrfThxPAUlHsyLQUBC9.4KEQZgoFcNb.vlxzySGjg
 HqnIy.tGd8mQAjZ7ozMlqljhAL.MswaHA3ITbgJ6tTgCxm4p8xbVhIZnGmINvWcEnw_ScfmC.Mb7
 e_SoneLMg90xLB0ZY3dQ8yl1GycyXukYKJzNWODvM..dnN35.Zpb0s68dA4R_n._KO8pBWBNDwbs
 cLu09US5t9JYalOUBKcjYxW98IT943kZSentrUpDKW5oIPr7UHNn4ZQr2phljsP.4EJ2thDfTQkJ
 _IkJRDh3SuJ4Q3RPLZ6Ia3SP6VLhUl9Fk7EbYCi0vKwBf_Jfe9P6nhWExDidn0_w9qVTW4426H8E
 WEeLOhMIn3Hu.VrB5VFjPSzuj5uIe4QNp2_eq9irOiBFN65lCaayyANgJClCerUVO9zjEZZmWLPW
 ya.5SypVOcD_SC0b84gjnanGjutCqyFcS9fYD1r6xEhSCDCYIoON5A6EJXyovW0dVueovqPx2HA8
 SAzvF5PfxhheQ_VFlWOWpmaW5tYqhjQVWAQHeX1lA30XKEjpdDb5.a7TLiwGs5EFklzTCcbB0N6.
 HzCURPbGW61goifIZNij9PrngO72FSiCIl8Q1Ef0CmZ3QJ_D2.pP6lhxLruQ3SZNcDuHyEUrM_ie
 bxa8wSUtFt9l5O9Knm9yS1rkt5D0tegVGgnIZmYKSUJaqHyzNpYkjcg7e74V.6quo03CdoEryuEJ
 z7xCEc3m311CzHx4BengdACVRd7S9HxbLmZzq7eCr
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f9aeebd7-8fa6-4a68-9d75-837c5bdf154a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Mon, 3 Apr 2023 18:05:01 +0000
Received: by hermes--production-bf1-5f9df5c5c4-qlh82 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 17de45c9a4f5d8e04d145ab4241f8149;
          Mon, 03 Apr 2023 18:05:00 +0000 (UTC)
Message-ID: <45e2a7c8-eebd-430b-0177-1b44b5397edd@schaufler-ca.com>
Date:   Mon, 3 Apr 2023 11:04:57 -0700
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
 <539e698a-1ab7-a390-a3a4-6c7e43db4eb6@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <539e698a-1ab7-a390-a3a4-6c7e43db4eb6@digikod.net>
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

On 4/3/2023 2:54 AM, Mickaël Salaün wrote:
>
> On 03/04/2023 11:47, Mickaël Salaün wrote:
>>
>> On 15/03/2023 23:47, Casey Schaufler wrote:
>>> Add lsm_name_to_attr(), which translates a text string to a
>>> LSM_ATTR value if one is available.
>>>
>>> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
>>> the trailing attribute value.
>>>
>>> All are used in module specific components of LSM system calls.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>    include/linux/security.h | 13 ++++++++++
>>>    security/lsm_syscalls.c  | 51
>>> ++++++++++++++++++++++++++++++++++++++++
>>>    security/security.c      | 31 ++++++++++++++++++++++++
>>>    3 files changed, 95 insertions(+)
>>
>> [...]
>>
>>> diff --git a/security/security.c b/security/security.c
>>> index 2c57fe28c4f7..f7b814a3940c 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -753,6 +753,37 @@ static int lsm_superblock_alloc(struct
>>> super_block *sb)
>>>        return 0;
>>>    }
>>>    +/**
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
>>> + * Returns 0 on success, -EFAULT on a copyout error.
>>> + */
>>> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
>>> +              size_t context_size, u64 id, u64 flags)
>>> +{
>>> +    struct lsm_ctx local;
>>> +    void __user *vc = ctx;
>>> +
>>> +    local.id = id;
>>> +    local.flags = flags;
>>> +    local.ctx_len = context_size;
>>> +    local.len = context_size + sizeof(local);
>>> +    vc += sizeof(local);
>>> +    if (copy_to_user(ctx, &local, sizeof(local)))
>>> +        return -EFAULT;
>>> +    if (context_size > 0 && copy_to_user(vc, context, context_size))
>>> +        return -EFAULT;
>>
>> Can we do a single copy_to_user() call? That would avoid inconsistent
>> user space data, could speed up a bit the operation, and make the code
>> easier to understand. To use the stack, we need to know the maximum size
>> of context_size for all use cases, which seems reasonable and can be
>> checked at build time (on each LSM side, and potentially with specific
>> context type passed as enum instead of context_size) and run time (for
>> this generic helper).
>
> Well, actually the context_size should be inferred from id, and the
> "local" size should be defined and check at build time against all
> context ID sizes.

Again, no, I don't see this as an improvement.

>
>>
>>
>>> +    return 0;
>>> +}
>>> +
>>>    /*
>>>     * The default value of the LSM hook is defined in
>>> linux/lsm_hook_defs.h and
>>>     * can be accessed with:
