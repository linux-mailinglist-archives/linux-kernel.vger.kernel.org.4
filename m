Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1F61E190
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKFK0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKFK0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:26:15 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDA864D3;
        Sun,  6 Nov 2022 02:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UKfx5EDKe7Y95qjbgdGSuy0MyrmHB1us0iqYRSxqv6Y=; b=PitKdNRbTpvsQcXZFcbxM9r6MQ
        ags2I3J4Fe0iJ1Q8WKMs6TrOoD1t9sng93589ad9uO4M8+6KDarp11iYsVckEO1TI6fenLh1rfuho
        rZM85euief7xd9whJFXZK5uf/bER9DSDboQn1eZJ8tAB5q+TeQDh4sSbTT2Y2rXD8765CctCmhVnA
        XtBd25tveSaujacjMywDhIFP1CbaKb4J1Pip7bTHTI6fY+k45xkg3DzJEkHGCIj/V5XtCc5A9TtUD
        T0rBAPZXsHOgkKhSbMo0m5pgQe4vVnbF6MYnJEybOKoGPxNXZUhRZYs5LIKS/pnDOUcHItwt9qw8M
        HXyGeUZg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35136)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1orcqr-0000o7-8n; Sun, 06 Nov 2022 10:26:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1orcqo-0002m8-2i; Sun, 06 Nov 2022 10:26:02 +0000
Date:   Sun, 6 Nov 2022 10:26:01 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] ARM: omap1: set ARCH_OMAP1_ANY for ARCH_OMAP1
Message-ID: <Y2eLuf4SCrZ5X+ui@shell.armlinux.org.uk>
References: <20221106062536.26369-1-rdunlap@infradead.org>
 <62f5b747-4c65-46a6-b04d-1d0fcbadf5c9@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f5b747-4c65-46a6-b04d-1d0fcbadf5c9@app.fastmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 08:43:50AM +0100, Arnd Bergmann wrote:
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -49,7 +49,7 @@ config ARCH_OMAP1_ANY
>         select ARCH_OMAP
>         def_bool ARCH_OMAP730 || ARCH_OMAP850 || ARCH_OMAP15XX || ARCH_OMAP16XX
>  
> -config ARCH_OMAP
> +config ARCH_OMAP1_ANY

This patch can't be right - look at the first line of context above, you
have symbols that select ARCH_OMAP and you've just removed the
definition of ARCH_OMAP.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
