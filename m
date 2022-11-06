Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3439F61E0A5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 08:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiKFHoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 02:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFHoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 02:44:09 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012E6E0C6;
        Sun,  6 Nov 2022 00:44:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 34FC15C00AB;
        Sun,  6 Nov 2022 02:44:07 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sun, 06 Nov 2022 02:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667720647; x=1667807047; bh=VLPb0XhoJH
        DKIMD03zLBtdHS2WjO54ue2wQf5CHEj7Q=; b=QTBbLYe9LHVOQFPZgOoC/EzY76
        nEgB6GFCAsWGNJajZif4XsBEqIDK4TcuMcQeqd++WoB5oEajfU7edJCDF8Bsd105
        UoqJKkQzo0ijVchrqQN9fn0Y9g32oD2hw7O6e/bbc8ZOfWUiwPFPZYOrPjmQkTkP
        quyg9cIdX/qFevMQJyT6MCMMWI4M0lftvTsNO+TFIOOaB4Plzos7iBBAL5mHNIYu
        jTx07MOHyYCtV2iIulrR2HqIpQk6SoSPO+5bNAGJp6gC0tqY+c2IVWOIsZ3/XvrE
        +RsXlUodJb1yCXl+7FxdNM2VSiFt7NHPvbNCl3I94qAewB8LnJf0DKjKNGuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667720647; x=1667807047; bh=VLPb0XhoJHDKIMD03zLBtdHS2WjO
        54ue2wQf5CHEj7Q=; b=XjfIuBwQysDxWpBgvIvTVgp0rbDymlovAUhsIZL+nYUp
        lW9fPdXpRnBYizXf14W9BT0YGOWXQgzQx3Blouj8hHgm26o/x/IN66kAYUqiji/I
        XzId0muOKiO/K+LwmbrF0xw0boOkh1kYGq1tJxhXTLt7k2uGoFAiuu+ZNaz0/IZD
        6bdzP1u/wHtSj15V0Sff031TWr4axZL7ypWMlNlpa7G/bTdbHGUM4twc4JTQOlog
        lVEkJbIcQPjFFxuWuoz0Yy4abZtwe7rQPhIR7zixNClcCu2hhU9sgEmpqsTq7tWi
        +Q6J4YLvc1GEsgxghAiQIYF1hqAqO4RbYEQp8mE2Og==
X-ME-Sender: <xms:xWVnY6LX4_eaxib6nZoS43PTl_blc6DqeISlM9V1P7extdoBcYDy3A>
    <xme:xWVnYyJ4DM1-jAiYZ7M-ifZVf_XHhhwxtRGul4Hy-ZAfWGGAE7elSiVVGmDrxxax1
    v1aGa2iBXrWb4n4mBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdehgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xWVnY6sK9rQYFKaAEozwEKHAXOT_6Ebrm0HZPajxuytKDVv_46YRrQ>
    <xmx:xWVnY_aY3350NLAGLfgrqzkklD9Gd_ojSBFZW255NJsdy_TGnuzH_A>
    <xmx:xWVnYxbprHtarLKHaVqoZe0DlwD5WTDScroaayZZBpRt9N2Me45rXA>
    <xmx:x2VnY2NpXtlcjoxHBt26qFe2EdxKSmwqC5isjtBSPiQzPYsUHJggGA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B6A57B603ED; Sun,  6 Nov 2022 02:44:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <62f5b747-4c65-46a6-b04d-1d0fcbadf5c9@app.fastmail.com>
In-Reply-To: <20221106062536.26369-1-rdunlap@infradead.org>
References: <20221106062536.26369-1-rdunlap@infradead.org>
Date:   Sun, 06 Nov 2022 08:43:50 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "kernel test robot" <lkp@intel.com>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>,
        "Russell King" <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] ARM: omap1: set ARCH_OMAP1_ANY for ARCH_OMAP1
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

On Sun, Nov 6, 2022, at 07:25, Randy Dunlap wrote:
> Fix a build error by setting ARCH_OMAP1_ANY Kconfig symbol.
> Fixes this build error:
>
> arm-linux-gnueabi-ld: drivers/video/backlight/omap1_bl.o: in function 
> `omapbl_probe':
> omap1_bl.c:(.text+0x1b4): undefined reference to `omap_cfg_reg'
>
> Fixes: 7036440eab3e ("ARM: omap1: enable multiplatform")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> ---
>  arch/arm/mach-omap1/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff -- a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -47,7 +47,8 @@ config ARCH_OMAP16XX
> 
>  config ARCH_OMAP1_ANY
>  	select ARCH_OMAP
> -	def_bool ARCH_OMAP730 || ARCH_OMAP850 || ARCH_OMAP15XX || ARCH_OMAP16XX
> +	def_bool ARCH_OMAP730 || ARCH_OMAP850 || ARCH_OMAP15XX || \
> +		ARCH_OMAP16XX || ARCH_OMAP1

I think this would introduce other build failures, because it
makes ARCH_OMAP1_ANY the same as ARCH_OMAP1, bringing back the
problems I solved with 615dce5bf736 ("ARM: omap1: fix build with
no SoC selected").

What you probably see here is a preexisting bug that bisects
to 7036440eab3e because of the contents of your .config file
that no longer enable ARCH_OMAP1 without 7036440eab3e.

I have not tested it, but I suspect what we want instead is
the change below, limiting OMAP_MUX and related symbols to
configs that enable at least one of the OMAP1 variants.

     Arnd

--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -49,7 +49,7 @@ config ARCH_OMAP1_ANY
        select ARCH_OMAP
        def_bool ARCH_OMAP730 || ARCH_OMAP850 || ARCH_OMAP15XX || ARCH_OMAP16XX
 
-config ARCH_OMAP
+config ARCH_OMAP1_ANY
        bool
 
 comment "OMAP Feature Selections"

