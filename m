Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4D66251F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiKKDxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiKKDxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:53:42 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1485E090;
        Thu, 10 Nov 2022 19:53:40 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8BxbbZCx21jNwAGAA--.7180S3;
        Fri, 11 Nov 2022 11:53:38 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxR1dBx21jvaIQAA--.27306S2;
        Fri, 11 Nov 2022 11:53:37 +0800 (CST)
Subject: Re: [PATCH v8 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver
 support
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>, zhuyinbo@loongson.cn,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20221109061122.786-1-zhuyinbo@loongson.cn>
 <Y2vJ953qKHQTalru@smile.fi.intel.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <1c8b897b-9dca-cb36-3281-e98ab29e0921@loongson.cn>
Date:   Fri, 11 Nov 2022 11:53:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y2vJ953qKHQTalru@smile.fi.intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxR1dBx21jvaIQAA--.27306S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw43WF1kXr4DAF1kGFWxJFb_yoW7Ar4DpF
        Zaka45tFWUJr1xury7Xa4FgF1fGrZ7Jrnrt3yYg343XFyDtFn3KFn8GrZFkr4kuFWkAa1I
        v3y7G3y7uFZ8AaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
        AKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
        JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07jOyCJUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andy,

I had add v9 that following your advice, but there are some explain 
about your doubt as follows:

ÔÚ 2022/11/9 ÏÂÎç11:40, Andy Shevchenko Ð´µÀ:
> On Wed, Nov 09, 2022 at 02:11:21PM +0800, Yinbo Zhu wrote:
>> The Loongson-2 SoC has a few pins that can be used as GPIOs or take
>> multiple other functions. Add a driver for the pinmuxing.
>>
>> There is currently no support for GPIO pin pull-up and pull-down.
> 
>> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> 
> Why two SoBs? Who is(are) the author(s)?
>
> ...
> 
>> +	help
>> +	  This selects pin control driver for the Loongson-2 SoC. It
> 
> One space is enough.
> 
>> +	  provides pin config functions multiplexing.  GPIO pin pull-up,
>> +	  pull-down functions are not supported. Say yes to enable
>> +	  pinctrl for Loongson-2 SoC.
> 
> Perhaps keep your entry in order?
> 
>>   source "drivers/pinctrl/actions/Kconfig"
>>   source "drivers/pinctrl/aspeed/Kconfig"
>>   source "drivers/pinctrl/bcm/Kconfig"
> 
> ...
> 
>> @@ -29,6 +29,7 @@ obj-$(CONFIG_PINCTRL_KEEMBAY)	+= pinctrl-keembay.o
>>   obj-$(CONFIG_PINCTRL_LANTIQ)	+= pinctrl-lantiq.o
>>   obj-$(CONFIG_PINCTRL_FALCON)	+= pinctrl-falcon.o
>>   obj-$(CONFIG_PINCTRL_XWAY)	+= pinctrl-xway.o
>> +obj-$(CONFIG_PINCTRL_LOONGSON2) += pinctrl-loongson2.o
> 
> I would expect more order here...
> 
>>   obj-$(CONFIG_PINCTRL_LPC18XX)	+= pinctrl-lpc18xx.o
>>   obj-$(CONFIG_PINCTRL_MAX77620)	+= pinctrl-max77620.o
>>   obj-$(CONFIG_PINCTRL_MCP23S08_I2C)	+= pinctrl-mcp23s08_i2c.o
> 
> ...
> 
>> + * Author: zhanghongchen <zhanghongchen@loongson.cn>
>> + *         Yinbo Zhu <zhuyinbo@loongson.cn>
> 
> Missed Co-developed-by tag above?
> 
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
> 
>> +#include <linux/of.h>
> 
> I found no user of this header.
> But you missed mod_devicetable.h.
> 
>> +#include <linux/pinctrl/pinmux.h>
>> +#include <linux/pinctrl/pinconf-generic.h>
>> +#include <linux/pinctrl/pinctrl.h>
> 
> Can we keep it as a separate group after generic linux/* ones?
> 
>> +#include <linux/seq_file.h>
> 
> + Blank line.
> 
>> +#include <asm-generic/io.h>
> 
> No, use linux/io.h.
> 
> ...
> 
>> +#define PMX_GROUP(grp, offset, bitv)					\
>> +	{								\
>> +		.name = #grp,						\
>> +		.pins = grp ## _pins,					\
>> +		.num_pins = ARRAY_SIZE(grp ## _pins),			\
>> +		.reg = offset,						\
>> +		.bit = bitv,						\
>> +	}
> 
> Use PINCTRL_PINGROUP() and associated data structure.
> 
> ...
> 
>> +static const unsigned int lio_pins[]    = {};
>> +static const unsigned int uart2_pins[]  = {};
>> +static const unsigned int uart1_pins[]  = {};
>> +static const unsigned int camera_pins[] = {};
>> +static const unsigned int dvo1_pins[]   = {};
>> +static const unsigned int dvo0_pins[]   = {};
> 
> No sure what this means.
There are some fuzzy reuse relationships on loongson2, e.g., lio can be
reused as gpio, which is one of the reserved gpios but the manual not
indicates this gpio index.
> 
> ...
> 
>> +static struct loongson2_pmx_group loongson2_pmx_groups[] = {
>> +	PMX_GROUP(gpio, 0x0, 64),
>> +	PMX_GROUP(sdio, 0x0, 20),
>> +	PMX_GROUP(can1, 0x0, 17),
>> +	PMX_GROUP(can0, 0x0, 16),
>> +	PMX_GROUP(pwm3, 0x0, 15),
>> +	PMX_GROUP(pwm2, 0x0, 14),
>> +	PMX_GROUP(pwm1, 0x0, 13),
>> +	PMX_GROUP(pwm0, 0x0, 12),
>> +	PMX_GROUP(i2c1, 0x0, 11),
>> +	PMX_GROUP(i2c0, 0x0, 10),
>> +	PMX_GROUP(nand, 0x0, 9),
>> +	PMX_GROUP(sata_led, 0x0, 8),
>> +	PMX_GROUP(lio, 0x0, 7),
>> +	PMX_GROUP(i2s, 0x0, 6),
>> +	PMX_GROUP(hda, 0x0, 4),
>> +	PMX_GROUP(uart2, 0x8, 13),
>> +	PMX_GROUP(uart1, 0x8, 12),
>> +	PMX_GROUP(camera, 0x10, 5),
>> +	PMX_GROUP(dvo1, 0x10, 4),
>> +	PMX_GROUP(dvo0, 0x10, 1),
> 
>> +
> 
> Redundant blank line.
> 
>> +};
> 
> ...
> 
>> +static const char * const gpio_groups[] = {
>> +	"sdio", "can1", "can0", "pwm3", "pwm2", "pwm1", "pwm0", "i2c1",
>> +	"i2c0", "nand", "sata_led", "lio", "i2s", "hda", "uart2", "uart1",
>> +	"camera", "dvo1", "dvo0"
> 
> Leave trailing comma.
> 
> Also it would be nice to have that grouped like
> 
> 	"sdio",
> 	"can1", "can0",
> 	"pwm3", "pwm2", "pwm1", "pwm0",
> 	"i2c1", "i2c0",
> 	"nand",
> 	"sata_led",
> 	"lio",
> 	"i2s", "hda",
> 	"uart2", "uart1",
> 	"camera",
> 	"dvo1", "dvo0",
> 
>> +};
> 
> 
> ...
> 
>> +	unsigned long reg = (unsigned long)pctrl->reg_base +
>> +				loongson2_pmx_groups[group_num].reg;
> 
> Why casting?!
There are some registers that determine the pin reuse relationship. For 
example, register A determines the sdio reuse relationship, and register 
A+offset determines the uart reuse relationship
> 
> ...
> 
>> +	val = readl((void *)reg);
> 
> Ouch.
> 
>> +	if (func_num == 0)
>> +		val &= ~(1<<mux_bit);
>> +	else
>> +		val |= (1<<mux_bit);
> 
> Why not using __assign_bit() or similar? Or at least BIT() ?
> 
> ...
> 
>> +	writel(val, (void *)reg);
> 
> Ouch!
I will keep writel/readl.
> 
> ...
> 
>> +	pctrl->reg_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(pctrl->reg_base))
> 
>> +		return dev_err_probe(pctrl->dev, PTR_ERR(pctrl->reg_base),
>> +				     "unable to map I/O memory");
> 
> Message duplicates what core does.
> 
> ...
> 
>> +	pctrl->desc.confops	= NULL;
> 
> Redundant.
> 
> ...
> 
>> +static const struct of_device_id loongson2_pinctrl_dt_match[] = {
>> +	{
>> +		.compatible = "loongson,ls2k-pinctrl",
>> +	},
> 
>> +	{ },
> 
> No comma for the terminator line.
> 
>> +};
> 

