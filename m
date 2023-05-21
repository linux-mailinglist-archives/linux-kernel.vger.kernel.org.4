Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8958870AD5C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 11:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjEUJxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 05:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEUJwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 05:52:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C99DF1;
        Sun, 21 May 2023 02:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5E9F60BC4;
        Sun, 21 May 2023 09:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3937C433D2;
        Sun, 21 May 2023 09:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684662726;
        bh=sF3fGO7U/xMB1sIbnknNsRZycdV/4okIPZSR/hPio8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bK1LHT/YeUymJe+bmviXtp5mkVbBYHgww5sdBnnL4Aq3MazisAdOr9Eoh9KjEMT46
         82WZxC27NLxnfDCkF9uoXRKThZaEhEGRvOijdZfL3Dg9LC1nfZK4cFX/gkotJdEUqF
         BMzsUHQEJzUnp2QhLRs4Ze0sRtWnRRogDb91smVpGALFwHdfzyNnP2k8Fn8So76cOl
         q+EWVBh/+JWPenfQAEbGuV8TdVl/u62JI0TJ+OdcfqdjeEVk36Elutf1GOsSV6uA4c
         Sq+ugXJhR8kJJ/yqcmmmsut0OYwKWo1L0eBpsipjXsXR7qLebKKv0sCH4uncaIZc0G
         IGU00kotUCwRw==
Date:   Sun, 21 May 2023 17:40:53 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v4 08/10] riscv: dts: bouffalolab: add Sipeed M1s SoM and
 Dock devicetree
Message-ID: <ZGnnJXWxSv2/p87Y@xhacker>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-9-jszhang@kernel.org>
 <dfa99943-3bca-ec6d-7152-fc6465181a08@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfa99943-3bca-ec6d-7152-fc6465181a08@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:55:21PM -0500, Samuel Holland wrote:
> Hi Jisheng,
> 
> On 5/18/23 10:22, Jisheng Zhang wrote:
> > Sipeed manufactures a M1s system-on-module and dock board, add basic
> > support for them.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> >  arch/riscv/boot/dts/Makefile                  |  1 +
> >  arch/riscv/boot/dts/bouffalolab/Makefile      |  2 ++
> >  .../dts/bouffalolab/bl808-sipeed-m1s-dock.dts | 25 +++++++++++++++++++
> >  .../dts/bouffalolab/bl808-sipeed-m1s.dtsi     | 21 ++++++++++++++++
> >  4 files changed, 49 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/bouffalolab/Makefile
> >  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
> >  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
> > 
> > diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> > index f0d9f89054f8..133e6c38c9b0 100644
> > --- a/arch/riscv/boot/dts/Makefile
> > +++ b/arch/riscv/boot/dts/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  subdir-y += allwinner
> > +subdir-y += bouffalolab
> >  subdir-y += sifive
> >  subdir-y += starfive
> >  subdir-y += canaan
> > diff --git a/arch/riscv/boot/dts/bouffalolab/Makefile b/arch/riscv/boot/dts/bouffalolab/Makefile
> > new file mode 100644
> > index 000000000000..5419964e892d
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/bouffalolab/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +dtb-$(CONFIG_SOC_BOUFFALOLAB) += bl808-sipeed-m1s-dock.dtb
> > diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
> > new file mode 100644
> > index 000000000000..aa6cf909cd4d
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "bl808-sipeed-m1s.dtsi"
> > +
> > +/ {
> > +	model = "Sipeed M1s Dock";
> > +	compatible = "sipeed,m1s-dock", "sipeed,m1s", "bouffalolab,bl808";
> > +
> > +	aliases {
> > +		serial3 = &uart3;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial3:2000000n8";
> > +	};
> > +};
> > +
> > +&uart3 {
> > +	status = "okay";
> > +};
> > diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
> > new file mode 100644
> > index 000000000000..5026de768534
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "bl808.dtsi"
> > +
> > +/ {
> > +	compatible = "sipeed,m1s", "bouffalolab,bl808";
> > +
> > +	memory@50000000 {
> > +		device_type = "memory";
> > +		reg = <0x50000000 0x04000000>;
> > +	};
> 
> Especially since the SoC contains three heterogeneous CPUs, the firmware
> may want to divide the PSRAM among them, so I do not think it is a good
> idea to define this statically. (Or would all of the DTs contain this
do you want the bootloader/firmware e.g uboot to add the memory node
dynamically?

But to be honest, nowdays most SoCs contain some heterogeneous CPUs, and
in real products some of those CPUs need to use DDR memory.
FWICT, their dtbs(in arch/arm64/boot/dts/...) still define the memory
statically. I believe this is acchieved by dynamically update the memory
node of DT. This solution doesn't make obvious difference with the uboot
adding memory node solution.

> same node, and then use reserved-memory nodes to cover the other CPUs'
> allocations?)
> 
> Regards,
> Samuel
> 
> > +};
> > +
> > +&xtal {
> > +	clock-frequency = <40000000>;
> > +};
> 
