Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1261EC58
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiKGHop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiKGHom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:44:42 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC090D2F9;
        Sun,  6 Nov 2022 23:44:41 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6D2AB320098B;
        Mon,  7 Nov 2022 02:44:37 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 07 Nov 2022 02:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667807076; x=1667893476; bh=gpvkcbB9aU
        GK1DAsXCTCzTnpVw31btsSzgZo6/6uIBE=; b=NCV/SlKwFixVlW2RTuHKunS3z0
        s2j6o2hpeR8/tXBhlTvBXNLa7mrTV/1nDsv2vDwU2zf11e7y6Y/FuONjYwhLqLNO
        ahl5TPHy+p8if+Y5TvP0j9thmA4i5MoZtEkR5x32REgLSMycnSaS9nNFQVMzVhBS
        eJwvj5YSMS68OReVfJIZF2CbA+2jdaPY4s4dhWhN4aQga9YIefHR7Ckmu9wkUUv9
        xBpGj90XC7ci7HDqnvi3RTPiUUzFdnsYBdQKn86xQrzYOML24EkYxhRYla+P4gJz
        4fVg7fZEQzTcxsutFevuPGaA89Yp6R4PMHL3d2yPRLb52shuBtfoJ0c1A9rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667807076; x=1667893476; bh=gpvkcbB9aUGK1DAsXCTCzTnpVw31
        btsSzgZo6/6uIBE=; b=Eh8RLtb5dQadHLzKZ98rtWZhUHC/RPLPZH5nrfV7dkUF
        RqlmgUk4uxr3ISpCkd3rWhiqLnUiWiP8x+aD7UYkTau9bEKP5vuC+oABq2o2I51u
        Zj8ZA77GXeXMGrwVxNSIpXc6QGtCdZWyQDVi9PjIox9loBFdb/O8IBbBaxqQb6sZ
        RhO8UG6z4KZCRkP4lOsFDvBt6PvoyBENHQCOQfgTWNgKit3AueyP8svg7YK7ccey
        jb9sPUavVp5uBm0Htagy+zzkuqqY3Smh9oYXvpv1J89H2GiKHHdKX8d5JBlnrGUb
        dgsshNck1rgiLEi+91nGjDQ5N4vGBjcRS912QCCYZQ==
X-ME-Sender: <xms:ZLdoY1OT9ItMNqpRWgxzgZl2WWB1-pg3LqMY_NWjM1yP_FYlUQiu-Q>
    <xme:ZLdoY39o-WXII-0H_EoOR0iBmqRTFvVPc2nFaNv3JWRo9rTwJb0i6zDFtyWMTiXyf
    QbFgzQzbs2N6bGYRcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdejgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ZLdoY0Twh-3seG_wYzXVkO_SSfiDsQndI5dbZV4sghHM_SkBXfLYMg>
    <xmx:ZLdoYxvRUQB9HQafHSm2kkhogWzCnN-aDhBjxci1pLhpn_48-oLA1w>
    <xmx:ZLdoY9cO3A9001tECLkgybD3vcGYairMoYYkyfP4yEigoY9Ov1YFYw>
    <xmx:ZLdoYxPTjA9QL41TSHdHazj8989jA4RPmoh9qv50ORgwD-Sc522VaA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0034FB60086; Mon,  7 Nov 2022 02:44:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <d293e410-223d-4baa-ba6d-65bc11ab1e55@app.fastmail.com>
In-Reply-To: <20221107071511.2764628-8-Mr.Bossman075@gmail.com>
References: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
 <20221107071511.2764628-8-Mr.Bossman075@gmail.com>
Date:   Mon, 07 Nov 2022 08:44:21 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jesse Taube" <mr.bossman075@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>, aisheng.dong@nxp.com,
        stefan@agner.ch, "Linus Walleij" <linus.walleij@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Russell King" <linux@armlinux.org.uk>, abel.vesa@nxp.com,
        dev@lynxeye.de, "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        tharvey@gateworks.com, leoyang.li@nxp.com, fugang.duan@nxp.com,
        "Giulio Benetti" <giulio.benetti@benettiengineering.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 7/7] ARM: dts: imx: Update i.MXRT1050.dtsi compatibles
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022, at 08:15, Jesse Taube wrote:
> Remove unused compatibles from i.MXRT1050.dtsi.
> Change GPT clock-names to match documentation.
>
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Can you make sure your changelog texts explain why you do this?
Are they fundamentally different from the devices you had
claimed to be compatible with that need a different driver,
or are there drivers in the field that bind to the wrong
string first?

       Arnd
