Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C56DDD06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjDKN5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjDKN5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:57:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177B619AF;
        Tue, 11 Apr 2023 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681221395; x=1712757395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVHxEPoTlOu2ZeEhIlwU729M1yFF4Fc4PIgiXba8dj4=;
  b=Vt+4/SyWkE84p+1jsqVmGdZaQM+F6AflBhraSoKxW4n4WP12I2iqirgz
   L9HDOoxeWIM1yE72Q2L4kmclcnfbNlxT7yY3nHVwLAvTPSJD1d7yLKF3J
   tMyQzp7Fkw/TYiHQS3dX3uiwRIC1zCuU701q1+0+ccal2djn7/J5QdtL2
   +qYm/HPEAaPT7dtmORYlKjBfNa3UytaRHf/YqaYgsXGcylTXBMWLP3pOI
   9qRILcwCXO+913W1c69lXUOFKDvao6CzIYvJvKUetI/9C4yke9/64wQfd
   3J7gEc9Uux/7QmIXbV1WQtHE9yNPwqgswRHrpUwtCm1jp1VR9F2KW7QBF
   w==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673938800"; 
   d="asc'?scan'208";a="220366966"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2023 06:56:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Apr 2023 06:56:31 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Apr 2023 06:56:30 -0700
Date:   Tue, 11 Apr 2023 14:56:15 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v16 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230411-ligament-wagon-6c8cacb966e8@wendy>
References: <20230411-wizard-cautious-3c048db6b4d2@wendy>
 <20230411-bronzing-crust-d302408a1259@wendy>
 <20230411105547.ypkktubgfx4jfen3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HE15B+KGsyyRolbk"
Content-Disposition: inline
In-Reply-To: <20230411105547.ypkktubgfx4jfen3@pengutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--HE15B+KGsyyRolbk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Uwe,

On Tue, Apr 11, 2023 at 12:55:47PM +0200, Uwe Kleine-K=F6nig wrote:
> On Tue, Apr 11, 2023 at 09:56:34AM +0100, Conor Dooley wrote:
> > Add a driver that supports the Microchip FPGA "soft" PWM IP core.
> >=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  drivers/pwm/Kconfig              |  10 +
> >  drivers/pwm/Makefile             |   1 +
> >  drivers/pwm/pwm-microchip-core.c | 509 +++++++++++++++++++++++++++++++
> >  3 files changed, 520 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-microchip-core.c
> >=20
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index dae023d783a2..f42756a014ed 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -393,6 +393,16 @@ config PWM_MEDIATEK
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-mediatek.
> > =20
> > +config PWM_MICROCHIP_CORE
> > +	tristate "Microchip corePWM PWM support"
> > +	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
> > +	depends on HAS_IOMEM && OF
> > +	help
> > +	  PWM driver for Microchip FPGA soft IP core.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-microchip-core.
> > +
> >  config PWM_MXS
> >  	tristate "Freescale MXS PWM support"
> >  	depends on ARCH_MXS || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 7bf1a29f02b8..a65625359ece 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -34,6 +34,7 @@ obj-$(CONFIG_PWM_LPSS_PCI)	+=3D pwm-lpss-pci.o
> >  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+=3D pwm-lpss-platform.o
> >  obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
> >  obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
> > +obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D pwm-microchip-core.o
> >  obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
> >  obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
> >  obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
> > diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microch=
ip-core.c
> > new file mode 100644
> > index 000000000000..0a69ec376c51
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-microchip-core.c
> > @@ -0,0 +1,509 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * corePWM driver for Microchip "soft" FPGA IP cores.
> > + *
> > + * Copyright (c) 2021-2023 Microchip Corporation. All rights reserved.
> > + * Author: Conor Dooley <conor.dooley@microchip.com>
> > + * Documentation:
> > + * https://www.microsemi.com/document-portal/doc_download/1245275-core=
pwm-hb
> > + *
> > + * Limitations:
> > + * - If the IP block is configured without "shadow registers", all reg=
ister
> > + *   writes will take effect immediately, causing glitches on the outp=
ut.
> > + *   If shadow registers *are* enabled, a write to the "SYNC_UPDATE" r=
egister
> > + *   notifies the core that it needs to update the registers defining =
the
> > + *   waveform from the contents of the "shadow registers".
>=20
> You only write once to the sync update register (i.e. during probe). So
> that register specifies that a period should be completed before a new
> setting becomes active, right?

Correct.

> Even with sync update this is still racy, right?

I assume the period ticking over as we are updating the values is your
concern here. I'm not sure that there's all that much we can do about
that, so I guess I shall update the comment.
Perhaps writing out period_steps and prescale should be done after
computing the new duty cycle to reduce the possible window since that
may require an expensive division on a 32-bit arch?

> > + * - The IP block has no concept of a duty cycle, only rising/falling =
edges of
> > + *   the waveform. Unfortunately, if the rising & falling edges regist=
ers have
> > + *   the same value written to them the IP block will do whichever of =
a rising
> > + *   or a falling edge is possible. I.E. a 50% waveform at twice the r=
equested
> > + *   period. Therefore to get a 0% waveform, the output is set the max=
 high/low
> > + *   time depending on polarity.
> > + *   If the duty cycle is 0%, and the requested period is less than the
> > + *   available period resolution, this will manifest as a ~100% wavefo=
rm (with
> > + *   some output glitches) rather than 50%.
>=20
> The last paragraph refers to negedge =3D 0, posedge =3D 0 and period_step=
s =3D
> 0?

Yes. Although, I did some poking around with it just now & that actually
only happens if prescale is also 0.
If it is non-zero, get to see some other "interesting behaviour" where
the period becomes gigantic - for example @ prescale =3D 0x3, the period
becomes about a quarter of a second w/ a 50% duty cycle. clk_rate is
62.5 MHz. I'd need to dig out the RTL to justify that one!

I've just gone and made apply() return -EINVAL for this, which the
subsystem does for requests of zero periods.

> > + * - The PWM period is set for the whole IP block not per channel. The=
 driver
> > + *   will only change the period if no other PWM output is enabled.
> > + */
>=20
> > +static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> > +				 bool enable, u64 period)
> > +{
> > +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> > +	u8 channel_enable, reg_offset, shift;
> > +
> > +	/*
> > +	 * There are two adjacent 8 bit control regs, the lower reg controls
> > +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
> > +	 * and if so, offset by the bus width.
> > +	 */
> > +	reg_offset =3D MCHPCOREPWM_EN(pwm->hwpwm >> 3);
> > +	shift =3D pwm->hwpwm & 7;
> > +
> > +	channel_enable =3D readb_relaxed(mchp_core_pwm->base + reg_offset);
> > +	channel_enable &=3D ~(1 << shift);
> > +	channel_enable |=3D (enable << shift);
> > +
> > +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
> > +	mchp_core_pwm->channel_enabled &=3D ~BIT(pwm->hwpwm);
> > +	mchp_core_pwm->channel_enabled |=3D enable << pwm->hwpwm;
> > +
> > +	/*
> > +	 * Notify the block to update the waveform from the shadow registers.
> > +	 * The updated values will not appear on the bus until they have been
> > +	 * applied to the waveform at the beginning of the next period.
> > +	 * This is a NO-OP if the channel does not have shadow registers.
> > +	 */
>=20
> The code doesn't match the comment. I think that is a relict from the
> times when we thought that a trigger was necessary to update the
> operating settings from the shadow registers?

Yeah, I read this back to myself before sending v15 & thought that it
didn't need to be changed. I think removing the first line should go.

>=20
> > +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm))
> > +		mchp_core_pwm->update_timestamp =3D ktime_add_ns(ktime_get(), period=
);
> > +}
> > +
> > +static void mchp_core_pwm_wait_for_sync_update(struct mchp_core_pwm_ch=
ip *mchp_core_pwm,
> > +					       unsigned int channel)
> > +{
> > +	/*
> > +	 * If a shadow register is used for this PWM channel, and iff there is
> > +	 * a pending update to the waveform, we must wait for it to be applied
> > +	 * before attempting to read its state. Reading the registers yields
> > +	 * the currently implemented settings & the new ones are only readable
> > +	 * once the current period has ended.
> > +	 */
> > +
> > +	if (mchp_core_pwm->sync_update_mask & (1 << channel)) {
> > +		ktime_t current_time =3D ktime_get();
> > +		s64 remaining_ns;
> > +		u32 delay_us;
> > +
> > +		remaining_ns =3D ktime_to_ns(ktime_sub(mchp_core_pwm->update_timesta=
mp,
> > +						     current_time));
> > +
> > +		/*
> > +		 * If the update has gone through, don't bother waiting for
> > +		 * obvious reasons. Otherwise wait around for an appropriate
> > +		 * amount of time for the update to go through.
> > +		 */
> > +		if (remaining_ns <=3D 0)
> > +			return;
> > +
> > +		delay_us =3D DIV_ROUND_UP_ULL(remaining_ns, NSEC_PER_USEC);
> > +		fsleep(delay_us);
> > +	}
>=20
> There is no way to query the hardware if there is still an update
> pending, right?

Hah, no. This IP is about as old as I am & appears to have been written
with keeping the FPGA utilisation % to a minimum. No such luxuries!

> Maybe that's possible implicitly by memoizing the
> expected read value? For me the current approach is fine enough though.
> This can be addressed in the future if needed.
>=20
> > +static u64 mchp_core_pwm_calc_duty(const struct pwm_state *state, u64 =
clk_rate,
> > +				   u8 prescale, u8 period_steps)
> > +{
> > +	u64 duty_steps, tmp;
> > +
> > +	/*
> > +	 * Calculate the duty cycle in multiples of the prescaled period:
> > +	 * duty_steps =3D duty_in_ns / step_in_ns
> > +	 * step_in_ns =3D (prescale * NSEC_PER_SEC) / clk_rate
> > +	 * The code below is rearranged slightly to only divide once.
> > +	 */
> > +	tmp =3D (prescale + 1) * NSEC_PER_SEC;
> > +	duty_steps =3D mul_u64_u64_div_u64(state->duty_cycle, clk_rate, tmp);
> > +
> > +	return duty_steps;
> > +}
> > +
> > +static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct pwm=
_device *pwm,
> > +				     const struct pwm_state *state, u64 duty_steps,
> > +				     u16 period_steps)
> > +{
> > +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> > +	u8 posedge, negedge;
> > +	u8 first_edge =3D 0, second_edge =3D duty_steps;
> > +
> > +	/*
> > +	 * Setting posedge =3D=3D negedge doesn't yield a constant output,
> > +	 * so that's an unsuitable setting to model duty_steps =3D 0.
> > +	 * In that case set the unwanted edge to a value that never
> > +	 * triggers.
> > +	 */
> > +	if (duty_steps =3D=3D 0)
> > +		first_edge =3D period_steps + 1;
> > +
> > +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> > +		negedge =3D first_edge;
> > +		posedge =3D second_edge;
> > +	} else {
> > +		posedge =3D first_edge;
> > +		negedge =3D second_edge;
> > +	}
> > +
> > +	writel_relaxed(posedge, mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm=
->hwpwm));
> > +	writel_relaxed(negedge, mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm=
->hwpwm));
>=20
> Is this racy with sync update implemented in the firmware? A comment
> about how the sync update is implemented would be good.

Unless this is a different fear of racing, see above.

> > +}
> > +
> > +static int mchp_core_pwm_calc_period(const struct pwm_state *state, un=
signed long clk_rate,
> > +				     u16 *prescale, u16 *period_steps)
> > +{
> > +	u64 tmp;
> > +	u32 remainder;
> > +
> > +	/*
> > +	 * Calculate the period cycles and prescale values.
> > +	 * The registers are each 8 bits wide & multiplied to compute the per=
iod
> > +	 * using the formula:
> > +	 *           (prescale + 1) * (period_steps + 1)
> > +	 * period =3D -------------------------------------
> > +	 *                      clk_rate
> > +	 * so the maximum period that can be generated is 0x10000 times the
> > +	 * period of the input clock.
> > +	 * However, due to the design of the "hardware", it is not possible to
> > +	 * attain a 100% duty cycle if the full range of period_steps is used.
> > +	 * Therefore period_steps is restricted to 0xfe and the maximum multi=
ple
> > +	 * of the clock period attainable is (0xff + 1) * (0xfe + 1) =3D 0xff=
00
> > +	 *
> > +	 * The prescale and period_steps registers operate similarly to
> > +	 * CLK_DIVIDER_ONE_BASED, where the value used by the hardware is that
> > +	 * in the register plus one.
> > +	 * It's therefore not possible to set a period lower than 1/clk_rate,=
 so
> > +	 * if tmp is 0, abort. Without aborting, we will set a period that is
> > +	 * greater than that requested and, more importantly, will trigger the
> > +	 * neg-/pos-edge issue described in the limitations.
> > +	 */
> > +	tmp =3D mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
> > +	if (!tmp)
> > +		return -EINVAL;
> > +
> > +	if (tmp >=3D MCHPCOREPWM_PERIOD_MAX) {
> > +		*prescale =3D MCHPCOREPWM_PRESCALE_MAX;
> > +		*period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX;
> > +
> > +		return 0;
> > +	}
> > +
> > +	/*
> > +	 * There are multiple strategies that could be used to choose the
> > +	 * prescale & period_steps values.
> > +	 * Here the idea is to pick values so that the selection of duty cycl=
es
> > +	 * is as finegrain as possible.
> > +	 * This "optimal" value for prescale can be calculated using the maxi=
mum
> > +	 * permitted value of period_steps, 0xfe.
> > +	 *
> > +	 *                period * clk_rate
> > +	 * prescale =3D ------------------------- - 1
> > +	 *            NSEC_PER_SEC * (0xfe + 1)
> > +	 *
> > +	 * However, we are purely interested in the integer upper bound of th=
is
> > +	 * calculation, so this division should be rounded up before subtract=
ing
> > +	 * 1
> > +	 *
> > +	 *  period * clk_rate
> > +	 * ------------------- was precomputed as `tmp`
> > +	 *    NSEC_PER_SEC
> > +	 */
> > +	*prescale =3D DIV64_U64_ROUND_UP(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX + =
1) - 1;
>=20
> If state->period * clk_rate is 765000000001 you get tmp =3D 765 and then
> *prescale =3D 2. However roundup(765000000001 / (1000000000 * 255)) - 1 is
> 3. The problem here is that you're rounding down in the calculation of
> tmp. Of course this is constructed because 765000000001 is prime, but
> I'm sure you get the point :-)

Hold that thought for a moment..

> Also we know that tmp is < 0xff00, so we don't need a 64 bit division
> here.

Neither here nor below, true.

> > +	/*
> > +	 * Because 0xff is not a permitted value some error will seep into the
> > +	 * calculation of prescale as prescale grows. Specifically, this error
> > +	 * occurs where the remainder of the prescale calculation is less than
> > +	 * prescale.
> > +	 * For small values of prescale, only a handful of values will need
> > +	 * correction, but overall this applies to almost half of the valid
> > +	 * values for tmp.
> > +	 *
> > +	 * To keep the algorithm's decision making consistent, this case is
> > +	 * checked for and the simple solution is to, in these cases,
> > +	 * decrement prescale and check that the resulting value of period_st=
eps
> > +	 * is valid.
> > +	 *
> > +	 * period_steps can be computed from prescale:
> > +	 *                      period * clk_rate
> > +	 * period_steps =3D ----------------------------- - 1
> > +	 *                NSEC_PER_SEC * (prescale + 1)
> > +	 *
> > +	 */
> > +	div_u64_rem(tmp, (MCHPCOREPWM_PERIOD_STEPS_MAX + 1), &remainder);
> > +	if (remainder < *prescale) {
> > +		u16 smaller_prescale =3D *prescale - 1;
> > +
> > +		*period_steps =3D div_u64(tmp, smaller_prescale + 1) - 1;
> > +		if (*period_steps < 255) {
> > +			*prescale =3D smaller_prescale;
> > +
> > +			return 0;
> > +		}
> > +	}

=2E..so in your prime case above, we would initially compute a prescale
value that is too large, and then wind up hitting the test of the
remainder here, thereby realising that the smaller prescale value is a
better fit?
Perhaps that's not an acceptable way to handle the issue though.

> I don't understand that part. It triggers for tmp =3D 511. So you prefer
>=20
> 	prescale =3D 1
> 	period_steps =3D 254
>=20
> yielding period =3D 510 / clkrate over
>=20
> 	prescale =3D 2
> 	period_steps =3D 170
>=20
> yielding 513 / clkrate. I wonder why.

Because 513 > 511 & 254 > 170!
Is the aim not to produce a period that is less than or equal to that
requested? The aim of this driver is to pick a prescale/period_steps
combo that satisfies that constraint, while also trying to maximise the
"finegrainness" of the duty cycle.
The latter should be stated in a comment above.


> Alsot tmp =3D 511 is the only value
> where this triggers. There is a mistake somewhere (maybe on my side).

It should trigger for any value 255 * n < x < 256 * n, no?
Say for tmp of 767:
*prescale =3D DIV64_U64_ROUND_UP(767, 254 + 1) - 1 =3D DIV64_U64_ROUND_UP(3=
=2E00784...) - 1 =3D 3
remainder =3D 0.00784.. * (254 + 1) =3D 2

Am I going nuts? Wouldn't be the first time that I've made a hames of
things here, there are 16 versions for a reason after all.

Cheers,
Conor.

--HE15B+KGsyyRolbk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDVm/gAKCRB4tDGHoIJi
0rnXAP432Ilc1lEPuAtQvIcjFRrQHek4R/bTEnYbc9wwAWMFWAD/TFTgMEAbXsk6
p/Mc9BkOy98FrJzQdU5MeLp7H/Dt/gc=
=QtNW
-----END PGP SIGNATURE-----

--HE15B+KGsyyRolbk--
