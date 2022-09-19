Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB75BCEC4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiISO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiISO3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:29:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91761A44C;
        Mon, 19 Sep 2022 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663597782; x=1695133782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IsiSELyQZHXzhmHlKNVp/4AhfXD4NvYslEVAsWis7tk=;
  b=hSYN5OONx1NwFdMUuG1qZ5FbsNsWASEzmfBmfjW3WD7IZ0N0OiXmTcis
   /mwHd+dBTr4vc87jYiebps15WimfFBqIiXm+9TETlqoDuJR3kxdYm095Z
   YNeMs/F9uolO7U7xNUF89/cRP7w4icZbJGzavP1CqMrvZECmGDPjp1cny
   Nk5vhufAnE5zKZKeXegurla6Mue6x0rT2ss9dXZD1gIvnWgYn6LCxUwDV
   GQOjsV9DjXp7kdqOjuxd15PjHTfTlC8m1g5kKx1Q7yC72Ppwe+Ir1jHdu
   p5wb/qgiyJGuG22kABj6ljPEh1nAQKnYKP0Xydhnq0sW9mfHriglP9uUG
   A==;
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="181099035"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2022 07:29:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 19 Sep 2022 07:29:41 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 19 Sep 2022 07:29:39 -0700
Date:   Mon, 19 Sep 2022 15:29:19 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v10 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <Yyh8v+MtHuc0LLf0@wendy>
References: <20220824091215.141577-1-conor.dooley@microchip.com>
 <20220824091215.141577-4-conor.dooley@microchip.com>
 <20220915072152.y346csakn7wetpz5@pengutronix.de>
 <YyhmZBmfJvJ9/vBg@wendy>
 <20220919135008.sahwmwbfwvgplji4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220919135008.sahwmwbfwvgplji4@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Uwe,

On Mon, Sep 19, 2022 at 03:50:08PM +0200, Uwe Kleine-König wrote:
> On Mon, Sep 19, 2022 at 01:53:56PM +0100, Conor Dooley wrote:
> > Hey Uwe,
> > Thanks (as always). I've switched up my email setup a bit so I hope
> > that I've not mangled anything here.
> > 
> > On Thu, Sep 15, 2022 at 09:21:52AM +0200, Uwe Kleine-König wrote:
> > > Hello,
> > > 
> > > On Wed, Aug 24, 2022 at 10:12:14AM +0100, Conor Dooley wrote:
> > > > Add a driver that supports the Microchip FPGA "soft" PWM IP core.
> > > > 
> > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > >  drivers/pwm/Kconfig              |  10 +
> > > >  drivers/pwm/Makefile             |   1 +
> > > >  drivers/pwm/pwm-microchip-core.c | 402 +++++++++++++++++++++++++++++++
> > > >  3 files changed, 413 insertions(+)
> > > >  create mode 100644 drivers/pwm/pwm-microchip-core.c
> > > > 
> > 
> > > > +static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > +			       const struct pwm_state *state)
> > > > +{
> > > > +	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
> > > > +	struct pwm_state current_state = pwm->state;
> > > > +	bool period_locked;
> > > > +	u64 duty_steps;
> > > > +	u16 prescale;
> > > > +	u8 period_steps;
> > > > +	int ret;
> > > > +
> > > > +	mutex_lock(&mchp_core_pwm->lock);
> > > > +
> > > > +	if (!state->enabled) {
> > > > +		mchp_core_pwm_enable(chip, pwm, false, current_state.period);
> > > > +		mutex_unlock(&mchp_core_pwm->lock);
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * If the only thing that has changed is the duty cycle or the polarity,
> > > > +	 * we can shortcut the calculations and just compute/apply the new duty
> > > > +	 * cycle pos & neg edges
> > > > +	 * As all the channels share the same period, do not allow it to be
> > > > +	 * changed if any other channels are enabled.
> > > > +	 * If the period is locked, it may not be possible to use a period
> > > > +	 * less than that requested. In that case, we just abort.
> > > > +	 */
> > > > +	period_locked = mchp_core_pwm->channel_enabled & ~(1 << pwm->hwpwm);
> > > > +
> > > > +	if (period_locked) {
> > > > +		u16 hw_prescale;
> > > > +		u8 hw_period_steps;
> > > > +
> > > > +		mchp_core_pwm_calc_period(chip, state, (u8 *)&prescale, &period_steps);
> > > 
> > > Huh, if (u8 *)&prescale works depends on endianness.
> > 
> > Big endian? What's that? ;)
> > I think the cast can just be dropped and the u16 used directly instead.
> > 
> > > 
> > > > +		hw_prescale = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
> > > > +		hw_period_steps = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
> > > > +
> > > > +		if ((period_steps + 1) * (prescale + 1) <
> > > > +		    (hw_period_steps + 1) * (hw_prescale + 1)) {
> > > > +			mutex_unlock(&mchp_core_pwm->lock);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +
> > > > +		/*
> > > > +		 * It is possible that something could have set the period_steps
> > > 
> > > My German feel for the English language says s/could have/has/
> > 
> > What I wrote is _fine_ but the could is redudant given the possible.
> > I'll change it over.
> > 
> > > > +		 * register to 0xff, which would prevent us from setting a 100%
> > > 
> > > For my understanding: It would also prevent a 0% relative duty, right?
> > 
> > Yeah, I guess the comment could reflect that.
> > 
> > > 
> > > > +		 * duty cycle, as explained in the mchp_core_pwm_calc_period()
> > > 
> > > s/duty/relative duty/; s/the //
> > > 
> > > > +		 * above.
> > > > +		 * The period is locked and we cannot change this, so we abort.
> > > > +		 */
> > > > +		if (period_steps == MCHPCOREPWM_PERIOD_STEPS_MAX) {
> > > 
> > > Don't you need to check hw_period_steps == MCHPCOREPWM_PERIOD_STEPS_MAX
> > > here?
> > 
> > D'oh.
> > 
> > > 
> > > > +			mutex_unlock(&mchp_core_pwm->lock);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +
> > > > +		prescale = hw_prescale;
> > > > +		period_steps = hw_period_steps;
> > > > +	} else if (!current_state.enabled || current_state.period != state->period) {
> > > > +		ret = mchp_core_pwm_calc_period(chip, state, (u8 *)&prescale, &period_steps);
> > > 
> > > ret is only used in this block, so the declaration can go into here,
> > > too.
> > > 
> > > > +		if (ret) {
> > > > +			mutex_unlock(&mchp_core_pwm->lock);
> > > > +			return ret;
> > > > +		}
> > > > +		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
> > > > +	} else {
> > > > +		prescale = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
> > > > +		period_steps = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
> > > > +		/*
> > > > +		 * As above, it is possible that something could have set the
> > > > +		 * period_steps register to 0xff, which would prevent us from
> > > > +		 * setting a 100% duty cycle, as explained above.
> > > > +		 * As the period is not locked, we are free to fix this.
> > > > +		 */
> > > 
> > > Are you sure this is safe? I think it isn't. Consider:
> > > 
> > > 	pwm_apply_state(mypwm, { .duty = 0, .period = A, .enabled = true, });
> > > 	pwm_apply_state(mypwm, { .duty = 0, .period = B, .enabled = false, });
> > > 	pwm_apply_state(mypwm, { .duty = 0, .period = B, .enabled = true, });
> > > 
> > > Then you have in the third call prescale and period_steps still
> > > corresponding to A because you didn't update these registers in the 2nd
> > > call as you exited early.
> > 
> > Riiight. I think I am a little confused here - this comment does not
> > refer to my comment but rather to the whole logic I have?
> > 
> > As in, what you're concerned about is the early exit if the state is
> > disabled & that I take the values in the hardware as accurate?
> 
> No, the thing I'm concerned about is assuming MCHPCOREPWM_PRESCALE and
> MCHPCOREPWM_PERIOD correspond to state->period. So I'd drop the last
> block use the 2nd last instead without further condition.

So, if the period isn't locked always re-configure it. Makes life easier
for me.

> 
> > What makes sense to me to do here (assuming I understood correctly)
> > is to compare state->period against what is in the hardare rather than
> > against what the pwm core thinks?
> > Or else I could stop exiting early if the pwm is to be disabled &
> > instead allow the period and duty to be set so that the state of the
> > hardware is as close to the pwm core's representation of it as possible.
> 
> exiting early is fine.
>  
> > > > [...]
> > > > +	period_steps = PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD));
> > > > +	state->period = period_steps * prescale * NSEC_PER_SEC;
> > > 
> > > This is broken on 32 bit archs (here: arm):
> > > 
> > > $ cat test.c
> > > #include <inttypes.h>
> > > #include <stdio.h>
> > > #include <stdlib.h>
> > > 
> > > int main(int argc, char *argv[])
> > > {
> > > 	uint8_t period_steps = atoi(argv[1]);
> > > 	uint16_t prescale = atoi(argv[2]);
> > > 	uint64_t period;
> > > 
> > > 	period = period_steps * prescale * 1000000000L;
> > > 
> > > 	printf("period_steps = %" PRIu8 "\n", period_steps);
> > > 	printf("prescale = %" PRIu16 "\n", prescale);
> > > 	printf("period = %" PRIu64 "\n", period);
> > > 
> > > 	return 0;
> > > }
> > > 
> > > $ make test
> > > cc     test.c   -o test
> > > 
> > > $ ./test 255 65535
> > > period_steps = 255
> > > prescale = 65535
> > > period = 18446744073018591744
> > > 
> > > The problem is that the result of 16711425 * 1000000000L isn't affected
> > > by the type of period and so it's promoted to L which isn't big enough
> > > to hold 16711425000000000 where longs are only 32 bit wide.
> > 
> > I don't think this is ever going to be hit in the wild, since prescale
> > comes from the hardware where it is limited to 255 - but preventing the
> > issue seems trivially done by splitting the multiplication so no reason
> > not to. Thanks for providing the test program btw :)
> 
> Even 255 * 255 * 1000000000 overflows. With a maintainer's hat on, it is
> very valuable to prevent such issues because your driver might be used
> as a template for the next driver.
> 
> > > > +	state->period = DIV64_U64_ROUND_UP(state->period, clk_get_rate(mchp_core_pwm->clk));
> > > > +
> > > > +	posedge = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->hwpwm));
> > > > +	negedge = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->hwpwm));
> > > > +
> > > > +	if ((negedge == posedge) && state->enabled) {
> > > 
> > > Why do you need that state->enabled?
> > 
> > Because I was running into conflicts between the reporting here and some
> > of the checks that I have added to prevent the PWM being put into an
> > invalid state. On boot both negedge and posedge will be zero & this was
> > preventing me from setting the period at all.
> 
> I don't understood that.

On startup, (negedge == posedge) is true as both are zero, but the reset
values for prescale and period are actually 0x8. If on reset I try to
set a small period, say "echo 1000 > period" apply() returns -EINVAL
because of a check in the pwm core in pwm_apply_state() as I am
attempting to set the period to lower than the out-of-reset duty cycle.

I considered zeroing the registers, but if something below Linux had
been using the PWM I felt that may not be the right thing to do. Can I
continue to check for the enablement here or would you rather I did
something different?

Thanks,
Conor.

