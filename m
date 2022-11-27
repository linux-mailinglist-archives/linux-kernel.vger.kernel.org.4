Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F327A639BF5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiK0RVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 12:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0RVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:21:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A197E092;
        Sun, 27 Nov 2022 09:21:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E754260DBB;
        Sun, 27 Nov 2022 17:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92350C433D6;
        Sun, 27 Nov 2022 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669569699;
        bh=RbCdGgC86wp3IrVQB8kh4eO/EyjCHT42dZFvCZpk/+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bBMFXK1XCqZSlP6OynF8hySHk5Qk7DpLm+s66cDs+n4ztSQKlOSuP1BgvhyizhhMk
         JGC9AKOhXRbqrdGsQWiK2dDLg4SU3P9MvRuTFRVElW8HdVVKN5twCpIr/iycITj2ER
         ZI+VUPNqz5Q1eiwCwcwiinxrt4PwdX0h4ZbnQzbgbMCGWxtadp7VEAhoS8ve+1z1Cg
         /2xlHZQKdpTG2v7bSNbJKK86lyul1owd7SBJRUB8nOMWcBGcVywY4i2cs3juL/41Ps
         vrkfwjEx++VHZlzkPzt9kHvqVTZPVq7PsxxmNlZbw/eGxlT38FbA6t05o6Ns+97tLR
         7BJ9XhP4BnvAg==
Date:   Sun, 27 Nov 2022 17:21:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH v2 6/9] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
Message-ID: <Y4OcngDlw/4Szt7g@spud>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-7-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127132448.4034-7-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Icenowy

On Sun, Nov 27, 2022 at 09:24:45PM +0800, Jisheng Zhang wrote:
> Add a baisc dtsi for the bouffalolab bl808 SoC.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 74 ++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> 
> diff --git a/arch/riscv/boot/dts/bouffalolab/bl808.dtsi b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> new file mode 100644
> index 000000000000..f4b170ccc32e
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "bouffalolab,bl808";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		timebase-frequency = <1000000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "thead,c906", "riscv";
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <256>;
> +			d-cache-size = <32768>;
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <32768>;
> +			mmu-type = "riscv,sv39";
> +			riscv,isa = "rv64imafdc";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +	};
> +
> +	xtal: xtal-clk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		/* This value must be overridden by the board */
> +		clock-frequency = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		ranges;
> +		interrupt-parent = <&plic>;
> +		dma-noncoherent;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		uart0: serial@30002000 {
> +			compatible = "bouffalolab,bl808-uart";
> +			reg = <0x30002000 0x1000>;
> +			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&xtal>;
> +			status = "disabled";
> +		};
> +
> +		plic: interrupt-controller@e0000000 {
> +			compatible = "thead,c900-plic";

Hmm, @Icenowy - should this use your new open-c906-plic compatible from
20221121041757.418645-4-uwu@icenowy.me ?

As is, dtbs_check gives a:
bl808-sipeed-m1s-dock.dtb: interrupt-controller@e0000000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['thead,c900-plic'] is too short

> +			reg = <0xe0000000 0x4000000>;
> +			interrupts-extended = <&cpu0_intc 0xffffffff>,
> +					      <&cpu0_intc 9>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			riscv,ndev = <64>;
> +		};
> +	};
> +};
> -- 
> 2.38.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
