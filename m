Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68396350AB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 07:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiKWGuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 01:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKWGuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:50:00 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D87F1DB8;
        Tue, 22 Nov 2022 22:49:59 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8160632009DF;
        Wed, 23 Nov 2022 01:49:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 23 Nov 2022 01:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669186198; x=
        1669272598; bh=pfeTiyTSvdx8Cc3qRibAIg5+skkpZxzHNm/gNig9/9c=; b=e
        FN0A6oRN9O/xv7J156ZmkLwxbTXz2Dmd2TyNUmarzl/qmxeOEaEunuTVxPzaCCcA
        LHAYZDbups+ot7VqMfdmvWF2OjgjOAd1BborzfBSfNn6eIys19RPbF4/QQ29Cqi+
        NRe9PTG5Vte7xMgXg7i3qV5hitgOdDC7ceI43zsisy/Ne86fqMy7rFFZssGTvqJj
        0bbaVXmAyaM++HQKbErZ39HUsde1Ci9KunX2mVhjkRGWPUKBQ9/MXsKPH8G5EHSL
        xvkFRhXxvMgwvFdk92QyeORfbl/wsUNC1B24f53BTLdXWQjmBtCoqPHHk6iIO8w9
        RFY1Y6+S50OoqdoT/RzwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669186198; x=
        1669272598; bh=pfeTiyTSvdx8Cc3qRibAIg5+skkpZxzHNm/gNig9/9c=; b=n
        yzsSRaYFQXeyjx7VjGM+ohaijzyErdeZf1wvgUvTZxrpVarAV5QTywF3ybcLk1Kv
        o1ixcmjBTvulgZEZ1OgHrjJo8OqWuX0BQuOmpk0SLN+CYVNRT7FmHRQNcCwIVsbY
        ndWyjGhv0+VOfuy/fIDa4kz81jy0yV7uhSzBy6UJwoOa18TyxdyKAy+t+qneDX5M
        CHyY6WsrWyZG16xM5VmLJrViifff7RXNrG2T1o9cfr4IoikTr+pKCeIRHDPx/Lod
        DPXzDb5mMWOCFj+Cpsnyl2A7xZQG9R8IK9UQpjbhfs3O7F1iYUTUNn1NLNdk6plZ
        AeVK/4lbBjs7G7ckA3l8w==
X-ME-Sender: <xms:lcJ9Y2dFd4r--_U7af1Z0OlUlD0Qdon8U3ofOXbHA0BKgWyvt8ZTGQ>
    <xme:lcJ9YwMzDbJuTCrE0U_A78egSHaiFFstNaNUq2d0VopeXFgiRIoh65D8Nq0lRlGOI
    I748YUnXloT7iwDNA>
X-ME-Received: <xmr:lcJ9Y3jCl0MKzbA8eI9AG-4l1v_LppAkRdhxhYaXvX8vbgdsiql6hIIcMeVfjzzvJYSzsnxkbu3tkqX58-TtV9hPMXaumDBfJMt5MhK6fcj7j3ePCIbUCX712g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedtgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:lcJ9Yz8J2bt9EOseMk2IX6qpmEZOjpbdzoqhorMuAR44T-VGsC-Rtw>
    <xmx:lcJ9YytOD143GTpqDn4DS_jGQ11LtkUSgyWiJa-3R19gM0e4-C41cw>
    <xmx:lcJ9Y6GGSaeG0sFF5v30fgEOtCDh_l5WJ8h3HVG3OvjoTjeio4fTGQ>
    <xmx:lsJ9Y6GDQqw6PCuLGXnDVRpIpQTzuDBalbaLHlxw_HXA-QK0HUdnaA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Nov 2022 01:49:56 -0500 (EST)
Message-ID: <be1cb304-f871-6768-d3ae-a5b55fb17c46@sholland.org>
Date:   Wed, 23 Nov 2022 00:49:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        conor.dooley@microchip.com, Conor Dooley <conor@kernel.org>,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
References: <mhng-6299f108-11af-4e70-9981-d7e7b3be0b9a@palmer-ri-x1c9>
 <57114829-c205-dece-abdb-1100947286d4@sholland.org>
 <CAK9=C2WLOa_zgboFE5UCgnwMB-kbWMAVtmXsBxoswqY63-5QHw@mail.gmail.com>
 <a591599e-d133-e19a-4898-5645c3862daa@sholland.org>
 <CAAhSdy2VdX9VivbuRhjN0cPXTi=nFWdiPwFs+hUv6iMqZu-q5g@mail.gmail.com>
 <4e9a46e2-eaa2-04cb-8b95-2fe9a091a96d@sholland.org>
 <CAAhSdy22jRmeMqAfJKtubo4wuOs29uax6uucz54RmoiySff7Nw@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
In-Reply-To: <CAAhSdy22jRmeMqAfJKtubo4wuOs29uax6uucz54RmoiySff7Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 00:41, Anup Patel wrote:
> On Wed, Nov 23, 2022 at 11:57 AM Samuel Holland <samuel@sholland.org> wrote:
>>
>> On 11/23/22 00:10, Anup Patel wrote:
>>> On Wed, Nov 23, 2022 at 11:08 AM Samuel Holland <samuel@sholland.org> wrote:
>>>>
>>>> Hi Anup,
>>>>
>>>> On 11/22/22 23:35, Anup Patel wrote:
>>>>> On Wed, Nov 23, 2022 at 10:41 AM Samuel Holland <samuel@sholland.org> wrote:
>>>>>> On 11/22/22 09:28, Palmer Dabbelt wrote:
>>>>>>> I also think we should stop entering non-retentive suspend until we can
>>>>>>> sort out how reliably wake up from it, as the SBI makes that a
>>>>>>> platform-specific detail.  If the answer there is "non-retentive suspend
>>>>>>> is fine on the D1 as long as we don't use the SBI timers" then that
>>>>>>> seems fine, we just need some way to describe that in Linux -- that
>>>>>>> doesn't fix other platforms and other interrupts, but at least it's a
>>>>>>> start.
>>>>>>
>>>>>> We need some way to describe the situation from the SBI implementation
>>>>>> to Linux.
>>>>>>
>>>>>> Non-retentive suspend is fine on the D1 as long as either one of these
>>>>>> conditions is met:
>>>>>>  1) we don't use the SBI timers, or
>>>>>>  2) the SBI timer implementation does not use the CLINT
>>>>>>
>>>>>> And it is up to the SBI implementation which timer hardware it uses, so
>>>>>> the SBI implementation needs to patch this information in to the DT at
>>>>>> runtime.
>>>>>
>>>>> Rather than SBI implementation patching information in DT, it is much
>>>>> simpler to add a quirk in RISC-V timer driver for D1 platform (i.e. based
>>>>> on D1 compatible string in root node).
>>>>
>>>> It would be simpler, but it would be wrong, as I just explained.
>>>>
>>>> Only the SBI implementation knows if the SBI timer extension can wake
>>>> any given CPU from any given non-retentive suspend state.
>>>
>>> The SBI implementation would derive this information from platform
>>> compatible string which is already available to the Linux kernel so
>>> why does SBI implementation have to patch the DTB and put the
>>> same information in a different way ?
>>
>> It is not the same information. The SBI implementation also chooses, at
>> runtime, which timer hardware (CLINT, platform-specific MMIO timer,
>> etc.) is used to implement the SBI timer extension. The value of the
>> sbi-timer-can-wake-cpu property depends on this choice.
>>
>> Using D1 as an example, there are two MMIO timer peripherals ("sun4i"
>> TIMER and "sun5i" HSTIMER) where the sbi-timer-can-wake-cpu property
>> should be set. But the property should not be set if the CLINT is used
>> by SBI.
>>
>> It would be perfectly reasonable for the SBI implementation to claim one
>> of the wakeup-capable MMIO timers for itself, mark it as "reserved" in
>> the DT passed to Linux, and thus force Linux to use the SBI timer or a
>> native CLINT driver (C906 CLINT has S-mode extensions). Then the SBI
>> timer _would_ be capable of waking the CPU from non-retentive suspend.
> 
> Fair enough but the DT property should not be SBI specific because same
> situation can happen with Sstc as well where a particular non-retentive state
> does not preserve the state of stimecmp CSRs in the HARTs.
> 
> Better to keep the DT property name as "riscv,timer-can-wake-cpu".

Consider a platform where the Sstc-based timer cannot wake the CPU, but
the SBI timer can, because it uses different timer hardware or a
different interrupt delivery method. It seems like we need two different
properties, one for Sstc and the other for the SBI timer. If both are
supported, firmware cannot know which one S-mode software will use.

Regards,
Samuel

