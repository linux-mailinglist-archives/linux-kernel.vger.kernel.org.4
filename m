Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919726499ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiLLINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiLLINC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:13:02 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FBCABF7F;
        Mon, 12 Dec 2022 00:12:59 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8DxuuqJ4pZjHfkEAA--.11719S3;
        Mon, 12 Dec 2022 16:12:57 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHuJ84pZjVDwsAA--.42459S2;
        Mon, 12 Dec 2022 16:12:55 +0800 (CST)
Subject: Re: [PATCH v5 2/3] gpio: loongson: add gpio driver support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
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
        Liu Peibao <liupeibao@loongson.cn>, zhuyinbo@loongson.cn
References: <20221121123803.3786-1-zhuyinbo@loongson.cn>
 <20221121123803.3786-2-zhuyinbo@loongson.cn>
 <CACRpkda1adiNwbTZHdAyHKny3r5FFMP_XXVGbo1vnCdw9U1gNg@mail.gmail.com>
 <8a7abd77-9540-efa8-6f67-908530e85399@loongson.cn>
 <CACRpkdb=wdydOYCcrpjLSyvfVO--_ezXsFQ46qwfVCiiTd5fNw@mail.gmail.com>
 <4c02570e-03d5-85f1-73fb-b66d6170c875@loongson.cn>
 <CACRpkdbgP9m40t_Ky4H+SQi9TELikomT2M-JpF7+auKmzOxQdg@mail.gmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <ce858832-c052-1797-ffeb-2dbe654cbdd1@loongson.cn>
Date:   Mon, 12 Dec 2022 16:12:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbgP9m40t_Ky4H+SQi9TELikomT2M-JpF7+auKmzOxQdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHuJ84pZjVDwsAA--.42459S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZryrZw1xtFW8tF15Xry5Jwb_yoWrZr4fpF
        W3Waya9r4kJF40gFyDG348ZFy3Jwn8JFW7AwsYy34xZ3WDZr9Ygr47tF1FvFyUWrZFvw4Y
        vr1Fyry8uF1DAFJanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI
        0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCj
        c4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU81lk3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/24 下午4:54, Linus Walleij 写道:
> On Thu, Nov 24, 2022 at 3:22 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>> 在 2022/11/24 上午6:05, Linus Walleij 写道:
> 
>>> But these drivers can not rely on the .gpio_to_irq() callback
>>> to be called before an IRQ is requested and used.
>>
>> I may not have made it clear before that the gpio irq chip for other
>> platforms may need to be implemented, but the loongson platform may be
>> special.
>>
>> I mean that the loongson platform use gpio irq does not need to rely on
>> gpio_to_irq, because loongson interrupt controller driver has covered
>> gpio irq.  The specific reason is my above explanation.
>>
>> so, Can I not realize gpio irq chip?
> 
> Isn't this a hierarchical irqchip then?
> 
> Please consult the following from
> Documentation/driver-api/gpio/driver.rst:
> 
> ---------------------------------
> 
> GPIO drivers providing IRQs
> ===========================
> 
> It is custom that GPIO drivers (GPIO chips) are also providing interrupts,
> most often cascaded off a parent interrupt controller, and in some special
> cases the GPIO logic is melded with a SoC's primary interrupt controller.
> 
> The IRQ portions of the GPIO block are implemented using an irq_chip, using
> the header <linux/irq.h>. So this combined driver is utilizing two sub-
> systems simultaneously: gpio and irq.
> 
> It is legal for any IRQ consumer to request an IRQ from any irqchip even if it
> is a combined GPIO+IRQ driver. The basic premise is that gpio_chip and
> irq_chip are orthogonal, and offering their services independent of each
> other.
> 
> gpiod_to_irq() is just a convenience function to figure out the IRQ for a
> certain GPIO line and should not be relied upon to have been called before
> the IRQ is used.
> 
> Always prepare the hardware and make it ready for action in respective
> callbacks from the GPIO and irq_chip APIs. Do not rely on gpiod_to_irq() having
> been called first.
> 
> We can divide GPIO irqchips in two broad categories:
> 
> - CASCADED INTERRUPT CHIPS: this means that the GPIO chip has one common
>    interrupt output line, which is triggered by any enabled GPIO line on that
>    chip. The interrupt output line will then be routed to an parent interrupt
>    controller one level up, in the most simple case the systems primary
>    interrupt controller. This is modeled by an irqchip that will inspect bits
>    inside the GPIO controller to figure out which line fired it. The irqchip
>    part of the driver needs to inspect registers to figure this out and it
>    will likely also need to acknowledge that it is handling the interrupt
>    by clearing some bit (sometime implicitly, by just reading a status
>    register) and it will often need to set up the configuration such as
>    edge sensitivity (rising or falling edge, or high/low level interrupt for
>    example).
> 
> - HIERARCHICAL INTERRUPT CHIPS: this means that each GPIO line has a dedicated
>    irq line to a parent interrupt controller one level up. There is no need
>    to inquire the GPIO hardware to figure out which line has fired, but it
>    may still be necessary to acknowledge the interrupt and set up configuration
>    such as edge sensitivity.
Hi Linus,

My patch had send it to v11, but I have some issues. it seems more
appropriate add them here. the issue as follows:


mask_irq/unmask_irq/irq_ack/ function always be called by
handle_level_irq/handle_edge_irq in current irq domain. and the
handle_level_irq/handle_edge_irq will be called  by handle_irq_desc that
ask know which irq is.

when a peripheral need to use a gpio irq that gpio irq driver need know
irq status and call irq desc->irq_handler.

so I don't got it about which case it is unnecessary to know which irq.
> 
> ---------------------------------
> 
> You find an example of a hierarchical GPIO irqchip using the
> GPIOLIB_IRQCHIP in drivers/gpio/gpio-ixp4xx.c.


Loongson-2 gpio irq hardware only a enable register, and when a gpio irq 
happen, then will has a such flow:  "cpuintc -> liointc -> gpioinc ->
generic_handle_domain_irq -> handle_level_irq ->
peripheral-action(action->handler)"

generic_handle_domain_irq need rely on specific hwirq that ask gpio irq 
hardware has a status register but Loongson-2 gpio irq hardware doesn't 
have it.

so I still think it wasn't appropriate that for loongson-2 gpio driver
add a irq chip.

Yinbo.
> 
> Yours,
> Linus Walleij
> 

