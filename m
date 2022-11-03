Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8CE617933
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiKCIxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiKCIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:53:42 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A13CC763;
        Thu,  3 Nov 2022 01:53:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1DEEA5C00E7;
        Thu,  3 Nov 2022 04:53:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 03 Nov 2022 04:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667465619; x=1667552019; bh=YMTHNrTlQM
        ptD5TGpQsFwcoklQykQSuoBCCpqi+5nsQ=; b=L8DypVymW/aai7Z97N5qeQkTIC
        vJLb8xggujFa3Ve3PYExqM0YFCNuZ6bRTgwZuqgZt9Rc+fvLlgh6Rrp9f5Rgv+3A
        ZgZ7mse0SUwAWisrKamJOPhaDYBsFf8FRYDLsZ9n0EAjqAttOgIms6pI9UpCM0Qz
        7658QRVFmd/CjrHNiwkaDIkqxfSO1UdTzeOejdR73K4JCrX/4MxKWJVT68Qi/IF8
        8wOtBV1QRTL24kCRWpflVC2kpmmVZrlzABdbuqmCoWmPWOF5OCHyAPqj/FKEXEwz
        DjtmMYiC+0faYxmvyxoEfv3pgfWhy5D+jKvBog6vmJdutee3Q0qnWi3mo4uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667465619; x=1667552019; bh=YMTHNrTlQMptD5TGpQsFwcoklQyk
        QSuoBCCpqi+5nsQ=; b=OkQuzP47yYOJ8/ZOwc+ABfktwJD8XYfncv/NdEYtEENZ
        8YCLW162Tgj6ldJ5SpvuhWNc4GM3SrUhzmLUbMXcJ5eGYFX1YQsTL9xxAY0RoaTU
        WMxZOdYU2IoC2/9YMsFumSk+6kr7OYqRNfgNecW/6eHpeA8ZQbSUdYBxC5LnJnMK
        fwMVghuIFLMHg6B3Mcy6OkzpPkgznsH3d1Mm9/+2Ohz2QJT2CqdixO1NjvOArb4n
        fYBhaiotMiiAiJi04Fc2/GDfWwnJl90bXywRoR9gnjR3pTuU98XVjGjpTgJYwxh/
        vJgZeberVR3gt1sdMY0VnnxU9X5FLYUBQa76iSIygA==
X-ME-Sender: <xms:koFjY7k4VC6EZDvNejVA7UwFy7HOY0pFQIbNN26ZhGyuT-zudRmzhQ>
    <xme:koFjY-14VGVrKtEiflnIku7xt6J9L7IPfW1eRwsP51TICF9f08ocYCWqmm2b5-S9B
    keBP39T2ve-togHMaU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudekgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffgeffuddtvdehffefleethfejjeegvdelffejieegueetledvtedtudelgfdu
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:koFjYxrDeAFqSmF7A24VRPbVP4beYwJLKrH1afP_TZqlaMMzGN6cuA>
    <xmx:koFjYznaj8w8PnNy2CXHm8Xk1_p85ULbd7WFQHVbYCVBpvQsbvXbaA>
    <xmx:koFjY53kHi5uxkmox_5yReS96VyUArHmSB9OFj1zbMSXXeBoMqirnw>
    <xmx:k4FjY6u0Axz_n9SLqTIE9nOeYKSsPwTzeLix8RDd2wXKQ9hkzgmwZw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0C2CDB603ED; Thu,  3 Nov 2022 04:53:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <b82c5b2c-d8a3-4b6f-9aad-0a63d2f45f08@app.fastmail.com>
In-Reply-To: <20221103081942.3529-1-zhuyinbo@loongson.cn>
References: <20221103081942.3529-1-zhuyinbo@loongson.cn>
Date:   Thu, 03 Nov 2022 09:53:17 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Lubomir Rintel" <lkundrak@v3.sk>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Hitomi Hasegawa" <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Brian Norris" <briannorris@chromium.org>,
        "Sven Peter" <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] soc: loongson: add GUTS driver for loongson-2 platforms
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022, at 09:19, Yinbo Zhu wrote:
> The global utilities block controls PCIE device enabling, alternate
> function selection for multiplexed signals, consistency of HDA, USB
> and PCIE, configuration of memory controller, rtc controller, lio
> controller, and clock control.
>
> This patch adds a driver to manage and access global utilities block
> for loongarch architecture Loongson-2 SoCs. Initially only reading SVR
> and registering soc device are supported. Other guts accesses, such
> as reading PMON configuration by default, should eventually be added
> into this driver as well.
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

Looks ok to me. I can take the new driver through the SoC tree,
so please send it to soc@kernel.org once there are no more
remaining review comments that need to be addressed.

One last thing from my side, with that addressed, please add my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> +config LOONGSON2_GUTS
> +	tristate "Loongson-2 GUTS"
> +	depends on LOONGARCH || COMPILE_TEST
> +	select SOC_BUS

In the one-line description, please spell out GUTS, since this
is not a generic term but apparently is something that is only
used on Loongarch and Layerscape.

Just for clarification: is this derived from the same IP block
that NXP are using, or is this just coincidentally named
similarly?

      Arnd
