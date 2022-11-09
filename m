Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123CA62249D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiKIH3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKIH3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:29:14 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8189E18B2D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 23:29:13 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D237A3200A7F;
        Wed,  9 Nov 2022 02:29:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 09 Nov 2022 02:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1667978951; x=
        1668065351; bh=Y+tyaEBih80W2PuGeaW2YLdpAhYiqh+fKlidiOE/JTw=; b=R
        CCCfO7aCaxtMo7n2n9xH1Zoh2dSxsI/jM9rXNeoLbqt4XHUhbG2myELW4X0hdEZg
        YOqiTqzgdMXFzRx7KdbxzNyPYs5tkE8G1DLmkZ7qTN9mJLRkbg+FNHxRYOZYhp+w
        Na/R7oR/3ehJxoPNwbRbXUDaQJQeqzvSn9JKZx6lXK7dylRYDKoFpD1q4dmOShEB
        6/n3bpvXKEA7ChOrZv8NAD+R00tjXUmRAZcG5IANvO4VcWsDpBWY54+su7Q0ElYq
        04U7nDgqfMr2V4HptcsIsZS2CmXAStFi1bA5nJON3nhwaPcinjWIvkVh/GX+uC0M
        fPR7k3DbmA+opkOIbvJuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1667978951; x=
        1668065351; bh=Y+tyaEBih80W2PuGeaW2YLdpAhYiqh+fKlidiOE/JTw=; b=K
        zcz9n797AinRAhTKB0htbmJHPn6+f1kLFKoK4DBprPCsCZJI45kBjUju0h7XMp2n
        Tjai2Xb1yhsTKyPeLajuwOVanT+FKzJfjS5K4BeOBnJEN9YCwlpyqPV0fB1Lxo6f
        FWRZhcJ5PDHDetcK/mdI8bv7drCCh9rTOp2/o5Zh1m149pvorNb2ZQG9LBhrQ42V
        UufTlIs5kjhAVdgFzbER7LcrqwUzb5OKxhGKTcJNYlu2uLTYwcNClqZrYw+RbJve
        Hf32A/Tm8PqSdNtYCaRGZ4MKP965ETkDs/xsBsewXEhgzmeVv8ux4KlPoLKaWi9x
        K6WvdVAHrAOW+BtfS32zA==
X-ME-Sender: <xms:x1ZrY74mAndKj1WDK0T2ZLvFe9n7ofwvxAxl_MAcyHetGU1r-5P7Kw>
    <xme:x1ZrYw5P113-AVne0zyDLM8WovZbG-y8NxIekup9JuG_lXX7i2h4qFRfBaQ3rX1TX
    DriXUd4uBF9cNQyA0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:x1ZrYyeV-2EImwTyZNjWZHuna-iQsxS_20cSBC9eOqpOSv8JRGRMpg>
    <xmx:x1ZrY8L39laD6xh0WsLWEl2Xdry2YU1WqcwT7P4EC4a44ipU8ZDBfw>
    <xmx:x1ZrY_KN28hy6wE3GMRZdp9Ubxco7Lt7WUlIBi1jXBqX-UEFPKEJAA>
    <xmx:x1ZrY5AJlNn4a43jAJ0l74OuELQgoajkscolSjPj78vQrMMwmBeaZg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F12A8B60086; Wed,  9 Nov 2022 02:29:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <06c4f370-715d-4c66-ad43-143b652af5ff@app.fastmail.com>
In-Reply-To: <20221108232228.1177199-1-nfraprado@collabora.com>
References: <20221108232228.1177199-1-nfraprado@collabora.com>
Date:   Wed, 09 Nov 2022 08:28:50 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Shawn Guo" <shawnguo@kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
        "Will Deacon" <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] arm64: defconfig: Enable missing kconfigs for
 mt8183-kukui-jacuzzi-juniper
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022, at 00:22, N=C3=ADcolas F. R. A. Prado wrote:
> mt8183-kukui-jacuzzi-juniper is one of the devices set up to run tests
> on KernelCI, but several of its drivers are currently disabled in the
> defconfig. This series enables all the missing kconfigs on the defconf=
ig
> to get everything probing on that machine so that it can be fully test=
ed
> by KernelCI.

The changes all look fine, but I would recommend not separating it
out into 13 patches when you are doing just one thing here.=20

As a general rule, if you keep saying the same things in each
patch description, it is usually an indication that they should
be combined. Similarly, if you find describing unrelated changes
("also, ..."), that would be an indication that patches should
be split up.

> Given that all kconfigs added in the series are to enable support for a
> MediaTek platform, it seems reasonable for it to be applied through the
> MediaTek tree, but the commits themselves are independent (apart from
> MTK_CMDQ and MTK_SVS) and could be applied separately.

Agreed, merging this through the Mediatek tree is the preferred way.

     Arnd
