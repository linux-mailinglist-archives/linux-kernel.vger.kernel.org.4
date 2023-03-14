Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C246B9810
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjCNOfE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Mar 2023 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjCNOe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:34:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D9A4DE1D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:34:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pc5jQ-0002Cq-1j; Tue, 14 Mar 2023 15:34:28 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pc5jP-0046Eq-BQ; Tue, 14 Mar 2023 15:34:27 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pc5jO-0008kD-GN; Tue, 14 Mar 2023 15:34:26 +0100
Message-ID: <3df9aa881dce1cfb1360c4d4fe6f609f5a73f97b.camel@pengutronix.de>
Subject: Re: [PATCH v5 06/21] reset: Create subdirectory for StarFive drivers
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hal Feng <hal.feng@starfivetech.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Mar 2023 15:34:26 +0100
In-Reply-To: <20230311090733.56918-7-hal.feng@starfivetech.com>
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
         <20230311090733.56918-7-hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sa, 2023-03-11 at 17:07 +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> This moves the StarFive JH7100 reset driver to a new subdirectory in
> preparation for adding more StarFive reset drivers.
> 
> Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  MAINTAINERS                                          | 2 +-
>  drivers/reset/Kconfig                                | 8 +-------
>  drivers/reset/Makefile                               | 2 +-
>  drivers/reset/starfive/Kconfig                       | 8 ++++++++
>  drivers/reset/starfive/Makefile                      | 2 ++
>  drivers/reset/{ => starfive}/reset-starfive-jh7100.c | 0
>  6 files changed, 13 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/reset/starfive/Kconfig
>  create mode 100644 drivers/reset/starfive/Makefile
>  rename drivers/reset/{ => starfive}/reset-starfive-jh7100.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index caba3b61ad5c..87f210e357ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19940,7 +19940,7 @@ STARFIVE JH7100 RESET CONTROLLER DRIVER
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
> -F:	drivers/reset/reset-starfive-jh7100.c
> +F:	drivers/reset/starfive/reset-starfive-jh7100.c
>  F:	include/dt-bindings/reset/starfive-jh7100.h
>  
> 
> 
> 
>  STARFIVE JH71XX PMU CONTROLLER DRIVER
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 6ae5aa46a6b2..6aa8f243b30c 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -232,13 +232,6 @@ config RESET_SOCFPGA
>  	  This enables the reset driver for the SoCFPGA ARMv7 platforms. This
>  	  driver gets initialized early during platform init calls.
>  
> 
> 
> 
> -config RESET_STARFIVE_JH7100
> -	bool "StarFive JH7100 Reset Driver"
> -	depends on ARCH_STARFIVE || COMPILE_TEST
> -	default ARCH_STARFIVE
> -	help
> -	  This enables the reset controller driver for the StarFive JH7100 SoC.
> -
>  config RESET_SUNPLUS
>  	bool "Sunplus SoCs Reset Driver" if COMPILE_TEST
>  	default ARCH_SUNPLUS
> @@ -320,6 +313,7 @@ config RESET_ZYNQ
>  	help
>  	  This enables the reset controller driver for Xilinx Zynq SoCs.
>  
> 
> 
> 
> +source "drivers/reset/starfive/Kconfig"
>  source "drivers/reset/sti/Kconfig"
>  source "drivers/reset/hisilicon/Kconfig"
>  source "drivers/reset/tegra/Kconfig"
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 3e7e5fd633a8..719b8f6f84bc 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y += core.o
>  obj-y += hisilicon/
> +obj-$(CONFIG_ARCH_STARFIVE) += starfive/

This should really be obj-y, otherwise this won't compile with
COMPILE_TEST=y but ARCH_STARFIVE=n.

With that fixed,
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
