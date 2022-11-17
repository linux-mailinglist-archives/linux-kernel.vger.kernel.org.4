Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD462D18B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 04:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiKQDTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 22:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKQDTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 22:19:21 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92E3758BC7;
        Wed, 16 Nov 2022 19:19:18 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8BxHLc0qHVj0SYIAA--.11779S3;
        Thu, 17 Nov 2022 11:19:16 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtuMwqHVj3J4VAA--.57027S2;
        Thu, 17 Nov 2022 11:19:13 +0800 (CST)
Subject: Re: [PATCH v3 1/2] gpio: loongson: add dts/acpi gpio support
To:     WANG Xuerui <kernel@xen0n.name>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     lvjianmin <lvjianmin@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, zhuyinbo@loongson.cn
References: <20221116065335.8823-1-zhuyinbo@loongson.cn>
 <3ae71f5c-2737-b313-31f5-5de9eedcf6cd@xen0n.name>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <61354cd8-f631-80d1-8f9e-73d3790aae0f@loongson.cn>
Date:   Thu, 17 Nov 2022 11:19:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3ae71f5c-2737-b313-31f5-5de9eedcf6cd@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxtuMwqHVj3J4VAA--.57027S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoWfAw1rWrWxGFykZr4rWF1xXwb_yoW5GFWDGo
        W7Kr1fXrWrJr1jgr1UJr15XF13XF1UJrnFyr17Gry7JF1YyF1UG3yUJrW7t3yUJF1rGryU
        JFy7GrWIyFy7tF15n29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUPF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFV
        AK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkE
        cVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7
        AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mFADUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/16 下午4:35, WANG Xuerui 写道:
> On 2022/11/16 14:53, Yinbo Zhu wrote:
>> The latest Loongson series platform use dts or acpi framework to
>> register gpio device resources, such as the Loongson-2 series
>> SoC of LOONGARCH architecture. In order to support dts, acpi and
>> compatibility with previous platform device resources in driver,
>> this patch was added.
> 
> "LoongArch", not "LOONGARCH". The latter sounds too similar to a mass 
> replace from the all-caps MIPS.
> 
> But again the commit message is overly verbose IMO, and contains minor 
> grammatical mistakes that don't hamper understanding but are a nuisance 
> nevertheless. I think the following could be enough:
> 
> "Subject: gpio: loongson: Add DTS and ACPI support"
> 
> "Latest Loongson platforms such as the Loongson-2 SoC series describe 
> GPIO device resources with DTS or ACPI. Add such support to the existing 
> platform device driver."
> 
>>
>> Signed-off-by: lvjianmin <lvjianmin@loongson.cn>
> 
> He's canonically "Jianmin Lv <...>" in the Git history.
> 
>> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> 
> Please use proper spelling, either "Zhang Hongchen" or "Hongchen Zhang". 
> I think every people with a loongson.cn address is using the latter form 
> i.e. the Western order of "Firstname Lastname" except the "Liu Peibao" 
> below, but ask the person themselves for honoring their own preference.
> 
>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>> Change in v3:
>>         1. Move the gpio platform data struct from arch/ into 
>> include/linux/
>>            platform_data/.
>>         2. Replace platform_gpio_data with loongson_gpio_platform_data 
>> in .c.
>>         3. Add maintainer in MAINTAINERS file for 
>> include/linux/platform_data/
>>            gpio-loongson.h and gpio-loongson.c
>> Change in v2:
>>         1. Fixup of_loongson_gpio_get_props and remove the parse logic 
>> about
>>                "loongson,conf_offset", "loongson,out_offset", 
>> "loongson,in_offset",
>>            "loongson,gpio_base", "loongson,support_irq" then kernel 
>> driver will
>>            initial them that depend compatible except 
>> "loongson,gpio_base".
>>
>>   MAINTAINERS                                 |   8 +
>>   drivers/gpio/Kconfig                        |   6 +-
>>   drivers/gpio/gpio-loongson.c                | 424 ++++++++++++++++----
>>   include/linux/platform_data/gpio-loongson.h |  22 +
>>   4 files changed, 385 insertions(+), 75 deletions(-)
>>   create mode 100644 include/linux/platform_data/gpio-loongson.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5114db9c8f32..bbd7a0d946eb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12051,6 +12051,14 @@ S:    Maintained
>>   F:    
>> Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
>>   F:    drivers/soc/loongson/loongson2_guts.c
>> +LOONGSON SERIES GPIO DRIVER
> 
> Drop "series" here and everywhere else.
> 
>> +M:    Huacai Chen <chenhuacai@kernel.org>
>> +M:    Yinbo Zhu <zhuyinbo@loongson.cn>
>> +L:    linux-gpio@vger.kernel.org
>> +S:    Maintained
>> +F:    drivers/gpio/gpio-loongson.c
>> +F:    include/linux/platform_data/gpio-loongson.h
>> +
>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>   M:    Sathya Prakash <sathya.prakash@broadcom.com>
>>   M:    Sreekanth Reddy <sreekanth.reddy@broadcom.com>
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index a01af1180616..fb8f0075a8ae 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -376,10 +376,10 @@ config GPIO_LOGICVC
>>         programmable logic block.
>>   config GPIO_LOONGSON
>> -    bool "Loongson-2/3 GPIO support"
>> -    depends on CPU_LOONGSON2EF || CPU_LOONGSON64
>> +    bool "Loongson series GPIO support"
>> +    depends on CPU_LOONGSON2EF || CPU_LOONGSON64 || LOONGARCH
>>       help
>> -      Driver for GPIO functionality on Loongson-2F/3A/3B processors.
>> +      Driver for GPIO functionality on Loongson seires processors.
>>   config GPIO_LPC18XX
>>       tristate "NXP LPC18XX/43XX GPIO support"
>> diff --git a/drivers/gpio/gpio-loongson.c b/drivers/gpio/gpio-loongson.c
>> index a42145873cc9..1e553db03cf8 100644
>> --- a/drivers/gpio/gpio-loongson.c
>> +++ b/drivers/gpio/gpio-loongson.c
>> @@ -1,13 +1,15 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - *  Loongson-2F/3A/3B GPIO Support
>> + *  Loongson Series GPIO Support
>>    *
>> - *  Copyright (c) 2008 Richard Liu,  STMicroelectronics     
>> <richard.liu@st.com>
>> + *  Copyright (c) 2008 Richard Liu, STMicroelectronics 
>> <richard.liu@st.com>
>>    *  Copyright (c) 2008-2010 Arnaud Patard <apatard@mandriva.com>
>>    *  Copyright (c) 2013 Hongbing Hu <huhb@lemote.com>
>>    *  Copyright (c) 2014 Huacai Chen <chenhc@lemote.com>
>> + *  Copyright (c) 2022-2023 Yinbo Zhu <zhuyinbo@loongson.cn>
> 
> Is it 2023 already?
> 
> And do the people listed in the S-o-b tags need a mention here? Or is it 
> more appropriate to remove some of them or demote to tags like 
> Co-developed-by?
> 
>>    */
>> +#include <linux/acpi.h>
>>   #include <linux/kernel.h>
>>   #include <linux/init.h>
>>   #include <linux/module.h>
>> @@ -16,120 +18,398 @@
>>   #include <linux/gpio/driver.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/bitops.h>
>> +#include <linux/platform_data/gpio-loongson.h>
>>   #include <asm/types.h>
>> -#include <loongson.h>
>> -
>> -#define STLS2F_N_GPIO        4
>> -#define STLS3A_N_GPIO        16
>> -
>> -#ifdef CONFIG_CPU_LOONGSON64
>> -#define LOONGSON_N_GPIO    STLS3A_N_GPIO
>> +#if defined(CONFIG_LOONGARCH)
>> +#include <asm/loongson.h>
>> +#elif defined(CONFIG_CPU_LOONGSON2EF)
>> +#include <asm/mach-loongson2ef/loongson.h>
>>   #else
>> -#define LOONGSON_N_GPIO    STLS2F_N_GPIO
>> +#include <asm/mach-loongson64/loongson.h>
>>   #endif
>> -/*
>> - * Offset into the register where we read lines, we write them from 
>> offset 0.
>> - * This offset is the only thing that stand between us and using
>> - * GPIO_GENERIC.
>> - */
>> -#define LOONGSON_GPIO_IN_OFFSET    16
>> +#define LOONGSON_GPIO_IN(x)        (x->base + x->in_offset)
>> +#define LOONGSON_GPIO_OUT(x)        (x->base + x->out_offset)
>> +#define LOONGSON_GPIO_OEN(x)        (x->base + x->conf_offset)
>> +
>> +#define LOONGSON_GPIO_IN_BYTE(x, gpio)    (x->base +\
>> +                    x->in_offset + gpio)
>> +#define LOONGSON_GPIO_OUT_BYTE(x, gpio)    (x->base +\
>> +                    x->out_offset + gpio)
>> +#define LOONGSON_GPIO_OEN_BYTE(x, gpio)    (x->base +\
>> +                    x->conf_offset + gpio)
>> +
>> +struct loongson_gpio_chip {
>> +    struct gpio_chip    chip;
>> +    spinlock_t        lock;
>> +    void __iomem        *base;
>> +    int            conf_offset;
>> +    int            out_offset;
>> +    int            in_offset;
>> +    u16            *gsi_idx_map;
>> +    u16            mapsize;
>> +    bool            support_irq;
>> +};
>> +
>> +static int loongson_gpio_request(
>> +            struct gpio_chip *chip, unsigned int pin)
>> +{
>> +    if (pin >= chip->ngpio)
>> +        return -EINVAL;
>> +    else
> 
> Drop the "else" because the true branch is an early return i.e. diverging.
> 
>> +        return 0;
>> +}
>> +
>> +static inline void __set_direction(struct loongson_gpio_chip *lgpio,
>> +            unsigned int pin, int input)
>> +{
>> +    u64 qval;
>> +    u8  bval;
>> +
>> +    if (!strcmp(lgpio->chip.label, "loongson,ls2k-gpio")) {
>> +        qval = readq(LOONGSON_GPIO_OEN(lgpio));
>> +        if (input)
>> +            qval |= 1ULL << pin;
>> +        else
>> +            qval &= ~(1ULL << pin);
>> +        writeq(qval, LOONGSON_GPIO_OEN(lgpio));
>> +        return;
>> +    }
>> -static DEFINE_SPINLOCK(gpio_lock);
>> +    if (!strcmp(lgpio->chip.label, "loongson,ls7a-gpio") ||
>> +            !strncmp(lgpio->chip.label, "LOON0002", 8)) {
>> +        if (input)
>> +            bval = 1;
>> +        else
>> +            bval = 0;
> 
> bval = input ? 1 : 0;
> 
>> +        writeb(bval, LOONGSON_GPIO_OEN_BYTE(lgpio, pin));
>> +        return;
>> +    }
>> +
>> +    if (!strcmp(lgpio->chip.label, "loongson,platform-gpio")) {
>> +        if (input)
>> +            LOONGSON_GPIOIE |= BIT(pin);
>> +        else
>> +            LOONGSON_GPIOIE &= ~BIT(pin);
>> +        return;
>> +    }
>> +}
>> -static int loongson_gpio_get_value(struct gpio_chip *chip, unsigned 
>> gpio)
>> +static void __set_level(struct loongson_gpio_chip *lgpio, unsigned 
>> int pin,
>> +            int high)
>>   {
>> -    u32 val;
>> +    u64 qval;
>> +    u8 bval;
>> +
>> +    if (!strcmp(lgpio->chip.label, "loongson,ls2k-gpio")) {
>> +        qval = readq(LOONGSON_GPIO_OUT(lgpio));
>> +        if (high)
>> +            qval |= 1ULL << pin;
>> +        else
>> +            qval &= ~(1ULL << pin);
>> +        writeq(qval, LOONGSON_GPIO_OUT(lgpio));
>> +        return;
>> +    }
>> -    spin_lock(&gpio_lock);
>> -    val = LOONGSON_GPIODATA;
>> -    spin_unlock(&gpio_lock);
>> +    if (!strcmp(lgpio->chip.label, "loongson,ls7a-gpio") ||
>> +            !strncmp(lgpio->chip.label, "LOON0002", 8)) {
>> +        if (high)
>> +            bval = 1;
>> +        else
>> +            bval = 0;
> 
> bval = high ? 1 : 0;
> 
>> +        writeb(bval, LOONGSON_GPIO_OUT_BYTE(lgpio, pin));
>> +        return;
>> +    }
>> -    return !!(val & BIT(gpio + LOONGSON_GPIO_IN_OFFSET));
>> +    if (!strcmp(lgpio->chip.label, "loongson,platform-gpio")) {
>> +        if (LOONGSON_GPIODATA)
>> +            LOONGSON_GPIODATA |= BIT(pin);
>> +        else
>> +            LOONGSON_GPIODATA &= ~BIT(pin);
>> +        return;
>> +    }
>>   }
>> -static void loongson_gpio_set_value(struct gpio_chip *chip,
>> -        unsigned gpio, int value)
>> +static int loongson_gpio_direction_input(
>> +                struct gpio_chip *chip, unsigned int pin)
>>   {
>> -    u32 val;
>> +    unsigned long flags;
>> +    struct loongson_gpio_chip *lgpio =
>> +        container_of(chip, struct loongson_gpio_chip, chip);
>> -    spin_lock(&gpio_lock);
>> -    val = LOONGSON_GPIODATA;
>> -    if (value)
>> -        val |= BIT(gpio);
>> -    else
>> -        val &= ~BIT(gpio);
>> -    LOONGSON_GPIODATA = val;
>> -    spin_unlock(&gpio_lock);
>> +    spin_lock_irqsave(&lgpio->lock, flags);
>> +    __set_direction(lgpio, pin, 1);
>> +    spin_unlock_irqrestore(&lgpio->lock, flags);
>> +
>> +    return 0;
>>   }
>> -static int loongson_gpio_direction_input(struct gpio_chip *chip, 
>> unsigned gpio)
>> +static int loongson_gpio_direction_output(
>> +                struct gpio_chip *chip, unsigned int pin,
>> +                int value)
>>   {
>> -    u32 temp;
>> +    struct loongson_gpio_chip *lgpio =
>> +        container_of(chip, struct loongson_gpio_chip, chip);
>> +    unsigned long flags;
>> -    spin_lock(&gpio_lock);
>> -    temp = LOONGSON_GPIOIE;
>> -    temp |= BIT(gpio);
>> -    LOONGSON_GPIOIE = temp;
>> -    spin_unlock(&gpio_lock);
>> +    spin_lock_irqsave(&lgpio->lock, flags);
>> +    __set_level(lgpio, pin, value);
>> +    __set_direction(lgpio, pin, 0);
>> +    spin_unlock_irqrestore(&lgpio->lock, flags);
>>       return 0;
>>   }
>> -static int loongson_gpio_direction_output(struct gpio_chip *chip,
>> -        unsigned gpio, int level)
>> +static int loongson_gpio_get(struct gpio_chip *chip, unsigned int pin)
>> +{
>> +    u64 qval;
>> +    u8  bval;
>> +    int val;
>> +    struct loongson_gpio_chip *lgpio =
>> +        container_of(chip, struct loongson_gpio_chip, chip);
>> +
>> +    if (!strcmp(lgpio->chip.label, "loongson,ls2k-gpio")) {
>> +        qval = readq(LOONGSON_GPIO_IN(lgpio));
>> +        return ((qval & (1ULL << pin)) != 0);
>> +    }
>> +
>> +    if (!strcmp(lgpio->chip.label, "loongson,ls7a-gpio") ||
>> +            !strncmp(lgpio->chip.label, "LOON0002", 8)) {
>> +        bval = readb(LOONGSON_GPIO_IN_BYTE(lgpio, pin));
>> +        return (bval & 1);
>> +    }
>> +
>> +    if (!strcmp(lgpio->chip.label, "loongson,platform-gpio")) {
>> +        val = LOONGSON_GPIODATA;
>> +        return !!(val & BIT(pin + lgpio->in_offset));
>> +    }
>> +
>> +    return -ENXIO;
>> +}
>> +
>> +static void loongson_gpio_set(struct gpio_chip *chip, unsigned int pin,
>> +            int value)
>>   {
>> -    u32 temp;
>> +    unsigned long flags;
>> +    struct loongson_gpio_chip *lgpio =
>> +        container_of(chip, struct loongson_gpio_chip, chip);
>> -    loongson_gpio_set_value(chip, gpio, level);
>> -    spin_lock(&gpio_lock);
>> -    temp = LOONGSON_GPIOIE;
>> -    temp &= ~BIT(gpio);
>> -    LOONGSON_GPIOIE = temp;
>> -    spin_unlock(&gpio_lock);
>> +    spin_lock_irqsave(&lgpio->lock, flags);
>> +    __set_level(lgpio, pin, value);
>> +    spin_unlock_irqrestore(&lgpio->lock, flags);
>> +}
>> +
>> +static int loongson_gpio_to_irq(
>> +            struct gpio_chip *chip, unsigned int offset)
>> +{
>> +    struct platform_device *pdev =
>> +        container_of(chip->parent, struct platform_device, dev);
>> +    struct loongson_gpio_chip *lgpio =
>> +        container_of(chip, struct loongson_gpio_chip, chip);
>> +
>> +    if (offset >= chip->ngpio)
>> +        return -EINVAL;
>> +
>> +    if ((lgpio->gsi_idx_map != NULL) && (offset < lgpio->mapsize))
>> +        offset = lgpio->gsi_idx_map[offset];
>> +
>> +    return platform_get_irq(pdev, offset);
>> +}
>> +
>> +static int loongson_gpio_init(
>> +            struct device *dev, struct loongson_gpio_chip *lgpio,
>> +            struct device_node *np, void __iomem *base)
>> +{
>> +    lgpio->chip.request = loongson_gpio_request;
>> +    lgpio->chip.direction_input = loongson_gpio_direction_input;
>> +    lgpio->chip.get = loongson_gpio_get;
>> +    lgpio->chip.direction_output = loongson_gpio_direction_output;
>> +    lgpio->chip.set = loongson_gpio_set;
>> +    lgpio->chip.can_sleep = 0;
>> +    lgpio->chip.of_node = np;
>> +    lgpio->chip.parent = dev;
>> +    spin_lock_init(&lgpio->lock);
>> +    lgpio->base = (void __iomem *)base;
>> +
>> +    if (!strcmp(lgpio->chip.label, "loongson,ls7a-gpio") ||
>> +            !strncmp(lgpio->chip.label, "LOON0002", 8) ||
>> +            !strcmp(lgpio->chip.label, "loongson,ls2k-gpio"))
> 
> Aren't these 3 device IDs the only models we support/have right now? If 
> so I think the check could safely be dropped.
> 
>> +        lgpio->chip.to_irq = loongson_gpio_to_irq;
>> +
>> +    gpiochip_add(&lgpio->chip);
>>       return 0;
>>   }
>> +static void of_loongson_gpio_get_props(struct device_node *np,
>> +                  struct loongson_gpio_chip *lgpio)
>> +{
>> +    const char *name;
>> +
>> +    of_property_read_u32(np, "ngpios", (u32 *)&lgpio->chip.ngpio);
>> +
>> +    of_property_read_string(np, "compatible", &name);
>> +    lgpio->chip.label = kstrdup(name, GFP_KERNEL);
>> +
>> +    if (!strcmp(name, "loongson,ls2k-gpio")) {
>> +        lgpio->support_irq = true;
>> +        lgpio->conf_offset = 0x0;
>> +        lgpio->out_offset = 0x10;
>> +        lgpio->in_offset = 0x20;
>> +        return;
>> +    }
>> +
>> +    if (!strcmp(name, "loongson,ls7a-gpio")) {
>> +        lgpio->support_irq = true;
>> +        lgpio->conf_offset = 0x800;
>> +        lgpio->out_offset = 0x900;
>> +        lgpio->in_offset = 0xa00;
> 
> Aren't configurations like these usually described in the DT? Are you 
> trying to maintain compatibility with the pre-existing DT structure that 
> is missing such data?
In fact, My v1 patch was to put it in the dts. But it needs to define
some custom dts attributes, and I don't find  any pre-existing DT struct
to compatible with it. so I will keep it in kernel driver. and other
advice I will adopt it.

Tks,
Yinbo.
> 
>> +        return;
>> +    }
>> +}
>> +
>> +static void acpi_loongson_gpio_get_props(struct platform_device *pdev,
>> +                  struct loongson_gpio_chip *lgpio)
>> +{
>> +
>> +    struct device *dev = &pdev->dev;
>> +    int rval;
>> +
>> +    device_property_read_u32(dev, "ngpios", (u32 *)&lgpio->chip.ngpio);
>> +    device_property_read_u32(dev, "gpio_base", (u32 
>> *)&lgpio->chip.base);
>> +    device_property_read_u32(dev, "conf_offset",
>> +                    (u32 *)&lgpio->conf_offset);
>> +    device_property_read_u32(dev, "out_offset",
>> +                    (u32 *)&lgpio->out_offset);
>> +    device_property_read_u32(dev, "in_offset", (u32 
>> *)&lgpio->in_offset);
>> +
>> +    rval = device_property_read_u16_array(dev, "gsi_idx_map", NULL, 0);
>> +    if (rval > 0) {
>> +        lgpio->gsi_idx_map =
>> +            kmalloc_array(rval, sizeof(*lgpio->gsi_idx_map),
>> +                    GFP_KERNEL);
>> +        if (unlikely(!lgpio->gsi_idx_map)) {
>> +            dev_err(dev, "Alloc gsi_idx_map fail!\n");
>> +        } else {
>> +            lgpio->mapsize = rval;
>> +            device_property_read_u16_array(dev, "gsi_idx_map",
>> +                    lgpio->gsi_idx_map, lgpio->mapsize);
>> +        }
>> +    }
>> +
>> +    lgpio->chip.label = kstrdup(pdev->name, GFP_KERNEL);
>> +}
>> +
>> +static void platform_loongson_gpio_get_props(struct platform_device 
>> *pdev,
>> +                  struct loongson_gpio_chip *lgpio)
>> +{
>> +    struct loongson_gpio_platform_data *gpio_data =
>> +        (struct loongson_gpio_platform_data *)pdev->dev.platform_data;
>> +
>> +    lgpio->chip.ngpio = gpio_data->ngpio;
>> +    lgpio->chip.base = gpio_data->gpio_base;
>> +    lgpio->conf_offset = gpio_data->gpio_conf;
>> +    lgpio->out_offset = gpio_data->gpio_out;
>> +    lgpio->in_offset = gpio_data->gpio_in;
>> +    lgpio->chip.label = kstrdup(gpio_data->label, GFP_KERNEL);
>> +}
>> +
>>   static int loongson_gpio_probe(struct platform_device *pdev)
>>   {
>> -    struct gpio_chip *gc;
>> +    struct resource *iores;
>> +    void __iomem *base;
>> +    struct loongson_gpio_chip *lgpio;
>> +    struct device_node *np = pdev->dev.of_node;
>>       struct device *dev = &pdev->dev;
>> +    int ret = 0;
>> -    gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
>> -    if (!gc)
>> +    lgpio = kzalloc(sizeof(struct loongson_gpio_chip), GFP_KERNEL);
>> +    if (!lgpio)
>>           return -ENOMEM;
>> -    gc->label = "loongson-gpio-chip";
>> -    gc->base = 0;
>> -    gc->ngpio = LOONGSON_N_GPIO;
>> -    gc->get = loongson_gpio_get_value;
>> -    gc->set = loongson_gpio_set_value;
>> -    gc->direction_input = loongson_gpio_direction_input;
>> -    gc->direction_output = loongson_gpio_direction_output;
>> +    if (np)
>> +        of_loongson_gpio_get_props(np, lgpio);
>> +    else if (ACPI_COMPANION(&pdev->dev))
>> +        acpi_loongson_gpio_get_props(pdev, lgpio);
>> +    else
>> +        platform_loongson_gpio_get_props(pdev, lgpio);
>> +
>> +    iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    if (!iores) {
>> +        ret = -ENODEV;
>> +        goto out;
>> +    }
>> +
>> +    if (!request_mem_region(iores->start, resource_size(iores),
>> +                pdev->name)) {
>> +        ret = -EBUSY;
>> +        goto out;
>> +    }
>> +
>> +    base = ioremap(iores->start, resource_size(iores));
>> +    if (!base) {
>> +        ret = -ENOMEM;
>> +        goto out;
>> +    }
>> +
>> +    platform_set_drvdata(pdev, lgpio);
>> +
>> +    loongson_gpio_init(dev, lgpio, np, base);
>> +
>> +    return 0;
>> +out:
>> +    pr_err("%s: %s: missing mandatory property\n", __func__, np->name);
> 
> I suggest checking out <linux/dev_printk.h> and use dev_* printk's 
> everywhere you have a `dev` at hand (which is the case here).
> 
>> +    return ret;
>> +}
>> +
>> +static int loongson_gpio_remove(struct platform_device *pdev)
>> +{
>> +    struct loongson_gpio_chip *lgpio = platform_get_drvdata(pdev);
>> +    struct resource        *mem;
>> +
>> +    platform_set_drvdata(pdev, NULL);
>> -    return gpiochip_add_data(gc, NULL);
>> +    gpiochip_remove(&lgpio->chip);
>> +    iounmap(lgpio->base);
>> +    kfree(lgpio->gsi_idx_map);
>> +    kfree(lgpio);
>> +    mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    release_mem_region(mem->start, resource_size(mem));
>> +
>> +    return 0;
>>   }
>> +static const struct of_device_id loongson_gpio_dt_ids[] = {
>> +    { .compatible = "loongson,ls2k-gpio"},
>> +    { .compatible = "loongson,ls7a-gpio"},
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(of, loongson_gpio_dt_ids);
>> +
>> +static const struct acpi_device_id loongson_gpio_acpi_match[] = {
>> +    {"LOON0002"},
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, loongson_gpio_acpi_match);
>> +
>>   static struct platform_driver loongson_gpio_driver = {
>>       .driver = {
>>           .name = "loongson-gpio",
>> +        .owner = THIS_MODULE,
>> +        .of_match_table = loongson_gpio_dt_ids,
>> +        .acpi_match_table = ACPI_PTR(loongson_gpio_acpi_match),
>>       },
>>       .probe = loongson_gpio_probe,
>> +    .remove = loongson_gpio_remove,
>>   };
>>   static int __init loongson_gpio_setup(void)
>>   {
>> -    struct platform_device *pdev;
>> -    int ret;
>> -
>> -    ret = platform_driver_register(&loongson_gpio_driver);
>> -    if (ret) {
>> -        pr_err("error registering loongson GPIO driver\n"); > 
>> -        return ret;
>> -    }
>> -
>> -    pdev = platform_device_register_simple("loongson-gpio", -1, NULL, 
>> 0);
>> -    return PTR_ERR_OR_ZERO(pdev);
>> +    return platform_driver_register(&loongson_gpio_driver);
>>   }
>>   postcore_initcall(loongson_gpio_setup);
>> +
>> +static void __exit loongson_gpio_exit(void)
>> +{
>> +    platform_driver_unregister(&loongson_gpio_driver);
>> +}
>> diff --git a/include/linux/platform_data/gpio-loongson.h 
>> b/include/linux/platform_data/gpio-loongson.h
>> new file mode 100644
>> index 000000000000..f102d2650576
>> --- /dev/null
>> +++ b/include/linux/platform_data/gpio-loongson.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
>> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
>> + */
>> +
>> +#ifndef __LOONGSON_GPIO_PLATFORM_H
>> +#define __LOONGSON_GPIO_PLATFORM_H
>> +
>> +/* ============== Data structrues =============== */
> 
> This comment could be removed as the code here is very trivial hence 
> self-commentary.
> 
> But again, please check out Arnd's review comment; still I think this 
> might not be necessary at all because the legacy users already have to 
> modify many other things elsewhere before they can rebase on the more 
> recent upstream versions.
okay, I got it.
> 
>> +
>> +struct loongson_gpio_platform_data {
>> +    u32 gpio_conf;
>> +    u32 gpio_out;
>> +    u32 gpio_in;
>> +    u32 support_irq;
>> +    char *label;
>> +    int gpio_base;
>> +    int ngpio;
>> +};
>> +
>> +#endif
> 

