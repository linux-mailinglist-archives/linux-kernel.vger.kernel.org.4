Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDD75ED753
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiI1IOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiI1IOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:14:14 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F671F0CCA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:14:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1235258056D;
        Wed, 28 Sep 2022 04:13:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 28 Sep 2022 04:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664352838; x=1664356438; bh=69l6dClFNG
        YJQL2+FpzgbpwS8TN7vzu1Wwoan5cO2Vg=; b=s9deY4mnSD9sLDPQ6SVYkT7T6J
        KxZh7vBlPjNtd1O01t/pK9ZrFQswFvuppcf7aWgykVwg+Ubs6LIO+3YFdU9ir9n3
        n68WJj0O/dsBJXl0KNnQePofGtcMKXwsPutokk53vKpxFI/1ajhwFv3DbY/O4Y1i
        gvmpo0GYf/NXyzX+1LgtiGdUD8ARC/XvgSawFnOFLeypZNE/vj2iBfwn52shvUo7
        jCDrzpE5vtNkUrht8HbMXmi5DuK3H9rcaKRN5ScmX7LgKgsDCbxaJ+3QzQa6AUf6
        FYdKXQF7RcEHYHZkbUz9PXp6HkSqqIeA/1LsCGN6zubu8DI8imOJZ8M40/tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664352838; x=1664356438; bh=69l6dClFNGYJQL2+FpzgbpwS8TN7
        vzu1Wwoan5cO2Vg=; b=Fwl28Mwh7WDopymckhfcGMQG/B0m3LF5CKLBEbU5hpnK
        HwSdA3r4XCnP/ww1aCn+67DGFasrhUW4OZPkBE/lBb4yYspEhAFeddWjdt6QVGfW
        AbVB5Wb2FFdOnZKIA7XFDvTZ5H1YE0Xt67QRrHfaI7b88er/3JPjwumd1rS8xwm7
        miYqUvdanUkzjdG46tOwMbVAkh+3cs1YgHwEzfaNxBszQJX3GqiA8Aki4uzD7jJH
        he1E8gP4hXQKtVD9Ujerg9jl6YcHPSZkDhayIasRplptNQcQnivr5z8GsDtyxzkU
        LckpSualbyjU+IYGaA7KMy/GIBUGxEnHSkViVoBkow==
X-ME-Sender: <xms:RAI0Y4-90ILBpRQZ49-EyEFgsTs1MTTE-rY-G6fsVXv2jXbdt-_QqQ>
    <xme:RAI0YwtM-UaSueZpKEdZ_op_ht6Q3UuI4PTUkURx44rYCprg1M9BK_7tSrAzDrWq5
    JxmBzMKf3XzWIWuXMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:RAI0Y-Ca-82KeQnQkz6uxl5-OmDyKgnheb7i7xLwvJLihEQcA68rkw>
    <xmx:RAI0Y4edqQyPDbC0-pqXDGD56MbaS3xfFpoq53ki-yQ1Vr7p8PXevg>
    <xmx:RAI0Y9Mgd04aUXW8KgsakL-YoV9HNYUSdaBpy-7JB9aVwaJ1ps63Rg>
    <xmx:RQI0Y0mOQbjvMjTm2U7zSvBQ1hFaVVHFKU1yT6LfEN0pajggUc8iag>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 665DDB60086; Wed, 28 Sep 2022 04:13:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <ab221e9a-e504-443f-9713-9a7cc23c66e9@www.fastmail.com>
In-Reply-To: <CAMuHMdWR61CJJ-J==3S6x9MX-i1maaJbjG5jS=vo6h_4Sr-45Q@mail.gmail.com>
References: <20220818145616.3156379-1-arnd@kernel.org>
 <20220818145616.3156379-6-arnd@kernel.org>
 <CAMuHMdVL8TZ8vfdQT_9DA=JLX3O7YrP0v9AK87ALjmsvryZptw@mail.gmail.com>
 <0c368c7d-3130-46e6-8185-7270f58161a3@www.fastmail.com>
 <CAMuHMdWR61CJJ-J==3S6x9MX-i1maaJbjG5jS=vo6h_4Sr-45Q@mail.gmail.com>
Date:   Wed, 28 Sep 2022 10:13:35 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Russell King" <linux@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Ard Biesheuvel" <ardb@kernel.org>, "Sekhar Nori" <nsekhar@ti.com>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Andrew Lunn" <andrew@lunn.ch>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 5/5] ARM: make ARCH_MULTIPLATFORM user-visible
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022, at 8:48 AM, Geert Uytterhoeven wrote:
> On Tue, Sep 27, 2022 at 10:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tue, Sep 27, 2022, at 3:31 PM, Geert Uytterhoeven wrote:
>> > On Thu, Aug 18, 2022 at 4:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
>> >> --- a/arch/arm/Kconfig.debug
>> >> +++ b/arch/arm/Kconfig.debug
>> >> @@ -1904,6 +1904,7 @@ config DEBUG_UART_8250_PALMCHIP
>> >>
>> >>  config DEBUG_UNCOMPRESS
>> >>         bool "Enable decompressor debugging via DEBUG_LL output"
>> >> +       depends on !ARCH_MULTIPLATFORM
>> >
>> > Shouldn't DEBUG_LL itself depend on !ARCH_MULTIPLATFORM instead?
>>
>> That would also be possible, but I prefer to keep limiting only
>> the DEBUG_UNCOMPRESS. The idea of DEBUG_LL is that while it's
>> hardwired to a particular hardware address, it does not actually
>> access this address unless you specify the 'earlyprintk'
>> argument on the command line.
>
> ... or unless something goes really wrong, and the kernel tries to
> inform the user using early_print()?

I don't think this matters either: without DEBUG_LL, you get a non-booting
kernel and no diagnostics, while with DEBUG_LL, you might get some
diagnostic if you have configured the right debug address, and otherwise
the user gets the same as before: a crash without any output ;-)

> Note that the I/O region for the debug serial port is mapped regardless.
> Any chance this can cause conflicts?

Not sure. The early debug mapping should only be used in for
the earlyprintk output, but if a platform has a conflicting mapping
at the same address, it just never gets used before it gets replaced.

     Arnd
