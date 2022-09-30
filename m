Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C335F058C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiI3HM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiI3HM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:12:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5C1F0CF3;
        Fri, 30 Sep 2022 00:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664521945; x=1696057945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=i9r4cm7CWBei9MpRxT6DhwEqr1A5EdaPBWIGSPlmOz0=;
  b=HMAKHFXVvujSfRGpL49PG7PcFipnsdIcpCKjs7LY5UYSWC8b3csTp7iG
   aectHsSx98VblDuW8APuKKX1Tl0zCV13jmnqs4T7l3R8OVSGMAD8jRjim
   Tk7a4O0LpgQqTxQO3YMGkK8MfwW+nrtEoCsO704SoxN8f8OWFSEEDRCvS
   tNWLXb9oXuOszv3K0XGQs6Mlfx86FdQnslc91Uq9TMSQOillHks5JtmGu
   wybJj5nnFznKW6Uyr5Sc3/Ll5HIp7qvAdhc7gTr/2EBwMnuioI5joFI+Z
   JKRtLG0Uw9xryJCqY8wb10D817q4XkCpuWgMt0Fexsls3C8u6Tje9yCVw
   A==;
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="179699630"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2022 00:12:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 30 Sep 2022 00:12:21 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 30 Sep 2022 00:12:19 -0700
Date:   Fri, 30 Sep 2022 08:11:58 +0100
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
Message-ID: <YzaWvrkWEvZdlwK6@wendy>
References: <20220824091215.141577-1-conor.dooley@microchip.com>
 <20220824091215.141577-4-conor.dooley@microchip.com>
 <20220915072152.y346csakn7wetpz5@pengutronix.de>
 <YyhmZBmfJvJ9/vBg@wendy>
 <20220919135008.sahwmwbfwvgplji4@pengutronix.de>
 <Yyh8v+MtHuc0LLf0@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yyh8v+MtHuc0LLf0@wendy>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 03:29:19PM +0100, Conor Dooley wrote:
> Hey Uwe,
> 
> On Mon, Sep 19, 2022 at 03:50:08PM +0200, Uwe Kleine-König wrote:
> > On Mon, Sep 19, 2022 at 01:53:56PM +0100, Conor Dooley wrote:
> > > Hey Uwe,
> > > Thanks (as always). I've switched up my email setup a bit so I hope
> > > that I've not mangled anything here.
> > > 
> > > On Thu, Sep 15, 2022 at 09:21:52AM +0200, Uwe Kleine-König wrote:
> > > > Hello,
> > > > 
> > > > On Wed, Aug 24, 2022 at 10:12:14AM +0100, Conor Dooley wrote:
> > > > > Add a driver that supports the Microchip FPGA "soft" PWM IP core.
> > > > > 
> > > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > ---

> > > > $ ./test 255 65535
> > > > period_steps = 255
> > > > prescale = 65535
> > > > period = 18446744073018591744
> > > > 
> > > > The problem is that the result of 16711425 * 1000000000L isn't affected
> > > > by the type of period and so it's promoted to L which isn't big enough
> > > > to hold 16711425000000000 where longs are only 32 bit wide.
> > > 
> > > I don't think this is ever going to be hit in the wild, since prescale
> > > comes from the hardware where it is limited to 255 - but preventing the
> > > issue seems trivially done by splitting the multiplication so no reason
> > > not to. Thanks for providing the test program btw :)
> > 
> > Even 255 * 255 * 1000000000 overflows. With a maintainer's hat on, it is
> > very valuable to prevent such issues because your driver might be used
> > as a template for the next driver.
> > 
> > > > > +	state->period = DIV64_U64_ROUND_UP(state->period, clk_get_rate(mchp_core_pwm->clk));
> > > > > +
> > > > > +	posedge = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->hwpwm));
> > > > > +	negedge = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->hwpwm));
> > > > > +
> > > > > +	if ((negedge == posedge) && state->enabled) {
> > > > 
> > > > Why do you need that state->enabled?
> > > 
> > > Because I was running into conflicts between the reporting here and some
> > > of the checks that I have added to prevent the PWM being put into an
> > > invalid state. On boot both negedge and posedge will be zero & this was
> > > preventing me from setting the period at all.
> > 
> > I don't understood that.
> 
> On startup, (negedge == posedge) is true as both are zero, but the reset
> values for prescale and period are actually 0x8. If on reset I try to
> set a small period, say "echo 1000 > period" apply() returns -EINVAL
> because of a check in the pwm core in pwm_apply_state() as I am
> attempting to set the period to lower than the out-of-reset duty cycle.
> 
> I considered zeroing the registers, but if something below Linux had
> been using the PWM I felt that may not be the right thing to do. Can I
> continue to check for the enablement here or would you rather I did
> something different?

Hey Uwe,
Just bumping here ICYMI. Should I leave the behaviour as-was and just
document what the default values out of reset may be? That would leave
the check here making more sense & head off confusion about why apply()
fails?

Thanks,
Conor.
