Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BB05F1BE3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJAKwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 06:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJAKwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 06:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C284D164;
        Sat,  1 Oct 2022 03:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 889B560BDB;
        Sat,  1 Oct 2022 10:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52511C433C1;
        Sat,  1 Oct 2022 10:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664621526;
        bh=Rv8wMw62hPBvQGNl2E7VkFVZEvT258K9oq+IlR87Ask=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IP8PTUGVNVS+ExEC356TXSwGfBHX4MmF8vr2MLoe9W9ea0nGQQpXVLPyZKnOwyWRS
         6QgjqinvbPbAJbgfnVDdYkKM1WYVp9eS88300VoqywTWs6A5S5lB+qrNNZ9uLiqmXW
         P3PvDjrtsGm55lpqRji2xqgiY9Rs74U9/G1a9wEvAnbHSq8bBAZDh3henEuFJXjj4V
         zrRi1Xys1/t6wl/Xit2CsDj7G2vxNr/MyTwvxyYenU6OAsRJbANjptoOZXgZ7r5VIf
         YqQA4H46Kq+sEWe33n1W0iXUaBI6+kBpoUNEAzHNsERI+z1FSQKW4PHZEmt/rwivN7
         2BUmer1kO/MdQ==
Date:   Sat, 1 Oct 2022 11:52:00 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 27/30] RISC-V: Add initial StarFive JH7110 device tree
Message-ID: <Yzgb0GzpLsV3RJyk@spud>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930074914.6757-1-hal.feng@linux.starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930074914.6757-1-hal.feng@linux.starfivetech.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 03:49:14PM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add initial device tree for the JH7110 RISC-V SoC by
> StarFive Technology Ltd.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>

There's little point reviewing this dt since there's a load of issues
that you can trivially find by running dtbs_check/dt_binding_check, but
this SoB change is wrong - if Emil wrote the patch, then Jianlong's SoB
is either redundant or should be accompanied by a Co-developed-by tag.

Ditto for patch 28/30 "RISC-V: Add StarFive JH7110 VisionFive2 board
device tree".

> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 449 +++++++++++++++++++++++
>  1 file changed, 449 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> new file mode 100644
> index 000000000000..46f418d4198a
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi

> +
> +	osc: osc {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	clk_rtc: clk_rtc {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	gmac0_rmii_refin: gmac0_rmii_refin {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <50000000>;

I assume, given osc has it's frequency set in the board dts, that these
are all oscillators on the SoC?

> +	};
> +
> +	gmac0_rgmii_rxin: gmac0_rgmii_rxin {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +	};
> +
> +	gmac1_rmii_refin: gmac1_rmii_refin {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <50000000>;
> +	};
> +
> +	gmac1_rgmii_rxin: gmac1_rgmii_rxin {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +	};
> +
> +	i2stx_bclk_ext: i2stx_bclk_ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <12288000>;
> +	};
> +
> +	i2stx_lrck_ext: i2stx_lrck_ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <192000>;
> +	};
> +
> +	i2srx_bclk_ext: i2srx_bclk_ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <12288000>;
> +	};
> +
> +	i2srx_lrck_ext: i2srx_lrck_ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <192000>;
> +	};
> +
> +	tdm_ext: tdm_ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <49152000>;
> +	};
> +
> +	mclk_ext: mclk_ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <49152000>;
> +	};

> +		syscrg: syscrg@13020000 {

The generic node name for syscons is just "syscon" afaik.

> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x0 0x13020000 0x0 0x10000>;
> +

> +		aoncrg: aoncrg@17000000 {

Again, syscon as the node name?

> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x0 0x17000000 0x0 0x10000>;
> +
> +		gpio: gpio@13040000 {

Someone else (Krzysztof maybe?) should comment, but is "pinctrl" not the
genric node name for pinctrl nodes?

Thanks,
Conor.

> +			compatible = "starfive,jh7110-sys-pinctrl";
> +			reg = <0x0 0x13040000 0x0 0x10000>;
> +			reg-names = "control";
> +			clocks = <&syscrg_clk JH7110_SYSCLK_IOMUX>;
> +			resets = <&syscrg_rst JH7110_SYSRST_IOMUX>;
> +			interrupts = <86>;
> +			interrupt-controller;
> +			#gpio-cells = <2>;
> +			ngpios = <64>;
> +		};
> +
> +		gpioa: gpio@17020000 {
> +			compatible = "starfive,jh7110-aon-pinctrl";
> +			reg = <0x0 0x17020000 0x0 0x10000>;
> +			reg-names = "control";
> +			resets = <&aoncrg_rst JH7110_AONRST_AON_IOMUX>;
> +			interrupts = <85>;
> +			interrupt-controller;
> +			#gpio-cells = <2>;
> +			ngpios = <4>;
> +		};
> +
> +		uart0: serial@10000000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x10000000 0x0 0x10000>;
> +			clocks = <&syscrg_clk JH7110_SYSCLK_UART0_CORE>,
> +				 <&syscrg_clk JH7110_SYSCLK_UART0_APB>;
> +			clock-names = "baudclk", "apb_pclk";
> +			resets = <&syscrg_rst JH7110_SYSRST_UART0_APB>,
> +				 <&syscrg_rst JH7110_SYSRST_UART0_CORE>;
> +			interrupts = <32>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@10010000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x10010000 0x0 0x10000>;
> +			clocks = <&syscrg_clk JH7110_SYSCLK_UART1_CORE>,
> +				 <&syscrg_clk JH7110_SYSCLK_UART1_APB>;
> +			clock-names = "baudclk", "apb_pclk";
> +			resets = <&syscrg_rst JH7110_SYSRST_UART1_APB>,
> +				 <&syscrg_rst JH7110_SYSRST_UART1_CORE>;
> +			interrupts = <33>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@10020000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x10020000 0x0 0x10000>;
> +			clocks = <&syscrg_clk JH7110_SYSCLK_UART2_CORE>,
> +				 <&syscrg_clk JH7110_SYSCLK_UART2_APB>;
> +			clock-names = "baudclk", "apb_pclk";
> +			resets = <&syscrg_rst JH7110_SYSRST_UART2_APB>,
> +				 <&syscrg_rst JH7110_SYSRST_UART2_CORE>;
> +			interrupts = <34>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial@12000000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x12000000 0x0 0x10000>;
> +			clocks = <&syscrg_clk JH7110_SYSCLK_UART3_CORE>,
> +				 <&syscrg_clk JH7110_SYSCLK_UART3_APB>;
> +			clock-names = "baudclk", "apb_pclk";
> +			resets = <&syscrg_rst JH7110_SYSRST_UART3_APB>,
> +				 <&syscrg_rst JH7110_SYSRST_UART3_CORE>;
> +			interrupts = <45>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart4: serial@12010000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x12010000 0x0 0x10000>;
> +			clocks = <&syscrg_clk JH7110_SYSCLK_UART4_CORE>,
> +				 <&syscrg_clk JH7110_SYSCLK_UART4_APB>;
> +			clock-names = "baudclk", "apb_pclk";
> +			resets = <&syscrg_rst JH7110_SYSRST_UART4_APB>,
> +				 <&syscrg_rst JH7110_SYSRST_UART4_CORE>;
> +			interrupts = <46>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart5: serial@12020000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x12020000 0x0 0x10000>;
> +			clocks = <&syscrg_clk JH7110_SYSCLK_UART5_CORE>,
> +				 <&syscrg_clk JH7110_SYSCLK_UART5_APB>;
> +			clock-names = "baudclk", "apb_pclk";
> +			resets = <&syscrg_rst JH7110_SYSRST_UART5_APB>,
> +				 <&syscrg_rst JH7110_SYSRST_UART5_CORE>;
> +			interrupts = <47>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +	};
> +};
> -- 
> 2.17.1
> 
