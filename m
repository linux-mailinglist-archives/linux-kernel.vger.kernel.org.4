Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD85647C2B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLICTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiLICS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:18:58 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99A784C24A;
        Thu,  8 Dec 2022 18:18:56 -0800 (PST)
Received: from loongson.cn (unknown [117.133.84.183])
        by gateway (Coremail) with SMTP id _____8Bx1vAPm5JjvE4EAA--.9895S3;
        Fri, 09 Dec 2022 10:18:55 +0800 (CST)
Received: from [192.168.1.2] (unknown [117.133.84.183])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHuIMm5JjrckoAA--.34956S3;
        Fri, 09 Dec 2022 10:18:54 +0800 (CST)
Message-ID: <ee87dbf5-2338-1bc0-9d70-ea0b1a5582a0@loongson.cn>
Date:   Fri, 9 Dec 2022 10:18:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1] irqchip: loongson-liointc: add hierarchy irq support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>
References: <20221207014555.22465-1-zhuyinbo@loongson.cn>
 <874ju7tz4r.wl-maz@kernel.org>
 <cfbfe5c1-2dbb-a057-b56c-13900ba8c953@loongson.cn>
 <86ilinlbf2.wl-maz@kernel.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
In-Reply-To: <86ilinlbf2.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHuIMm5JjrckoAA--.34956S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZr4kWFykGw4fZw48JF47Jwb_yoWrWrW5pF
        W8Ja12kF45Jr17urya9r1DX3sIyryrtrWqvw4fKF9rZFyDJrn7CF18ZF1q9r1Fkr18G3WU
        ZF1UGFW3uF15AaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x
        8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzFApUUUUU
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/7 19:07, Marc Zyngier 写道:
> On Wed, 07 Dec 2022 10:50:56 +0000,
> Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>>
>> 在 2022/12/7 16:08, Marc Zyngier 写道:
>>> On Wed, 07 Dec 2022 01:45:55 +0000,
>>> Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>>>> When the irq of hierarchical interrupt chip was routed to liointc
>>>> that asked liointc driver to support hierarchy irq and this patch
>>>> was to add such support.
>>>>
>>>> In addition, this patch only consider dts, and acpi hierarchy irq
>>>> support will be added later as required.
>>>>
>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>> ---
>>>>    drivers/irqchip/irq-loongson-liointc.c | 31 ++++++++++++++++++++++++++
>>>>    1 file changed, 31 insertions(+)
>>>>
>>>> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
>>>> index 0da8716f8f24..58e43a2cd02e 100644
>>>> --- a/drivers/irqchip/irq-loongson-liointc.c
>>>> +++ b/drivers/irqchip/irq-loongson-liointc.c
>>>> @@ -177,6 +177,32 @@ static const struct irq_domain_ops acpi_irq_gc_ops = {
>>>>    	.xlate	= liointc_domain_xlate,
>>>>    };
>>>>    +#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
>>>> +static int liointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>>> +				unsigned int nr_irqs, void *arg)
>>>> +{
>>>> +	int i, ret;
>>>> +	irq_hw_number_t hwirq;
>>>> +	unsigned int type = IRQ_TYPE_NONE;
>>>> +	struct irq_fwspec *fwspec = arg;
>>>> +
>>>> +	ret = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	for (i = 0; i < nr_irqs; i++)
>>>> +		irq_map_generic_chip(domain, virq + i, hwirq + i);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct irq_domain_ops of_irq_gc_ops = {
>>>> +	.translate	= irq_domain_translate_twocell,
>>>> +	.alloc		= liointc_domain_alloc,
>>>> +	.free		= irq_domain_free_irqs_top,
>>>> +};
>>>> +#endif
>>>> +
>>>>    static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
>>>>    		struct fwnode_handle *domain_handle, struct device_node *node)
>>>>    {
>>>> @@ -218,8 +244,13 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
>>>>    		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
>>>>    					&acpi_irq_gc_ops, priv);
>>>>    	else
>>>> +#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
>>>> +		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
>>>> +					&of_irq_gc_ops, priv);
>>>> +#else
>>>>    		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
>>>>    					&irq_generic_chip_ops, priv);
>>>> +#endif
>>> Two things:
>>>
>>> - Why do we need three calls to create the same domains depending on
>>>     what firmware is used and kernel configuration?
>> yes, It depend on firmeware and kernel configuration.
> Read again:
>
> why do we need 3 different calls to irq_domain_create_linear when you
> can *indirect* them with a pointer to the correct structure?
It was not considered comprehensively before, one call is enough.
>
>>> - who is going to decide whether to select the
>>>     CONFIG_IRQ_DOMAIN_HIERARCHY option?
>> The latest gpio driver will select  CONFIG_IRQ_DOMAIN_HIERARCHY
> Then why do we need two different behaviours? The same kernel should
> run everywhere.

in fact, A behaviours can handle it, and I will add proper change

in v2.

>
>>> I'd really like to see a statement from the Loongson folks about what
>>> this whole DT stuff is all about. AFAICT, the core ACPICA stuff isn't
>>> even fully merged (i.e. we still rely on arch-specific hacks).
>> The support of dts is mainly for Loongson embedded chips, such as
>> LoongArch Loongson-2 series SoC.  and it use dts to descripte device
>> and don't support acpi.
> That doesn't answer my question. Please have a *consistent* approach
> to your interrupt handling, and work with your ACPI colleagues.

I have a talk with ACPI colleagues that the dts and acpi can keep consistent

approach and I will add it in v2.

>
> 	M.
>

