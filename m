Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC4860DCF8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiJZIV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJZIVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:21:21 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B371AC3A9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:21:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AD6B73200413;
        Wed, 26 Oct 2022 04:21:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Oct 2022 04:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666772473; x=
        1666858873; bh=72610K1J3wmTniq/6jI50qZaUJG9FcbeHM8xWZxsyGY=; b=A
        jeEXUDcjbgaTqMXcsPh4ofJjFLbzuFZ+sfUJUSaTHXCAU7eJwEwQcGGP3jGb15IA
        rRvRmdOL89NDVEG9cRe5IFfuiyZwR8Zjq+HqewJyWloN33IHZ/JJsdUbD0bObKNH
        PRIuEhQ199DRFlkbLStSqhMqkELNuF7AJrbyBwgnzWRGNysUJLnTfbhDgkmEGjhz
        yr9Q/Wl6MeTmiKGyUtvU5vaWIFroZ6xRhtz30FGvMbLDjlfaQ8PxsmaZMJAdC12Y
        gqcXtYQib4F+MaBcflJ3Ih/wskWW9uJtoFokwaLAyYxAldQ5KAhra0Oeh8LWHoOg
        tpLD2YYW6t5IA163elUDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666772473; x=
        1666858873; bh=72610K1J3wmTniq/6jI50qZaUJG9FcbeHM8xWZxsyGY=; b=R
        cRvaRjhdUmc6RRNzQVpIynk3vQTv9zbZhHmakJnySijg8T40OLtsmMgK9ZJ8HDxY
        tNrWxxcGYdPCkXSat8l+ovPk3dQoFQUPYQKTrgOW0R3K83OoX0kNcZJFttWI269d
        VM21UNkzh3Em4BAsGWqkWdt4C/X7x0ChthsqGPy9gctEYe4CKbgn5Q7YE2Fb/V3h
        oyvqOR+YxAYJMikNcYBITDmfnRsPI4NcV4CI7FA9eN21bHnNYRQUfCO5r/4jOy6/
        O1a3EaC9Y0KLQxxivknGJYtKQTQg75iz/sm3eR+EDaS6ails2M/lpbLmQkqrWRKa
        9aMqVvkzJcPjioTR43Hqg==
X-ME-Sender: <xms:-O1YY50PO8roe4Y9aKN0Sr0a1CAEkrD1HJLcR5bf5_tCJgOhHnBQlA>
    <xme:-O1YYwHQ3v0wHDWoosjSLhGmyVLk3UTqtza-yBdbCazVox6UaFjHb-QrM9VGnnTbt
    nXunyoohHR0G4RqaHE>
X-ME-Received: <xmr:-O1YY57OC915PlPGrvqEahSDf7dxMd1V7HpRT2QjBKSVfs99NJ1wm2S0xvy5JnwP5SWTYcQopaeQN8lyDQRV760apNjcWZ6TR75zaQH6P_jRiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepmhgrgihi
    mhgvsegtvghrnhhordhtvggthhenucggtffrrghtthgvrhhnpedvtefggeffuefhkedufe
    ffgffhgfehheetheeghfffkeduhfegffeukeelvdejgfenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtg
    hh
X-ME-Proxy: <xmx:-O1YY21ZNHx5tClKEydFY0yT9oT9sMGeVbaVtlziZ3Yd_teT26xBmg>
    <xmx:-O1YY8HFYR1enaQBQtDFvrtrpX45LHIj8_YDhzZEZRE-mD_MI4yozA>
    <xmx:-O1YY381H4dmXj8lW4apM31l1N4B3Neolo8gguaYWLlAcQ-TufPrSg>
    <xmx:-e1YY6VzCF4ev5J6ariJtm5xMMRCQ_Wq3-wGa6OU2orQFas8MWzX2Q>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 04:21:11 -0400 (EDT)
From:   maxime@cerno.tech
Date:   Wed, 26 Oct 2022 10:21:10 +0200
To:     Victor Hassan <victor@allwinnertech.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [RESEND] clocksource: sun4i: Fix the bug that tick_resume stucks
Message-ID: <20221026082110.b7pguv7tkltn74k4@houat>
11;rgb: ffff/ffff/ffffFrom: Maxime Ripard <maxime@cerno.tech>
References: <20221009032507.39145-1-victor@allwinnertech.com>
 <83fa8869-5cc2-2306-0a82-d05c9e390316@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <83fa8869-5cc2-2306-0a82-d05c9e390316@allwinnertech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 25, 2022 at 02:23:09PM +0800, Victor Hassan wrote:
> On 2022/10/9 11:25, Victor Hassan wrote:
> > Currently syscore_resume() will stuck on tick_resume().
> > Fix this by changing  `.tick_resume` from
> > sun4i_clkevt_shutdown() to a new function sun4i_tick_resume().
> >=20
> > Signed-off-by: Victor Hassan <victor@allwinnertech.com>
> > ---
> >   drivers/clocksource/timer-sun4i.c | 131 ++++++++++++++++++++++--------
> >   1 file changed, 96 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/ti=
mer-sun4i.c
> > index 94dc6e42e983..574398c35a22 100644
> > --- a/drivers/clocksource/timer-sun4i.c
> > +++ b/drivers/clocksource/timer-sun4i.c
> > @@ -38,6 +38,19 @@
> >   #define TIMER_SYNC_TICKS	3
> > +/* Registers which needs to be saved and restored before and after sle=
eping */
> > +static u32 sun4i_timer_regs_offset[] =3D {
> > +	TIMER_IRQ_EN_REG,
> > +	TIMER_CTL_REG(0),
> > +	TIMER_INTVAL_REG(0),
> > +	TIMER_CNTVAL_REG(0),
> > +	TIMER_CTL_REG(1),
> > +	TIMER_INTVAL_REG(1),
> > +	TIMER_CNTVAL_REG(1),
> > +};
> > +
> > +static void __iomem *sun4i_timer_sched_base __read_mostly;
> > +
> >   /*
> >    * When we disable a timer, we need to wait at least for 2 cycles of
> >    * the timer source clock. We will use for that the clocksource timer
> > @@ -79,10 +92,41 @@ static void sun4i_clkevt_time_start(void __iomem *b=
ase, u8 timer,
> >   	       base + TIMER_CTL_REG(timer));
> >   }
> > +static inline void sun4i_timer_save_regs(struct timer_of *to)
> > +{
> > +	void __iomem *base =3D timer_of_base(to);
> > +	int i;
> > +	u32 *regs_backup =3D (u32 *)to->private_data;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(sun4i_timer_regs_offset); i++)
> > +		regs_backup[i] =3D readl(base + sun4i_timer_regs_offset[i]);
> > +}
> > +
> > +static inline void sun4i_timer_restore_regs(struct timer_of *to)
> > +{
> > +	void __iomem *base =3D timer_of_base(to);
> > +	int i;
> > +	u32 *regs_backup =3D (u32 *)to->private_data;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(sun4i_timer_regs_offset); i++)
> > +		writel(regs_backup[i], base + sun4i_timer_regs_offset[i]);
> > +}
> > +
> >   static int sun4i_clkevt_shutdown(struct clock_event_device *evt)
> >   {
> >   	struct timer_of *to =3D to_timer_of(evt);
> > +	sun4i_timer_save_regs(to);
> > +	sun4i_clkevt_time_stop(timer_of_base(to), 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int sun4i_tick_resume(struct clock_event_device *evt)
> > +{
> > +	struct timer_of *to =3D to_timer_of(evt);
> > +
> > +	sun4i_timer_restore_regs(to);
> >   	sun4i_clkevt_time_stop(timer_of_base(to), 0);
> >   	return 0;
> > @@ -137,45 +181,54 @@ static irqreturn_t sun4i_timer_interrupt(int irq,=
 void *dev_id)
> >   	return IRQ_HANDLED;
> >   }
> > -static struct timer_of to =3D {
> > -	.flags =3D TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
> > -
> > -	.clkevt =3D {
> > -		.name =3D "sun4i_tick",
> > -		.rating =3D 350,
> > -		.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> > -		.set_state_shutdown =3D sun4i_clkevt_shutdown,
> > -		.set_state_periodic =3D sun4i_clkevt_set_periodic,
> > -		.set_state_oneshot =3D sun4i_clkevt_set_oneshot,
> > -		.tick_resume =3D sun4i_clkevt_shutdown,
> > -		.set_next_event =3D sun4i_clkevt_next_event,
> > -		.cpumask =3D cpu_possible_mask,
> > -	},
> > -
> > -	.of_irq =3D {
> > -		.handler =3D sun4i_timer_interrupt,
> > -		.flags =3D IRQF_TIMER | IRQF_IRQPOLL,
> > -	},
> > -};
> > +static void __init sun4i_clockevent_init(struct timer_of *to)
> > +{
> > +	to->clkevt.name =3D "sun4i_tick";
> > +	to->clkevt.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONES=
HOT;
> > +	to->clkevt.set_state_shutdown =3D sun4i_clkevt_shutdown;
> > +	to->clkevt.set_state_periodic =3D sun4i_clkevt_set_periodic;
> > +	to->clkevt.set_state_oneshot =3D sun4i_clkevt_set_oneshot;
> > +	to->clkevt.tick_resume =3D sun4i_tick_resume;
> > +	to->clkevt.set_next_event =3D sun4i_clkevt_next_event;
> > +	to->clkevt.cpumask =3D cpu_possible_mask;
> > +	to->of_irq.flags =3D IRQF_TIMER | IRQF_IRQPOLL;
> > +
> > +	sun4i_timer_sched_base =3D timer_of_base(to) + TIMER_CNTVAL_REG(1);
> > +}
> >   static u64 notrace sun4i_timer_sched_read(void)
> >   {
> > -	return ~readl(timer_of_base(&to) + TIMER_CNTVAL_REG(1));
> > +	return (u64)~readl(sun4i_timer_sched_base);
> >   }
> >   static int __init sun4i_timer_init(struct device_node *node)
> >   {
> > +	struct timer_of *to;
> >   	int ret;
> >   	u32 val;
> > -	ret =3D timer_of_init(node, &to);
> > +	to =3D kzalloc(sizeof(*to), GFP_KERNEL);
> > +	if (!to)
> > +		return -ENOMEM;
> > +
> > +	to->flags =3D TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE;
> > +	to->of_irq.handler =3D sun4i_timer_interrupt;
> > +	ret =3D timer_of_init(node, to);
> >   	if (ret)
> > -		return ret;
> > +		goto err;
> > -	writel(~0, timer_of_base(&to) + TIMER_INTVAL_REG(1));
> > +	sun4i_clockevent_init(to);
> > +
> > +	to->private_data =3D kcalloc(ARRAY_SIZE(sun4i_timer_regs_offset), siz=
eof(u32), GFP_KERNEL);
> > +	if (!to->private_data) {
> > +		ret =3D -ENOMEM;
> > +		goto err1;
> > +	}
> > +
> > +	writel(~0, timer_of_base(to) + TIMER_INTVAL_REG(1));
> >   	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD |
> >   	       TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
> > -	       timer_of_base(&to) + TIMER_CTL_REG(1));
> > +	       timer_of_base(to) + TIMER_CTL_REG(1));
> >   	/*
> >   	 * sched_clock_register does not have priorities, and on sun6i and
> > @@ -186,32 +239,40 @@ static int __init sun4i_timer_init(struct device_=
node *node)
> >   	    of_machine_is_compatible("allwinner,sun5i-a10s") ||
> >   	    of_machine_is_compatible("allwinner,suniv-f1c100s"))
> >   		sched_clock_register(sun4i_timer_sched_read, 32,
> > -				     timer_of_rate(&to));
> > +				     timer_of_rate(to));
> > -	ret =3D clocksource_mmio_init(timer_of_base(&to) + TIMER_CNTVAL_REG(1=
),
> > -				    node->name, timer_of_rate(&to), 350, 32,
> > +	ret =3D clocksource_mmio_init(timer_of_base(to) + TIMER_CNTVAL_REG(1),
> > +				    node->name, timer_of_rate(to), 350, 32,
> >   				    clocksource_mmio_readl_down);
> >   	if (ret) {
> >   		pr_err("Failed to register clocksource\n");
> > -		return ret;
> > +		goto err2;
> >   	}
> >   	writel(TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
> > -	       timer_of_base(&to) + TIMER_CTL_REG(0));
> > +	       timer_of_base(to) + TIMER_CTL_REG(0));
> >   	/* Make sure timer is stopped before playing with interrupts */
> > -	sun4i_clkevt_time_stop(timer_of_base(&to), 0);
> > +	sun4i_clkevt_time_stop(timer_of_base(to), 0);
> >   	/* clear timer0 interrupt */
> > -	sun4i_timer_clear_interrupt(timer_of_base(&to));
> > +	sun4i_timer_clear_interrupt(timer_of_base(to));
> > -	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> > +	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
> >   					TIMER_SYNC_TICKS, 0xffffffff);
> >   	/* Enable timer0 interrupt */
> > -	val =3D readl(timer_of_base(&to) + TIMER_IRQ_EN_REG);
> > -	writel(val | TIMER_IRQ_EN(0), timer_of_base(&to) + TIMER_IRQ_EN_REG);
> > +	val =3D readl(timer_of_base(to) + TIMER_IRQ_EN_REG);
> > +	writel(val | TIMER_IRQ_EN(0), timer_of_base(to) + TIMER_IRQ_EN_REG);
> > +
> > +	return ret;
> > +err2:
> > +	kfree(to->private_data);
> > +err1:
> > +	timer_of_cleanup(to);
> > +err:
> > +	kfree(to);
> >   	return ret;
> >   }
> >   TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
>=20
> Hi Maxime,
> Sorry to disturb. Just want to say that I'm looking forward to your
> advice on this patch. Thank you : )

I'm not the maintainer anymore. Jernej, Samuel and Daniel are the ones
you should seek review from :)

Maxime
