Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603526A46D3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjB0QQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0QQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:16:23 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C511820680;
        Mon, 27 Feb 2023 08:16:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3AA09320091D;
        Mon, 27 Feb 2023 11:16:20 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 27 Feb 2023 11:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677514579; x=1677600979; bh=gyEHnWGhDf
        Ft2Gu4gB/Bqdx54bxIG396QI5JbNzq7aU=; b=eRTtkeH3NgJCjy1to2Uusv6Qp/
        Nygkb915sQzycJJtLrfWs6aOhC3aNr0tQYVmu4VTcEJYz4xTMSEApRwPXmOJ2lzA
        Sheu2vj4jyFJC/z3vb6aiI1KrLbs0/mJbAZbqmM/UgukR4Yn8OUDIi11yB0Ig7LW
        HcGL/LG+d5XmfYOnCAA23ZhaLYIbRyVJ/nGFjUcC1912Y7izj1FO1YTxvZ59YAWr
        TbwfowaTngAr9LHF2qNEAQmvPJpHLILqmo8HNtfbipUSzV2wVvozEiBhIN9Haebo
        zpbIKm8kvHKF4nYqdNX0KvQzl3xUlMfzyXEm8Djg5WiQTPQkJR3Bksn+dNkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677514579; x=1677600979; bh=gyEHnWGhDfFt2Gu4gB/Bqdx54bxI
        G396QI5JbNzq7aU=; b=svhAJi84rKRyvhhozMBsXMvg6qI/GYqiFTpIKRvDAqjw
        n98CxMFl7OYokOoyd3J6H9j/ZiH2VTbvVAWwPaP60Z+J+Vsq+C3OYp0jGBCUAYdE
        k4GMSwzvx37hEv7e1kkI/mZXxwMjCbAk/tLowT0QBE3+hCQLImqMTsVT6En+tkyU
        bt1lMWLKwJ5J0FL5WKQ4cVLfJewGfzhn9B13flGAl2J2A+L2LZgBQcyO1CbjbJaC
        CCpMiweOeRQjqNEJG+Rvuqb29mAaXx9mZB6Cez4JZToCw+K41uKdDXtURBt3Sygq
        wrscnQxhqetCXiw14qA9gAsY5GLg4eWWYQu9TaUXBw==
X-ME-Sender: <xms:Utf8Y-FOyucHm-41KFBp0YzaKK8ynadWnWt4znVCo9OlRDcKwmmgAQ>
    <xme:Utf8Y_XXY5Hb6Hkp8_pom-ELkmg0XrSJXjuajU4_JKkffD0K81D3BKtieRtgn2Es3
    3Cc6cYcBN5DgsymRec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:U9f8Y4JpxR4zmsW0albUDf-0duNZYbOkUWz0jzOtJdwkGSrYZd4p7w>
    <xmx:U9f8Y4EklLudLiEmcV9xrE9OyR-XD9QMTw1TynXiGsj-YfHPs8v7KA>
    <xmx:U9f8Y0U1D7jCEdezc7CtK4Kym4v2cMOdFSsXc8U69txsfTN0Yh0Ofg>
    <xmx:U9f8YzPuLTFjjbJ4FfqrQstIEqYX9-oK28Jxa0mK9rkUXjYxsL1G-Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DC7AAB60086; Mon, 27 Feb 2023 11:16:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <a5fa8b23-4ec8-475f-be5e-538b53d6f82d@app.fastmail.com>
In-Reply-To: <20230227155100.hhl4yvkyfqfyoa6h@CAB-WSD-L081021>
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
 <8e5f9bfa-d612-cd43-d722-d04c40938c62@linaro.org>
 <20230227142809.kujmrraf3pcdhqyn@CAB-WSD-L081021>
 <f3e42012-609c-4085-b4f4-bd32bfc34aff@app.fastmail.com>
 <20230227155100.hhl4yvkyfqfyoa6h@CAB-WSD-L081021>
Date:   Mon, 27 Feb 2023 17:15:58 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dmitry Rokosov" <ddrokosov@sberdevices.ru>
Cc:     "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Alexey Romanov" <avromanov@sberdevices.ru>,
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

On Mon, Feb 27, 2023, at 16:51, Dmitry Rokosov wrote:
> On Mon, Feb 27, 2023 at 03:58:50PM +0100, Arnd Bergmann wrote:
>> 
>> I would argue that is a problem with buildroot, and using a 32-bit
>> kernel is not something we should encourage over fixing buildroot
>> to do it right, or building the kernel separately from the rootfs.
>> 
>> We do allow building support for a couple of ARMv8 SoCs in 32-bit
>> mode, but that is usually because they ship with a 32-bit bootrom
>> and cannot actually run a 64-bit kernel.
>
> To be honest, I didn't know about this principle. It looks like a very
> rational approach "start from max supported bitness".
> Based on overall maintainers opinion, we have to prepare a patch for
> buildroot to support compat mode :)

That would be great, thanks a lot!

For what it's worth, the main arguments in favor of running a 64-bit
kernel with compat user space over a 32-bit kernel are support for:

- larger RAM sizes without highmem (most 32-bit kernels only
  support 768MB of lowmem, and highmem sucks)
- larger virtual address space (4GB vs 3GB or less)
- CPU specific errata workarounds (arch/arm/ only has those for 32-bit cpus)
- mitigations for common attacks such as spectre
- security hardening that depends on larger address space
  (KASLR, BTI, ptrauth, PAN, ...)
- emulating instructions that were removed in Armv8 (setend, swp, ...)

Most of these don't apply in userspace, so the incentive to
run smaller 32-bit userland on systems with less than 1GB of
RAM usually outweighs the benefits of 64-bit userspace.

      Arnd
