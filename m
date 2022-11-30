Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EB463D289
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiK3JyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiK3JyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:54:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FAC28E1A;
        Wed, 30 Nov 2022 01:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669802053; x=1701338053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FQUudcpbrwWHkFfuVM0pAZ6RGvYOLQp3yxH7VudB6wg=;
  b=j8uaqVBVq7sedfiyUakLwXOb5k92vWFP1rCUNkq8L5G8/muz/PH1iIXC
   pCuFPwLAlyNPfTTx6W+71GNEbBG2mFF6ObhEPevSCmAq2C1N5Zf0pjPXs
   FggetWMG2+9cc0k2GfUTiOCaQiC2cpkvTA4XS7shvgybEexqDD29BmKO5
   mQxsbFguQzqZUJugSEUJPtmR1uRVOyRR3ZYLIOMdSldcyKRadi1+BYgjz
   uZguXmFk64eEKrT8DHR9MuirUBvvAWr1mZRbUoHO8KBlTFzIfH2lzUYD8
   rfm6K3l7ZCBnXqTXAiWkAPvnajVOyBl/EsUo0cGzBU3ftiSNeyt6fEDpy
   A==;
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="191103996"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Nov 2022 02:54:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 30 Nov 2022 02:54:12 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 30 Nov 2022 02:54:10 -0700
Date:   Wed, 30 Nov 2022 09:53:51 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>, <u.kleine-koenig@pengutronix.de>
CC:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v12 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <Y4coL74qQX80TNaT@wendy>
References: <20221110093512.333881-1-conor.dooley@microchip.com>
 <20221110093512.333881-2-conor.dooley@microchip.com>
 <20221117164950.cssukd63fywzuwua@pengutronix.de>
 <Y3Zxkt3OSPQc46Q2@spud>
 <20221117210433.n5j7upqqksld42mu@pengutronix.de>
 <Y3avobkvYK3ydKTS@spud>
 <Y3uZY5mt/ZIWk3sS@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3uZY5mt/ZIWk3sS@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Uwe,

On Mon, Nov 21, 2022 at 03:29:39PM +0000, Conor Dooley wrote:
> On Thu, Nov 17, 2022 at 10:03:13PM +0000, Conor Dooley wrote:
> > On Thu, Nov 17, 2022 at 10:04:33PM +0100, Uwe Kleine-König wrote:
> > > On Thu, Nov 17, 2022 at 05:38:26PM +0000, Conor Dooley wrote:
> > > > On Thu, Nov 17, 2022 at 05:49:50PM +0100, Uwe Kleine-König wrote:
> > > > > Hello Conor,
> > > > 
> > > > Hello Uwe,
> > > > 
> > > > > On Thu, Nov 10, 2022 at 09:35:12AM +0000, Conor Dooley wrote:
> > > > > > [...]
> > > > > > +
> > > > > > +static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > > > +				 bool enable, u64 period)
> > > > > > +{
> > > > > > +	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
> > > > > > +	u8 channel_enable, reg_offset, shift;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * There are two adjacent 8 bit control regs, the lower reg controls
> > > > > > +	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
> > > > > > +	 * and if so, offset by the bus width.
> > > > > > +	 */
> > > > > > +	reg_offset = MCHPCOREPWM_EN(pwm->hwpwm >> 3);
> > > > > > +	shift = pwm->hwpwm & 7;
> > > > > > +
> > > > > > +	channel_enable = readb_relaxed(mchp_core_pwm->base + reg_offset);
> > > > > > +	channel_enable &= ~(1 << shift);
> > > > > > +	channel_enable |= (enable << shift);
> > > > > > +
> > > > > > +	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
> > > > > > +	mchp_core_pwm->channel_enabled &= ~BIT(pwm->hwpwm);
> > > > > > +	mchp_core_pwm->channel_enabled |= enable << pwm->hwpwm;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Notify the block to update the waveform from the shadow registers.
> > > > > > +	 * The updated values will not appear on the bus until they have been
> > > > > > +	 * applied to the waveform at the beginning of the next period. We must
> > > > > > +	 * write these registers and wait for them to be applied before
> > > > > > +	 * considering the channel enabled.
> > > > > > +	 * If the delay is under 1 us, sleep for at least 1 us anyway.
> > > > > > +	 */
> > > > > > +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> > > > > > +		u64 delay;
> > > > > > +
> > > > > > +		delay = div_u64(period, 1000u) ? : 1u;
> > > > > > +		writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> > > > > > +		usleep_range(delay, delay * 2);
> > > > > > +	}
> > > > > 
> > > > > In some cases the delay could be prevented. e.g. when going from one
> > > > > disabled state to another. If you don't want to complicate the driver
> > > > > here, maybe point it out in a comment at least?
> > > > 
> > > > Maybe this is my naivity talking, but I'd rather wait. Is there not the
> > > > chance that we re-enter pwm_apply() before the update has actually gone
> > > > through?
> > > 
> > > My idea was to do something like that:
> > > 
> > > 	int mchp_core_pwm_apply(....)
> > > 	{
> > > 		if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> > > 			/*
> > > 			 * We're still waiting for an update, don't
> > > 			 * interfer until it's completed.
> > > 			 */
> > > 			while (readl_relaxed(mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD)) {
> > > 				cpu_relax();
> > > 				if (waited_unreasonably_long())
> > > 					return -ETIMEOUT;
> > > 			}
> > > 		}
> > > 
> > > 		update_period_and_duty(...);
> > > 		return 0;
> > > 	}
> 
> So I was doing some fiddling, and the following works reasonably well:
> 	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> 		u32 delay = MCHPCOREPWM_TIMEOUT_US;
> 		u32 sync_upd;
> 		int ret;
> 
> 		writel_relaxed(1u, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> 
> 		ret = read_poll_timeout(readl, sync_upd, !sync_upd, delay/100, delay,
> 					false, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> 		if (ret)
> 			dev_dbg(mchp_core_pwm->chip.dev,
> 				"timed out waiting for shadow register sync\n");
> 	}
> 
> but...
> 
> > > This way you don't have to wait at all if the calls to pwm_apply() are
> > > infrequent. Of course this only works this way, if you can determine if
> > > there is a pending update.
> > 
> > Ah I think I get what you mean now about waiting for completion &
> > reading the bit. I don't know off the top of my head if that bit is
> > readable. Docs say that they're R/W but I don't know if that means that
> > an AXI read works or if the value is actually readable. I'll try
> > something like this if I can.
> 
> ...it does not implement what I think you suggested & comes with the
> drawback of inconsistent behaviour depending on whether the timeout is
> hit or not.
> 
> Instead, waiting in apply(), as you suggested, & get_state() looks to be the
> better option, using the same sort of logic as above, say:
> static int mchp_core_pwm_wait_for_sync_update(struct mchp_core_pwm_chip *mchp_core_pwm,
> 					      unsigned int channel)
> {
> 	int ret;
> 
> 	/*
> 	 * If a shadow register is used for this PWM channel, and iff there is
> 	 * a pending update to the waveform, we must wait for it to be applied
> 	 * before attempting to read its state, as reading the registers yields
> 	 * the currently implemented settings, the new ones are only readable
> 	 * once the current period has ended.
> 	 *
> 	 * Rather large delays are possible, in the seconds, so to avoid waiting
> 	 * around for **too** long - cap the wait at 100 ms.
> 	 */
> 	if (mchp_core_pwm->sync_update_mask & (1 << channel)) {
> 		u32 delay = MCHPCOREPWM_TIMEOUT_US;
> 		u32 sync_upd;
> 
> 		writel_relaxed(1u, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> 
> 		ret = read_poll_timeout(readl, sync_upd, !sync_upd, delay/100, delay,
> 					false, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> 		if (ret)
> 			return -ETIMEDOUT;
> 	}
> 
> 	return 0;
> }
> 
> I think that strikes a good balance? We return quickly & don't blocker
> the caller, but simultaneously try to prevent them from either trying to
> apply new settings or get the current settings until the last request
> has gone though?
> 
> get_state() returns void though, is it valid behaviour to wait for the
> timeout there?
> I had a check in the core code and found some places where the call in
> looks like:
> 	struct pwm_state s1, s2; 
> 	chip->ops->get_state(chip, pwm, &s1);
> In this case, exiting early would leave us with a completely wrong
> idead of the state, if it was to time out.
> 
> Either way, it seems like either way we would be misleading the caller
> of get_state() - perhaps the way around that is to do the wait & then
> just carry on with get_state()?
> In that scenario, you'd get the new settings where possible and the old ones
> otherwise.
> Returning if the timeout is hit would give you the new settings where possible
> & otherwise you'd get whatever was passed to get_state().
> I'm not really sure which of those two situations would be preferred?

Apologies for bumping this, I was wondering if any thoughts on the
above? I'm not sure which is the lesser evil here (or if I have
misunderstood something).

Thanks,
Conor.

