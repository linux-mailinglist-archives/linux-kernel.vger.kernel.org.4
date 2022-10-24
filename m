Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0A960A00E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJXLRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJXLRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:17:49 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505F83FEEC;
        Mon, 24 Oct 2022 04:17:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 803485C00C6;
        Mon, 24 Oct 2022 07:17:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 24 Oct 2022 07:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666610267; x=1666696667; bh=xu4mddjmHF
        LxnCcoSQUu2xkXQQ81r/PoGIDhSxMIONM=; b=Wr8kYIcA8ultl9YCxdTiu/llJM
        LxGcsgPvU5fWnldqUZ40JmfQqTCeJdQNdLBjgN5/4qnEx3eDcs3l7krCJ4bzvOGI
        pp6+/a13xHkR/+L1fM5L+4h0jVZwswo60w6JFQUPIiyGvqejgFZz4HiMsTP4B1fr
        RUU2LFYCORRH22p0iPqHM6J+ZM92pvwTp6DfTJF0pjLjWtglcxUn8348YeBGeg0+
        ZMXFdVBCqoqfiU4xylqKGNmRb/Ek+H6VhDYRGaXkab8qwK9R1t0W+acywh3CVwuI
        HkVhvGdAzWYqLCHHapCyP5Qiz4vWp6zX+nGE1K8MqNTeiQzJ3K04o+Aab6rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666610267; x=1666696667; bh=xu4mddjmHFLxnCcoSQUu2xkXQQ81
        r/PoGIDhSxMIONM=; b=a1WFvxkxKo0shWp1h3gg/SNznNtxmUPZJDVbbG1ycf5F
        l97J0BmEgYPZ08CiU8oe8hIvqPr6Fv5krfwhMtvnqVx/9WoNKsFheR4TyKW5Cuuc
        PstLqaL2eOiMhOsqpUP7FTBoxcghKDf2XnIiR+EpMfW5IXRrdNYFaxuLufL8tU3n
        b1pt/WHbEKyD3tYc2eWxNNG12tAIpucTLAgONGqpp7r7sDR+NyBt3aU/3fY+1Z0w
        vQoRbEbnuNeX42Y3McmyL/aMfZEBZWewBmm1fkOHLReTdyt3ghtEPi1MhEenpzLl
        u6U5EPRlPtVfP1oLeA/4hzxKBAA7lL+WJxZr8DpKrA==
X-ME-Sender: <xms:WnRWY-JowfNqXIv4EG3uHHNNF-Zl3n-eIiToAuAstubmzsVrm7rKwQ>
    <xme:WnRWY2LQ4oF5V3J0jzWjpbNAJvwXwIujYxkZNoBqbs4egCpThPkpezMh3H9vVcVS3
    f_NgV1LfUPMzva1NEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffgeffuddtvdehffefleethfejjeegvdelffejieegueetledvtedtudelgfdu
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:WnRWY-sdgyIpZZIzyT5LJhp10aUciD3THxBUN8rOD44MfuxdBCRftA>
    <xmx:WnRWYzZLPCKe05zhg4n9DfJfyCEzJVlvauRKb1aGqJpvpG0UjiPqvA>
    <xmx:WnRWY1ZOSiURVJBiaQ6z3ZR-i1H0PRmW00hlZ4JMcr4XUyWwUreilg>
    <xmx:W3RWY7DpzRVJ6nEShxKMNqaXfG_DTOUdWCdFInTmojkG-XTeSPJ0pA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 54C8AB60086; Mon, 24 Oct 2022 07:17:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <7821b174-ff80-419e-9deb-5fb702457f9a@app.fastmail.com>
In-Reply-To: <20221024105822.24514-1-zhuyinbo@loongson.cn>
References: <20221024105822.24514-1-zhuyinbo@loongson.cn>
Date:   Mon, 24 Oct 2022 13:17:26 +0200
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
Subject: Re: [PATCH v1 1/2] soc: loongson: add GUTS driver for loongson2 platforms
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

On Mon, Oct 24, 2022, at 12:58, Yinbo Zhu wrote:
> The global utilities block controls PCIE device enabling, alternate
> function selection for multiplexed signals, consistency of HDA, USB
> and PCIE, configuration of memory controller, rtc controller, lio
> controller, and clock control.


> This patch adds a driver to manage and access global utilities block.
> Initially only reading SVR and registering soc device are supported.

Is this for MIPS, Loongarch or both?

It looks like the driver only deals with identifying the SoC, but
is at the moment unrelated to the other functionality you mention
in the changelog text.

Please explain in the text whether you plan to add more functionality
in this driver later, of if this is just meant to be set up by
bootloader/firmware.

> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  MAINTAINERS                             |   7 +
>  drivers/soc/Kconfig                     |   1 +
>  drivers/soc/Makefile                    |   1 +
>  drivers/soc/loongson/Kconfig            |  17 +++
>  drivers/soc/loongson/Makefile           |   6 +
>  drivers/soc/loongson/loongson2_guts.c   | 168 ++++++++++++++++++++++++
>  include/linux/loongson/loongson2_guts.h |  35 +++++

Is there a need to include the header from another driver?
If not, just fold it into the driver file itself.

> +
> +menu "Loongson2 series SoC drivers"
> +
> +config LOONGSON2_GUTS
> +	tristate "LOONGSON2 GUTS"
> +	select SOC_BUS

Please limit this to to the appropriate targets like

        depends on MACH_LOONGSON64 || LOONGARCH || COMPILE_TEST

so this does not show up in 'make oldconfig' for users of
other architectures.

> +struct scfg_guts {
> +   u32 svr; /* Version Register */
> +   u8 res0[4];
> +   u16 feature; /* Feature Register */
> +   u32 vendor; /* Vendor Register */
> +   u8 res1[6];
> +   u32 id;
> +   u8 res2[0x3ff8 - 0x18];
> +   u32 chip;
> +} __packed;

This should not be marked as __packed, since MMIO
registers have to be accessed atomically while packed
registers have to be accessed byte-wise on CPUs without
unaligned access.

    Arnd
