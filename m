Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113046F3F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjEBIkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjEBIk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:40:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C851980
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qW27Psnz6Q1vfe6BIK0+aEldfhHNdYxb+z74naJGClI=; b=0VcQb5xPKr4xx2Xl7Bq0b7/lHG
        N3eRRLM33oqsSNwQ/vED3sPfB4k2x9ls+0aspuCup/3F6YwWU7iVojrWxGHl8hKDlAwMQWmyGEGE0
        SbnLbcD+mK512ekzOBkE6PT9fTpCxPDDbI8PReOsXL3WXna7DYaZa6Fw1jMzFsFuoO+h3yp1hhtDR
        IWfPHiHreOum3y7PzOeSCJx55e7Hra+qCRFxdtOY1OnrasbTfSbryYzD3c50Z67VT7+WZ3DkPzZmd
        AyNpT7LKjXxQzwV7uzw6BHp2YtAmXpU4VCtvdxO1n0M1Bde3X4rJEjsKM5m2y5MTP95Fi3rYlqUl8
        4qWiLkDw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39762)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ptlY1-0001zY-MS; Tue, 02 May 2023 09:39:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ptlXq-0000YV-87; Tue, 02 May 2023 09:39:34 +0100
Date:   Tue, 2 May 2023 09:39:34 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Nick Terrell <terrelln@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/3] ARM: compressed: Bump MALLOC_SIZE to 128 KiB
Message-ID: <ZFDMRst2O+RJUYuu@shell.armlinux.org.uk>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
 <20230412212126.3966502-3-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230412212126.3966502-3-j.neuschaefer@gmx.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:21:25PM +0200, Jonathan Neuschäfer wrote:
> The ZSTD compressor needs about 100 KiB.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Please check the kexec sources to see whether that also needs to be
updated. IIRC, kexec also needs to know how big this malloc space
is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
