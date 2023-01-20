Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B48675727
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjATO3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjATO3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:29:20 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6100F80B82;
        Fri, 20 Jan 2023 06:28:54 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0CA6A320082A;
        Fri, 20 Jan 2023 09:28:17 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 20 Jan 2023 09:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674224897; x=1674311297; bh=fkHRcSTxE3
        JEfKy3VGeRsYMxwOkBi/LzRtU9Bqmf8IU=; b=DnMX5JrPFN1zKm40RGE7n7n0AB
        mSyLcKQ/DyA3dmvNNsh0RHPeCxss3QaigCtZ44vONkuNbIrsr2ihe/4hpHMK8Hrv
        gyQEuHTCn0gvZHkD3t2R20JtIlfLK+lSnz79y32XKGF3GZ85Ew0FcswDmhDLRi9A
        OSlk7dytVJaQY+GSShfkdIgQBmfwsScIxvUFihzht9TVEQlUo1rhXc79yCj+/Fge
        +cTZBkL4i1NkCMERaD/zmSN1n7jMBWUEXeVViwcelrOonyGJNy+FS/C1LQ6Usxyc
        YfuRmQF1AoNUGKmxMwzcBJaM1aaeFTbzOPWPlebRuXFinJpUhQ9Kam5mWTgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674224897; x=1674311297; bh=fkHRcSTxE3JEfKy3VGeRsYMxwOkB
        i/LzRtU9Bqmf8IU=; b=TFMIxvredoruK1eVNeS/DDwKhh1LKnzM080FD9uHa7ny
        4dwbe4amnxKBqJlgfGXtX8fZluC3Bs6gELsoJ9QvfzvYgj3Pq6E12xfZPgfYVrnL
        t7HxgHDDmAepj7MskME4PBaX6gi8j9B2yLJ2zjhSq+79qnzbsL59KlV+thG5VC3m
        pznn2DsatnuXLCXA6ef7ssfc5yrV63ux03R0mgzb2SeSzpf32kG4bMEQuMavyl6X
        8xUoMl1ytrYLLxF1vb8t7ntzkWc+WHdtcqWx67htJES0nJMQ0mKh8EuIPeLEFW4D
        4ICd0/flM5tXjH3Das2cupziyWqV2crDKLXBEdR7Vw==
X-ME-Sender: <xms:AKXKYw71lYr8ykbXUyJjwFvm9UG3sx7pjwcSaYWvJG2yYc6Vn8vm6Q>
    <xme:AKXKYx4H4hAZxiOPy1kUHaBNNf_W6G2jMWr4BXc_DyHm7D3g6gWPtlCEPA_1w8EF6
    CDN6wvPh7p8EPI_1Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduvddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:AaXKY_dTqs0st2G0CDaRNr9hOvijMx4OshZ0jPrzSW9hKXSRpeWDPQ>
    <xmx:AaXKY1IWjXeTsiQcqoC8GA2bGPpv7wrWoPT4U9PAOl7yjktndHEjMA>
    <xmx:AaXKY0Lx-5SDRCnagJQOG9MP4lANM4ceVd-16mrQRRQO7_86p3abww>
    <xmx:AaXKY3Zp3R-0jn8YCe6Sa0HXv0TE207fu-ZG7sF5nvN6Dt4yfo2fEg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DE899B60086; Fri, 20 Jan 2023 09:28:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <9f0ddd93-a7b6-4b21-86ed-8604fb8a44e1@app.fastmail.com>
In-Reply-To: <Y8qio/hwsP6+EG29@google.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-20-arnd@kernel.org> <Y8qio/hwsP6+EG29@google.com>
Date:   Fri, 20 Jan 2023 15:27:51 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lee Jones" <lee@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, "Marek Vasut" <marex@denx.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 19/27] mfd: remove ucb1400 support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023, at 15:18, Lee Jones wrote:
> On Thu, 05 Jan 2023, Arnd Bergmann wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The ucb1400 MFD driver and its gpio and touchscreen child
>> drivers were only used on a few PXA machines that were unused
>> for a while and are now removed.
>> 
>> Removing these leaves the AC97 support as ALSA specific,
>> no other drivers are now connected through this interface.
>> 
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Lee Jones <lee@kernel.org>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-gpio@vger.kernel.org
>> Cc: linux-input@vger.kernel.org
>> Cc: alsa-devel@alsa-project.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/gpio/Kconfig                   |   7 -
>>  drivers/gpio/Makefile                  |   1 -
>>  drivers/gpio/gpio-ucb1400.c            |  85 -----
>>  drivers/input/touchscreen/Kconfig      |  16 -
>>  drivers/input/touchscreen/Makefile     |   1 -
>>  drivers/input/touchscreen/ucb1400_ts.c | 458 -------------------------
>>  drivers/mfd/Kconfig                    |  11 -
>>  drivers/mfd/Makefile                   |   1 -
>>  drivers/mfd/ucb1400_core.c             | 158 ---------
>>  include/linux/ucb1400.h                | 160 ---------
>>  sound/Kconfig                          |   1 -
>>  sound/pci/ac97/ac97_codec.c            |   1 -
>>  sound/pci/ac97/ac97_patch.c            |  40 ---
>
> Happy to take this with the relevant Acks.
>
> I assume an immutable branch is necessary.

I actually have this and the other bits from the series
in my the soc tree already, aside from one bufix patch
that Mark Brown picked up in the ASoC tree. If it's ok
with you, I'd just leave it like this and submit
everything together.

     Arnd
