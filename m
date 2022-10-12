Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741A95FCD79
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJLVqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJLVqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:46:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22377120BD3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:46:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r14so132789edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YUyIY83Dz03rVrBLkTenfe7mbUr9786EuQDLdDJGng=;
        b=PqhVBWetRQlAHaB43XhFYSSTsBtizCz8wzlzjTix67DKZtbrWZ8gOQfrOr8aYBAPJO
         /1dFUUD6WFUnEmRAltLlyUTTTzrIkTz7oonYvz4uE+mQXdtr98UbcwYQHZQOLcS1QJjY
         mlv9uDUvGiabxDp2hO1YCZNW7JoAVDzNU4RlaiuW54AMhKilg00WM1GAJJa9TBtmbn5u
         9MJ8JCl8VHcMiFbUENtOtEwU1tMSygZp53hZ22fi1BhrtyVzvDxErYD7MrknvsKjuHTa
         f3KbF7xRkPT/thJhuz3mSOXp5QSs1LuKqaol22wB1IWyBRTIBqrb95Zr/8MdT9lAMdJg
         Qpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YUyIY83Dz03rVrBLkTenfe7mbUr9786EuQDLdDJGng=;
        b=zouruw/ljvMiQgMDXcwoB2AJVfYlCP/qVZ1G+PhaiYTX9jJDoC8FV56pCb++RPDfcN
         k278GeqPXDyAXL0jNT7wEXhXEk2N4DrxYu/idBBXWCDZqaK1Zxj5Ue+UtQCP8JOTHOTR
         ndcjXQNTXiJnHokcoFODrjZO68iF+xFSreYUrvzkOxJtaN5cdrQjQbShlUc0q5kZDMfX
         aP8+o7FCW3f9OLT9PQo/nVAtqmYiFz69ZIuGZArsX2j+bkTjVKWYmtFznGO2Nz3xEnYT
         xPqBgM6SNXFw8t6JHagcEa3gJ4A0tPX4eKbSsRtsZlPel9RKAdnHACQFg1YjyJPBoBBW
         bwTg==
X-Gm-Message-State: ACrzQf2m3fUUqnGpAYaFrLPf8d3Bbjl3jnvC0q8ErdE8wQyoRGD+dsf3
        1pcAJDipXCY4YZ1TYmpmnjU=
X-Google-Smtp-Source: AMsMyM6P6mlqUw6GqDNCTZBVc5ICFtjnTs3LXofvV/8dwaJZTotxqk7EjtRuUCqNUblN28Yd8wQOkw==
X-Received: by 2002:a05:6402:410:b0:451:ea13:4ed7 with SMTP id q16-20020a056402041000b00451ea134ed7mr30341411edv.262.1665611203426;
        Wed, 12 Oct 2022 14:46:43 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ja10-20020a170907988a00b007824c5fe95esm1902451ejc.50.2022.10.12.14.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:46:42 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, wens@csie.org,
        samuel@sholland.org, maxime@cerno.tech,
        Victor Hassan <victor@allwinnertech.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [RESEND] clocksource: sun4i: Fix the bug that tick_resume stucks
Date:   Wed, 12 Oct 2022 23:46:41 +0200
Message-ID: <14741195.tv2OnDr8pf@kista>
In-Reply-To: <20221009032507.39145-1-victor@allwinnertech.com>
References: <20221009032507.39145-1-victor@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Victor,

Dne nedelja, 09. oktober 2022 ob 05:25:07 CEST je Victor Hassan napisal(a):
> Currently syscore_resume() will stuck on tick_resume().
> Fix this by changing  `.tick_resume` from
> sun4i_clkevt_shutdown() to a new function sun4i_tick_resume().

This is pretty involved change. Can you split it in more manageable chunks? 
Also you didn't state why it stucks and what does new approach differently so 
it doesn't stuck.

Best regards,
Jernej

> 
> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
> ---
>  drivers/clocksource/timer-sun4i.c | 131 ++++++++++++++++++++++--------
>  1 file changed, 96 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-sun4i.c
> b/drivers/clocksource/timer-sun4i.c index 94dc6e42e983..574398c35a22 100644
> --- a/drivers/clocksource/timer-sun4i.c
> +++ b/drivers/clocksource/timer-sun4i.c
> @@ -38,6 +38,19 @@
> 
>  #define TIMER_SYNC_TICKS	3
> 
> +/* Registers which needs to be saved and restored before and after sleeping
> */ +static u32 sun4i_timer_regs_offset[] = {
> +	TIMER_IRQ_EN_REG,
> +	TIMER_CTL_REG(0),
> +	TIMER_INTVAL_REG(0),
> +	TIMER_CNTVAL_REG(0),
> +	TIMER_CTL_REG(1),
> +	TIMER_INTVAL_REG(1),
> +	TIMER_CNTVAL_REG(1),
> +};
> +
> +static void __iomem *sun4i_timer_sched_base __read_mostly;
> +
>  /*
>   * When we disable a timer, we need to wait at least for 2 cycles of
>   * the timer source clock. We will use for that the clocksource timer
> @@ -79,10 +92,41 @@ static void sun4i_clkevt_time_start(void __iomem *base,
> u8 timer, base + TIMER_CTL_REG(timer));
>  }
> 
> +static inline void sun4i_timer_save_regs(struct timer_of *to)
> +{
> +	void __iomem *base = timer_of_base(to);
> +	int i;
> +	u32 *regs_backup = (u32 *)to->private_data;
> +
> +	for (i = 0; i < ARRAY_SIZE(sun4i_timer_regs_offset); i++)
> +		regs_backup[i] = readl(base + 
sun4i_timer_regs_offset[i]);
> +}
> +
> +static inline void sun4i_timer_restore_regs(struct timer_of *to)
> +{
> +	void __iomem *base = timer_of_base(to);
> +	int i;
> +	u32 *regs_backup = (u32 *)to->private_data;
> +
> +	for (i = 0; i < ARRAY_SIZE(sun4i_timer_regs_offset); i++)
> +		writel(regs_backup[i], base + 
sun4i_timer_regs_offset[i]);
> +}
> +
>  static int sun4i_clkevt_shutdown(struct clock_event_device *evt)
>  {
>  	struct timer_of *to = to_timer_of(evt);
> 
> +	sun4i_timer_save_regs(to);
> +	sun4i_clkevt_time_stop(timer_of_base(to), 0);
> +
> +	return 0;
> +}
> +
> +static int sun4i_tick_resume(struct clock_event_device *evt)
> +{
> +	struct timer_of *to = to_timer_of(evt);
> +
> +	sun4i_timer_restore_regs(to);
>  	sun4i_clkevt_time_stop(timer_of_base(to), 0);
> 
>  	return 0;
> @@ -137,45 +181,54 @@ static irqreturn_t sun4i_timer_interrupt(int irq, void
> *dev_id) return IRQ_HANDLED;
>  }
> 
> -static struct timer_of to = {
> -	.flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
> -
> -	.clkevt = {
> -		.name = "sun4i_tick",
> -		.rating = 350,
> -		.features = CLOCK_EVT_FEAT_PERIODIC | 
CLOCK_EVT_FEAT_ONESHOT,
> -		.set_state_shutdown = sun4i_clkevt_shutdown,
> -		.set_state_periodic = sun4i_clkevt_set_periodic,
> -		.set_state_oneshot = sun4i_clkevt_set_oneshot,
> -		.tick_resume = sun4i_clkevt_shutdown,
> -		.set_next_event = sun4i_clkevt_next_event,
> -		.cpumask = cpu_possible_mask,
> -	},
> -
> -	.of_irq = {
> -		.handler = sun4i_timer_interrupt,
> -		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> -	},
> -};
> +static void __init sun4i_clockevent_init(struct timer_of *to)
> +{
> +	to->clkevt.name = "sun4i_tick";
> +	to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | 
CLOCK_EVT_FEAT_ONESHOT;
> +	to->clkevt.set_state_shutdown = sun4i_clkevt_shutdown;
> +	to->clkevt.set_state_periodic = sun4i_clkevt_set_periodic;
> +	to->clkevt.set_state_oneshot = sun4i_clkevt_set_oneshot;
> +	to->clkevt.tick_resume = sun4i_tick_resume;
> +	to->clkevt.set_next_event = sun4i_clkevt_next_event;
> +	to->clkevt.cpumask = cpu_possible_mask;
> +	to->of_irq.flags = IRQF_TIMER | IRQF_IRQPOLL;
> +
> +	sun4i_timer_sched_base = timer_of_base(to) + TIMER_CNTVAL_REG(1);
> +}
> 
>  static u64 notrace sun4i_timer_sched_read(void)
>  {
> -	return ~readl(timer_of_base(&to) + TIMER_CNTVAL_REG(1));
> +	return (u64)~readl(sun4i_timer_sched_base);
>  }
> 
>  static int __init sun4i_timer_init(struct device_node *node)
>  {
> +	struct timer_of *to;
>  	int ret;
>  	u32 val;
> 
> -	ret = timer_of_init(node, &to);
> +	to = kzalloc(sizeof(*to), GFP_KERNEL);
> +	if (!to)
> +		return -ENOMEM;
> +
> +	to->flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE;
> +	to->of_irq.handler = sun4i_timer_interrupt;
> +	ret = timer_of_init(node, to);
>  	if (ret)
> -		return ret;
> +		goto err;
> 
> -	writel(~0, timer_of_base(&to) + TIMER_INTVAL_REG(1));
> +	sun4i_clockevent_init(to);
> +
> +	to->private_data = kcalloc(ARRAY_SIZE(sun4i_timer_regs_offset),
> sizeof(u32), GFP_KERNEL); +	if (!to->private_data) {
> +		ret = -ENOMEM;
> +		goto err1;
> +	}
> +
> +	writel(~0, timer_of_base(to) + TIMER_INTVAL_REG(1));
>  	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD |
>  	       TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
> -	       timer_of_base(&to) + TIMER_CTL_REG(1));
> +	       timer_of_base(to) + TIMER_CTL_REG(1));
> 
>  	/*
>  	 * sched_clock_register does not have priorities, and on sun6i and
> @@ -186,32 +239,40 @@ static int __init sun4i_timer_init(struct device_node
> *node) of_machine_is_compatible("allwinner,sun5i-a10s") ||
>  	    of_machine_is_compatible("allwinner,suniv-f1c100s"))
>  		sched_clock_register(sun4i_timer_sched_read, 32,
> -				     timer_of_rate(&to));
> +				     timer_of_rate(to));
> 
> -	ret = clocksource_mmio_init(timer_of_base(&to) + 
TIMER_CNTVAL_REG(1),
> -				    node->name, 
timer_of_rate(&to), 350, 32,
> +	ret = clocksource_mmio_init(timer_of_base(to) + 
TIMER_CNTVAL_REG(1),
> +				    node->name, 
timer_of_rate(to), 350, 32,
>  				    clocksource_mmio_readl_down);
>  	if (ret) {
>  		pr_err("Failed to register clocksource\n");
> -		return ret;
> +		goto err2;
>  	}
> 
>  	writel(TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
> -	       timer_of_base(&to) + TIMER_CTL_REG(0));
> +	       timer_of_base(to) + TIMER_CTL_REG(0));
> 
>  	/* Make sure timer is stopped before playing with interrupts */
> -	sun4i_clkevt_time_stop(timer_of_base(&to), 0);
> +	sun4i_clkevt_time_stop(timer_of_base(to), 0);
> 
>  	/* clear timer0 interrupt */
> -	sun4i_timer_clear_interrupt(timer_of_base(&to));
> +	sun4i_timer_clear_interrupt(timer_of_base(to));
> 
> -	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> +	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
>  					TIMER_SYNC_TICKS, 
0xffffffff);
> 
>  	/* Enable timer0 interrupt */
> -	val = readl(timer_of_base(&to) + TIMER_IRQ_EN_REG);
> -	writel(val | TIMER_IRQ_EN(0), timer_of_base(&to) + 
TIMER_IRQ_EN_REG);
> +	val = readl(timer_of_base(to) + TIMER_IRQ_EN_REG);
> +	writel(val | TIMER_IRQ_EN(0), timer_of_base(to) + 
TIMER_IRQ_EN_REG);
> +
> +	return ret;
> 
> +err2:
> +	kfree(to->private_data);
> +err1:
> +	timer_of_cleanup(to);
> +err:
> +	kfree(to);
>  	return ret;
>  }
>  TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
> --
> 2.29.0


