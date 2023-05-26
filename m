Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704B0712137
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbjEZHgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242498AbjEZHgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:36:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85961E58;
        Fri, 26 May 2023 00:35:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 107)
        id 2525C68D0E; Fri, 26 May 2023 09:35:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from blackhole.lan (p5b33fa9c.dip0.t-ipconnect.de [91.51.250.156])
        by verein.lst.de (Postfix) with ESMTPSA id 3440168D07;
        Fri, 26 May 2023 09:34:37 +0200 (CEST)
Date:   Fri, 26 May 2023 09:34:32 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <yanhong.wang@starfivetech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add StarFive JH7110 PLL
 clock generator
Message-ID: <20230526093432.4682eab8@blackhole.lan>
In-Reply-To: <20230524-jittery-sway-41b578b24153@wendy>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
        <20230512022036.97987-2-xingyu.wu@starfivetech.com>
        <20230519135733.GA10188@lst.de>
        <20230519-smokeless-guileless-2a71cae06509@wendy>
        <df43411e-8982-74f5-6148-e7281c37dada@starfivetech.com>
        <20230523-fondue-monotype-0c751a8f0c13@wendy>
        <20230523131006.46997d84@blackhole.lan>
        <20230523-saturate-axis-f46b78b7b82b@wendy>
        <38a9cb77-18b3-4daa-724b-9f2282f7d948@starfivetech.com>
        <20230524-jittery-sway-41b578b24153@wendy>
Organization: LST e.V.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 11:19:48 +0100
Conor Dooley <conor.dooley@microchip.com> wrote:

> On Wed, May 24, 2023 at 05:00:02PM +0800, Xingyu Wu wrote:
> > On 2023/5/23 19:28, Conor Dooley wrote:
> > > On Tue, May 23, 2023 at 01:10:06PM +0200, Torsten Duwe wrote:
> > >> On Tue, 23 May 2023 09:28:39 +0100
> > >> Conor Dooley <conor.dooley@microchip.com> wrote:
> > >> 
> > >> > On Tue, May 23, 2023 at 10:56:43AM +0800, Xingyu Wu wrote:
> > >> > > On 2023/5/19 22:16, Conor Dooley wrote:
> > >> > > > On Fri, May 19, 2023 at 03:57:33PM +0200, Torsten Duwe
> > >> > > > wrote:
> > >> > > >> On Fri, May 12, 2023 at 10:20:30AM +0800, Xingyu Wu wrote:
[...]

> > >> > > Because PLL driver is separated from SYSCRG drivers in
> > >> > > Linux, the numbering starts from 0. But in Uboot, the PLL
> > >> > > driver is included in the SYSCRG driver, and the number
> > >> > > follows the SYSCRG.
> > >> > 
> > >> > Unfortunately, how you choose to construct your drivers has
> > >> > nothing to do with this.

Exactly. As I wrote (quote below), the PLLx frequencies are controlled
by the I/O block SYS_SYSCON (starting there at offset 0x18), according
to the public datasheets. All(?) other clocks are derived from those in
the *_CRG units. That *is* the hardware to be described, in *the* (one
and only!) DT. U-Boot, and any OS, are free to reorganise their driver
framework around that, but the hardware description is quite clear.

> > >> > These defines/numbers appear in the dts and are part of the DT
> > >> > ABI. The same dts is supposed to work for Linux & U-Boot.
> > >> 
> > >> The JH7110 has 6 blocks of 64k iomem in that functional area:
> > >> {SYS,STG,AON} x {CRG,SYSCON}. None of these has 190 clocks.
> > >> The good news: the current DTS, as proposed here and in U-Boot
> > >> master, provides nodes for all 6 entities. The bad news is that
> > >> the clock assignments to those nodes and their numbering is
> > >> messed up.
> > >> 
> > >> AFAICT PLL{0,1,2} _are_ generated in SYS_SYSCON and thus U-Boot
> > >> gets it wrong, in addition to the erroneous DTS.
> > > 
> > > The numbers are kinda hocus-pocus anyway, they are just made up
> > > since the clock numbering usually isn't something with a nice TRM
> > > to go and reference (unlike interrupts which usually are
> > > documented in that way). It is very helpful to make them aligned
> > > some register/bit positions or, but that is not required.
> > > IOW U-Boot is not wrong per se to use 190 instead of 0, but it is
> > > wrong to have different numbers in both places.

U-Boot reuses the Common Clock Framework from Linux, and I'm not sure
whether the clock IDs need to be unique in order for the appropriate
clock to be found. But that would be the only restriction, if it
applies. Even then, each driver could register a clock with its own,
arbitrarily chosen base offset with the CCF, so each CRG unit could
still have its own clocks enumerated starting with 0 in the DTB.

> > > It sounds like you're saying that (and I have not looked) the
> > > U-Boot dts actually has structural difference w.r.t. what
> > > provides which clock? If so, that'll need to be fixed
> > > independently of the numbering problem.

> > 
> > Oh, unfortunately, the 7110 can not support to mix the uboot dtb
> > and linux dtb up.
> 
> What does "cannot support" mean? It's normal and desirable for the

IMHO "desirable" is too weak.

> same dtb to be usable for both. The Linux kernel's dt-bindings are
> used for multiple projects, not just Linux - it'd be silly for
> U-Boot, FreeBSD etc etc to go off and each have their open set of
> (incompatible) bindings.
> 
> > If boot the Linux and should use the linux dtb instead of the uboot
> > dtb. Because all clock ids and reset ids in Linux and Uboot are
> > different include PLL, and some modules can work in Linux but not
> > in uboot.
[...]
> 
> > I suggest to boot Linux with its own linux dtb.

This is a fragile band-aid, to be used only as a last resort. It
creates more problems than it solves. Your DTB will then match your
kernel, but whether it describes the actual hardware is a game of
chance. Doesn't the VisionFive2 have an RPi connector... ?

One of the IMO few valid use cases of adding a DTB to the kernel
at boot is OpenWRT, when you build an OS Image for a particular piece
of hardware you have at hand.

> I suggest to make sure that you can use the same dtb for both.

Interestingly enough, U-Boot already has the PLL driver in a separate
file. I have a half-baked patch here that moves the sys_syscon DT
matching into that file...

	Torsten

