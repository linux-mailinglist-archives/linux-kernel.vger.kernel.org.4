Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B2363D41E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiK3LPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiK3LPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:15:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DE728E14;
        Wed, 30 Nov 2022 03:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669806932; x=1701342932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=h8e+dDcveIhXtv4l23Jh2CJfpqVLFmQPAuoBcBH7Hyk=;
  b=tFwxku4b3ckw94Obe6IOGzG0ixxBoiGXkGEVNBSN6JhfSEIVr83ikMQv
   xlVe0N5xREFbja6KY/4uNiHCd2QUZeN8sDMdgf1tbHgummOEvRr0XF5Xb
   hnF3DBNHsp90X1G094SKYMAQKEt6FbLCjhbreJLR9K0Lc4s7kPwQ7LkCn
   1/vVIkTAzVmwJSQRSgbBl4wAdh4kasQXbMdhbgFCQo1CFKxSOxIhXURMP
   wXl0rl10wXtWW9fE+IpnSgK47v7zRSxGfRlXkBjb7/x5V/RmFQIQwnsIO
   tGSLV5SGjJGgrqb5k8/mGSRgV2efcNG+L2OFRLtFwgdhrHqaEK/mNfl+9
   A==;
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="189334692"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Nov 2022 04:15:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 30 Nov 2022 04:15:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 30 Nov 2022 04:15:29 -0700
Date:   Wed, 30 Nov 2022 11:15:10 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Conor Dooley <conor@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v12 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <Y4c7PpgzAi+HPrET@wendy>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221130103755.lhil2jaw3oufr2sf@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 11:37:55AM +0100, Uwe Kleine-König wrote:
> Hello Conor,

> > > get_state() returns void though, is it valid behaviour to wait for the
> > > timeout there?
> 
> There was an approach to change that, see
> https://lore.kernel.org/linux-pwm/20220916151506.298488-1-u.kleine-koenig@pengutronix.de
> 
> I need to send a v2.

Ahh, yeah. That looks like a better idea. I'd much rather be able to
return an actual error.

> > > I had a check in the core code and found some places where the call in
> > > looks like:
> > > 	struct pwm_state s1, s2; 
> > > 	chip->ops->get_state(chip, pwm, &s1);
> > > In this case, exiting early would leave us with a completely wrong
> > > idead of the state, if it was to time out.
> > > 
> > > Either way, it seems like either way we would be misleading the caller
> > > of get_state() - perhaps the way around that is to do the wait & then
> > > just carry on with get_state()?
> > > In that scenario, you'd get the new settings where possible and the old ones
> > > otherwise.
> > > Returning if the timeout is hit would give you the new settings where possible
> > > & otherwise you'd get whatever was passed to get_state().
> > > I'm not really sure which of those two situations would be preferred?
> 
> Hmm, .get_state should not return the old state. We really want
> .get_state to return an error code. Maybe postpone that question until
> we have that?

If get_state() can return an error, there's no need for the question I
think. I'd rather return what's in the shadow registers *and* on the bus
or an error than an inconsistent state.

I'll send a v(N+1) based on the non-void get_state() at some point
soon-ish.

> > Apologies for bumping this, I was wondering if any thoughts on the
> > above? I'm not sure which is the lesser evil here (or if I have
> > misunderstood something).
> 
> That's fine. I'm sorry to be not more responsive. This development cycle
> is somehow crazy and there are so many open mails in my inbox ... :-\

Oh nw about that at all. I feel bad pinging stuff since I know everyone
is busy.

Thanks,
Conor.

