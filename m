Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC27D609BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJXHwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJXHv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:51:59 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D7B52DDD;
        Mon, 24 Oct 2022 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eDI2oC/Jr6d6JOexJAxW8yOYPdCtd6NfI008/PX5+FU=; b=fukTnkadU0iMI3XPNFZ4K4HhIV
        qOUTbVcjOH9+WKra9lzUlGWqEZ3Bb+s1Xwas/tN/X0S/+UsUTiPlkIzegV+PeGMbf9QUQ07ad6I1w
        zk3Ipq5JIb6h53QGGB0vcSv/Y4ApzbE/S0IyhcUKgNfXQR+s9WuvoOa0LBhgyMSMIXXmZq4X1ua7G
        PvireKY/L9MYDkw4q4qKMFqAYT36knmX0wyBirzrVoFRPzBXd83UAfGpIHmvij/4WE02cLzrxo/5J
        HVpRGd8nr3Ox2I0uN2j4MIjvKqTyqJZAJRxKIR4vlWH+lyRcIQnSPDMYeSRj4lbAGMsmguF8j108g
        +93xqsiQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34924)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1omsFJ-0002hW-An; Mon, 24 Oct 2022 08:51:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1omsFC-0006xK-Fs; Mon, 24 Oct 2022 08:51:34 +0100
Date:   Mon, 24 Oct 2022 08:51:34 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Marcin Wojtas <mw@semihalf.com>, Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hch@lst.de, jaz@semihalf.com
Subject: Re: [PATCH] ARM: dts: armada-38x: Mark devices as dma-coherent
Message-ID: <Y1ZEBqrxZ1PSLCU6@shell.armlinux.org.uk>
References: <20221022234024.87475-1-mw@semihalf.com>
 <Y1VX4RtzKQZHe/oO@lunn.ch>
 <Y1Vp4BdC50o9roKe@shell.armlinux.org.uk>
 <CAPv3WKdcQGqofEgV4w_iiQ7FFa0ZF=du8gK9eAD==10HhwEnUA@mail.gmail.com>
 <20221024085102.15712ce9@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221024085102.15712ce9@thinkpad>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 08:51:02AM +0200, Marek Behún wrote:
> > Sure. In such a case the description of 380 variant (single core)
> > should remain untouched.
> > 
> > We need to decide what to do with dual-CPU, i.e. Armada 385/388. How about:
> > - Don't change current behavior, i.e. perform a necessary kernel
> > configuration in "arm,pl310-cache" driver,
> > arch/arm/mach-mvebu/coherency.c + &coherencyfab:node in DT
> > - Satisfy of_dma_is_coherent() by adding `dma-coherent;` in
> > armada-385.dtsi only (IMO this would describe HW properly)
> > ?
> 
> It will describe HW properly, but someone running older kernel compiled
> with no SMP support will see a performance drop. I wonder how many
> people do that.

If the kernel is built without SMP support, the page table entries will
not have the shared bit set, and the system will _not_ be DMA-coherent.
Having DT mark devices as "dma-coherent" in this case will lead to data
corruption, because the DMA API will believe them to be DMA-coherent
when the page tables are not setup for that to work.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
