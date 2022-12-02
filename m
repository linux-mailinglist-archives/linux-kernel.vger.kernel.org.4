Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B216263FF87
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 05:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiLBEhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 23:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiLBEg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:36:59 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA6E4D3781;
        Thu,  1 Dec 2022 20:36:56 -0800 (PST)
Received: from loongson.cn (unknown [117.133.84.183])
        by gateway (Coremail) with SMTP id _____8Bx1vDngIljqrcCAA--.6342S3;
        Fri, 02 Dec 2022 12:36:55 +0800 (CST)
Received: from [192.168.1.2] (unknown [117.133.84.183])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx9VblgIljvRckAA--.5510S3;
        Fri, 02 Dec 2022 12:36:54 +0800 (CST)
Message-ID: <c46e5ebf-5293-5123-52d3-b3594c6e9244@loongson.cn>
Date:   Fri, 2 Dec 2022 12:36:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v11 1/3] clocksource: loongson2_hpet: add hpet driver
 support
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev, zhuyinbo@loongson.cn
References: <20221129030925.14074-1-zhuyinbo@loongson.cn>
 <87k03bs6pj.ffs@tglx>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
In-Reply-To: <87k03bs6pj.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx9VblgIljvRckAA--.5510S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3JF17Kr48Jr1rCF1Duw17ZFb_yoWxArWUpF
        yIvFsxtFWDJr1kXr1jqrs8urWqq3yfury7Kry5tayUJ34qvwn3GFy0939xCr10krZ3Ja9F
        ya1Yq347uF9FyaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8FAp5UUUUU==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/1 19:29, Thomas Gleixner 写道:
> On Tue, Nov 29 2022 at 11:09, Yinbo Zhu wrote:
>> HPET (High Precision Event Timer) defines a new set of timers, which
> It's not really new. The HPET specification is 20 years old :)

I will change it.

thanks.

>
>> +++ b/drivers/clocksource/loongson2_hpet.c
>> @@ -0,0 +1,334 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
>> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/percpu.h>
>> +#include <linux/delay.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_address.h>
>> +#include <linux/clk.h>
>> +#include <asm/time.h>
>> +
>> +/* HPET regs */
>> +#define HPET_CFG                0x010
>> +#define HPET_STATUS             0x020
>> +#define HPET_COUNTER            0x0f0
>> +#define HPET_T0_IRS             0x001
>> +#define HPET_T0_CFG             0x100
>> +#define HPET_T0_CMP             0x108
>> +#define HPET_CFG_ENABLE         0x001
>> +#define HPET_TN_LEVEL           0x0002
>> +#define HPET_TN_ENABLE          0x0004
>> +#define HPET_TN_PERIODIC        0x0008
>> +#define HPET_TN_SETVAL          0x0040
>> +#define HPET_TN_32BIT           0x0100
> So this is another copy of the defines which are already available in
> x86 and mips. Seriously?

in fact, these definition was also record in LoongArch Loongson-2 SoC

datasheet.

>
>> +static DEFINE_SPINLOCK(hpet_lock);
> This wants to be a raw spinlock if at all. But first you have to explain
> the purpose of this lock.
>
>> +DEFINE_PER_CPU(struct clock_event_device, hpet_clockevent_device);
> Why needs this to be global and why is it needed at all?
>
> This code does support exactly _ONE_ clock event device.

This is consider that the one hardware clock_event_device is used for 
multiple cpu cores,

and earch cpu cores has a device from its perspective, so add 
DEFINE_SPINLOCK(hpet_lock)

and DEFINE_PER_CPU(struct clock_event_device, hpet_clockevent_device),

the use of locks described below is also this reason .


and I will use raw spinlock to replace spin lock.

>
>> +static int hpet_read(int offset)
>> +{
>> +	return readl(hpet_mmio_base + offset);
>> +}
>> +
>> +static void hpet_write(int offset, int data)
>> +{
>> +	writel(data, hpet_mmio_base + offset);
>> +}
>> +
>> +static void hpet_start_counter(void)
>> +{
>> +	unsigned int cfg = hpet_read(HPET_CFG);
>> +
>> +	cfg |= HPET_CFG_ENABLE;
>> +	hpet_write(HPET_CFG, cfg);
>> +}
>> +
>> +static void hpet_stop_counter(void)
>> +{
>> +	unsigned int cfg = hpet_read(HPET_CFG);
>> +
>> +	cfg &= ~HPET_CFG_ENABLE;
>> +	hpet_write(HPET_CFG, cfg);
>> +}
>> +
>> +static void hpet_reset_counter(void)
>> +{
>> +	hpet_write(HPET_COUNTER, 0);
>> +	hpet_write(HPET_COUNTER + 4, 0);
>> +}
>> +
>> +static void hpet_restart_counter(void)
>> +{
>> +	hpet_stop_counter();
>> +	hpet_reset_counter();
>> +	hpet_start_counter();
>> +}
> This is also a copy of the x86 HPET code....
>
>> +static void hpet_enable_legacy_int(void)
>> +{
>> +	/* Do nothing on Loongson2 */
>> +}
>> +
>> +static int hpet_set_state_periodic(struct clock_event_device *evt)
>> +{
>> +	int cfg;
>> +
>> +	spin_lock(&hpet_lock);
> What's the purpose of this lock ?
>
>> +	pr_info("set clock event to periodic mode!\n");
>> +
>> +	/* stop counter */
>> +	hpet_stop_counter();
>> +	hpet_reset_counter();
>> +	hpet_write(HPET_T0_CMP, 0);
>> +
>> +	/* enables the timer0 to generate a periodic interrupt */
>> +	cfg = hpet_read(HPET_T0_CFG);
>> +	cfg &= ~HPET_TN_LEVEL;
>> +	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
>> +		HPET_TN_32BIT | hpet_irq_flags;
>> +	hpet_write(HPET_T0_CFG, cfg);
>> +
>> +	/* set the comparator */
>> +	hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
>> +	udelay(1);
>> +	hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
>> +
>> +	/* start counter */
>> +	hpet_start_counter();
> Pretty much the same code as hpet_clkevt_set_state_periodic()
>
>> +	spin_unlock(&hpet_lock);
>> +	return 0;
>> +}
>> +
>> +static int hpet_set_state_shutdown(struct clock_event_device *evt)
>> +{
>> +	int cfg;
>> +
>> +	spin_lock(&hpet_lock);
>> +
>> +	cfg = hpet_read(HPET_T0_CFG);
>> +	cfg &= ~HPET_TN_ENABLE;
>> +	hpet_write(HPET_T0_CFG, cfg);
>> +
>> +	spin_unlock(&hpet_lock);
> Another slightly different copy of the x86 code
>
>> +	return 0;
>> +}
>> +
>> +static int hpet_set_state_oneshot(struct clock_event_device *evt)
>> +{
>> +	int cfg;
>> +
>> +	spin_lock(&hpet_lock);
>> +
>> +	pr_info("set clock event to one shot mode!\n");
>> +	cfg = hpet_read(HPET_T0_CFG);
>> +	/*
>> +	 * set timer0 type
>> +	 * 1 : periodic interrupt
>> +	 * 0 : non-periodic(oneshot) interrupt
>> +	 */
>> +	cfg &= ~HPET_TN_PERIODIC;
>> +	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT |
>> +		hpet_irq_flags;
>> +	hpet_write(HPET_T0_CFG, cfg);
> Yet another copy.
>
>> +	/* start counter */
>> +	hpet_start_counter();
> Why doe you need an explicit start here?

if the hpet doesn't support period mode,  the the hpet irq doesn't enable in

oneshot mode, so add it in here.

>
>> +	spin_unlock(&hpet_lock);
>> +	return 0;
>> +}
>> +
>> +static int hpet_tick_resume(struct clock_event_device *evt)
>> +{
>> +	spin_lock(&hpet_lock);
>> +	hpet_enable_legacy_int();
>> +	spin_unlock(&hpet_lock);
> More copy and paste just to slap a spinlock on to it which has zero
> value AFAICT.
thank you for reminding me, I will remove it.
>> +	return 0;
>> +}
>> +
>> +static int hpet_next_event(unsigned long delta,
>> +		struct clock_event_device *evt)
>> +{
>> +	u32 cnt;
>> +	s32 res;
>> +
>> +	cnt = hpet_read(HPET_COUNTER);
>> +	cnt += (u32) delta;
>> +	hpet_write(HPET_T0_CMP, cnt);
>> +
>> +	res = (s32)(cnt - hpet_read(HPET_COUNTER));
>> +
>> +	return res < HPET_MIN_CYCLES ? -ETIME : 0;
> Another copy of the x86 code except for omitting the big comment which
> explains the logic.
>
> Seriously, this is not how it works. Instead of copy & paste, we create
> shared infrastructure and just keep the real architecture specific
> pieces separate.
>
> Thanks,
>
>          tglx

I don't find the shared infrastructure in LoongArch, I want to support  
hpet for LoongArch

architecture Loongson-2 SoC series.   the peripherals on the SoC are 
generally

descriped by dts.


In addition, I havent' found any architecture releated differences for 
hpet, at least Mips (loongson)

and LoongArch should be like this,  in addtion to the hpet control base 
address.


Loongson-2 SoC need to support dts, so I refer to the hpet driver of 
Mips and add

hpet dts support for LoongArch architecture Loongson-2 SoC.


Thanks,

Yinbo.

