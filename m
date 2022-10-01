Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0FC5F1BF0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 13:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJALPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 07:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJALPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 07:15:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5586E3BC68;
        Sat,  1 Oct 2022 04:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EE9BB80DC6;
        Sat,  1 Oct 2022 11:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353DDC433C1;
        Sat,  1 Oct 2022 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664622895;
        bh=06zggjHa8kTBjzns75XbCc45MBQbTfIwinmOKApewzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qK4LDBiC9y8EK1KCnuG2t8wKBHZ4BZ9Irq+tLn1Ev1VSRh2ywrpnAkWNyu+QcS0r0
         +0LnGgmf8aFMyCNAKp7+RKkB/REOYW1RfhMeG8o7CN01Vx/+fqz1sDjzDlbrKvMpAG
         Da7F1ejhJDbzaDZoO92IjdRPwSriLDZfp0Ozlc2LquSpF5tknkQl1dqTvKA+AZVU+E
         WINvoI56EqsTQSOfvVRAvXFB6Bi5fLGkGClbKZ33b8lFKizqd/z1FHJ9XLx7ovgjdo
         cQOWd4eJAUDqXPNwWCNdwx41cryB8tNvpZ3seLIF5ATBAB/myHlj/PlkJYFpZVu3Kd
         U7/aTDryQ8tvw==
Date:   Sat, 1 Oct 2022 12:14:49 +0100
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
Subject: Re: [PATCH v1 28/30] RISC-V: Add StarFive JH7110 VisionFive2 board
 device tree
Message-ID: <YzghKZ2E8AN1ajnI@spud>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930075353.6842-1-hal.feng@linux.starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930075353.6842-1-hal.feng@linux.starfivetech.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 03:53:53PM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add a minimal device tree for StarFive JH7110 VisionFive2 board.
> Support booting and basic clock/reset/pinctrl/uart drivers.
>

I would like to see a link to the publicly available datasheet or
documentation for the board (and for the SoC in patch 28) please.

> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>

Ditto from patch 28 re: the SoB chain.

> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---

> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> new file mode 100644
> index 000000000000..6b9fe32c7eac
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh7110.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
> +
> +/ {
> +	model = "StarFive VisionFive V2";
> +	compatible = "starfive,visionfive-v2", "starfive,jh7110";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};

Should we also have a chosen node here?

> +
> +	cpus {
> +		timebase-frequency = <4000000>;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0x1 0x0>;

What is going to happen to the 2 GB variant if they attempt to use this
devicetree?

> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x0 0x20000000>;
> +			alignment = <0x0 0x1000>;
> +			alloc-ranges = <0x0 0xa0000000 0x0 0x20000000>;
> +			linux,cma-default;
> +		};
> +
> +		e24_mem: e24@c0000000 {

I had a conversation previously with Icenowy [0] about the e24 on the
jh7100 that didn't really come to a conclusion about how to represent
it there - but looks like you've decided that it should be a remoteproc
for the jh7100?

Is this another situation where peripherals appear at different
addresses for the e24 compared to the u74s? Or has that changed for the
jh7100, and really the e24 should be described in the CPUs node? If it
is the latter, you can pick the first patch from [0] into your series.

0 - https://lore.kernel.org/linux-riscv/e8543838cd221ab6699da16c985eed7514daa786.camel@icenowy.me/

> +			reg = <0x0 0xc0110000 0x0 0xf0000>;
> +			no-map;
> +		};
> +
> +		xrp_reserved: xrpbuffer@f0000000 {

"Following the generic-names recommended practice, node names should
reflect the purpose of the node (ie. “framebuffer” or “dma-pool”)."

I tried googling around for an explanation for what the xrp was, and all
I could find was this out-of-tree text binding:
https://github.com/foss-xtensa/xrp/blob/master/xrp-kernel/cdns%2Cxrp-hw-simple%2Cv1.txt

Thanks,
Conor.

> +			reg = <0x0 0xf0000000 0x0 0x01ffffff>,
> +			      <0x0 0xf2000000 0x0 0x00001000>,
> +			      <0x0 0xf2001000 0x0 0x00fff000>,
> +			      <0x0 0xf3000000 0x0 0x00001000>;
> +		};
> +
> +	};
> +
> +	gpio-restart {
> +		compatible = "gpio-restart";
> +		gpios = <&gpio 35 GPIO_ACTIVE_HIGH>;
> +		priority = <224>;
> +	};
> +};
> +
> +&gpio {
> +	uart0_pins: uart0-pins {
> +		uart0-pins-tx {
> +			starfive,pins = <PAD_GPIO5>;
> +			starfive,pin-ioconfig = <IO(GPIO_IE(1) | GPIO_DS(3))>;
> +			starfive,pin-gpio-dout = <GPO_UART0_SOUT>;
> +			starfive,pin-gpio-doen = <OEN_LOW>;
> +		};
> +
> +		uart0-pins-rx {
> +			starfive,pins = <PAD_GPIO6>;
> +			starfive,pinmux = <PAD_GPIO6_FUNC_SEL 0>;
> +			starfive,pin-ioconfig = <IO(GPIO_IE(1) | GPIO_PU(1))>;
> +			starfive,pin-gpio-doen = <OEN_HIGH>;
> +			starfive,pin-gpio-din =  <GPI_UART0_SIN>;
> +		};
> +	};
> +};
> +
> +&osc {
> +	clock-frequency = <24000000>;
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins>;
> +	status = "okay";
> +};
> -- 
> 2.17.1
> 
