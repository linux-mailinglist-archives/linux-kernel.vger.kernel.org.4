Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5398F677677
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjAWIkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjAWIkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:40:03 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1BD1CF45;
        Mon, 23 Jan 2023 00:40:02 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id F39765C00CD;
        Mon, 23 Jan 2023 03:40:01 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 23 Jan 2023 03:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674463201; x=1674549601; bh=w/xnBpY6hf
        cSJp7QsVobDnUei84Cu91kfG5Ty8mZVFk=; b=pYnvhcLmN8HvMMcp4+fmBdl0lO
        oZgrYlh4LAYA7ed0PDdouTryoJ3zzaBXossuzem6QeiJiskglPTxZjrCQQJMLtVv
        +RX1WCOfAq0VtwsQ2jbJ+3s/pd6wlwqKr6xWwNRzPo6zuHO4LZd6mp/AUQ4kgnfX
        QLpEbNe10D72PL1JJpO8KmMV/v3FSktvlRicW1gJT5QBwivjInWWXC0kSqVqiwiU
        h3VqTSAm5KjUKiyxcj5E2/fq7xcGo4hSttFaei3BpOHP/VnFVfbZo9qrqKVMux1a
        e7Bh4aRw0BUTvFJTovXvDqOhDe3t3xv5/WQqmPnMoDrmcu+D6LN0MtsjSb5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674463201; x=1674549601; bh=w/xnBpY6hfcSJp7QsVobDnUei84C
        u91kfG5Ty8mZVFk=; b=j9mjnf21Vz/iIhzR9VMDfOIM5XcpVcqxRzqtzw00sjq1
        4Cs6xzzTbSj3ltZCDBkNoV0lInqeXzN/hRdLbu2JrAhY5seMU6HEBWAsGmNZ/2sj
        Y4LzkC3v58ZsXeBSmRksFGtmLv6kLO3l1oubTEm67PaDvbu1zokH8LcWdfn1iqk2
        ldGXpxee5GvOCVxIlYxGe3EC7ycrPGP9FLym+OlwfCJwBGaJ0lnMJeclCgcG48P2
        /3Juzc6j43gjWMENoYdsZI4GDaBI5gPpx6n/a1k1NdvNE5tkYEAU2tANLAMs54Yx
        beKxrFW2c9ixIEq0gECuGVQ5VQzGMr5PTt6cBamDlg==
X-ME-Sender: <xms:4EfOY6vpTDlhmMjSriH5ttsPa5qTSBcPgi6f66LsCrn1yKJ-kUKXjQ>
    <xme:4EfOY_c7SXsGLPk2732pBYYqo5KtkLpKkx6hNUe56AfMFyOnocDShrOz3JDYhcwsD
    QaNTqPfehJrjAWVCLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddujedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:4EfOY1zKIrt6HgC3WlCgi1VoLkspNUJwKtTCZ2JbADae91lS3z6cLA>
    <xmx:4EfOY1M9Uon-7Q3owh33nDPgVUvsW5JHhfYxbMoCqItEhaYZgJ1P6g>
    <xmx:4EfOY69y5BmZLndAqUH-hZLYDhwo9QVHsuf2M00GsMrFfH-g1spOLQ>
    <xmx:4UfOY49RJKSBbJhvhLTS5tzhjisCJi22pJdjgaXc05fhaTwQpRc9JQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5FCCCB60086; Mon, 23 Jan 2023 03:40:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <a69a5ffc-0820-4adc-9ac4-f827ebf66cf0@app.fastmail.com>
In-Reply-To: <20230123073305.149940-1-lchen@ambarella.com>
References: <20230123073305.149940-1-lchen@ambarella.com>
Date:   Mon, 23 Jan 2023 09:39:41 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Li Chen" <lchen@ambarella.com>
Cc:     =?UTF-8?Q?Andreas_B=C3=B6hler?= <dev@aboehler.at>,
        "Brian Norris" <briannorris@chromium.org>,
        "Chris Morgan" <macromorgan@hotmail.com>,
        "Christian Lamparter" <chunkeey@gmail.com>,
        "Chuanhong Guo" <gch981213@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Daniel Palmer" <daniel@0x0f.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Hitomi Hasegawa" <hasegawa-hitomi@fujitsu.com>,
        "Jean Delvare" <jdelvare@suse.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Liang Yang" <liang.yang@amlogic.com>,
        "Li Chen" <lchen@ambarella.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY DEVICES (MTD)" 
        <linux-mtd@lists.infradead.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Richard Weinberger" <richard@nod.at>,
        "Rickard x Andersson" <rickaran@axis.com>,
        "Rob Herring" <robh@kernel.org>,
        "Roger Quadros" <rogerq@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sven Peter" <sven@svenpeter.dev>,
        "Yinbo Zhu" <zhuyinbo@loongson.cn>
Subject: Re: [PATCH 00/15] Ambarella S6LM SoC bring-up
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

On Mon, Jan 23, 2023, at 08:32, Li Chen wrote:
> This series brings up initial support for the Ambarella S6LM
> SoC.
>
> The following features are supported in this initial port:
>
> - UART with console support
> - Pinctrl with GPIO controller
> - Nand flash controller
> - Devicetree

I seem to only have part of the series, please add both me and
the linux-arm-kernel mailing list to each part of the initial
submission.

It's possible that some patches were already Cc'd to
linux-arm-kernel but did not make it through because the Cc list
was too long (it has to fit within 1024 characters for many lists).
I think you too the Cc list from get_maintainers.pl, but when
sending new drivers this does not work well because it picks
up everyone that recently touched the Makefile/Kconfig.

     Arnd
