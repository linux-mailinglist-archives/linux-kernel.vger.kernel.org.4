Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C9C658F88
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiL2RWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiL2RWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:22:01 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F5B140AB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:22:00 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2FCEA32005C1;
        Thu, 29 Dec 2022 12:21:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Dec 2022 12:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672334516; x=
        1672420916; bh=QJOjYC8ur79wEhI5X44d2FsV4Yf4TjIn7hONPRpkry8=; b=r
        +jVhARpBTe3OVe5K2tzzMXVW8/D6qP8pu0qkT46TXlZHSvBUfxWkCthV/1oQ7qqK
        0nvo6qB/6RyetqVoY1spxV2A4YKfVFK5WT8MLKea6OB4F0mmBA5z5sNzDPX2mLAL
        V9xT822r9DiUDMPqfLEtW6P6wLXA+2jhsiLX440/yOfqmGqwPt7YzFZdQPWj0ktD
        hICSH1riQIL+d/y9j6DsxbXHDzT4oNLE95D1kLynpmpC+/Uwzz2ZZvyHtq9hjyVI
        e5GJfuA6BjECmb76o6cZRKoelsXxwaOkMRwjhr7t8U+urWvOwt/WttEuoE5OSwss
        Hqr7sLXsogVHPP3Qr+SpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672334516; x=
        1672420916; bh=QJOjYC8ur79wEhI5X44d2FsV4Yf4TjIn7hONPRpkry8=; b=w
        9LnjGR97KXyu5hMUQ0lMxeXJrSXD6c2cK0Pdd9fs7SmxAC9ExnselbifOEnijxMW
        Di2vSF+mCiGjFlPAdnmtfscrRAdZDNPXO9aFXrf/HJhHbNO707c+eGrCNZhOOh+k
        jydFnKYaCAehkYL/OOXvqdd8xMPXEYIvc/wCRGAfz1IS7O1cSA7ZvnJniUPjlbm0
        TEn+6Ltpp59ZaM5aHZT8FHxwOT1XZlIsgGAhEy8dh3pLZGUTXTNGpzRoUh+9VFDG
        yhpiNSlGUuXEwDS18MUGZ/RNOdKpOkoUnER6GTNL2syhYzOMtgMym+ZozlCP25Og
        8gZ9t1ZbAvaewUcWueSfg==
X-ME-Sender: <xms:s8ytYyViZIgZ0PKto4SfZ9s7odJXjdaBOxTrb10g1CHWquCHt6IyLg>
    <xme:s8ytY-kj_Rqc1g1gAu6Z1maGgE1mzVUwscMo2bsAJMskrQHGDi_1vAU6c9__oIH3-
    Hb4nBdweIQTnS3_gA>
X-ME-Received: <xmr:s8ytY2b4Nwxyaz85nkWWqjOf1E1HEhis5wIs9UJJXel9TYsjw8yQaa95XVVgdP-7KQxkgq23JZuI1fdPF0EAuKl1QU5LXRiA6Y0SC8bmuXIJXM_8uXATXVgZzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeikefgheduvdfhheelkedvffelueehgeejtdeuieduieejhedv
    vddtfeevleeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:s8ytY5XT6zNYfXtnGR6EzMX_7elxSRtPASlTviAwrKKCmRWwJ3cuaQ>
    <xmx:s8ytY8m4IHvcv3gmFQpizdQSQOzTMcUfSdCvTeDQ3eQAM2jU00zDUA>
    <xmx:s8ytY-ffJfvgNW-49u2McTdNmQ56es7_A7L-RiVI9SsVcGJrM_Q94Q>
    <xmx:tMytY6aacm78Tw1mwEv-MR8SKqMo5dFw7uffQcgSxILEJFhdTvfjzQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 12:21:55 -0500 (EST)
Message-ID: <86ad9bca-dc30-924c-6017-8cec5a0389b3@sholland.org>
Date:   Thu, 29 Dec 2022 11:21:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        prabhakar.csengg@gmail.com, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <mhng-e60a7fcd-f497-4bca-8de3-b57e2a2d3532@palmer-ri-x1c9>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] clocksource/drivers/riscv: Increase the clock source
 rating
In-Reply-To: <mhng-e60a7fcd-f497-4bca-8de3-b57e2a2d3532@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 12/29/22 10:22, Palmer Dabbelt wrote:
> On Tue, 27 Dec 2022 16:44:44 PST (-0800), samuel@sholland.org wrote:
>> RISC-V provides an architectural clock source via the time CSR. This
>> clock source exposes a 64-bit counter synchronized across all CPUs.
>> Because it is accessed using a CSR, it is much more efficient to read
>> than MMIO clock sources. For example, on the Allwinner D1, reading the
>> sun4i timer in a loop takes 131 cycles/iteration, while reading the
>> RISC-V time CSR takes only 5 cycles/iteration.
>>
>> Adjust the RISC-V clock source rating so it is preferred over the
>> various platform-specific MMIO clock sources.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/clocksource/timer-riscv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/timer-riscv.c
>> b/drivers/clocksource/timer-riscv.c
>> index a0d66fabf073..55dad7965f43 100644
>> --- a/drivers/clocksource/timer-riscv.c
>> +++ b/drivers/clocksource/timer-riscv.c
>> @@ -73,7 +73,7 @@ static u64 notrace riscv_sched_clock(void)
>>
>>  static struct clocksource riscv_clocksource = {
>>      .name        = "riscv_clocksource",
>> -    .rating        = 300,
>> +    .rating        = 400,
>>      .mask        = CLOCKSOURCE_MASK(64),
>>      .flags        = CLOCK_SOURCE_IS_CONTINUOUS,
>>      .read        = riscv_clocksource_rdtime,
> 
> I've never really understood what we're supposed to do here, it seems
> like we're just picking arbitrary ratings for the various clock drivers
> to get the one we want.  That's really a property of the whole platform,
> though, not the drivers, so trying to encode it as part of the driver
> seems awkward -- if anything I'd expect the ISA clock drivers to be the
> worst on any platform, as otherwise what's the point of adding the
> platform-specific mechanism?

For sunxi at least, the platform-specific MMIO timers came first, as the
ARM architectural timer was not implemented in the first couple of SoCs.
The ARM architectural timer was universally better for timekeeping
(percpu events, faster access, larger range), so we completely ignored
the MMIO timers once it was available.

We eventually went back and enabled the MMIO timers everywhere because
they are useful for PM. Either they don't have CLOCK_EVT_FEAT_C3STOP, or
they do have CLOCK_SOURCE_SUSPEND_NONSTOP, or both.

I imagine the RISC-V situation will be similar. The time CSR will be
used as the primary clocksource and for sched_clock, while MMIO clock
sources will only be used in specific PM scenarios where the time CSR is
unavailable.

Plus there is the distinction between clock sources and clock events.
Drivers usually provide both, but there is no requirement that both be
used. The RISC-V architecture provides a high quality clock source (time
CSR) but a poor quality clock event (SBI call) unless Sstc is available.
So platforms without Sstc may use a combination of drivers: the RISC-V
clock source along with a platform-specific clock event.

> That said, I'm fine with this as long as it's improving things on the
> platforms that actually exist.  IIUC it's only the D1 that has multiple
> clock drivers currently, so if it's good there it's good for me.  We'll

RZ/Five also has a platform MMIO timer driver[1].

[1]:
https://lore.kernel.org/lkml/20221211215843.24024-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

> go crazy trying to reason about all possible future hardware, so we can
> just sort out how to make stuff work as it shows up.  So:
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> I'll let the clock folks chime in, happy to take it through the RISC-V
> tree but unless someone says something I'm going to assume it's aimed
> over there.

Thanks for the review!

Regards,
Samuel

