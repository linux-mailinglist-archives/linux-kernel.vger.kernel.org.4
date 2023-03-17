Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CE6BE2EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCQITG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 04:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjCQITA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:19:00 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B1183EA;
        Fri, 17 Mar 2023 01:18:18 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C920024DC31;
        Fri, 17 Mar 2023 16:17:08 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 17 Mar
 2023 16:17:08 +0800
Received: from [192.168.125.74] (113.72.145.194) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 17 Mar
 2023 16:17:07 +0800
Message-ID: <555ba3ba-085b-b7e0-f06f-3ec856034801@starfivetech.com>
Date:   Fri, 17 Mar 2023 16:17:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
From:   Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v5 06/21] reset: Create subdirectory for StarFive drivers
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
 <20230311090733.56918-7-hal.feng@starfivetech.com>
 <3df9aa881dce1cfb1360c4d4fe6f609f5a73f97b.camel@pengutronix.de>
Content-Language: en-US
In-Reply-To: <3df9aa881dce1cfb1360c4d4fe6f609f5a73f97b.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.145.194]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 15:34:26 +0100, Philipp Zabel wrote:
> On Sa, 2023-03-11 at 17:07 +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>> 
>> This moves the StarFive JH7100 reset driver to a new subdirectory in
>> preparation for adding more StarFive reset drivers.
>> 
>> Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  MAINTAINERS                                          | 2 +-
>>  drivers/reset/Kconfig                                | 8 +-------
>>  drivers/reset/Makefile                               | 2 +-
>>  drivers/reset/starfive/Kconfig                       | 8 ++++++++
>>  drivers/reset/starfive/Makefile                      | 2 ++
>>  drivers/reset/{ => starfive}/reset-starfive-jh7100.c | 0
>>  6 files changed, 13 insertions(+), 9 deletions(-)
>>  create mode 100644 drivers/reset/starfive/Kconfig
>>  create mode 100644 drivers/reset/starfive/Makefile
>>  rename drivers/reset/{ => starfive}/reset-starfive-jh7100.c (100%)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index caba3b61ad5c..87f210e357ca 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19940,7 +19940,7 @@ STARFIVE JH7100 RESET CONTROLLER DRIVER
>>  M:	Emil Renner Berthing <kernel@esmil.dk>
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
>> -F:	drivers/reset/reset-starfive-jh7100.c
>> +F:	drivers/reset/starfive/reset-starfive-jh7100.c
>>  F:	include/dt-bindings/reset/starfive-jh7100.h
>>  
>> 
>> 
>> 
>>  STARFIVE JH71XX PMU CONTROLLER DRIVER
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 6ae5aa46a6b2..6aa8f243b30c 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -232,13 +232,6 @@ config RESET_SOCFPGA
>>  	  This enables the reset driver for the SoCFPGA ARMv7 platforms. This
>>  	  driver gets initialized early during platform init calls.
>>  
>> 
>> 
>> 
>> -config RESET_STARFIVE_JH7100
>> -	bool "StarFive JH7100 Reset Driver"
>> -	depends on ARCH_STARFIVE || COMPILE_TEST
>> -	default ARCH_STARFIVE
>> -	help
>> -	  This enables the reset controller driver for the StarFive JH7100 SoC.
>> -
>>  config RESET_SUNPLUS
>>  	bool "Sunplus SoCs Reset Driver" if COMPILE_TEST
>>  	default ARCH_SUNPLUS
>> @@ -320,6 +313,7 @@ config RESET_ZYNQ
>>  	help
>>  	  This enables the reset controller driver for Xilinx Zynq SoCs.
>>  
>> 
>> 
>> 
>> +source "drivers/reset/starfive/Kconfig"
>>  source "drivers/reset/sti/Kconfig"
>>  source "drivers/reset/hisilicon/Kconfig"
>>  source "drivers/reset/tegra/Kconfig"
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 3e7e5fd633a8..719b8f6f84bc 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-y += core.o
>>  obj-y += hisilicon/
>> +obj-$(CONFIG_ARCH_STARFIVE) += starfive/
> 
> This should really be obj-y, otherwise this won't compile with
> COMPILE_TEST=y but ARCH_STARFIVE=n.
> 
> With that fixed,
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

The same problem exists in drivers/clk/Makefile.
Will fix them in the next version. Thank you for your review.

Best regards,
Hal
