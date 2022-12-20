Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968AC65199E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiLTD1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiLTD1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:27:05 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B4B010AD;
        Mon, 19 Dec 2022 19:27:03 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8AxxvCFK6FjZTEHAA--.15945S3;
        Tue, 20 Dec 2022 11:27:01 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf+SEK6FjHV0FAA--.22782S2;
        Tue, 20 Dec 2022 11:27:00 +0800 (CST)
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
 <ce858832-c052-1797-ffeb-2dbe654cbdd1@loongson.cn>
 <CACRpkda0VerZhVGMJJjMYyAWdobvSLj4=eWxBjh+5ubmxvFcjQ@mail.gmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <5dd652c7-f215-0c1f-84c5-fd1e1913b86e@loongson.cn>
Date:   Tue, 20 Dec 2022 11:27:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda0VerZhVGMJJjMYyAWdobvSLj4=eWxBjh+5ubmxvFcjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxf+SEK6FjHV0FAA--.22782S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJF4Utr4rZr4DtFyDtw47urg_yoW5Xr1xpa
        yj9ay7ur4kGr40v3ZrC3WI9F9xA3s8JrW3Ars5trWxGw1qqwn3KrWjvFyY9F43uay8WFWj
        qF1Fv3y09F1UAFJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1SoXUUUUU=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/12/13 下午5:36, Linus Walleij 写道:
> On Mon, Dec 12, 2022 at 9:13 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> 
>> mask_irq/unmask_irq/irq_ack/ function always be called by
>> handle_level_irq/handle_edge_irq in current irq domain. and the
>> handle_level_irq/handle_edge_irq will be called  by handle_irq_desc that
>> ask know which irq is.
>>
>> when a peripheral need to use a gpio irq that gpio irq driver need know
>> irq status and call irq desc->irq_handler.
>>
>> so I don't got it about which case it is unnecessary to know which irq.
> 
> Sorry I don't understand what you are asking, can you elaborate?
> 
> Do you mean that you don't know which driver will not call ->to_irq()
> on the gpiochip? That would be any driver that takes an IRQ directly in
> the device tree:
> 
> gpio: gpio {
>      interrupt-controller;
>      #interrupt-cells = <2>;
>      ....
> };
> 
> device {
>      interrupts = <&gpio 14 IRQ_TYPE_LEVEL_HIGH>;
>      ....
> };
> 
> This case will only call the irqchip callbacks and will never call
> the .to_irq() on the gpio_chip.

I mean that if the current domain is a valid doamin, every interrupt 
must have an interrupt status.

If there is no interrupt status, no one can cover the interrupt,
and no one will call 14 irq's desc->handle_irq (handle_level_irq)
and Loongson-2 gpio doesn't have irq status register, so Loongson-2
gpio irqchip shouldn't be implemented.
> 
>>> You find an example of a hierarchical GPIO irqchip using the
>>> GPIOLIB_IRQCHIP in drivers/gpio/gpio-ixp4xx.c.
>>
>> Loongson-2 gpio irq hardware only a enable register, and when a gpio irq
>> happen, then will has a such flow:  "cpuintc -> liointc -> gpioinc ->
>> generic_handle_domain_irq -> handle_level_irq ->
>> peripheral-action(action->handler)"
>>
>> generic_handle_domain_irq need rely on specific hwirq that ask gpio irq
>> hardware has a status register but Loongson-2 gpio irq hardware doesn't
>> have it.
>>
>> so I still think it wasn't appropriate that for loongson-2 gpio driver
>> add a irq chip.
> 
> generic_handle_domain_irq() is of no concern, what matters is if
> your interrupt is hierarchical or not, the callback in the GPIO chip
> can be a simple remapping of the numberspace followed by
> a call to the parent callbacks.
> 
> Yours,
> Linus Walleij
Hi

I think gpio irq domain should be a normal irq domain that like other 
irq domain. that need a function A to call virq desc handler in gpio irq 
domain.  if no use generic_handler_domain_irq or similar interface,
that will no one to call irq_desc->irq_handler.

"cpuintc -> liointc -> gpioinc -> generic_handle_domain_irq ->
handle_level_irq -> peripheral-action(action->handler)"
> 

