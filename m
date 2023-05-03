Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCCB6F602C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjECUhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjECUhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:37:43 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACA47ABA;
        Wed,  3 May 2023 13:37:41 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 204E5580DD5;
        Wed,  3 May 2023 16:37:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 03 May 2023 16:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683146259; x=1683153459; bh=de
        sv6xluCw6O+vvGUBE1D2AER9o0GCpP/5poLPXyM/I=; b=dPT1qww92IzHVup5HD
        dBW4pJtCc3mO7+suvORGzU/mum6k7BRdyBFP9vj/V9pcUMTlLsRq9Dfyf0TxPKx5
        YGLrHzHgERFVrr/5nu2PocVjYM1XBfwv/aA56y5g4hroK4QZ3jk4TPPcP6mrUoEb
        JMYYqfpFBP/Rxd6Gt6rgRn2NW9becs5c7yab13WTXd5j/To6bkYC0EOiRxnie1Jx
        bC5Zt0xB4/42BHh+ZwrEeMB/vd+Qtr/ZcDv9W6thTdAfYf5ORSaL/sDo/ovkzvBM
        GLy4HMODldsz9Q4mT0NlweDGFgHqLam/KNavBuQzHtXODRk2aokvO9HUK4cbH3o3
        5Xrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683146259; x=1683153459; bh=desv6xluCw6O+
        vvGUBE1D2AER9o0GCpP/5poLPXyM/I=; b=d48yA3SILCVW3LXBTHIbLeHd3/55J
        lqCOnfsbA/LldPyygh9jh5J28/dsd8VUhXAFP/EkNp/lobLda1F5PT14Ev6GN+ew
        G6LOsplfleF40FEUspzQcMJugBF8TRJqAJ8qI9YYSeRqysA8B112xhztSrLb8Elq
        vr9P1xezH88OAe5nH5P6aD1C7C630mNeOvhLxIqL4Rd6LysBSZPPQuneer/bRja0
        vJqvuj0S+ddloNWFG95dqwNyXOUnF550OTdcmkQjKkD80XI9dKNFUou/FnylDupT
        7QT1q75XDl9Tkw/5rEEeDO+E2qgfKGHNkZcBi4wrIPv1kHUXuwfyNqmZA==
X-ME-Sender: <xms:EsZSZB5kJ0GrHR853zsjReTXCKVzZZoOEsZUrLM9Ii19_fMe7QEyIg>
    <xme:EsZSZO6wVrnO6sfVpVMYHV-p9-4TDkFZOjWwoen4Pv4_WkwrEpvS1M4ci3zIanwDm
    iUGKsSgwu187PEcA7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:EsZSZIeBp0ONVV8TVGAY_CZg0aGNjOO37JGCfetCDzJCfsVOWHoHeA>
    <xmx:EsZSZKLcCAxw1z1MpswPdC09DGpopJXBLGfDzf3ZMawPn9MBk-esNw>
    <xmx:EsZSZFJBmzNloya5zTwIRkajH22JwQIMIb5cn4Bc3yIvQGmJ9q_Iog>
    <xmx:E8ZSZAITCL8EImpKlG0FYkRLfsze_wfBG8B-LvTI8Bca_uFWRtmTrA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0094FB60086; Wed,  3 May 2023 16:37:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <4d9b4159-88b2-48cf-84d9-34169928c8e4@app.fastmail.com>
In-Reply-To: <CAL_JsqJEdZBS231TvkmmipaXEqzvDjz+A32V6uJ4zfSMAJHn2w@mail.gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <bce93654-fc36-3d12-282d-76fafb8f51ce@linaro.org>
 <CAL_JsqJXd_EpOQwwNEAn25mzFfkhEvqzur6ui5Ca+dbt2kA8-Q@mail.gmail.com>
 <5e318b02-8f33-4e2d-a956-5660e1c60619@app.fastmail.com>
 <CAA8EJpq8x5wQa3fMebaSP3hCdMiCsZRaF+B4Y3N3royW_CeXCA@mail.gmail.com>
 <4e1e70a9-9b28-410b-bd29-fb5f5805798f@app.fastmail.com>
 <CAL_JsqJEdZBS231TvkmmipaXEqzvDjz+A32V6uJ4zfSMAJHn2w@mail.gmail.com>
Date:   Wed, 03 May 2023 22:37:17 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Rob Herring" <robh+dt@kernel.org>
Cc:     "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
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
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023, at 15:16, Rob Herring wrote:

> We could do a second level of directories here:

Works for me, but at that point, I'd really also want to do it
for nxp with its five or more product lines (mxs, imx, lpc,
s32, layerscape, vybrid)

> intel/pxa/
> intel/ixp/
> intel/socfpga/

and intel/axxia I guess.

     Arnd
