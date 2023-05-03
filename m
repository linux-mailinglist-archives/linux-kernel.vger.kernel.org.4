Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F205C6F56DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjECLDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjECLDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:03:18 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86DE5B9A;
        Wed,  3 May 2023 04:03:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 6C7392B0671E;
        Wed,  3 May 2023 07:02:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 03 May 2023 07:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683111752; x=1683118952; bh=MMamfdw2Idw7oZk+/E3mvL+dBo0TUHD8cWv
        2z+u/0pc=; b=WBctjyvS2xYVsNx/PXLCezyBfk6d0fNGJLAbjyR93iv+JntYfRw
        1FknZqmA6tsFPUoOxwPIzC92Rp5Y6yMCdnzeprisuAEmk/2FwjwhujnyjmXpkimB
        SppIL5oaBfr59F6AzPecb7p3PngCPKwbucj2v1SwZaiAn0b8V6yRvxWIATOoB1yT
        kTJFFdKrKoLxDca9M6vO2wD00yP0v9E+Y6cH9ws5eKi/SUd2UHkyPleSrFe3oyLX
        8GenDC9VkDzpl0DM3D3MJqCCidmbvb4oXCVvEsbwuVU7zsrm1wOjex4kRkPwyRT1
        Y3o5kMbVVaclWgwF5PhZKyT7r7Y+YHslZ1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683111752; x=1683118952; bh=MMamfdw2Idw7oZk+/E3mvL+dBo0TUHD8cWv
        2z+u/0pc=; b=AH+K36zaN4zYugn+q+n765d7RqYhBnYAkyeBKpd/jUwnO4cc17N
        sOtk4fgnjqgBRejjoUPfmgWTaKFP4N6l86PC9yWkTl7qSHDYKt8zUNrMJm7hgsac
        MAKOY5kQ55a0V+cd6KgpG+xKpJy4SWbnKyPbmZiW4Z0r+3tL/pAww5DKoBXtHvDI
        i273D40wtniWtgLX4sC5ApVUdClgCvIzPssLKxyAw/v9JuPv2gH8vOUO3lADSDBb
        NaXuK10560hVSSAb2s815TRFlAaY6HIsVEB4nLwDJq5pD3D+mqkoaNJij4p9s68c
        FZWuHfNk6rEKY5SsKc3Dqj2x0oLyHX/paVw==
X-ME-Sender: <xms:Rj9SZKlTTnbDiHX55Z0zVK4RRHqTtD34Ic0kr9gu8LXRZUd5vW1sNQ>
    <xme:Rj9SZB2RRbTSlfnvoyCiq-CjuDURcGdNgs5GoDJl4qCHFJ5-ZHoIvp9bWKCYjpXN-
    ODT0WgrXyw40LeC0sc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Rj9SZIovGybcnhaYiLbWAMPNr2wtxMzL-NEtbKfgejz2jVx79Q3BOw>
    <xmx:Rj9SZOmlZGrdb2-rGVi2XdPxahue8H13hkdPES4NDGwCeY-jXgd-ew>
    <xmx:Rj9SZI2--fY13skOLwZ1x9wt_VRgsao0yXJv8XyToKLEhPijWfOSBw>
    <xmx:SD9SZMJstDJSwk6E9VhGeSPmli8W6KuMDF8H4lCfg1AWmdfP8FfC5WnUfw0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B77FBB6008D; Wed,  3 May 2023 07:02:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <99b49e6b-e963-415a-a2c9-72505087833c@app.fastmail.com>
In-Reply-To: <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
Date:   Wed, 03 May 2023 13:02:10 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Rob Herring" <robh+dt@kernel.org>
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Olof Johansson" <olof@lixom.net>,
        "Christian Marangi" <ansuelsmth@gmail.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023, at 21:40, Rob Herring wrote:
> On Tue, May 2, 2023 at 3:15=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:

> vendor_map =3D {
>     'alphascale' : 'alphascale',
>     'alpine' : 'alpine',

I would make this one 'amazon' if we go with current manufacturers.

>     'nspire' : 'nspire',

nspire is the name of the end-user product, so that doesn't quite
fit. The SoC was apparently an LSI logic Zevio, which is now owned
by Broadcom.

>     'mvebu' : 'marvell',
>     'mmp' : 'marvell',
>     'berlin' : 'berlin',

While berlin is related to pxa/mmp, this one is now owned
by Synaptics, and the 64-bit versions are already in the
synaptics subdir, so I'd go with teh same here.

>     'openbmc' : 'aspeed',
>     'en7' : 'airoha',

airoha is a separate company now, but the hardware is still
shared with mediatek, so we could consider lumping it into
that subdir, but a separate one may be better long-term.

>     'gemini' : 'gemini',

This one is also a product name, not a company. Apparently,
gemini was originally made by Storm Semiconductor, and then
by Cortina, which was subsequently acquired by Inphi, and that ended
up in Marvell after the product was already discontinued.

Out of the four, I'd probably go with 'cortina' as the
directory name.

>     'meson' : 'meson',

-> amlogic

>     'moxa' : 'moxa',
>     'mstar' : 'mstar',

-> sigmastar

>     'nuvo' : 'nuvoton',
>     'lpc' : 'lpc',

-> nxp

>     'lan96' : 'microchip',
>     'owl' : 'actions',
>     'ox8' : 'oxsemi',
>     'rda' : 'rda',

-> unisoc

>     'rtd' : 'realtek',
>     'r7' : 'renesas',
>     'r8' : 'renesas',
>     'r9' : 'renesas',
>     'emev2' : 'renesas',
>     'sh73a' : 'renesas',
>     'gr-' : 'renesas',
>     'iwg' : 'renesas',
>     'rk' : 'rockchip',
>     'rv11' : 'rockchip',
>     'rockchip' : 'rockchip',
>     'socfpga' : 'socfpga',

-> intel

>     'stm' : 'stm32',
>     'sti' : 'sti',
>     'st-pin' : 'sti',
>     'ste' : 'st-ericsson',
>     'spear' : 'spear',

I would put all five of these into 'st'. The ux500 was developed
in st-ericsson, but last sold by st, and the other ones are all
original st products.

      Arnd
