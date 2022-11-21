Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B03E632250
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiKUMgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKUMga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:36:30 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1A8DB4A6;
        Mon, 21 Nov 2022 04:36:26 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8CxLdnJcHtjKRoJAA--.25129S3;
        Mon, 21 Nov 2022 20:36:25 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxmFfDcHtjF5kXAA--.43571S2;
        Mon, 21 Nov 2022 20:36:22 +0800 (CST)
Subject: Re: [PATCH v4 1/2] gpio: loongson: add dts and acpi support
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20221117035902.13995-1-zhuyinbo@loongson.cn>
 <CAMRc=MdDAoS+4djFX0mA5v-ceVFXYByHmWrfH+p4pVzsY8keXw@mail.gmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <58a29930-874f-da5b-4bee-71c673970802@loongson.cn>
Date:   Mon, 21 Nov 2022 20:36:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdDAoS+4djFX0mA5v-ceVFXYByHmWrfH+p4pVzsY8keXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxmFfDcHtjF5kXAA--.43571S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoWfJrWDXr4xGr47CrWxXFyftFb_yoW8CF13to
        W7GFZ3Z3yxXry7JF1Dt34FqF47Z3Wqva10yw1Ikan8Ga15ta4DKry3JrW3ZFW0yF1YqFWU
        Za4xWw4SkFWxtF43n29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUPY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFV
        AK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jU2-nUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/17 下午5:39, Bartosz Golaszewski 写道:
> On Thu, Nov 17, 2022 at 4:59 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>>
>> Latest Loongson platforms such as the Loongson-2 SoC series describe
>> GPIO device resources with DTS or ACPI. Add such support to the
>> existing platform device driver.
>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>> Change in v4:
>>                  1. Fixup name spelling about Signed-off-by.
>>                  2. Drop "series" here and everywhere else.
>>                  3. Fixup the copyright in driver.
>>                  4. Drop the "else" in loongson_gpio_request.
>>                  5. Use trinocular operation replace the related logic.
>>                  6. Remove lable judgement in context about "lgpio->chip.to_irq =
>>                     loongson_gpio_to_irq"
>>                  7. Use dev_err replace pr_err in probe.
>>                  8. Make legacy platform_data should be left out of this patch.
>>                  9. Remove the mips config in gpio Kconfig.
>> Change in v3:
>>                  1. Move the gpio platform data struct from arch/ into include/linux/
>>                     platform_data/.
>>                  2. Replace platform_gpio_data with loongson_gpio_platform_data in .c.
>>                  3. Add maintainer in MAINTAINERS file for include/linux/platform_data/
>>                     gpio-loongson.h and gpio-loongson.c
>> Change in v2:
>>                  1. Fixup of_loongson_gpio_get_props and remove the parse logic about
>>                     "loongson,conf_offset", "loongson,out_offset", "loongson,in_offset",
>>                     "loongson,gpio_base", "loongson,support_irq" then kernel driver will
>>                     initial them that depend compatible except "loongson,gpio_base".
>>
>>   MAINTAINERS                  |   8 +
>>   drivers/gpio/Kconfig         |   6 +-
>>   drivers/gpio/gpio-loongson.c | 403 ++++++++++++++++++++++++++++-------
>>   3 files changed, 338 insertions(+), 79 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5114db9c8f32..838b920efcef 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12051,6 +12051,14 @@ S:     Maintained
>>   F:     Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
>>   F:     drivers/soc/loongson/loongson2_guts.c
>>
>> +LOONGSON GPIO DRIVER
>> +M:     Huacai Chen <chenhuacai@kernel.org>
>> +M:     Yinbo Zhu <zhuyinbo@loongson.cn>
>> +L:     linux-gpio@vger.kernel.org
>> +S:     Maintained
>> +F:     drivers/gpio/gpio-loongson.c
>> +F:     include/linux/platform_data/gpio-loongson.h
>> +
>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>   M:     Sathya Prakash <sathya.prakash@broadcom.com>
>>   M:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index a01af1180616..b4423c058b1d 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -376,10 +376,10 @@ config GPIO_LOGICVC
>>            programmable logic block.
>>
>>   config GPIO_LOONGSON
>> -       bool "Loongson-2/3 GPIO support"
>> -       depends on CPU_LOONGSON2EF || CPU_LOONGSON64
>> +       bool "Loongson series GPIO support"
>> +       depends on LOONGARCH || COMPILE_TEST
>>          help
>> -         Driver for GPIO functionality on Loongson-2F/3A/3B processors.
>> +         Driver for GPIO functionality on Loongson seires processors.
>>
>>   config GPIO_LPC18XX
>>          tristate "NXP LPC18XX/43XX GPIO support"
>> diff --git a/drivers/gpio/gpio-loongson.c b/drivers/gpio/gpio-loongson.c
>> index a42145873cc9..b9b191a541c0 100644
>> --- a/drivers/gpio/gpio-loongson.c
>> +++ b/drivers/gpio/gpio-loongson.c
>> @@ -1,13 +1,11 @@
>> -// SPDX-License-Identifier: GPL-2.0-or-later
>> +// SPDX-License-Identifier: GPL-2.0+
>>   /*
>> - *  Loongson-2F/3A/3B GPIO Support
>> + * Loongson GPIO Support
>>    *
>> - *  Copyright (c) 2008 Richard Liu,  STMicroelectronics         <richard.liu@st.com>
>> - *  Copyright (c) 2008-2010 Arnaud Patard <apatard@mandriva.com>
>> - *  Copyright (c) 2013 Hongbing Hu <huhb@lemote.com>
>> - *  Copyright (c) 2014 Huacai Chen <chenhc@lemote.com>
> 
> Why are you removing other people's copyright notices?
I will add a new file.
> 
>> + * Copyright (C) 2022 Loongson Technology Corporation Limited
>>    */
>>
>> +#include <linux/acpi.h>
>>   #include <linux/kernel.h>
>>   #include <linux/init.h>
>>   #include <linux/module.h>
>> @@ -17,119 +15,372 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/bitops.h>
>>   #include <asm/types.h>
>> -#include <loongson.h>
>> +#include <asm/loongson.h>
>>
>> -#define STLS2F_N_GPIO          4
>> -#define STLS3A_N_GPIO          16
>> +#define LOONGSON_GPIO_IN(x)            (x->base + x->in_offset)
>> +#define LOONGSON_GPIO_OUT(x)           (x->base + x->out_offset)
>> +#define LOONGSON_GPIO_OEN(x)           (x->base + x->conf_offset)
>>
>> -#ifdef CONFIG_CPU_LOONGSON64
>> -#define LOONGSON_N_GPIO        STLS3A_N_GPIO
>> -#else
>> -#define LOONGSON_N_GPIO        STLS2F_N_GPIO
>> -#endif
>> +#define LOONGSON_GPIO_IN_BYTE(x, gpio) (x->base +\
>> +                                       x->in_offset + gpio)
>> +#define LOONGSON_GPIO_OUT_BYTE(x, gpio)        (x->base +\
>> +                                       x->out_offset + gpio)
>> +#define LOONGSON_GPIO_OEN_BYTE(x, gpio)        (x->base +\
>> +                                       x->conf_offset + gpio)
>>
>> -/*
>> - * Offset into the register where we read lines, we write them from offset 0.
>> - * This offset is the only thing that stand between us and using
>> - * GPIO_GENERIC.
>> - */
>> -#define LOONGSON_GPIO_IN_OFFSET        16
>> +struct loongson_gpio_chip {
>> +       struct gpio_chip        chip;
>> +       spinlock_t              lock;
>> +       void __iomem            *base;
>> +       int                     conf_offset;
>> +       int                     out_offset;
>> +       int                     in_offset;
>> +       u16                     *gsi_idx_map;
>> +       u16                     mapsize;
>> +};
>>
>> -static DEFINE_SPINLOCK(gpio_lock);
>> +static int loongson_gpio_request(
>> +                       struct gpio_chip *chip, unsigned int pin)
>> +{
>> +       if (pin >= chip->ngpio)
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>>
>> -static int loongson_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
>> +static inline void __set_direction(struct loongson_gpio_chip *lgpio,
>> +                       unsigned int pin, int input)
>>   {
>> -       u32 val;
>> +       u64 qval;
>> +       u8  bval;
>> +
>> +       if (!strcmp(lgpio->chip.label, "loongson,ls2k-gpio")) {
>> +               qval = readq(LOONGSON_GPIO_OEN(lgpio));
>> +               if (input)
>> +                       qval |= 1ULL << pin;
>> +               else
>> +                       qval &= ~(1ULL << pin);
>> +               writeq(qval, LOONGSON_GPIO_OEN(lgpio));
>> +               return;
>> +       }
>>
>> -       spin_lock(&gpio_lock);
>> -       val = LOONGSON_GPIODATA;
>> -       spin_unlock(&gpio_lock);
>> +       if (!strcmp(lgpio->chip.label, "loongson,ls7a-gpio") ||
>> +                       !strncmp(lgpio->chip.label, "LOON0002", 8)) {
> 
> This is ugly - can you instead use chip data associated with the
> relevant compatible to store whatever custom info you need? See the
> data field in struct of_device_id and acpi_device_id. Same elsewhere,
> I really dislike this label parsing everywhere.
okay, I got it.
> 
>> +               bval = input ? 1 : 0;
>> +               writeb(bval, LOONGSON_GPIO_OEN_BYTE(lgpio, pin));
>> +               return;
>> +       }
>>
>> -       return !!(val & BIT(gpio + LOONGSON_GPIO_IN_OFFSET));
>> +       if (!strcmp(lgpio->chip.label, "loongson,platform-gpio")) {
>> +               if (input)
>> +                       LOONGSON_GPIOIE |= BIT(pin);
>> +               else
>> +                       LOONGSON_GPIOIE &= ~BIT(pin);
>> +               return;
>> +       }
>>   }
>>
>> -static void loongson_gpio_set_value(struct gpio_chip *chip,
>> -               unsigned gpio, int value)
>> +static void __set_level(struct loongson_gpio_chip *lgpio, unsigned int pin,
>> +                       int high)
>>   {
>> -       u32 val;
>> +       u64 qval;
>> +       u8 bval;
>>
>> -       spin_lock(&gpio_lock);
>> -       val = LOONGSON_GPIODATA;
>> -       if (value)
>> -               val |= BIT(gpio);
>> -       else
>> -               val &= ~BIT(gpio);
>> -       LOONGSON_GPIODATA = val;
>> -       spin_unlock(&gpio_lock);
>> +       if (!strcmp(lgpio->chip.label, "loongson,ls2k-gpio")) {
>> +               qval = readq(LOONGSON_GPIO_OUT(lgpio));
>> +               if (high)
>> +                       qval |= 1ULL << pin;
>> +               else
>> +                       qval &= ~(1ULL << pin);
>> +               writeq(qval, LOONGSON_GPIO_OUT(lgpio));
>> +               return;
>> +       }
>> +
>> +       if (!strcmp(lgpio->chip.label, "loongson,ls7a-gpio") ||
>> +                       !strncmp(lgpio->chip.label, "LOON0002", 8)) {
>> +               bval = high ? 1 : 0;
>> +               writeb(bval, LOONGSON_GPIO_OUT_BYTE(lgpio, pin));
>> +               return;
>> +       }
>> +
>> +       if (!strcmp(lgpio->chip.label, "loongson,platform-gpio")) {
>> +               if (LOONGSON_GPIODATA)
>> +                       LOONGSON_GPIODATA |= BIT(pin);
>> +               else
>> +                       LOONGSON_GPIODATA &= ~BIT(pin);
>> +               return;
>> +       }
>>   }
>>
>> -static int loongson_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
>> +static int loongson_gpio_direction_input(
>> +                               struct gpio_chip *chip, unsigned int pin)
>>   {
>> -       u32 temp;
>> +       unsigned long flags;
>> +       struct loongson_gpio_chip *lgpio =
>> +               container_of(chip, struct loongson_gpio_chip, chip);
>>
>> -       spin_lock(&gpio_lock);
>> -       temp = LOONGSON_GPIOIE;
>> -       temp |= BIT(gpio);
>> -       LOONGSON_GPIOIE = temp;
>> -       spin_unlock(&gpio_lock);
>> +       spin_lock_irqsave(&lgpio->lock, flags);
>> +       __set_direction(lgpio, pin, 1);
>> +       spin_unlock_irqrestore(&lgpio->lock, flags);
>>
>>          return 0;
>>   }
>>
>> -static int loongson_gpio_direction_output(struct gpio_chip *chip,
>> -               unsigned gpio, int level)
>> +static int loongson_gpio_direction_output(
>> +                               struct gpio_chip *chip, unsigned int pin,
>> +                               int value)
>>   {
>> -       u32 temp;
>> +       struct loongson_gpio_chip *lgpio =
>> +               container_of(chip, struct loongson_gpio_chip, chip);
>> +       unsigned long flags;
>>
>> -       loongson_gpio_set_value(chip, gpio, level);
>> -       spin_lock(&gpio_lock);
>> -       temp = LOONGSON_GPIOIE;
>> -       temp &= ~BIT(gpio);
>> -       LOONGSON_GPIOIE = temp;
>> -       spin_unlock(&gpio_lock);
>> +       spin_lock_irqsave(&lgpio->lock, flags);
>> +       __set_level(lgpio, pin, value);
>> +       __set_direction(lgpio, pin, 0);
>> +       spin_unlock_irqrestore(&lgpio->lock, flags);
>>
>>          return 0;
>>   }
>>
>> +static int loongson_gpio_get(struct gpio_chip *chip, unsigned int pin)
>> +{
>> +       u64 qval;
>> +       u8  bval;
>> +       int val;
>> +       struct loongson_gpio_chip *lgpio =
>> +               container_of(chip, struct loongson_gpio_chip, chip);
>> +
>> +       if (!strcmp(lgpio->chip.label, "loongson,ls2k-gpio")) {
>> +               qval = readq(LOONGSON_GPIO_IN(lgpio));
>> +               return ((qval & (1ULL << pin)) != 0);
>> +       }
>> +
>> +       if (!strcmp(lgpio->chip.label, "loongson,ls7a-gpio") ||
>> +                       !strncmp(lgpio->chip.label, "LOON0002", 8)) {
>> +               bval = readb(LOONGSON_GPIO_IN_BYTE(lgpio, pin));
>> +               return (bval & 1);
>> +       }
>> +
>> +       if (!strcmp(lgpio->chip.label, "loongson,platform-gpio")) {
>> +               val = LOONGSON_GPIODATA;
>> +               return !!(val & BIT(pin + lgpio->in_offset));
>> +       }
>> +
>> +       return -ENXIO;
>> +}
>> +
>> +static void loongson_gpio_set(struct gpio_chip *chip, unsigned int pin,
>> +                       int value)
>> +{
>> +       unsigned long flags;
>> +       struct loongson_gpio_chip *lgpio =
>> +               container_of(chip, struct loongson_gpio_chip, chip);
>> +
>> +       spin_lock_irqsave(&lgpio->lock, flags);
>> +       __set_level(lgpio, pin, value);
>> +       spin_unlock_irqrestore(&lgpio->lock, flags);
>> +}
>> +
>> +static int loongson_gpio_to_irq(
>> +                       struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       struct platform_device *pdev =
>> +               container_of(chip->parent, struct platform_device, dev);
>> +       struct loongson_gpio_chip *lgpio =
>> +               container_of(chip, struct loongson_gpio_chip, chip);
>> +
>> +       if (offset >= chip->ngpio)
>> +               return -EINVAL;
>> +
>> +       if ((lgpio->gsi_idx_map != NULL) && (offset < lgpio->mapsize))
>> +               offset = lgpio->gsi_idx_map[offset];
>> +
>> +       return platform_get_irq(pdev, offset);
>> +}
>> +
>> +static int loongson_gpio_init(
>> +                       struct device *dev, struct loongson_gpio_chip *lgpio,
>> +                       struct device_node *np, void __iomem *base)
>> +{
>> +       lgpio->chip.request = loongson_gpio_request;
>> +       lgpio->chip.direction_input = loongson_gpio_direction_input;
>> +       lgpio->chip.get = loongson_gpio_get;
>> +       lgpio->chip.direction_output = loongson_gpio_direction_output;
>> +       lgpio->chip.set = loongson_gpio_set;
>> +       lgpio->chip.can_sleep = 0;
>> +       lgpio->chip.of_node = np;
>> +       lgpio->chip.parent = dev;
>> +       spin_lock_init(&lgpio->lock);
>> +       lgpio->base = (void __iomem *)base;
>> +       lgpio->chip.to_irq = loongson_gpio_to_irq;
>> +
>> +       gpiochip_add(&lgpio->chip);
>> +
>> +       return 0;
>> +}
>> +
>> +static void of_loongson_gpio_get_props(struct device_node *np,
>> +                                 struct loongson_gpio_chip *lgpio)
>> +{
>> +       const char *name;
>> +
>> +       of_property_read_u32(np, "ngpios", (u32 *)&lgpio->chip.ngpio);
>> +
>> +       of_property_read_string(np, "compatible", &name);
>> +       lgpio->chip.label = kstrdup(name, GFP_KERNEL);
>> +
>> +       if (!strcmp(name, "loongson,ls2k-gpio")) {
>> +               lgpio->conf_offset = 0x0;
>> +               lgpio->out_offset = 0x10;
>> +               lgpio->in_offset = 0x20;
>> +               return;
>> +       }
>> +
>> +       if (!strcmp(name, "loongson,ls7a-gpio")) {
>> +               lgpio->conf_offset = 0x800;
>> +               lgpio->out_offset = 0x900;
>> +               lgpio->in_offset = 0xa00;
>> +               return;
>> +       }
>> +}
>> +
>> +static void acpi_loongson_gpio_get_props(struct platform_device *pdev,
>> +                                 struct loongson_gpio_chip *lgpio)
>> +{
>> +
>> +       struct device *dev = &pdev->dev;
>> +       int rval;
>> +
>> +       device_property_read_u32(dev, "ngpios", (u32 *)&lgpio->chip.ngpio);
>> +       device_property_read_u32(dev, "gpio_base", (u32 *)&lgpio->chip.base);
>> +       device_property_read_u32(dev, "conf_offset",
>> +                                       (u32 *)&lgpio->conf_offset);
>> +       device_property_read_u32(dev, "out_offset",
>> +                                       (u32 *)&lgpio->out_offset);
>> +       device_property_read_u32(dev, "in_offset", (u32 *)&lgpio->in_offset);
>> +
>> +       rval = device_property_read_u16_array(dev, "gsi_idx_map", NULL, 0);
>> +       if (rval > 0) {
>> +               lgpio->gsi_idx_map =
>> +                       kmalloc_array(rval, sizeof(*lgpio->gsi_idx_map),
>> +                                       GFP_KERNEL);
>> +               if (unlikely(!lgpio->gsi_idx_map)) {
>> +                       dev_err(dev, "Alloc gsi_idx_map fail!\n");
>> +               } else {
>> +                       lgpio->mapsize = rval;
>> +                       device_property_read_u16_array(dev, "gsi_idx_map",
>> +                                       lgpio->gsi_idx_map, lgpio->mapsize);
>> +               }
>> +       }
>> +
>> +       lgpio->chip.label = kstrdup(pdev->name, GFP_KERNEL);
>> +}
>> +
>> +static void platform_loongson_gpio_get_props(struct platform_device *pdev,
>> +                                 struct loongson_gpio_chip *lgpio)
>> +{
>> +}
> 
> Drop it, if you don't use it.
okay, I got it.
> 
>> +
>>   static int loongson_gpio_probe(struct platform_device *pdev)
>>   {
>> -       struct gpio_chip *gc;
>> +       struct resource *iores;
>> +       void __iomem *base;
>> +       struct loongson_gpio_chip *lgpio;
>> +       struct device_node *np = pdev->dev.of_node;
>>          struct device *dev = &pdev->dev;
>> +       int ret = 0;
>>
>> -       gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
>> -       if (!gc)
>> +       lgpio = kzalloc(sizeof(struct loongson_gpio_chip), GFP_KERNEL);
> 
> Why stop using devres? Same elsewhere.
okay, I had use it devres.
> 
>> +       if (!lgpio)
>>                  return -ENOMEM;
>>
>> -       gc->label = "loongson-gpio-chip";
>> -       gc->base = 0;
>> -       gc->ngpio = LOONGSON_N_GPIO;
>> -       gc->get = loongson_gpio_get_value;
>> -       gc->set = loongson_gpio_set_value;
>> -       gc->direction_input = loongson_gpio_direction_input;
>> -       gc->direction_output = loongson_gpio_direction_output;
>> +       if (np)
>> +               of_loongson_gpio_get_props(np, lgpio);
>> +       else if (ACPI_COMPANION(&pdev->dev))
>> +               acpi_loongson_gpio_get_props(pdev, lgpio);
>> +       else
>> +               platform_loongson_gpio_get_props(pdev, lgpio);
> 
> I would prefer if you used generic device properties - like you
> already do for acpi. They work for OF too thanks to the fwnode
> abstraction.
Some of these attributes I tried to define in the dts, but they are not
generic, so I put them in xxx_ device_ id data field.
> 
>> +
>> +       iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!iores) {
>> +               ret = -ENODEV;
>> +               goto out;
>> +       }
>> +
>> +       if (!request_mem_region(iores->start, resource_size(iores),
>> +                               pdev->name)) {
>> +               ret = -EBUSY;
>> +               goto out;
>> +       }
>> +
>> +       base = ioremap(iores->start, resource_size(iores));
>> +       if (!base) {
>> +               ret = -ENOMEM;
>> +               goto out;
>> +       }
> 
> Are you aware of the gpio-regmap interface? It seems to me that this
> code could benefit from using it. There are already some good examples
> in the tree.
I tried to use regmap, but I found that my driver needs to access 64 bit
registers, and regmap cannot cover it.
> 
>> +
>> +       platform_set_drvdata(pdev, lgpio);
>> +
>> +       loongson_gpio_init(dev, lgpio, np, base);
>> +
>> +       return 0;
>> +out:
>> +       dev_err(dev, "missing mandatory property\n");
>> +
> 
> So if request_mem_region() or ioremap() fails, we're printing this
> error message? Doesn't seem right.
> 
>> +       return ret;
>> +}
>> +
>> +static int loongson_gpio_remove(struct platform_device *pdev)
>> +{
>> +       struct loongson_gpio_chip *lgpio = platform_get_drvdata(pdev);
>> +       struct resource         *mem;
>>
>> -       return gpiochip_add_data(gc, NULL);
>> +       platform_set_drvdata(pdev, NULL);
>> +
>> +       gpiochip_remove(&lgpio->chip);
>> +       iounmap(lgpio->base);
>> +       kfree(lgpio->gsi_idx_map);
>> +       kfree(lgpio);
>> +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       release_mem_region(mem->start, resource_size(mem));
>> +
> 
> This entire function can be dropped if you used devres.
> 
>> +       return 0;
>>   }
>>
>> +static const struct of_device_id loongson_gpio_dt_ids[] = {
>> +       { .compatible = "loongson,ls2k-gpio"},
>> +       { .compatible = "loongson,ls7a-gpio"},
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, loongson_gpio_dt_ids);
>> +
>> +static const struct acpi_device_id loongson_gpio_acpi_match[] = {
>> +       {"LOON0002"},
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, loongson_gpio_acpi_match);
>> +
>>   static struct platform_driver loongson_gpio_driver = {
>>          .driver = {
>>                  .name = "loongson-gpio",
>> +               .owner = THIS_MODULE,
>> +               .of_match_table = loongson_gpio_dt_ids,
>> +               .acpi_match_table = ACPI_PTR(loongson_gpio_acpi_match),
>>          },
>>          .probe = loongson_gpio_probe,
>> +       .remove = loongson_gpio_remove,
>>   };
>>
>>   static int __init loongson_gpio_setup(void)
>>   {
>> -       struct platform_device *pdev;
>> -       int ret;
>> -
>> -       ret = platform_driver_register(&loongson_gpio_driver);
>> -       if (ret) {
>> -               pr_err("error registering loongson GPIO driver\n");
>> -               return ret;
>> -       }
>> -
>> -       pdev = platform_device_register_simple("loongson-gpio", -1, NULL, 0);
>> -       return PTR_ERR_OR_ZERO(pdev);
>> +       return platform_driver_register(&loongson_gpio_driver);
>>   }
>>   postcore_initcall(loongson_gpio_setup);
>> +
>> +static void __exit loongson_gpio_exit(void)
>> +{
>> +       platform_driver_unregister(&loongson_gpio_driver);
>> +}
> 
> This module cannot be unloaded so you can drop this. The __exit macro
> will make the compiler drop it anyway.
okay I got it.
> 
> Bart
> 
>> +
>> +MODULE_DESCRIPTION("Loongson gpio driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.31.1
>>

