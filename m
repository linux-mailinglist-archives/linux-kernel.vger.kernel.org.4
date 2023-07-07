Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B018A74AD72
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjGGI4h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jul 2023 04:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGGI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:56:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3653D11B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:56:35 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qHhG1-0005rV-WC; Fri, 07 Jul 2023 10:56:06 +0200
Message-ID: <6d1a6940f67eb2cd87817458d4ec9111b4fe7768.camel@pengutronix.de>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: remove arm, primecell-periphid
 at etm nodes
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Frank Li <Frank.li@nxp.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Jul 2023 10:56:03 +0200
In-Reply-To: <24260662.6Emhk5qWAg@steina-w>
References: <20230705205954.4159781-1-Frank.Li@nxp.com>
         <49ef52b7-0269-898c-7cc2-096f2f1037fc@arm.com>
         <ZKbSC8LBjLuo3ygD@lizhi-Precision-Tower-5810>
         <24260662.6Emhk5qWAg@steina-w>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 07.07.2023 um 07:34 +0200 schrieb Alexander Stein:
> Hi Frank,
> 
> Am Donnerstag, 6. Juli 2023, 16:39:07 CEST schrieb Frank Li:
> > On Thu, Jul 06, 2023 at 12:06:19PM +0100, Robin Murphy wrote:
> > > > > Am Mittwoch, 5. Juli 2023, 22:59:53 CEST schrieb Frank Li:
> > > > > > The reg size of etm nodes is incorrectly set to 64k instead of 4k.
> > > > > > This
> > > > > > leads to a crash when calling amba_read_periphid().  After corrected
> > > > > > reg
> > > > > > size, amba_read_periphid() retrieve the correct periphid.
> > > > > > arm,primecell-periphid were removed from the etm nodes.
> > > > > 
> > > > > So this means the reference manual is wrong here? It clearly states
> > > > > the size is 64kiB. Reference Manual i.MX8MP Rev 1. 06/2021
> > > > > On a side note: Is imx8mq affected by this as well? The DAP memory
> > > > > table lists similar sizes in the RM .
> > > > 
> > > > Note that the 64K MMIO space per device is really an alignment thing.
> > > > It's a recommendation from ARM to allow individual device MMIO regions
> > > > to be mapped on kernels with 64K page size. Most of the time the real
> > > > MMIO space occupied by the device is actually much smaller than 64K.
> > > 
> > > Indeed, it's quite common for TRM memory maps to be written in terms of
> > > the
> > > interconnect configuration, i.e. from the point of view of the
> > > interconnect
> > > itself, that whole range of address space is assigned to that peripheral,
> > > and it may even be true that the entire range is routed to the port where
> > > that peripheral is connected. However what's of more interest for DT is
> > > how
> > > much of that range the peripheral itself actually decodes.
> > 
> > Yes, there are not problem by mapping bigger space in most case.
> > 
> > amba bus's periphal use close to end of region to show device's identical
> > information.
> 
> Ah, thanks for the explanation. This make things more clear.
> But on the other is it sensible to assume the memory resource size to fit the 
> IP address space? It appears to me the size is fixed to 4kiB anyway. Would it 
> make more sense to read the values from the address "base + 4K - x" instead of 
> "base + size - x"?
> 
Huh? Why would AMBA peripherals be fixed to 4K in MMIO size? The ID
detection by reading offsets at the end of the MMIO range is generic
AMBA bus behavior.

The DT should declare the real peripheral MMIO size. Declaring the
aligned size is not much of a problem on 64bit systems with huge
address spaces but it still wastes vmap space when remapping the MMIO
range. When the real peripheral decode size is known it should always
be preferred over the aligned size.

Regards,
Lucas

> Best regards,
> Alexander
> 
> > In drivers/amba/bus.c,
> > 
> > amba_read_periphid()
> > {
> > 	...
> > 	size = resource_size(&dev->res);
> > 	...
> > 	for (pid = 0, i = 0; i < 4; i++)
> > 		pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 
> 8);
> > }
> > 
> > So the range in DTS for arm,primecell should be actual IP address space.
> > 
> > > Robin.
> > > 
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 

