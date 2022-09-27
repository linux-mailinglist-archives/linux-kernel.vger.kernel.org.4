Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFB35ECE03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiI0ULz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiI0ULd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:11:33 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2BC147F1E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:10:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 10A2F58091D;
        Tue, 27 Sep 2022 16:10:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 27 Sep 2022 16:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664309436; x=1664313036; bh=HxMEAGlrPb
        DwKnJjuKAXWgh8MXkugc7jSmVO0YSXdok=; b=JsFIcr3HaWbxby+TaVvRXbQ1ng
        2JyHX+ouKivs9uyFe0vw4C7QdfkVXuaxNSfCk4pU95F6v5fQum3q0uTA6IAy/i/y
        v9vttpDgH5gWvOMKZoe9Se3r1zbdNSgk9KSh+ROQjo6j6wt9LXSXmJyDqYmS05Hq
        YcitThzq7fqxpMxzFbTTtMRvdAwz0BQtWUuI5Z9Vs2S0rBJALDqlEdXB6vf1Zcn2
        r5xwbRwLtOtX+Rg6vITv6sySu+5OVQjRLpThXNIA/1MzQ9t5k09raO/2rE7U8Vid
        0CiQ3px3yMeONLREHlRoDzPaEm5kc8GoKHWCkbo2RKRbdKEWfaelCtYtmFXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664309436; x=1664313036; bh=HxMEAGlrPbDwKnJjuKAXWgh8MXku
        gc7jSmVO0YSXdok=; b=oEUGU6gf+BJO0pQmqzmyX1o/e8A1z72WJ6Y1x4oPFWLo
        otBo1lb/E0KnxrbD798lLbCRfCge8pF9wuluesFfWDzu5y5Bm/BCQb+v6taZG+iI
        34z2VnkZj90psCTsq29F6GObvp3aMNwubXyrTU3sFoMD5V3WPS9Xemu2H/JL+Y5o
        cR8kybLFiGUe4MmUwmK1G1aNHIkBRSHMwkw2cXGPvbyIqyNGDkeuaovTRR6OQK8w
        qG34crNAGvJLRmq/6Y7yzY+ED2iTxIFI/4lOAXGwEneFsFNJbGe31cACFVqzHH+X
        +fCFUt3fUfNE00Dd/UoNt++5d2f5WXVqypeeq0otbA==
X-ME-Sender: <xms:u1gzY4UmHLnPXdMF-dM3ZZ7ALWwctPPWHX54KecbyNRz94ja8tG_0Q>
    <xme:u1gzY8kAKjx33jksCNRobRH38xWH-JGQYvB9Yu35HKR-6g0PUhO3LgoIMzEDCvXyY
    ZydOQ8_J7Ci5FEAHoM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegiedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:u1gzY8ZDQ1lJY21BwVJe0NHc_xdn94H12D-HC5zmy3NnzQ4nwwmv3A>
    <xmx:u1gzY3Ur8-NR-hHe1_vHT3pYgFgjgowqKlP07KgUxi0F8TKNNMw_zQ>
    <xmx:u1gzYyljtEk171Eg8gENd56BvnRffVmQdivZEhZwXMzSF1KQO1DxtA>
    <xmx:u1gzY3-5qJZou-jDwArCbrGvC38zHaDk9q2yr-u5QdcjWA-yAJUu3w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0318BB60086; Tue, 27 Sep 2022 16:10:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <0c368c7d-3130-46e6-8185-7270f58161a3@www.fastmail.com>
In-Reply-To: <CAMuHMdVL8TZ8vfdQT_9DA=JLX3O7YrP0v9AK87ALjmsvryZptw@mail.gmail.com>
References: <20220818145616.3156379-1-arnd@kernel.org>
 <20220818145616.3156379-6-arnd@kernel.org>
 <CAMuHMdVL8TZ8vfdQT_9DA=JLX3O7YrP0v9AK87ALjmsvryZptw@mail.gmail.com>
Date:   Tue, 27 Sep 2022 22:10:14 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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

On Tue, Sep 27, 2022, at 3:31 PM, Geert Uytterhoeven wrote:
> On Thu, Aug 18, 2022 at 4:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -1904,6 +1904,7 @@ config DEBUG_UART_8250_PALMCHIP
>>
>>  config DEBUG_UNCOMPRESS
>>         bool "Enable decompressor debugging via DEBUG_LL output"
>> +       depends on !ARCH_MULTIPLATFORM
>
> Shouldn't DEBUG_LL itself depend on !ARCH_MULTIPLATFORM instead?
>

That would also be possible, but I prefer to keep limiting only
the DEBUG_UNCOMPRESS. The idea of DEBUG_LL is that while it's
hardwired to a particular hardware address, it does not actually
access this address unless you specify the 'earlyprintk'
argument on the command line.

We should probably remove the earlyprintk argument from all the
bootargs in the dts files though, because that somewhat defeats
the purpose.

      Arnd
