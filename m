Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735E668C44E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBFRMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBFRM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:12:28 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A0E298DF;
        Mon,  6 Feb 2023 09:12:19 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9C2A424E01A;
        Tue,  7 Feb 2023 01:12:17 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Feb
 2023 01:12:17 +0800
Received: from [172.16.16.234] (113.72.145.145) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Feb
 2023 01:12:15 +0800
Message-ID: <ddb197c3-9c77-c8c2-1d41-1691de05847e@starfivetech.com>
Date:   Tue, 7 Feb 2023 01:12:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 2/4] hwmon: (sfctemp) Add StarFive JH71x0 temperature
 sensor
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230103013145.9570-1-hal.feng@starfivetech.com>
 <20230103013145.9570-3-hal.feng@starfivetech.com>
 <20230103221017.GA217155@roeck-us.net>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230103221017.GA217155@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.145]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023 14:10:17 -0800, Guenter Roeck wrote:
> On Tue, Jan 03, 2023 at 09:31:43AM +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>> 
>> Register definitions and conversion constants based on sfctemp driver by
>> Samin in the StarFive 5.10 kernel.
>> 
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Co-developed-by: Samin Guo <samin.guo@starfivetech.com>
>> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> 
> This is obviously version 4 of the previous patch series,
> with various enhancements. Please do not "sell" that as
> v1 of a new patch series. Submit it as next version,
> and provide a change log.

Sorry to reply too late. I will resend this series as v4 tomorrow.

> 
>> ---
>>  Documentation/hwmon/index.rst   |   1 +
>>  Documentation/hwmon/sfctemp.rst |  33 +++
>>  MAINTAINERS                     |   8 +
>>  drivers/hwmon/Kconfig           |  10 +
>>  drivers/hwmon/Makefile          |   1 +
>>  drivers/hwmon/sfctemp.c         | 350 ++++++++++++++++++++++++++++++++
>>  6 files changed, 403 insertions(+)
>>  create mode 100644 Documentation/hwmon/sfctemp.rst
>>  create mode 100644 drivers/hwmon/sfctemp.c
>> 
>> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
>> index c1d11cf13eef..f7ede608b6e3 100644
>> --- a/Documentation/hwmon/index.rst
>> +++ b/Documentation/hwmon/index.rst
>> @@ -179,6 +179,7 @@ Hardware Monitoring Kernel Drivers
>>     sch5627
>>     sch5636
>>     scpi-hwmon
>> +   sfctemp
>>     sht15
>>     sht21
>>     sht3x
>> diff --git a/Documentation/hwmon/sfctemp.rst b/Documentation/hwmon/sfctemp.rst
>> new file mode 100644
>> index 000000000000..9fbd5bb1f356
>> --- /dev/null
>> +++ b/Documentation/hwmon/sfctemp.rst
>> @@ -0,0 +1,33 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +Kernel driver sfctemp
>> +=====================
>> +
>> +Supported chips:
>> + - StarFive JH7100
>> + - StarFive JH7110
>> +
>> +Authors:
>> + - Emil Renner Berthing <kernel@esmil.dk>
>> +
>> +Description
>> +-----------
>> +
>> +This driver adds support for reading the built-in temperature sensor on the
>> +JH7100 and JH7110 RISC-V SoCs by StarFive Technology Co. Ltd.
>> +
>> +``sysfs`` interface
>> +-------------------
>> +
>> +The temperature sensor can be enabled, disabled and queried via the standard
>> +hwmon interface in sysfs under ``/sys/class/hwmon/hwmonX`` for some value of
>> +``X``:
>> +
>> +================ ==== =============================================
>> +Name             Perm Description
>> +================ ==== =============================================
>> +temp1_enable     RW   Enable or disable temperature sensor.
>> +                      Automatically enabled by the driver,
>> +                      but may be disabled to save power.
>> +temp1_input      RO   Temperature reading in milli-degrees Celsius.
>> +================ ==== =============================================
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 85e8f83161d7..ab3cd5827b26 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18661,6 +18661,14 @@ L:	netdev@vger.kernel.org
>>  S:	Supported
>>  F:	drivers/net/ethernet/sfc/
>>  
>> +SFCTEMP HWMON DRIVER
>> +M:	Emil Renner Berthing <kernel@esmil.dk>
>> +L:	linux-hwmon@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
>> +F:	Documentation/hwmon/sfctemp.rst
>> +F:	drivers/hwmon/sfctemp.c
>> +
>>  SFF/SFP/SFP+ MODULE SUPPORT
>>  M:	Russell King <linux@armlinux.org.uk>
>>  L:	netdev@vger.kernel.org
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 7ac3daaf59ce..c6bbfcca3a14 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1910,6 +1910,16 @@ config SENSORS_STTS751
>>  	  This driver can also be built as a module. If so, the module
>>  	  will be called stts751.
>>  
>> +config SENSORS_SFCTEMP
>> +	tristate "Starfive JH71x0 temperature sensor"
>> +	depends on SOC_STARFIVE || COMPILE_TEST
>> +	help
>> +	  If you say yes here you get support for temperature sensor
>> +	  on the Starfive JH71x0 SoCs.
>> +
>> +	  This driver can also be built as a module.  If so, the module
>> +	  will be called sfctemp.
>> +
>>  config SENSORS_SMM665
>>  	tristate "Summit Microelectronics SMM665"
>>  	depends on I2C
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 11d076cad8a2..5a4a02c5535c 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -179,6 +179,7 @@ obj-$(CONFIG_SENSORS_SBRMI)	+= sbrmi.o
>>  obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
>>  obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
>>  obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
>> +obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
>>  obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
>>  obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
>>  obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
>> diff --git a/drivers/hwmon/sfctemp.c b/drivers/hwmon/sfctemp.c
>> new file mode 100644
>> index 000000000000..e56716ad9587
>> --- /dev/null
>> +++ b/drivers/hwmon/sfctemp.c
>> @@ -0,0 +1,350 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
>> + * Copyright (C) 2021 Samin Guo <samin.guo@starfivetech.com>
>> + */
>> +#include <linux/clk.h>
>> +#include <linux/completion.h>
>> +#include <linux/delay.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset.h>
>> +
>> +/*
>> + * TempSensor reset. The RSTN can be de-asserted once the analog core has
>> + * powered up. Trst(min 100ns)
>> + * 0:reset  1:de-assert
>> + */
>> +#define SFCTEMP_RSTN	BIT(0)
> 
> Missing include of linux/bits.h

Will add it. Thanks.

> 
>> +
>> +/*
>> + * TempSensor analog core power down. The analog core will be powered up
>> + * Tpu(min 50us) after PD is de-asserted. RSTN should be held low until the
>> + * analog core is powered up.
>> + * 0:power up  1:power down
>> + */
>> +#define SFCTEMP_PD	BIT(1)
>> +
>> +/*
>> + * TempSensor start conversion enable.
>> + * 0:disable  1:enable
>> + */
>> +#define SFCTEMP_RUN	BIT(2)
>> +
>> +/*
>> + * TempSensor conversion value output.
>> + * Temp(C)=DOUT*Y/4094 - K
>> + */
>> +#define SFCTEMP_DOUT_POS	16
>> +#define SFCTEMP_DOUT_MSK	GENMASK(27, 16)
>> +
>> +/* DOUT to Celcius conversion constants */
>> +#define SFCTEMP_Y1000	237500L
>> +#define SFCTEMP_Z	4094L
>> +#define SFCTEMP_K1000	81100L
>> +
>> +struct sfctemp {
>> +	/* serialize access to hardware register and enabled below */
>> +	struct mutex lock;
>> +	struct completion conversion_done;
>> +	void __iomem *regs;
>> +	struct clk *clk_sense;
>> +	struct clk *clk_bus;
>> +	struct reset_control *rst_sense;
>> +	struct reset_control *rst_bus;
>> +	bool enabled;
>> +};
>> +
>> +static irqreturn_t sfctemp_isr(int irq, void *data)
>> +{
>> +	struct sfctemp *sfctemp = data;
>> +
>> +	complete(&sfctemp->conversion_done);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void sfctemp_power_up(struct sfctemp *sfctemp)
>> +{
>> +	/* make sure we're powered down first */
>> +	writel(SFCTEMP_PD, sfctemp->regs);
>> +	udelay(1);
>> +
>> +	writel(0, sfctemp->regs);
>> +	/* wait t_pu(50us) + t_rst(100ns) */
>> +	usleep_range(60, 200);
>> +
>> +	/* de-assert reset */
>> +	writel(SFCTEMP_RSTN, sfctemp->regs);
>> +	udelay(1); /* wait t_su(500ps) */
>> +}
>> +
>> +static void sfctemp_power_down(struct sfctemp *sfctemp)
>> +{
>> +	writel(SFCTEMP_PD, sfctemp->regs);
>> +}
>> +
>> +static void sfctemp_run_single(struct sfctemp *sfctemp)
>> +{
>> +	writel(SFCTEMP_RSTN | SFCTEMP_RUN, sfctemp->regs);
>> +	udelay(1);
>> +	writel(SFCTEMP_RSTN, sfctemp->regs);
> 
> The datasheet (or, rather, programming manual) does not appear
> to be public, so I have to guess here.
> 
> The code suggests that running a single conversion may be a choice,
> not a requirement. If it is indeed a choice, the reasoning needs to be
> explained since it adds a lot of complexity and dependencies to the
> driver (for example, interrupt support is only mandatory or even needed
> due to this choice). It also adds a significant delay to temperature
> read operations, which may have practical impact on thermal control
> software.
> 
> If the chip only supports single temperature readings, that needs to be
> explained as well (and why SFCTEMP_RUN has to be reset in that case).

The chip supports continuous conversion. When you set SFCTEMP_RUN, the
temperature raw data will be generated all the time. However, it will
also generate interrupts all the time when the conversion is finished,
because of the hardware limitation. So in this driver, we just support
the single conversion.

Thank you for your feedback.

Best regards,
Hal
