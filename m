Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACA26094B1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 18:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiJWQVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 12:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJWQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:21:08 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B972C5B9FA;
        Sun, 23 Oct 2022 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iTvQ2cWB+6XWNFX3zk4Auk9RwK12kn68XHvnKVvYeIU=; b=OGBR4feeWffQUhNajVMj1osao1
        bbXJNZtpEk7wHN8vAYkuJvGHtqMJxuYYmYCrLXA3/CU0G6VNxEWg8DL0S+1quagLailQHNnbdQihr
        LOyVtzOphlaUcztOauPh5pOB3Y5Bb7RLaEjDeHw6TLWmjfXBWBQNCXepUnjnCIksIxnwxGi/jwTnH
        e401yO+MqpbUPb8TO+IPti9FDtC4JRfEErt+3CiLCoQ77FYzXMpLMwJwcGhEmnMzzfutmkelXEz2j
        Op3bnPo7QScQR4FZoAZVNOvBEOpRGb/UVap49VxOOLGp/6McjA3aiavsWjx8jG29hcztzspgDhAFe
        +VTBRz7A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34910)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1omdiY-00027Q-UQ; Sun, 23 Oct 2022 17:20:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1omdiS-0006DU-On; Sun, 23 Oct 2022 17:20:48 +0100
Date:   Sun, 23 Oct 2022 17:20:48 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Marcin Wojtas <mw@semihalf.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hch@lst.de, kabel@kernel.org,
        jaz@semihalf.com
Subject: Re: [PATCH] ARM: dts: armada-38x: Mark devices as dma-coherent
Message-ID: <Y1Vp4BdC50o9roKe@shell.armlinux.org.uk>
References: <20221022234024.87475-1-mw@semihalf.com>
 <Y1VX4RtzKQZHe/oO@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1VX4RtzKQZHe/oO@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 05:04:01PM +0200, Andrew Lunn wrote:
> On Sun, Oct 23, 2022 at 01:40:24AM +0200, Marcin Wojtas wrote:
> > Armada 38x platforms marks all devices as coherent via
> > mvebu_hwcc_notifier(), whereas the standard way to determine
> > this is by of_dma_is_coherent(). Reflect the hardware
> > capabilities by adding 'dma-coherent' properties to the device tree.
> 
> Hi Marcin
> 
> Does this need to go to -rc for 6.0? The DMA issues being reported?
> If so, please add a Fixed: tag.

Are we absolutely sure this makes sense?

Looking at atch/arm/mach-mvebu/coherency.c, there are dependencies
on stuff such as whether the kernel is in SMP mode or not (because
the page tables need to be appropriately marked as shared for
coherency with IO to work). We only enable the shared bit if we're
in SMP mode because (a) its difficult to do at runtime due to TLB
conflicts (requires switching the MMU off, rewriting the page tables
and switching the MMU back on), and (b) setting the shared bit for
CPUs that don't need it _can_ result in the CPUs basically bypassing
their caches and thus kill system performance.

So, if we have Armada 38x platforms that are operated in uniprocessor
mode, this patch can cause havoc on such a setup.

I would suggest utmost caution with this approach.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
