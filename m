Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CA660DA41
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiJZE1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJZE1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:27:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170EEAA369
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:27:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DD2585C01ED;
        Wed, 26 Oct 2022 00:27:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 26 Oct 2022 00:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1666758456; x=
        1666844856; bh=3lH7X8yQix97gdXSx419Xf6XqIsUcanr/0tYZOtCBXQ=; b=k
        53R4LPhtAq8mWpwXfukg099EnLgbomR+II1CTaFdy4FV4fmIV9CXrX5898qSs6Y4
        4oye0gEqBAsHxZVtGY97pFOf8Pj2njZRcS4bBLqcopEvE8e7Q6jUo9W0NIzPSJVP
        73xppp0ZO62I9zXkJDU1pOcDmS7ZMbq/mMmKAcCo6li/lfGUP/bJWAStCiSFdPtv
        C8Wrwk5qcninvlTQiSfHD0LBQzN2Fl9EZUG17c5FfpEEE6696HAQgkjvktTBiAVd
        l/DcfT3XwZwTyBXDexvqEIefTWJiC5cYZMkaX3YBpnJDXP3BU0I2nKwSKloDTAof
        c8+2jVaqJo2IBmlF3xuIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666758456; x=
        1666844856; bh=3lH7X8yQix97gdXSx419Xf6XqIsUcanr/0tYZOtCBXQ=; b=B
        FaktF506oO+rrqnMuL38F7fRnNEos5n0Kx0myv5qP9F1cNm/+/vxbWsvSocrblMa
        E4lKTSRlyHa8bEtFb+v6vvEeK7b68ee06Tzry6kyUkNDig+ybv16vA4+5qz9D/Kg
        xSZUQnqtxu4wSVjm2o9/A5e8c97QyWhULHSDTLQQ+ryzz5BU91k1C7vjd8nqWYHr
        h1IPD1+rxQBAGfSFZrQ6CAUYVSR+gsgbPtG1pg/w6m91lrMUwNgiUN75veqRpqWL
        LXBJomPjw4O05/MRVSQBunblSdc/uAwdU6qGmpMh9Lln4vdHHPJUfW1UIKNmbIX8
        RHrPBimDrHJlXmjnVisYw==
X-ME-Sender: <xms:OLdYY01nsWJRFr_J4-yteTesznM5lGB_y76sn3L4Tka9Cmq8o34-MA>
    <xme:OLdYY_FFSrGO9gJxkynggmHiJ_LPzQ7yvxTaYW9pDBwGj-7QfbkhTUmppJt8aqe9P
    MtgoZcS1zzv8-YwZg>
X-ME-Received: <xmr:OLdYY86lAqdKYRd0LX2kGrL8pdT1WXMWJicTTUIoBzRMUc7BXU_AcSisHVZB5R5kXGT5w1YIe9uAiqBlqz8OfLdEYYnB3x3v1hfhR8SQiDP3ARKak5CeU_pQOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgeeikeeufedvvdeuteeivdeiffdtgfdtfeejgfetfeefgeffgfdv
    ffehjedvueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:OLdYY90Y4z_CWDyAJuFzytlxT3jelJ_gVhqmcWm8TZCQKKqmNyObYA>
    <xmx:OLdYY3HoBwrd1PZNkkVmUrMLTkqBiHhLhIwBuRTDWppX2HOSih87iQ>
    <xmx:OLdYY28aRicWn1arTx29L1kgO16El0PZU4XhJ1DMKcdztNSvz_SWgw>
    <xmx:OLdYY845K8z3x_j0-iWPyWGBjlCnmVnl_4OQPlm88HMgAFyLjmqJwA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 00:27:36 -0400 (EDT)
Message-ID: <28f0b6b0-cc85-8406-c007-111d44fa06c2@sholland.org>
Date:   Tue, 25 Oct 2022 23:27:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Russell Currey <ruscur@russell.cc>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20220916050515.48842-1-samuel@sholland.org>
 <89049105-64fc-8d5b-d090-2841064786d1@csgroup.eu>
 <87h713leu8.fsf@mpe.ellerman.id.au>
 <01281a29-5dff-8868-a1c3-4c4978dca346@sholland.org>
 <ea1cf92d-a388-9f7d-1f86-38afedfeff1e@csgroup.eu>
Content-Language: en-US
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] powerpc: Save AMR/IAMR when switching tasks
In-Reply-To: <ea1cf92d-a388-9f7d-1f86-38afedfeff1e@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 00:17, Christophe Leroy wrote:
> Le 21/09/2022 à 05:33, Samuel Holland a écrit :
>> On 9/19/22 07:37, Michael Ellerman wrote:
>>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>>> Le 16/09/2022 à 07:05, Samuel Holland a écrit :
>>>>> With CONFIG_PREEMPT=y (involuntary preemption enabled), it is possible
>>>>> to switch away from a task inside copy_{from,to}_user. This left the CPU
>>>>> with userspace access enabled until after the next IRQ or privilege
>>>>> level switch, when AMR/IAMR got reset to AMR_KU[AE]P_BLOCKED. Then, when
>>>>> switching back to the original task, the userspace access would fault:
>>>>
>>>> This is not supposed to happen. You never switch away from a task
>>>> magically. Task switch will always happen in an interrupt, that means
>>>> copy_{from,to}_user() get interrupted.
>>>
>>> Unfortunately this isn't true when CONFIG_PREEMPT=y.
>>>
>>> We can switch away without an interrupt via:
>>>    __copy_tofrom_user()
>>>      -> __copy_tofrom_user_power7()
>>>         -> exit_vmx_usercopy()
>>>            -> preempt_enable()
>>>               -> __preempt_schedule()
>>>                  -> preempt_schedule()
>>>                     -> preempt_schedule_common()
>>>                        -> __schedule()
>>>
>>> I do some boot tests with CONFIG_PREEMPT=y, but I realise now those are
>>> all on Power8, which is a bit of an oversight on my part.
>>>
>>> And clearly no one else tests it, until now :)
>>>
>>> I think the root of our problem is that our KUAP lock/unlock is at too
>>> high a level, ie. we do it in C around the low-level copy to/from.
>>>
>>> eg:
>>>
>>> static inline unsigned long
>>> raw_copy_to_user(void __user *to, const void *from, unsigned long n)
>>> {
>>> 	unsigned long ret;
>>>
>>> 	allow_write_to_user(to, n);
>>> 	ret = __copy_tofrom_user(to, (__force const void __user *)from, n);
>>> 	prevent_write_to_user(to, n);
>>> 	return ret;
>>> }
>>>
>>> There's a reason we did that, which is that we have various different
>>> KUAP methods on different platforms, not a simple instruction like other
>>> arches.
>>>
>>> But that means we have that exit_vmx_usercopy() being called deep in the
>>> guts of __copy_tofrom_user(), with KUAP disabled, and then we call into
>>> the preempt machinery and eventually schedule.
>>>
>>> I don't see an easy way to fix that "properly", it would be a big change
>>> to all platforms to push the KUAP save/restore down into the low level
>>> asm code.
>>>
>>> But I think the patch below does fix it, although it abuses things a
>>> little. Namely it only works because the 64s KUAP code can handle a
>>> double call to prevent, and doesn't need the addresses or size for the
>>> allow.
>>>
>>> Still I think it might be our best option for an easy fix.
>>>
>>> Samuel, can you try this on your system and check it works for you?
>>
>> It looks like your patch works. Thanks for the correct fix!
> 
> Instead of the patch from Michael, could you try by replacing 
> preempt_enable() by preempt_enable_no_resched() in exit_vmx_usercopy() ?

I finally got a chance to test this, and the simpler fix of using
preempt_enable_no_resched() works as well.

>> I replaced my patch with the one below, and enabled
>> CONFIG_PPC_KUAP_DEBUG=y, and I was able to do several kernel builds
>> without any crashes or splats in dmesg.
> 
> Did you try CONFIG_PPC_KUAP_DEBUG without the patch ? Did it detect any 
> problem ?

I believe I did at one point, and it did not detect anything.

Regards,
Samuel

