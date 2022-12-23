Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A51654CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiLWHB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWHBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:01:25 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F81B60C6;
        Thu, 22 Dec 2022 23:01:22 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0BF7324DFDC;
        Fri, 23 Dec 2022 15:01:21 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 23 Dec
 2022 15:01:20 +0800
Received: from [192.168.125.65] (183.27.97.120) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 23 Dec
 2022 15:01:20 +0800
Message-ID: <fec1b051-d5ca-c279-50f0-3ad1fd3f813c@starfivetech.com>
Date:   Fri, 23 Dec 2022 15:02:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 03/11] reset: Create subdirectory for StarFive drivers
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-4-hal.feng@starfivetech.com> <Y6Iz7pzG3Zmecm3S@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y6Iz7pzG3Zmecm3S@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.120]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2022 22:15:10 +0000, Conor Dooley wrote:
> On Tue, Dec 20, 2022 at 08:50:46AM +0800, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> > 
> > This moves the StarFive JH7100 reset driver to a new subdirectory in
> > preparation for adding more StarFive reset drivers.
> > 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  MAINTAINERS                                          | 2 +-
> >  drivers/reset/Kconfig                                | 8 +-------
> >  drivers/reset/Makefile                               | 2 +-
> >  drivers/reset/starfive/Kconfig                       | 8 ++++++++
> >  drivers/reset/starfive/Makefile                      | 2 ++
> >  drivers/reset/{ => starfive}/reset-starfive-jh7100.c | 0
> >  6 files changed, 13 insertions(+), 9 deletions(-)
> >  create mode 100644 drivers/reset/starfive/Kconfig
> >  create mode 100644 drivers/reset/starfive/Makefile
> >  rename drivers/reset/{ => starfive}/reset-starfive-jh7100.c (100%)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fd90403c33bd..117024b52d06 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19651,7 +19651,7 @@ STARFIVE JH7100 RESET CONTROLLER DRIVER
> >  M:	Emil Renner Berthing <kernel@esmil.dk>
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
> > -F:	drivers/reset/reset-starfive-jh7100.c
> > +F:	drivers/reset/starfive/reset-starfive-jh7100.c
> >  F:	include/dt-bindings/reset/starfive-jh7100.h
> >  
> >  STATIC BRANCH/CALL
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index de176c2fbad9..1e8e1c4954cd 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -232,13 +232,6 @@ config RESET_SOCFPGA
> >  	  This enables the reset driver for the SoCFPGA ARMv7 platforms. This
> >  	  driver gets initialized early during platform init calls.
> >  
> > -config RESET_STARFIVE_JH7100
> > -	bool "StarFive JH7100 Reset Driver"
> > -	depends on SOC_STARFIVE || COMPILE_TEST
> > -	default SOC_STARFIVE
> > -	help
> > -	  This enables the reset controller driver for the StarFive JH7100 SoC.
> > -
> >  config RESET_SUNPLUS
> >  	bool "Sunplus SoCs Reset Driver" if COMPILE_TEST
> >  	default ARCH_SUNPLUS
> > @@ -320,6 +313,7 @@ config RESET_ZYNQ
> >  	help
> >  	  This enables the reset controller driver for Xilinx Zynq SoCs.
> >  
> > +source "drivers/reset/starfive/Kconfig"
> >  source "drivers/reset/sti/Kconfig"
> >  source "drivers/reset/hisilicon/Kconfig"
> >  source "drivers/reset/tegra/Kconfig"
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > index 3e7e5fd633a8..fee17a0e3a16 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-y += core.o
> >  obj-y += hisilicon/
> > +obj-$(CONFIG_SOC_STARFIVE) += starfive/
> >  obj-$(CONFIG_ARCH_STI) += sti/
> >  obj-$(CONFIG_ARCH_TEGRA) += tegra/
> >  obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
> > @@ -30,7 +31,6 @@ obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
> >  obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
> >  obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
> >  obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
> > -obj-$(CONFIG_RESET_STARFIVE_JH7100) += reset-starfive-jh7100.o
> >  obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
> >  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
> >  obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
> > diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
> > new file mode 100644
> > index 000000000000..cddebdba7177
> > --- /dev/null
> > +++ b/drivers/reset/starfive/Kconfig
> > @@ -0,0 +1,8 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +config RESET_STARFIVE_JH7100
> > +	bool "StarFive JH7100 Reset Driver"
> > +	depends on SOC_STARFIVE || COMPILE_TEST
> > +	default SOC_STARFIVE
> 
> You could in theory drop the default that I added & replace it with a y,
> since the subdir is gated by the symbol. I don't really care though tbh.

If you don't mind, I would like to keep it because the starfive clk subdir
did the same before.

Best regards,
Hal

> The movement seems fine to me..
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

