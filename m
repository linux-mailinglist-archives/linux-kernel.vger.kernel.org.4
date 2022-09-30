Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13C55F0BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiI3MiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiI3Mh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:37:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886831AF0A;
        Fri, 30 Sep 2022 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664541477; x=1696077477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g97BiHM6o59FUlv7BemhsBNGyRYECFjXlvWFuEOzmqo=;
  b=yOs3MFPYSRARn6D6pGx8St3HNCOXQuSBRDXpEpvlXKrXy21YjlRJJU5+
   vJPVRgoJX2Hqq4La5e0hMRfyysaBtpnpBPH8GWReuWk3q3LEUpg6hF4Br
   /7772rsofnH/xu1XXW6giJxGskk7bo4KYSsXRREtbbSZMBqR0Xja55H+g
   m/+5xZoihSldBo45cMREaBN1R38DLSp2SKbbJbJi8jeVlnazRKyUwiE55
   f/Y3vLoUULIOAe6SJVTKI3PV4QPal1Gm9wEcozdR1banCaTw+MFr0pKj3
   1Wpv2a4XJkr9q/PQYu3fDbNXJzU9c076QqeBxI1GkXfDaP4Nzcb4tfen8
   g==;
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="182692375"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2022 05:37:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 30 Sep 2022 05:37:55 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 30 Sep 2022 05:37:51 -0700
Date:   Fri, 30 Sep 2022 13:37:28 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@linux.starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
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
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 30/30] RISC-V: Add StarFive JH7100 and JH7110 SoC
 Kconfig options
Message-ID: <YzbjCIfoxjsFCuD1@wendy>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930122318.9244-1-hal.feng@linux.starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220930122318.9244-1-hal.feng@linux.starfivetech.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 08:23:18PM +0800, Hal Feng wrote:
> Add Kconfig options to select the specified StarFive SoC. Select
> necessary Kconfig options required by the specified SoC for booting.
> 
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  arch/riscv/Kconfig.socs               | 27 ++++++++++++++++++++++++++-
>  arch/riscv/boot/dts/starfive/Makefile |  4 ++--
>  drivers/clk/starfive/Kconfig          | 14 ++++++--------
>  drivers/pinctrl/starfive/Kconfig      |  6 ++----
>  drivers/reset/Kconfig                 |  1 -

Firstly, you cannot change all of these files in one commit, sorry.

>  5 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 10f68a4359f9..321c448e7b6f 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -22,10 +22,35 @@ config SOC_STARFIVE
>  	bool "StarFive SoCs"
>  	select PINCTRL
>  	select RESET_CONTROLLER
> +	select RESET_STARFIVE

Secondly, we are trying to get rid of selects in arch/riscv at the
moment, not add them. use "default SOC_STARFIVE" in
drivers/reset/kconfig instead please.

> +	help
> +	  This enables support for StarFive SoC platform hardware.
> +
> +if SOC_STARFIVE

I don't think we want to have per soc selection menus in arch code,
I think this should move to drivers/soc (a la Renesas) if you want to
have a per soc selection menu or else just do "default SOC_STARFIVE"
for both clock and pinctrl drivers in the clk and pinctrl Kconfig
entries.

Thanks,
Conor.

> +
> +config SOC_JH7100
> +	bool "StarFive JH7100 SoC support"
> +	depends on SOC_STARFIVE
>  	select SIFIVE_L2
>  	select SIFIVE_PLIC
> +	select CLK_STARFIVE_JH7100
> +	select PINCTRL_STARFIVE_JH7100
> +	default SOC_STARFIVE
>  	help
> -	  This enables support for StarFive SoC platform hardware.
> +	  This enables support for StarFive JH7100 SoC.
> +
> +config SOC_JH7110
> +	bool "StarFive JH7110 SoC support"
> +	depends on SOC_STARFIVE
> +	select SIFIVE_L2
> +	select SIFIVE_PLIC
> +	select CLK_STARFIVE_JH7110_SYS
> +	select PINCTRL_STARFIVE_JH7110
> +	default SOC_STARFIVE
> +	help
> +	  This enables support for StarFive JH7110 SoC.
> +
> +endif
>  
>  config SOC_VIRT
>  	bool "QEMU Virt Machine"
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index e1237dbc6aac..a6ecd3c2ec7d 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb
> -dtb-$(CONFIG_SOC_STARFIVE) += jh7110-starfive-visionfive-v2.dtb
> +dtb-$(CONFIG_SOC_JH7100) += jh7100-beaglev-starlight.dtb
> +dtb-$(CONFIG_SOC_JH7110) += jh7110-starfive-visionfive-v2.dtb
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index 42aad3b553cb..d0490e9f42db 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -5,36 +5,34 @@ config CLK_STARFIVE
>  
>  config CLK_STARFIVE_JH7100
>  	bool "StarFive JH7100 clock support"
> -	depends on SOC_STARFIVE || COMPILE_TEST
> +	depends on SOC_JH7100 || COMPILE_TEST
>  	select CLK_STARFIVE
> -	default SOC_STARFIVE
>  	help
>  	  Say yes here to support the clock controller on the StarFive JH7100
>  	  SoC.
>  
>  config CLK_STARFIVE_JH7100_AUDIO
>  	tristate "StarFive JH7100 audio clock support"
> -	depends on SOC_STARFIVE || COMPILE_TEST
> +	depends on SOC_JH7100 || COMPILE_TEST
>  	select CLK_STARFIVE
> -	default m if SOC_STARFIVE
> +	default m if SOC_JH7100
>  	help
>  	  Say Y or M here to support the audio clocks on the StarFive JH7100
>  	  SoC.
>  
>  config CLK_STARFIVE_JH7110_SYS
>  	bool "StarFive JH7110 system clock support"
> -	depends on SOC_STARFIVE || COMPILE_TEST
> +	depends on SOC_JH7110 || COMPILE_TEST
>  	select CLK_STARFIVE
> -	default SOC_STARFIVE
>  	help
>  	  Say yes here to support the system clock controller on the
>  	  StarFive JH7110 SoC.
>  
>  config CLK_STARFIVE_JH7110_AON
>  	tristate "StarFive JH7110 always-on clock support"
> -	depends on SOC_STARFIVE || COMPILE_TEST
> +	depends on SOC_JH7110 || COMPILE_TEST
>  	select CLK_STARFIVE
> -	default m if SOC_STARFIVE
> +	default m if SOC_JH7110
>  	help
>  	  Say yes here to support the always-on clock controller on the
>  	  StarFive JH7110 SoC.
> diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/Kconfig
> index fde39f4a7922..d09bdf6d3029 100644
> --- a/drivers/pinctrl/starfive/Kconfig
> +++ b/drivers/pinctrl/starfive/Kconfig
> @@ -2,7 +2,7 @@
>  
>  config PINCTRL_STARFIVE_JH7100
>  	tristate "Pinctrl and GPIO driver for the StarFive JH7100 SoC"
> -	depends on SOC_STARFIVE || COMPILE_TEST
> +	depends on SOC_JH7100 || COMPILE_TEST
>  	depends on OF
>  	select GENERIC_PINCTRL_GROUPS
>  	select GENERIC_PINMUX_FUNCTIONS
> @@ -10,7 +10,6 @@ config PINCTRL_STARFIVE_JH7100
>  	select GPIOLIB
>  	select GPIOLIB_IRQCHIP
>  	select OF_GPIO
> -	default SOC_STARFIVE
>  	help
>  	  Say yes here to support pin control on the StarFive JH7100 SoC.
>  	  This also provides an interface to the GPIO pins not used by other
> @@ -28,10 +27,9 @@ config PINCTRL_STARFIVE
>  
>  config PINCTRL_STARFIVE_JH7110
>  	bool "Pinctrl and GPIO driver for the StarFive JH7110 SoC"
> -	depends on SOC_STARFIVE || COMPILE_TEST
> +	depends on SOC_JH7110 || COMPILE_TEST
>  	depends on OF
>  	select PINCTRL_STARFIVE
> -	default SOC_STARFIVE
>  	help
>  	  Say yes here to support pin control on the StarFive JH7110 SoC.
>  	  This also provides an interface to the GPIO pins not used by other
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 8121de5ecc3c..c001879bd890 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -228,7 +228,6 @@ config RESET_SOCFPGA
>  config RESET_STARFIVE
>  	bool "StarFive SoC Reset Driver"
>  	depends on SOC_STARFIVE || COMPILE_TEST
> -	default SOC_STARFIVE
>  	help
>  	  This enables the reset controller driver for the StarFive SoCs.
>  
> -- 
> 2.17.1
> 
