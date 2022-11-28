Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7FA63B1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiK1THR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiK1THO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:07:14 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11C3286F5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669662432; bh=zqgUB3mZAQOQjit7U5aXZlIVGvUZND/Pw43ftnqmLuA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SNM9gBqNkNG1nDtVAgflObmJMdss4PDY20ViqVjYN1GfnhBf7YBchKRPjSRMX8PKWC4ozM2xtpBTvOf8GkuojqhdQ7syatL5pwSIV99fTe/FrnKIITdGMVCR+HLK3/su3KJX1G596YUakNKZ+TlFyDUOEkc7a7EYgG+EnGq6yLVzaqEQBjbmpzx2BL+A3GNmEAjdTJM9LRvtziAst+4Ayr7+zxjqW5c5gLx/MCqdYLwysmk3TX3ictVsU8E4yt7riULXFvkHZ5EA7WgHm1+YpBrjD8mcLg5VbzFXfJF10KMnj1NihghBKB8HslBZ60pb6JTB7mWhsTTnBnesk7y9Ag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669662432; bh=3Sbhmw85eT2LFt99J/2HFTZ8d/OK8X6klBRu9ezhCLF=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RHW66VzP3x0f5qZgDhtg/xov4UH8BiK746Sb/j8hZOeA1YNjEEblZ9PWjZmodRPx/xdHXCY7QTCgf4pNCOjLkbZoip1JVY/4SCVxkeM27PJSASdbZAUiRsW901DLpMlppstlbLKQJkoY2TFJmG/pzOS0wPA9fVduoIHN2DG+ZcpqzCxeo5X4z6BHRFDrKIB2rsDdzOWdwgyGxDHwp5axOmX0V+Gwdm861EQMAAGJj54gFBqi/0RFaWlSC0JcbN74X7kJG3sYeHf3xn5G/7AwUtn68WLyYfg0WPpDPcLXB7A97Jvm4s/MvMGFaP4FDaNEIBPISbdNFWdpNPeKUl8sdg==
X-YMail-OSG: j33bM2IVM1kghuU1Km3z59HpgqUAliR2VUom8Cf3yBXlOZGPbjP4.RcYrrCsz9q
 9YxWY4lNCcvIM432hrS96_O09fpauweyXYIQLt0d7u6rjvkMMoL_e895EnkUSlPtdajt_sh9PqKn
 w_aSXehe5.Tw03JwQ72Qz3PpXNP8Dr9y4nPAFTO_oTKI4zhJhAYjWobzEjw0Oafd7QBEvD27jdep
 kcWape2zCTMFwUTdsmuPVxmGyk2sf54orHfxBZRspxwF8UDhjYvSbpfnCIES6zuV0OsctHtIIDgh
 ZSSQ1cx5DhDb9QarpPxLesqKwg_xQrxctAIAfMfk2nUMwpcHZgpPeOo9PsssjR9J7G1mQk1f_21C
 eFP54mSNO.xzpMVKYw93bJrakA5vKRuHqMTi90Uz1BeSCvKZwQmYQDjtEZqs8KAGjwyMIT0.l0ve
 XkV2GlQdMosGp_Df4t4UkilgoaMpFilSCtUnhnwTkflV_eAQiNTFCMxskEWxkQ.L7akLhXWznKQ8
 _ZerEjJTs9ueAI86nh_941Q08nDlGd8YyMbjTbuvpe19.E4Ogqd7b8SeS_zbQZ733ReQ8J7pXjHj
 9vbY4uYrq7LT48uBktWtyqeLQX_0VGE5..MAoMh3CQtRoGq41PyR0KPz5LjaLZ4DtelGOqH4Gm0H
 4kjyvk0XdnF0k7vL30wLbQYS_Hh8Be.9grpKilcwnQqCodo9IvALXgVsAzcDmKw.z9a7e_yiFRMz
 1SFQTqAU3JxHG0QyfEuJou8OCWQ5WRDfPy8j0EuyfgGlK6wklS5sFQObmwu28rLTjczEoamPUrlT
 uIBmBRRfzyNqPxBUgNmFFAAjEZeF2QhK51B_PwCt4m496V_YT9Pj5MXF7J1.As8ADprqBpjQgXY.
 0m37FSCfbpCQLgqZe8Xu1QwU7tW4qNwloxWWUQW6hJ3cCxNkZ1D838cZN6KarBzLKfwUQ5unlyHs
 KcntON0eoFIYVyfLzeARgbVWiMx0oiJIyJiC7KTBkCpCF.3a5z.C0pzObJ5dilxn.obAIJEYgJf6
 mpPXy6BC7_EdZQp5yaw9hCbvIZj3B3U5h3N_GLgpYF8xjqVpPhq1DSw3ZfpXfkBGCzw76.wABV.a
 n0MkZF0X7rM8vofKwMgu6u2IdgCkh9aVDBtCMcQHl4s5EwhFgsuLsePQxD4kXu1l69rBmxETVb.i
 .eSgn4ShED69bFP6PUGcmfO2YnQAnn8wJpoRotTgc4BIjT7ESp8bIht22iAC6tfcS3fjxFvVLsx2
 Y10t90p2WwMyVYiZ9AvKkJXJjUGdQ_Y9622KObJhgf4aomnZxe3nKzXIwtsd4XM2lNtL49CPVkCJ
 aDmg5d7RCJYOayAJS88IUtTDLhRiYCV_sV_oqVlE.a7pcqHqa4rN9gO9mlO5Wxz2lRxfbPiUQq5i
 KAMZPmCubJ3AeW.48YZTx1_WpjgKcJlbeJvTCysxu5JSh3AE32UzAGmwKBl_NiC6_esfHFxbPMaE
 619e5cTZSzDmq.o.c2nlkc5FtXu5mLnnGaaHeW5H1lUOFjWN1PqJyNOuV879LyZuOaItJyx.Gmyh
 Fe6HTmjGqRH5a.TmRkJoJFDX9ZH63KtDTJ85m5mTnqoryXh3yjyHjafmHNlkGQCXbrhUxaFRrSIy
 d5bQ_Ev9CKq6VPBP2R7IjLZkyPdBS8G1Cc3qR5RnHKmpjLeOSRUZ7mW4AhS71ypLJjt6u8Hq56dI
 FgG__63SCt3HCbuYtjBcMVJW3OpGyUknXNBe1uNQxg9yOvKs1.TfyruWOgAzjtr5zgpGLZ4MR6eJ
 uM5G9yuVp2_hEtQM3Rpkoe3TRuSxvNdyUMMUMJeuypiBQAkOqa8nBEbB817Mf.HZVkfZy0Ld4jwy
 XjjV111zmEZywXgyhxRdqhJIqWFO5wCBFCLQZuvxUY39Iri9Ka.1_uu1fMN9tyMjdJq8vakvCAxp
 198lRoW3TGt7xFIkdGDyE8VmWprPp7h62RmCpu1CWOipV4u69W.PhXQcxyaVMZVFvyYMUuZxryUb
 olkXPjth.ruK4QpzR3aVekiqczrP39dvCCB5z8qfiF.1PkFc5ntoX1tj2glXKW6fLdP3eyTcuBDl
 MuW2b3uwb5fRyCKgqrWxa.FMW.g3pUDTZOywf.lAzYWGd9MLip2wnk4yx9Mo6_O8Qo4.5UAatxIM
 xAwGM0eZh_peviot_IsCiSrnvwj7fb7p7fdN58dCAnVCck_.Ntmwn0Ra1TcR0tX878TV_rzJXOiD
 .oPVTzyYkOy1j5OwrPMCePacjeoPtweWdvm3EGI7GPy3T8Mo7bzWhnVGM2JwUoSrWJrL.5HeQsqI
 yOFqAAiv5kSk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Nov 2022 19:07:12 +0000
Received: by hermes--production-gq1-579bc4bddd-wsmzh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 94f00fc74ecff500035d8dc589be8046;
          Mon, 28 Nov 2022 19:07:05 +0000 (UTC)
Message-ID: <dd27f643-38e8-b312-72ce-77d1dc962a68@schaufler-ca.com>
Date:   Mon, 28 Nov 2022 11:07:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/9] LSM: Identify modules by more than name
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, casey@schaufler-ca.com
References: <20221123201552.7865-1-casey@schaufler-ca.com>
 <20221123201552.7865-2-casey@schaufler-ca.com> <Y38D1s3uQ6zNORei@kroah.com>
 <463cb747-5bac-9e8e-b78e-1ff6a1b29142@digikod.net>
 <CAHC9VhR9h1GF6VGovp1+UB-vt+QNofjmecPwLqE3OviKQHRMcg@mail.gmail.com>
 <Y4Rok2iAOekw/tSJ@kroah.com>
 <184be48c558.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <184be48c558.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20863 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/2022 4:49 AM, Paul Moore wrote:
> On November 28, 2022 2:51:55 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
>> On Sun, Nov 27, 2022 at 10:48:53PM -0500, Paul Moore wrote:
>>> On Fri, Nov 25, 2022 at 11:19 AM Mickaël Salaün <mic@digikod.net> wrote:
>>>> On 24/11/2022 06:40, Greg KH wrote:
>>>>> On Wed, Nov 23, 2022 at 12:15:44PM -0800, Casey Schaufler wrote:
>>>>>> Create a struct lsm_id to contain identifying information
>>>>>> about Linux Security Modules (LSMs). At inception this contains
>>>>>> the name of the module and an identifier associated with the
>>>>>> security module. Change the security_add_hooks() interface to
>>>>>> use this structure. Change the individual modules to maintain
>>>>>> their own struct lsm_id and pass it to security_add_hooks().
>>>>>>
>>>>>> The values are for LSM identifiers are defined in a new UAPI
>>>>>> header file linux/lsm.h. Each existing LSM has been updated to
>>>>>> include it's LSMID in the lsm_id.
>>>>>>
>>>>>> The LSM ID values are sequential, with the oldest module
>>>>>> LSM_ID_CAPABILITY being the lowest value and the existing modules
>>>>>> numbered in the order they were included in the main line kernel.
>>>>>> This is an arbitrary convention for assigning the values, but
>>>>>> none better presents itself. The value 0 is defined as being invalid.
>>>>>> The values 1-99 are reserved for any special case uses which may
>>>>>> arise in the future.
>>>>> What would be a "special case" that deserves a lower number?

The interface is designed to extend to attributes beyond those which
are active today. Currently all the attributes are specific to the
individual modules. The LSM infrastructure itself has no variable state,
but that may change. One proposal would allow loadable modules, in which
case an attribute such as LSM_IS_LOADABLE might identify the dynamic
modules. Another potential attribute could be which security module is
responsible for network labeling via netlabel. That could be LSM_NETLABEL.
Another possible attribute could be related to stacking behavior in a
namespaced environment.

While it would be possible to intermingle the LSM infrastructure attribute
values with the security module provided values, separating them makes for
a clearer distinction.

>>>> I don't see any meaningful use case for these reserved numbers either.
>>>> If there are some, let's put them now, otherwise we should start with 1.
>>>> Is it inspired by an existing UAPI?
>>>> Reserving 0 as invalid is good though.
>>> I haven't finished reviewing this latest patchset, but I wanted to
>>> comment on this quickly while I had a moment in front of a keyboard
>>> ... I did explain my desire and reasoning for this in a previous
>>> revision of this patchset and I still believe the
>>> reserved-for-potential-future-use to be a valid reason so I'm going to
>>> ask for this to remain.
>> Then that reasoning and explaination needs to be here in the changelog
>> so that we understand and have a chance to agree/disagree with that.
>> Otherwise we, and everyone else, are left to just be confused.
>>
>> thanks,
>>
>> greg k-h
> The patch author should have done that considering I made my comments on the last revision.
>
> --
> paul-moore.com
>
>
