Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70E36120B3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 08:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJ2G16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 02:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2G14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 02:27:56 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C2F81C883B;
        Fri, 28 Oct 2022 23:27:53 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8CxLLfox1xjCjsDAA--.420S3;
        Sat, 29 Oct 2022 14:27:52 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxiFfmx1xjfh4HAA--.5806S2;
        Sat, 29 Oct 2022 14:27:51 +0800 (CST)
Subject: Re: [PATCH v6 2/3] clk: clk-loongson2: add clock controller driver
 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20221028061922.19045-1-zhuyinbo@loongson.cn>
 <20221028061922.19045-2-zhuyinbo@loongson.cn>
 <b63f7fde-4e51-00c5-b060-335e54f73f46@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <652959be-e29a-b312-d67d-dd7b7cb6c147@loongson.cn>
Date:   Sat, 29 Oct 2022 14:27:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b63f7fde-4e51-00c5-b060-335e54f73f46@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxiFfmx1xjfh4HAA--.5806S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxtw48Xw4xZr4DAF45Kw4kZwb_yoW7Ar1kpF
        4DAF45CF4DtF47Xw4Sv34akFn8Xws3GFy2kFy2v34UZr9Fvwn7Xr1kXF93ZFyqqF4kJFWI
        vFZ3uw4SkF4YgaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYnmiUUUUU=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/28 下午7:42, Krzysztof Kozlowski 写道:
> On 28/10/2022 02:19, Yinbo Zhu wrote:
>> This driver provides support for clock controller on Loongson-2 SoC
>> , the Loongson-2 SoC uses a 100MHz clock as the PLL reference clock
>> , there are five independent PLLs inside, each of which PLL can
> 
> Same problem as in other patch - no new lines before commas.
> 
>> provide up to three sets of frequency dependent clock outputs.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   MAINTAINERS                  |   1 +
>>   arch/loongarch/Kconfig       |   1 +
>>   arch/loongarch/kernel/time.c |   3 +
>>   drivers/clk/Kconfig          |   9 ++
>>   drivers/clk/Makefile         |   1 +
>>   drivers/clk/clk-loongson2.c  | 285 +++++++++++++++++++++++++++++++++++
>>   6 files changed, 300 insertions(+)
>>   create mode 100644 drivers/clk/clk-loongson2.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 14af7ebf2be1..5136684fb6c6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11911,6 +11911,7 @@ LOONGSON-2 SOC SERIES CLOCK DRIVER
>>   M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>>   L:	linux-clk@vger.kernel.org
>>   S:	Maintained
>> +F:	drivers/clk/clk-loongson2.c
>>   F:	include/dt-bindings/clock/loongson,ls2k-clk.h
>>   
>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 26aeb1408e56..8b65f349cd6e 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -122,6 +122,7 @@ config LOONGARCH
>>   	select USE_PERCPU_NUMA_NODE_ID
>>   	select USER_STACKTRACE_SUPPORT
>>   	select ZONE_DMA32
>> +	select COMMON_CLK
>>   
>>   config 32BIT
>>   	bool
>> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
>> index 786735dcc8d6..09f20bc81798 100644
>> --- a/arch/loongarch/kernel/time.c
>> +++ b/arch/loongarch/kernel/time.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/sched_clock.h>
>>   #include <linux/spinlock.h>
>> +#include <linux/of_clk.h>
>>   
>>   #include <asm/cpu-features.h>
>>   #include <asm/loongarch.h>
>> @@ -214,6 +215,8 @@ int __init constant_clocksource_init(void)
>>   
>>   void __init time_init(void)
>>   {
>> +	of_clk_init(NULL);
>> +
>>   	if (!cpu_has_cpucfg)
>>   		const_clock_freq = cpu_clock_freq;
>>   	else
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index 48f8f4221e21..e85a3ed88d4c 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -428,6 +428,15 @@ config COMMON_CLK_K210
>>   	help
>>   	  Support for the Canaan Kendryte K210 RISC-V SoC clocks.
>>   
>> +config COMMON_CLK_LOONGSON2
> 
> Messed up order.
okay, I got it.
> 
>> +	bool "Clock driver for Loongson-2 SoC"
>> +	depends on COMMON_CLK && OF
>> +	help
>> +	  This driver provides support for Clock Controller that base on
>> +	  Common Clock Framework Controller (CCF) on Loongson-2 SoC. The
>> +	  Clock Controller can generates and supplies clock to various
>> +	  peripherals within the SoC.
>> +
>>   source "drivers/clk/actions/Kconfig"
>>   source "drivers/clk/analogbits/Kconfig"
>>   source "drivers/clk/baikal-t1/Kconfig"
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index d5db170d38d2..8ccc7436052f 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -75,6 +75,7 @@ obj-$(CONFIG_COMMON_CLK_RS9_PCIE)	+= clk-renesas-pcie.o
>>   obj-$(CONFIG_COMMON_CLK_VC5)		+= clk-versaclock5.o
>>   obj-$(CONFIG_COMMON_CLK_WM831X)		+= clk-wm831x.o
>>   obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
>> +obj-$(CONFIG_COMMON_CLK_LOONGSON2)	+= clk-loongson2.o
> 
> Messed up order.
> 
okay, I got it.
>>   
>>   # please keep this section sorted lexicographically by directory path name
>>   obj-y					+= actions/
>> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
>> new file mode 100644
>> index 000000000000..359fede40112
>> --- /dev/null
>> +++ b/drivers/clk/clk-loongson2.c
>> @@ -0,0 +1,285 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
>> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <linux/clkdev.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <dt-bindings/clock/loongson,ls2k-clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/slab.h>
>> +#include <linux/clk.h>
>> +
>> +#define LOONGSON2_PLL_MULT_SHIFT		32
>> +#define LOONGSON2_PLL_MULT_WIDTH		10
>> +#define LOONGSON2_PLL_DIV_SHIFT			26
>> +#define LOONGSON2_PLL_DIV_WIDTH			6
>> +#define LOONGSON2_APB_FREQSCALE_SHIFT		20
>> +#define LOONGSON2_APB_FREQSCALE_WIDTH		3
>> +#define LOONGSON2_USB_FREQSCALE_SHIFT		16
>> +#define LOONGSON2_USB_FREQSCALE_WIDTH		3
>> +#define LOONGSON2_SATA_FREQSCALE_SHIFT		12
>> +#define LOONGSON2_SATA_FREQSCALE_WIDTH		3
>> +
>> +void __iomem *loongson2_pll_base;
> 
> This must be static.
okay, I will add it.
> 
>> +static DEFINE_SPINLOCK(loongson2_clk_lock);
>> +static struct clk_hw **hws;
>> +static struct clk_hw_onecell_data *clk_hw_data;
> 
> You have way too many file-scope variables. I would expect 0 and this
> being a driver.
okay, I will move it in probe.
> 
> Best regards,
> Krzysztof
> 

