Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D749642BAC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiLEP11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiLEP06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:26:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00ED1E707;
        Mon,  5 Dec 2022 07:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670253917; x=1701789917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hSQqL6G6O6dHLpGgvVNcHoOq19ZeyXIBrs3i+gQxqeg=;
  b=jZUYnoV7hoBjdAbidTLO1Qp7tS3fUEgDUtqjHLdeNgGr7xzSh2uTQPid
   Q/WwJ+KeIJZ3ABGepCGW4KDgNNk3RjWUG2oyj22G31sBhTVsKHej6lgcr
   GhVzhK4FlCqZyjT8bnlxBEfvaOLLmMudoesK+pCw+ycvN4+02LFy74hJR
   KT13NwjdCGdi9W6ItYafv0IrMPXVHjJv2ypXb13CeXJUqGCmtF5o6RwMy
   pewErT4nS9TifnUPqFE0xtk3tQaF0ptQw4vWyWT1LhHiaNsA2XUB95au1
   sBsXIqEH4Bl7t4PWdWuM/0BseFr7SkujoS/g1SYzsDfzrDZADOoz62v4a
   w==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="asc'?scan'208";a="191756953"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Dec 2022 08:22:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Dec 2022 08:22:15 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Dec 2022 08:22:14 -0700
Date:   Mon, 5 Dec 2022 15:21:55 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Conor Dooley <conor@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v12 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <Y44Mk2nGu1Zeq7QQ@wendy>
References: <20221110093512.333881-1-conor.dooley@microchip.com>
 <20221110093512.333881-2-conor.dooley@microchip.com>
 <20221117164950.cssukd63fywzuwua@pengutronix.de>
 <Y3Zxkt3OSPQc46Q2@spud>
 <20221117210433.n5j7upqqksld42mu@pengutronix.de>
 <Y3avobkvYK3ydKTS@spud>
 <Y3uZY5mt/ZIWk3sS@wendy>
 <Y4coL74qQX80TNaT@wendy>
 <20221130103755.lhil2jaw3oufr2sf@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XXSnb1K2Eukxwzpi"
Content-Disposition: inline
In-Reply-To: <20221130103755.lhil2jaw3oufr2sf@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--XXSnb1K2Eukxwzpi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Uwe,

Preserving the context..

On Wed, Nov 30, 2022 at 11:37:55AM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Nov 30, 2022 at 09:53:51AM +0000, Conor Dooley wrote:
> > On Mon, Nov 21, 2022 at 03:29:39PM +0000, Conor Dooley wrote:
> > > On Thu, Nov 17, 2022 at 10:03:13PM +0000, Conor Dooley wrote:
> > > > On Thu, Nov 17, 2022 at 10:04:33PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > > On Thu, Nov 17, 2022 at 05:38:26PM +0000, Conor Dooley wrote:
> > > > > > On Thu, Nov 17, 2022 at 05:49:50PM +0100, Uwe Kleine-K=F6nig wr=
ote:
> > > > > > > Hello Conor,
> > > > > >=20
> > > > > > Hello Uwe,
> > > > > >=20
> > > > > > > On Thu, Nov 10, 2022 at 09:35:12AM +0000, Conor Dooley wrote:
> > > > > > > > [...]
> > > > > > > > +
> > > > > > > > +static void mchp_core_pwm_enable(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> > > > > > > > +				 bool enable, u64 period)
> > > > > > > > +{
> > > > > > > > +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core=
_pwm(chip);
> > > > > > > > +	u8 channel_enable, reg_offset, shift;
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * There are two adjacent 8 bit control regs, the lower r=
eg controls
> > > > > > > > +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the=
 upper reg
> > > > > > > > +	 * and if so, offset by the bus width.
> > > > > > > > +	 */
> > > > > > > > +	reg_offset =3D MCHPCOREPWM_EN(pwm->hwpwm >> 3);
> > > > > > > > +	shift =3D pwm->hwpwm & 7;
> > > > > > > > +
> > > > > > > > +	channel_enable =3D readb_relaxed(mchp_core_pwm->base + re=
g_offset);
> > > > > > > > +	channel_enable &=3D ~(1 << shift);
> > > > > > > > +	channel_enable |=3D (enable << shift);
> > > > > > > > +
> > > > > > > > +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_=
offset);
> > > > > > > > +	mchp_core_pwm->channel_enabled &=3D ~BIT(pwm->hwpwm);
> > > > > > > > +	mchp_core_pwm->channel_enabled |=3D enable << pwm->hwpwm;
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * Notify the block to update the waveform from the shado=
w registers.
> > > > > > > > +	 * The updated values will not appear on the bus until th=
ey have been
> > > > > > > > +	 * applied to the waveform at the beginning of the next p=
eriod. We must
> > > > > > > > +	 * write these registers and wait for them to be applied =
before
> > > > > > > > +	 * considering the channel enabled.
> > > > > > > > +	 * If the delay is under 1 us, sleep for at least 1 us an=
yway.
> > > > > > > > +	 */
> > > > > > > > +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> > > > > > > > +		u64 delay;
> > > > > > > > +
> > > > > > > > +		delay =3D div_u64(period, 1000u) ? : 1u;
> > > > > > > > +		writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYN=
C_UPD);
> > > > > > > > +		usleep_range(delay, delay * 2);
> > > > > > > > +	}
> > > > > > >=20
> > > > > > > In some cases the delay could be prevented. e.g. when going f=
rom one
> > > > > > > disabled state to another. If you don't want to complicate th=
e driver
> > > > > > > here, maybe point it out in a comment at least?
> > > > > >=20
> > > > > > Maybe this is my naivity talking, but I'd rather wait. Is there=
 not the
> > > > > > chance that we re-enter pwm_apply() before the update has actua=
lly gone
> > > > > > through?
> > > > >=20
> > > > > My idea was to do something like that:
> > > > >=20
> > > > > 	int mchp_core_pwm_apply(....)
> > > > > 	{
> > > > > 		if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> > > > > 			/*
> > > > > 			 * We're still waiting for an update, don't
> > > > > 			 * interfer until it's completed.
> > > > > 			 */
> > > > > 			while (readl_relaxed(mchp_core_pwm->base + MCHPCOREPWM_SYNC_UP=
D)) {
> > > > > 				cpu_relax();
> > > > > 				if (waited_unreasonably_long())
> > > > > 					return -ETIMEOUT;
> > > > > 			}
> > > > > 		}
> > > > >=20
> > > > > 		update_period_and_duty(...);
> > > > > 		return 0;
> > > > > 	}
> > >=20
> > > So I was doing some fiddling, and the following works reasonably well:
> > > 	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> > > 		u32 delay =3D MCHPCOREPWM_TIMEOUT_US;
> > > 		u32 sync_upd;
> > > 		int ret;
> > >=20
> > > 		writel_relaxed(1u, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> > >=20
> > > 		ret =3D read_poll_timeout(readl, sync_upd, !sync_upd, delay/100, de=
lay,
> > > 					false, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> > > 		if (ret)
> > > 			dev_dbg(mchp_core_pwm->chip.dev,
> > > 				"timed out waiting for shadow register sync\n");
> > > 	}
> > >=20
> > > but...
> > >=20
> > > > > This way you don't have to wait at all if the calls to pwm_apply(=
) are
> > > > > infrequent. Of course this only works this way, if you can determ=
ine if
> > > > > there is a pending update.
> > > >=20
> > > > Ah I think I get what you mean now about waiting for completion &
> > > > reading the bit. I don't know off the top of my head if that bit is
> > > > readable. Docs say that they're R/W but I don't know if that means =
that
> > > > an AXI read works or if the value is actually readable. I'll try
> > > > something like this if I can.
> > >=20
> > > ...it does not implement what I think you suggested & comes with the
> > > drawback of inconsistent behaviour depending on whether the timeout is
> > > hit or not.
> > >=20
> > > Instead, waiting in apply(), as you suggested, & get_state() looks to=
 be the
> > > better option, using the same sort of logic as above, say:
> > > static int mchp_core_pwm_wait_for_sync_update(struct mchp_core_pwm_ch=
ip *mchp_core_pwm,
> > > 					      unsigned int channel)
> > > {
> > > 	int ret;
> > >=20
> > > 	/*
> > > 	 * If a shadow register is used for this PWM channel, and iff there =
is
> > > 	 * a pending update to the waveform, we must wait for it to be appli=
ed
> > > 	 * before attempting to read its state, as reading the registers yie=
lds
> > > 	 * the currently implemented settings, the new ones are only readable
> > > 	 * once the current period has ended.
> > > 	 *
> > > 	 * Rather large delays are possible, in the seconds, so to avoid wai=
ting
> > > 	 * around for **too** long - cap the wait at 100 ms.
> > > 	 */
> > > 	if (mchp_core_pwm->sync_update_mask & (1 << channel)) {
> > > 		u32 delay =3D MCHPCOREPWM_TIMEOUT_US;
> > > 		u32 sync_upd;
> > >=20
> > > 		writel_relaxed(1u, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> > >=20
> > > 		ret =3D read_poll_timeout(readl, sync_upd, !sync_upd, delay/100, de=
lay,
> > > 					false, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> > > 		if (ret)
> > > 			return -ETIMEDOUT;
> > > 	}
> > >=20
> > > 	return 0;
> > > }
> > >=20
> > > I think that strikes a good balance? We return quickly & don't blocker
> > > the caller, but simultaneously try to prevent them from either trying=
 to
> > > apply new settings or get the current settings until the last request
> > > has gone though?
> > >=20
> > > get_state() returns void though, is it valid behaviour to wait for the
> > > timeout there?
>=20
> There was an approach to change that, see
> https://lore.kernel.org/linux-pwm/20220916151506.298488-1-u.kleine-koenig=
@pengutronix.de
>=20
> I need to send a v2.
>=20
> > > I had a check in the core code and found some places where the call in
> > > looks like:
> > > 	struct pwm_state s1, s2;=20
> > > 	chip->ops->get_state(chip, pwm, &s1);
> > > In this case, exiting early would leave us with a completely wrong
> > > idead of the state, if it was to time out.
> > >=20
> > > Either way, it seems like either way we would be misleading the caller
> > > of get_state() - perhaps the way around that is to do the wait & then
> > > just carry on with get_state()?
> > > In that scenario, you'd get the new settings where possible and the o=
ld ones
> > > otherwise.
> > > Returning if the timeout is hit would give you the new settings where=
 possible
> > > & otherwise you'd get whatever was passed to get_state().
> > > I'm not really sure which of those two situations would be preferred?
>=20
> Hmm, .get_state should not return the old state. We really want
> .get_state to return an error code. Maybe postpone that question until
> we have that?

I came into work today thinking that I could just rebase on top of your
patchset and send out a v13, but that was unfortunately not the case :/

So uh, it turns out that I was wrong about the behaviour of the
sync_update register's bit.
It turns out that that bit holds it's value until the IP block is reset,
and /does not/ get cleared at the start of the next period.
I'm really not sure how it worked when I tested the other week [0], so I
spent the first half of the day trying to figure out what on earth had
happened to my FPGA image. I must've picked the wrong image when I went
to test it the other week that had the wrong configuration somehow.

As a result, I've gone and hacked up another way of transferring the
burden of waiting - setting a timer for the period, backed by a
completion. get_state() and apply() now both check for the completion
and time out otherwise. I'm half tempted to tack RFC back onto the
series as I have not really messed with timers at all before and may
have done something off the wall.

I pushed it out (see [1] in case you'd like to look) so that the bots
can have a play with it, since it'll be a few weeks before I'll have a
chance to properly test that I've broken nothing with this.

It's not nearly as neat or contained, but still benefits from the
non-void get_state() & doesn't "confuse" a caller of get_state() with
some potential garbage.

The diff on top of the read_poll_timeout() approach from above is pasted
here. Hopefully I'll refine it a bit before sending a v13, checkpatch
may have an aneurysm with what's below. Or have a better idea and throw
it out..

Thanks again for sending that v2 ~immediately,
Conor.

0 - https://lore.kernel.org/linux-riscv/Y3uZY5mt%2FZIWk3sS@wendy/
1 - https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/tree/dr=
ivers/pwm/pwm-microchip-core.c?h=3Dpwm-dev-v13&id=3Dddbd59fb5480b1be74645f0=
a84d934b1f91d833d

diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-c=
ore.c
index c88fa8f8d96d..f565e8be46b3 100644
--- a/drivers/pwm/pwm-microchip-core.c
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -34,6 +34,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
+#include <linux/timer.h>
=20
 #define PREG_TO_VAL(PREG) ((PREG) + 1)
=20
@@ -47,12 +48,14 @@
 #define MCHPCOREPWM_POSEDGE(i)	(0x10 + 0x08 * (i)) /* 0x10, 0x18, ..., 0x8=
8 */
 #define MCHPCOREPWM_NEGEDGE(i)	(0x14 + 0x08 * (i)) /* 0x14, 0x1c, ..., 0x8=
c */
 #define MCHPCOREPWM_SYNC_UPD	0xe4
-#define MCHPCOREPWM_TIMEOUT_US	100000u
+#define MCHPCOREPWM_TIMEOUT_MS	100u
=20
 struct mchp_core_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
 	struct mutex lock; /* protect the shared period */
+	struct completion sync_update_complete;
+	struct timer_list sync_update_timer;
 	void __iomem *base;
 	u32 sync_update_mask;
 	u16 channel_enabled;
@@ -91,9 +94,54 @@ static void mchp_core_pwm_enable(struct pwm_chip *chip, =
struct pwm_device *pwm,
 	 * applied to the waveform at the beginning of the next period.
 	 * This is a NO-OP if the channel does not have shadow registers.
 	 */
+	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
+		u64 delay;
+
+		/* Have to convert to jiffies... */
+		delay =3D div_u64(period, 1000000u) ? : 1u;
+		reinit_completion(&mchp_core_pwm->sync_update_complete);
+		mchp_core_pwm->sync_update_timer.expires =3D jiffies + delay;
+		add_timer(&mchp_core_pwm->sync_update_timer);
+	}
+}
+
+static int mchp_core_pwm_wait_for_sync_update(struct mchp_core_pwm_chip *m=
chp_core_pwm,
+					      unsigned int channel)
+{
+	/*
+	 * If a shadow register is used for this PWM channel, and iff there is
+	 * a pending update to the waveform, we must wait for it to be applied
+	 * before attempting to read its state, as reading the registers yields
+	 * the currently implemented settings, the new ones are only readable
+	 * once the current period has ended.
+	 *
+	 * Rather large delays are possible, in the seconds, so to avoid waiting
+	 * around for **too** long - cap the wait at 100 ms.
+	 */
+	if (!timer_pending(&mchp_core_pwm->sync_update_timer))
+		return 0;
+
+	if (mchp_core_pwm->sync_update_mask & (1 << channel)) {
+		int ret;
+		ret =3D wait_for_completion_interruptible_timeout(&mchp_core_pwm->sync_u=
pdate_complete,
+								msecs_to_jiffies(MCHPCOREPWM_TIMEOUT_MS));
+		if (!ret)
+			return -ETIMEDOUT;
+
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
=20
-	writel_relaxed(1u, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
+static void mchp_core_pwm_complete_sync_update(struct timer_list *t)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm =3D from_timer(mchp_core_pwm,
+							      t, sync_update_timer);
=20
+	complete(&mchp_core_pwm->sync_update_complete);
+	del_timer(&mchp_core_pwm->sync_update_timer);
 }
=20
 static u64 mchp_core_pwm_calc_duty(const struct pwm_state *state, u64 clk_=
rate,
@@ -181,35 +229,6 @@ static inline void mchp_core_pwm_apply_period(struct m=
chp_core_pwm_chip *mchp_co
 	writel_relaxed(period_steps, mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
 }
=20
-static int mchp_core_pwm_wait_for_sync_update(struct mchp_core_pwm_chip *m=
chp_core_pwm,
-					      unsigned int channel)
-{
-	/*
-	 * If a shadow register is used for this PWM channel, and iff there is
-	 * a pending update to the waveform, we must wait for it to be applied
-	 * before attempting to read its state, as reading the registers yields
-	 * the currently implemented settings, the new ones are only readable
-	 * once the current period has ended.
-	 *
-	 * Rather large delays are possible, in the seconds, so to avoid waiting
-	 * around for **too** long - cap the wait at 100 ms.
-	 */
-	if (mchp_core_pwm->sync_update_mask & (1 << channel)) {
-		u32 delay =3D MCHPCOREPWM_TIMEOUT_US;
-		u32 sync_upd;
-		int ret;
-
-		writel_relaxed(1u, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
-
-		ret =3D read_poll_timeout(readl, sync_upd, !sync_upd, delay/100, delay,
-					false, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
-		if (ret)
-			return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
 static int mchp_core_pwm_apply_locked(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
 				      const struct pwm_state *state)
 {
@@ -297,31 +316,37 @@ static int mchp_core_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
 	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
 	int ret;
=20
+	mutex_lock(&mchp_core_pwm->lock);
+
 	ret =3D mchp_core_pwm_wait_for_sync_update(mchp_core_pwm, pwm->hwpwm);
 	if (ret)
-		return ret;
-
-	mutex_lock(&mchp_core_pwm->lock);
+		goto exit_unlock;
=20
 	ret =3D mchp_core_pwm_apply_locked(chip, pwm, state);
=20
+exit_unlock:
 	mutex_unlock(&mchp_core_pwm->lock);
=20
 	return ret;
 }
=20
-static void mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
-				    struct pwm_state *state)
+static int mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
+				   struct pwm_state *state)
 {
 	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
 	u64 rate;
 	u16 prescale;
 	u8 period_steps, duty_steps, posedge, negedge;
-
-	mchp_core_pwm_wait_for_sync_update(mchp_core_pwm, pwm->hwpwm);
+	int ret;
=20
 	mutex_lock(&mchp_core_pwm->lock);
=20
+	ret =3D mchp_core_pwm_wait_for_sync_update(mchp_core_pwm, pwm->hwpwm);
+	if (ret) {
+		mutex_unlock(&mchp_core_pwm->lock);
+		return ret;
+	}
+
 	if (mchp_core_pwm->channel_enabled & (1 << pwm->hwpwm))
 		state->enabled =3D true;
 	else
@@ -351,6 +376,8 @@ static void mchp_core_pwm_get_state(struct pwm_chip *ch=
ip, struct pwm_device *pw
 	}
=20
 	state->polarity =3D negedge < posedge ? PWM_POLARITY_INVERSED : PWM_POLAR=
ITY_NORMAL;
+
+	return 0;
 }
=20
 static const struct pwm_ops mchp_core_pwm_ops =3D {
@@ -403,6 +430,10 @@ static int mchp_core_pwm_probe(struct platform_device =
*pdev)
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
=20
+	init_completion(&mchp_pwm->sync_update_complete);
+	timer_setup(&mchp_pwm->sync_update_timer, mchp_core_pwm_complete_sync_upd=
ate, 0);
+	writel_relaxed(1U, mchp_pwm->base + MCHPCOREPWM_SYNC_UPD);
+
 	return 0;
 }



--XXSnb1K2Eukxwzpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY44MkwAKCRB4tDGHoIJi
0mT1AQCpLrbgpStJbvNzUWyuZLWvrAMekvHbHU92X3pi3Tx7KQEA0msCXTompy0X
GPxXAlniApVqWKn+yW+Fyb6DQ2K6DwA=
=4TAu
-----END PGP SIGNATURE-----

--XXSnb1K2Eukxwzpi--
