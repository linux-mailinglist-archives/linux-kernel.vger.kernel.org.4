Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B929B6A456C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjB0O7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjB0O7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:59:17 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC2822014;
        Mon, 27 Feb 2023 06:59:14 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0190B3200929;
        Mon, 27 Feb 2023 09:59:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 27 Feb 2023 09:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677509951; x=1677596351; bh=QLLRw6307b
        THJCej6Dsg3/3/0PoBqWfSBSLn7yYLifY=; b=Zr7hsxRaft6qOSczlEXCHedPV+
        r96EXTSibv+H/UWEsXhc838Rejel7LOs9McoeemUQo00cMKwz/Ed5Nnwz80d9sVW
        je5164z2h30FqrLYmvRXXPwQgS2m2IzsZmiysTm3fFl3Nns/iQutYYeNfrDcZjQ/
        CRGvO1UzHD/4Ho1rFUPnWXNyvMc7gfocah5yJMoAs7H1YEVa7XzR1h2xJHC4yf6Y
        inirBw7UpfTMs0pS+sVjyzm436cMponYakuUj+R+mMjYJbFYFp48fGiEVTnq2LW7
        tQL9phYkwCsCz7FCLDoyO26o2vHQIHvptMeCaWP1m/ZtFPHaGWP1g5N05AsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677509951; x=1677596351; bh=QLLRw6307bTHJCej6Dsg3/3/0PoB
        qWfSBSLn7yYLifY=; b=fsQrMtN9T2DGoyaRs2G7JF87rgV8mM8aLVOlz+saByM3
        ZIoe5+10++ITaYkrYcKL3rZxQxIQ9wqQsuwcrPQLy5+6M/kYMoKkCYYzVFZeW5sF
        a8W6fbZ8pjS2VoZM/nhuvP8YoHKkkPEOknEZ1w2jfIxbwGqThrQS8QKmPMXdARWH
        BfM6XWOW6tcAycp0BMLkzikexwLlUSOVtIWaB01EmMeko2g09es/iMA42KsJN3ub
        xRmZCqzl3OuCzisFPtgWKJgkoGjOrHeBSRliEOTqVZ5bezEhFM+c39ln+o+Sh9HD
        18yVa1PeI6zzIDLfvBLn+JwUQrY9m+BsXTrC4WcDlA==
X-ME-Sender: <xms:P8X8Yw4R4tyM3Di0n8tiuJ22TZFaHDsvUVxJeObM48lCS9S4i2vjYA>
    <xme:P8X8Yx7zcUxANilRbGReT_Or2RzHkKwzIuwVYx5_CIvIF5SNgvybasN82WY0ys6f3
    VC9m_V-A-4sUROu784>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:P8X8Y_fP-QcbqSDT8-z_TnywZc5LWpabQqZt1sXiQObMaGazkHi2dg>
    <xmx:P8X8Y1LizARy4cFAaLtRXks7BHS0HzyvGKQNes_7WJ3OCW8jf7GcNg>
    <xmx:P8X8Y0LNbRpd64Tjs0XuOsTjbGumTnge6ox2WH2rF0jyWbI7TAZWZA>
    <xmx:P8X8YyyTHLvhXZ2BQor-9PqVOVIs-c8G2phPueuDh2RdqE_v0YsYuA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 50F53B60086; Mon, 27 Feb 2023 09:59:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <f3e42012-609c-4085-b4f4-bd32bfc34aff@app.fastmail.com>
In-Reply-To: <20230227142809.kujmrraf3pcdhqyn@CAB-WSD-L081021>
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
 <8e5f9bfa-d612-cd43-d722-d04c40938c62@linaro.org>
 <20230227142809.kujmrraf3pcdhqyn@CAB-WSD-L081021>
Date:   Mon, 27 Feb 2023 15:58:50 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dmitry Rokosov" <ddrokosov@sberdevices.ru>,
        "Neil Armstrong" <neil.armstrong@linaro.org>
Cc:     "Alexey Romanov" <avromanov@sberdevices.ru>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Kevin Hilman" <khilman@baylibre.com>, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        "Linus Walleij" <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v1 0/3] Meson A1 32-bit support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023, at 15:28, Dmitry Rokosov wrote:
> Hello Neil!
>
> On Mon, Feb 27, 2023 at 09:15:04AM +0100, neil.armstrong@linaro.org wrote:
>
> [...]
>
>> I'm aware Amlogic also runs their kernel as 32bit to gain a few kbytes
>> of memory, but those processors are ARMv8 and the arm64 arch code
>> has been designed for those CPUs.
>> 
>> So far I didn't find a single good reason to add 32bit support for
>> ARMv8 Amlogic based SoCs, if you have a solid reason please share.
>
> I totally agree with you, but I suppose it's fully related to 'big'
> Amlogic SoC like S905_ or A311_ series. A113L (aka 'a1') is
> a cost-efficient dual-core SoC which is used for small, cheap solutions
> with cheap components. Every cent is important during BoM development.
> That's why usually ODMs install small ROM and RAM capacity, and each
> megabyte is important for RAM/ROM kernel and rootfs footprints.
> Why am I talking about rootfs? For such small projects a good
> choice is buildroot rootfs assembling framework. Unfortunatelly,
> buildroot doesn't support 'compat' mode when kernel and userspace have
> a different bitness. In the internal project, we save several
> percents of ROM/RAM free space using 32-bit configuration (mostly rootfs
> ROM space, to be honest). Therefore, for such 'little' cost-efficient
> SoCs we can make an exception and support 32-bit configuration, from my
> point of view.
>
> What do you think about that?

I would argue that is a problem with buildroot, and using a 32-bit
kernel is not something we should encourage over fixing buildroot
to do it right, or building the kernel separately from the rootfs.

We do allow building support for a couple of ARMv8 SoCs in 32-bit
mode, but that is usually because they ship with a 32-bit bootrom
and cannot actually run a 64-bit kernel.

The overhead of running a 64-bit kernel is usually a few megabytes
compared to a 32-bit kernel, to store the larger kernel .text/.data
segments, per-thread stack and page tables as well as 'page',
and 'inode' structures. I see that A1 only supports DDR3 and DDR4
memory, so I assume that there are always at least 128MB
of total RAM available, or 512MB for the most cost-effective
size with a single memory chip.

My feeling is that for the 256MB configuration, it is very hard to
argue for a 32-bit kernel because of the countless downsides,
and even for the 128MB configuration, I would still try to avoid
it out of principle.

      Arnd
