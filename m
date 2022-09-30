Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A195F0CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiI3Ntw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiI3Ntr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:49:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C211363B1;
        Fri, 30 Sep 2022 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664545782; x=1696081782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n9ebYPlj7qybcpG08KXmsqxmGM43O0sG2jH9VygklZk=;
  b=bxCo1loqqSmCvb/R0u+UpGVYTBor68rGrNzqEQot92db2V0GXcJJr57i
   Tb7ODy5mzsVyPpNC+e6Wiob4x9mS4ubDC0iDLK1nmEITm+54ghQ4/ljC/
   nAPfG16DyINPFh7MMJosaVBb8bWKxnSNzf0c7K+3sRJRQ0KknAqfEw6Uy
   McqL7TJ6sBqp1D0CCDi4gdBffTcK4tReN09zpJrkn4y/Hew9/LLr4PJYy
   RicV7yYC+QlmwGMlUQm+0ULJuBWo65dyqQGOYPT+SSARWPIYPzFMa4pT/
   QRzAM2l5pMFwDI2h/wfuUkzZXflhpHgjZvEwelmqY9D3TbJz9HPOU2tzA
   w==;
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="179788492"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2022 06:49:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 30 Sep 2022 06:49:35 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 30 Sep 2022 06:49:33 -0700
Date:   Fri, 30 Sep 2022 14:49:12 +0100
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
Message-ID: <Yzbz2N28RJ8Yyg2v@wendy>
References: <20220824091215.141577-1-conor.dooley@microchip.com>
 <20220824091215.141577-4-conor.dooley@microchip.com>
 <20220915072152.y346csakn7wetpz5@pengutronix.de>
 <YyhmZBmfJvJ9/vBg@wendy>
 <20220919135008.sahwmwbfwvgplji4@pengutronix.de>
 <Yyh8v+MtHuc0LLf0@wendy>
 <20220930091316.kdkf4oeu6uvxzqa6@pengutronix.de>
 <Yza61MO9hbuFytmM@wendy>
 <20220930133933.br5kanbh3clvahvr@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930133933.br5kanbh3clvahvr@pengutronix.de>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 03:39:33PM +0200, Uwe Kleine-König wrote:
> On Fri, Sep 30, 2022 at 10:45:56AM +0100, Conor Dooley wrote:
> > On Fri, Sep 30, 2022 at 11:13:16AM +0200, Uwe Kleine-König wrote:
> > > On Mon, Sep 19, 2022 at 03:29:19PM +0100, Conor Dooley wrote:
> > > > Hey Uwe,
> > > > 
> > > > On Mon, Sep 19, 2022 at 03:50:08PM +0200, Uwe Kleine-König wrote:
> > > > > On Mon, Sep 19, 2022 at 01:53:56PM +0100, Conor Dooley wrote:
> > > > > > Because I was running into conflicts between the reporting here and some
> > > > > > of the checks that I have added to prevent the PWM being put into an
> > > > > > invalid state. On boot both negedge and posedge will be zero & this was
> > > > > > preventing me from setting the period at all.
> > > > > 
> > > > > I don't understood that.
> > > > 
> > > > On startup, (negedge == posedge) is true as both are zero, but the reset
> > > > values for prescale and period are actually 0x8. If on reset I try to
> > > > set a small period, say "echo 1000 > period" apply() returns -EINVAL
> > > > because of a check in the pwm core in pwm_apply_state() as I am
> > > > attempting to set the period to lower than the out-of-reset duty cycle.
> > > 
> > > You're supposed to keep the period for pwm#1 untouched while configuring
> > > pwm#0 only if pwm#1 already has a consumer. So if pwm#1 isn't requested,
> > > you can change the period for pwm#0.
> > 
> > I must have done a bad job of explaining here, as I don't think this is
> > an answer to my question.
> > 
> > On reset, the prescale and period_steps registers are set to 0x8. If I
> > attempt to set the period to do "echo 1000 > period", I get -EINVAL back
> > from pwm_apply_state() (in next-20220928 it's @ L562 in pwm/core.c) as
> > the duty cycle is computed as twice the period as, on reset, we have
> > posedge = negedge = 0x0. The check of state->duty_cycle > state->period
> > fails in pwm_apply_state() as a result.
> 
> So set duty_cycle to 0 first?
> 
> A problem of the sysfs interface is that you can only set one parameter
> after the other. So there you have to find a sequence of valid
> pwm_states that only differ in a single parameter between the initial
> and the desired state.
> 
> That's nothing a "normal" pwm consumer would be affected by. (IMHO we
> should have a userspace API that benefits from the properties of
> pwm_apply().)

Right, so I guess I will drop the check so. That's good to know, thanks.

Would you rather I waited until after the mw to send v11?

Thanks,
Conor.


