Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD086694790
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjBMOBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBMOBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:01:16 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F13518A9A;
        Mon, 13 Feb 2023 06:01:15 -0800 (PST)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id B91A926F77F; Mon, 13 Feb 2023 15:01:13 +0100 (CET)
Date:   Mon, 13 Feb 2023 15:01:13 +0100
From:   Janne Grunau <j@jannau.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] arm64: dts: apple: t8112: Initial t8112 (M2)
 device trees
Message-ID: <20230213140113.GE17933@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-17-cb5442d1c229@jannau.net>
 <1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-13 12:22:11 +0100, Krzysztof Kozlowski wrote:
> On 12/02/2023 16:41, Janne Grunau wrote:
> > From: Hector Martin <marcan@marcan.st>
> > 
> > This adds device trees for the following devices:
> >  - Macbook Air (M2, 2022)
> >  - Macbook Pro 13" (M2, 2022)
> >  - Mac mini (M2, 2023)
> > 
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > Co-developed-by: Janne Grunau <j@jannau.net>
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> >  arch/arm64/boot/dts/apple/Makefile        |    3 +
> >  arch/arm64/boot/dts/apple/t8112-j413.dts  |   71 ++
> >  arch/arm64/boot/dts/apple/t8112-j473.dts  |   60 ++
> >  arch/arm64/boot/dts/apple/t8112-j493.dts  |   60 ++
> >  arch/arm64/boot/dts/apple/t8112-jxxx.dtsi |   81 ++
> >  arch/arm64/boot/dts/apple/t8112-pmgr.dtsi | 1141 +++++++++++++++++++++++++++++
> >  arch/arm64/boot/dts/apple/t8112.dtsi      |  904 +++++++++++++++++++++++
> >  7 files changed, 2320 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
> > index 5a7506ff5ea3..aec5e29cdfb7 100644
> > --- a/arch/arm64/boot/dts/apple/Makefile
> > +++ b/arch/arm64/boot/dts/apple/Makefile
> > @@ -10,3 +10,6 @@ dtb-$(CONFIG_ARCH_APPLE) += t6000-j316s.dtb
> >  dtb-$(CONFIG_ARCH_APPLE) += t6001-j316c.dtb
> >  dtb-$(CONFIG_ARCH_APPLE) += t6001-j375c.dtb
> >  dtb-$(CONFIG_ARCH_APPLE) += t6002-j375d.dtb
> > +dtb-$(CONFIG_ARCH_APPLE) += t8112-j413.dtb
> > +dtb-$(CONFIG_ARCH_APPLE) += t8112-j473.dtb
> > +dtb-$(CONFIG_ARCH_APPLE) += t8112-j493.dtb
> > diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts b/arch/arm64/boot/dts/apple/t8112-j413.dts
> > new file mode 100644
> > index 000000000000..0e5b5add92cf
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
> > @@ -0,0 +1,71 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > +/*
> > + * Apple MacBook Air (M2, 2022)
> > + *
> > + * target-type: J413
> > + *
> > + * Copyright The Asahi Linux Contributors
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "t8112.dtsi"
> > +#include "t8112-jxxx.dtsi"
> > +
> > +/ {
> > +	compatible = "apple,j413", "apple,t8112", "apple,arm-platform";
> > +	model = "Apple MacBook Air (13-inch, M2, 2022)";
> > +
> > +	aliases {
> > +		bluetooth0 = &bluetooth0;
> > +		wifi0 = &wifi0;
> > +	};
> > +};
> > +
> > +/*
> > + * Force the bus number assignments so that we can declare some of the
> > + * on-board devices and properties that are populated by the bootloader
> > + * (such as MAC addresses).
> > + */
> > +&port00 {
> > +	bus-range = <1 1>;
> > +	wifi0: wifi@0,0 {
> > +		compatible = "pci14e4,4433";
> > +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> > +		/* To be filled by the loader */
> > +		local-mac-address = [00 10 18 00 00 10];
> > +		apple,antenna-sku = "XX";
> > +		brcm,board-type = "apple,hokkaido";
> > +	};
> > +
> > +	bluetooth0: bluetooth@0,1 {
> > +		compatible = "pci14e4,5f71";
> > +		reg = <0x10100 0x0 0x0 0x0 0x0>;
> > +		/* To be filled by the loader */
> > +		local-bd-address = [00 00 00 00 00 00];
> > +		brcm,board-type = "apple,hokkaido";
> > +	};
> > +};
> > +
> > +/*
> > + * Remove unused PCIe ports
> > + */
> > +
> > +/delete-node/ &port01;
> 
> You should not delete devices just because they are unused. Externally
> visible buses should be just disabled in DTSI and you enable them when
> needed. Not the opposite way.
> 
> What's more, you must node delete nodes just because they are "not
> used". This not anymore proper description of hardware.

I agree, this is copied from the M1 and M1 Pro/Max/Ultra devictrees.  
I'll fix it there as well.

> 
> > +/delete-node/ &port02;
> > +/delete-node/ &port03;
> > +
> > +&i2c0 {
> > +	/* MagSafe port */
> > +	hpm5: usb-pd@3a {
> > +		compatible = "apple,cd321x";
> > +		reg = <0x3a>;
> > +		interrupt-parent = <&pinctrl_ap>;
> > +		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupt-names = "irq";
> > +	};
> > +};
> > +
> > +&i2c4 {
> > +	status = "okay";
> > +};
> > diff --git a/arch/arm64/boot/dts/apple/t8112-j473.dts b/arch/arm64/boot/dts/apple/t8112-j473.dts
> > new file mode 100644
> > index 000000000000..55950d0a73c5
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/apple/t8112-j473.dts
> > @@ -0,0 +1,60 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > +/*
> > + * Apple Mac mini (M2, 2023)
> > + *
> > + * target-type: J473
> > + *
> > + * Copyright The Asahi Linux Contributors
> > + */
> > +
> > +/dts-v1/;
> 
> (....)
> 
> 
> > +
> > +	ps_debug_switch: power-controller@b8 {
> > +		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
> > +		reg = <0xb8 4>;
> > +		#power-domain-cells = <0>;
> > +		#reset-cells = <0>;
> > +		label = "debug_switch";
> > +		apple,always-on; /* Core AON device */
> > +	};
> > +};
> > +
> > diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
> > new file mode 100644
> > index 000000000000..974443913f6a
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/apple/t8112.dtsi
> > @@ -0,0 +1,904 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > +/*
> > + * Apple T8112 "M2" SoC
> > + *
> > + * Other names: H14G
> > + *
> > + * Copyright The Asahi Linux Contributors
> > + */
> 
> 
> (...)
> 
> > +
> > +		aic: interrupt-controller@23b0c0000 {
> > +			compatible = "apple,t8112-aic", "apple,aic2";
> > +			#interrupt-cells = <3>;
> > +			interrupt-controller;
> > +			reg = <0x2 0x3b0c0000 0x0 0x8000>,
> > +				<0x2 0x3b0c8000 0x0 0x4>;
> > +			reg-names = "core", "event";
> > +			power-domains = <&ps_aic>;
> > +
> > +			affinities {
> > +				e-core-pmu-affinity {
> > +					apple,fiq-index = <AIC_CPU_PMU_E>;
> > +					cpus = <&cpu_e0 &cpu_e1 &cpu_e2 &cpu_e3>;
> > +				};
> > +
> > +				p-core-pmu-affinity {
> > +					apple,fiq-index = <AIC_CPU_PMU_P>;
> > +					cpus = <&cpu_p0 &cpu_p1 &cpu_p2 &cpu_p3>;
> > +				};
> > +			};
> > +		};
> > +
> > +		pmgr: power-management@23b700000 {
> > +			compatible = "apple,t8112-pmgr", "apple,pmgr", "syscon", "simple-mfd";
> 
> Why this is simple-mfd?

I suppose because the syscon device is not limited to power domain 
controls. The dt-bindings in arm/apple/apple,pmgr.yaml specify those 
compatibles. See the original discussion in:

https://lore.kernel.org/linux-devicetree/57991dac-196e-a76d-831a-d4ac166bfe29@marcan.st/  

> 
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			reg = <0x2 0x3b700000 0 0x14000>;
> > +		};
> 
> 
> > +
> > +		pmgr_mini: power-management@23d280000 {
> > +			compatible = "apple,t8112-pmgr", "apple,pmgr", "syscon", "simple-mfd";
> 
> Why this is simple-mfd?

see above
 
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			reg = <0x2 0x3d280000 0 0x4000>;
> > +		};
>

thanks

Janne 
