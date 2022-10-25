Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF48660C66A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiJYI2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiJYI2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:28:11 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEF823EBB;
        Tue, 25 Oct 2022 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RMh7N1iAwRBr8l5CmJvPYQFQqn62UbNTJnfq+SnM2P0=; b=B5v3z2Ll7gl08QZJvV0t12UL1B
        c9QU5eOUR0DagRcNQNVZEGOBJhJYqmbKEU7zct1R7EWDJkgEcgJ/8HiTi6cZkYpA4g0YQZsou0LEf
        /3xENV5fURQfbYNWMNLsZPN8S8YbXNCrd4r4xjNnj40tWOPF6cn/ZCYQ6RIt1kIVVkoaCQ+scFESC
        wva0cUMDbGsTl66B2nbYyWHUwnMEK/II69tYEnhBzZRP1qmRF3rG4xn10LGdjuj/XLe7t4wo0uwqU
        K7l38+giz8i/6W9ZHAoWhoklrhphZOqAz7dXmzmk/FxQcwOIuV3gBkCBP2YV8WIEzUrffBXDNWj6O
        AyExHbRg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34942)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1onFI3-0004Ei-Bc; Tue, 25 Oct 2022 09:28:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1onFI1-0007xg-FU; Tue, 25 Oct 2022 09:28:01 +0100
Date:   Tue, 25 Oct 2022 09:28:01 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 04/11] ARM: sa1100: make cpufreq driver build standalone
Message-ID: <Y1eeEQr/E59uIE3j@shell.armlinux.org.uk>
References: <20221021155000.4108406-1-arnd@kernel.org>
 <20221021155000.4108406-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021155000.4108406-5-arnd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 05:49:34PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit 59a2e613d07f ("cpufreq: sa11x0: move cpufreq driver
> to drivers/cpufreq") added an unnecessary reference to
> mach/generic.h. Just remove it again after moving the code
> into the corresponding driver.

So how does arch/arm/mach-sa1100/clock.c get the MPLL rate with this
change?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
