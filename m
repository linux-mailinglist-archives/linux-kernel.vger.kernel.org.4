Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BD960B1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJXQcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiJXQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:31:39 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F081F611;
        Mon, 24 Oct 2022 08:18:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id ABA773200956;
        Mon, 24 Oct 2022 09:33:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 24 Oct 2022 09:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666618380; x=1666704780; bh=yALotGF5gu
        2PaCNV/egtd+i3//YX5Y+ckq5ZuUGJVS4=; b=CGcKm8uy7pXuNtC88a+pdrGRCB
        k/M0r+ucQbVt2z7aNyBAR6pRBZw8NJs567YzTVed5NyNRhbcaXHwOuocNqvkUY1Q
        a68YYRB/kKOAn6neyz323y+AY0jABRus/GKs6ZnMGGzadubtLbobFzYRkyDscYbS
        vCDMVPpfg0mJkMo0dt3BPbxS9ISz4UETtXdTTqolJieAxJBZprtuBBFW7KWzQNwq
        b5d2/2R5JPt36BEgIYG/7w5fVNQB93HfHaAuyuzY3F4k1bSM1mk78MlxBoq0794c
        po8uCvWJYEsV2IuHpET+tTXFgicOU5us4NP4Qu4j6pJoahsQAacmTync8TwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666618380; x=1666704780; bh=yALotGF5gu2PaCNV/egtd+i3//YX
        5Y+ckq5ZuUGJVS4=; b=EYkrsuKQaLFIHyQdtqIYcx3apZCF9wBdNRpj+GJSpPB9
        JkwjAsVrrY+8/LBhMLw2UdwaSO1W0CtV3JXA0M1ZcZjmWYGiVLpHXQ4TQ/N+Bs9+
        FMO23IyPIUW5t2ttBK83GiHdDUQP5TYkVh0mAUKrMNBwg+uTrfY41l4PYZOuUU58
        CHYsg0MyFCHjagA3vA8/qECW16h3s6jqrbPHqZZQKa3MsWPDCBNYL2GD7bnWj0K7
        q/AAuW1ScFgFNBDiCUt6QRr+K76NWAMXWw+C94t+Udq1ws+LB/KWr+RXltGOJrqY
        EX9pCQ4ZjbGeCQ28d12waKezhvXypQmeT6IfOGlvlw==
X-ME-Sender: <xms:C5RWYwArBfZ6a8VFgQq_VBQoQTB-1S-7NavM4BMPa88J9TlSQWY3Ow>
    <xme:C5RWYyhry1D8X17PM3cBtEWkyYDX3hD1HgeoA8GLH4j5O_nJDNxIfYwO4Dp66GsDl
    Gz0nSyOpNrHmAcFMnI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:C5RWYznoIpl1VK6WYw_vMuOUglG__xOiy9B--I8tpKZDrOp5WTrB4w>
    <xmx:C5RWY2yC71fuGhbvF3TFTgSUvwX5ezK5pw78TU_-6IVRuQLR5a7_NA>
    <xmx:C5RWY1RU-78At65GyTDfaOHMkNT2stYNgrmEUD6UEJfh6gu2TQeIHA>
    <xmx:DJRWY0IsNfEI1saq1f9seCxaBlQlB3caBiKeZCPw6wBsipbJkidqZQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 81B7CB60086; Mon, 24 Oct 2022 09:32:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <9912a1eb-ad12-4608-bf48-d74ac5f5805a@app.fastmail.com>
In-Reply-To: <fc923325-335d-e768-ea72-ba1712320d9d@linaro.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-5-arnd@kernel.org>
 <fc923325-335d-e768-ea72-ba1712320d9d@linaro.org>
Date:   Mon, 24 Oct 2022 15:32:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "Ben Dooks" <ben-linux@fluff.org>,
        "Simtec Linux Team" <linux@simtec.co.uk>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Juerg Haefliger" <juerg.haefliger@canonical.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Tomasz Figa" <tomasz.figa@gmail.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 05/21] ARM: s3c: simplify platform code
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022, at 14:29, Krzysztof Kozlowski wrote:

>> diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
>> index c403d7642f0a..c52c7ce1d8fa 100644
>> --- a/arch/arm/mach-s3c/Kconfig.s3c64xx
>> +++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
>> @@ -15,12 +15,9 @@ menuconfig ARCH_S3C64XX
>>  	select HAVE_TCM
>>  	select PLAT_SAMSUNG
>>  	select PM_GENERIC_DOMAINS if PM
>> -	select S3C_DEV_NAND if ATAGS
>>  	select S3C_GPIO_TRACK if ATAGS
>> -	select S3C2410_WATCHDOG
>
> This does not seem right. S3C2410_WATCHDOG is a driver used by all
> (including Exynos) platforms.

I don't remember why I removed this line, probably because I
removed S3C_DEV_WDT after there are no references to that
symbol left in board files. The watchdog driver is now DT-only
with cragg6410 being the last remaining board file.

Ideally we should not 'select' it from here but instead have
it enabled in the defconfig file, but I agree that would
be something to do in a separate patch, while the patch here
should not change the behavior. I'll revert this part.

>> @@ -121,10 +118,8 @@ config MACH_WLF_CRAGG_6410
>>  	select S3C_DEV_HSMMC1
>>  	select S3C_DEV_HSMMC2
>>  	select S3C_DEV_I2C1
>> -	select S3C_DEV_RTC
>
> This as well.

I'm fairly sure this can be removed along with S3C_DEV_WDT,
S3C_DEV_I2C[2-7], S3C_DEV_NAND, and S3C_DEV_ONENAND
as I remove the symbols due to the lack of references
from cragg6410.

I folded in this fixup now:

--- a/arch/arm/mach-s3c/Kconfig.s3c64xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
@@ -16,8 +16,10 @@ menuconfig ARCH_S3C64XX
        select PLAT_SAMSUNG
        select PM_GENERIC_DOMAINS if PM
        select S3C_GPIO_TRACK if ATAGS
+       select S3C2410_WATCHDOG
        select SAMSUNG_ATAGS if ATAGS
        select SAMSUNG_WAKEMASK if PM
+       select WATCHDOG
        help
          Samsung S3C64XX series based systems
 
      Arnd
