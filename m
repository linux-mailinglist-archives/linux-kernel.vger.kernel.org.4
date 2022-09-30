Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBE25F07EE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiI3JrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiI3Jqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:46:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A95B18B5EE;
        Fri, 30 Sep 2022 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664531185; x=1696067185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/9hzbJtvcmCDwMsTwmaZ+u2TLuGLLihxFJfWTDLRCkA=;
  b=z/D96xRe2E2eKDKu7dfXNSXISpnpvnZ6EJ0RLl28RYLFiPgDu9c215FY
   Okt8akHRrM1lOjKKM0u8ca7/fVdP/d/iPCm9XwKRm7brBYKQDOjmx2T7H
   8WMe1Z995iiQh3WiVgFbq17f+hVumkmmIJ+UQEFdBUV9lsZWTXDbzgxAo
   8ZiETFaOlSyYO8hCSKtPn5kK92hV9/SGAIrIlW3aStJF/AxbyqKPmxAcx
   DqOGdRLeN2yLWJF48FPAD9asN0neFv9vieSdsOLlDxyGxhdXbGDKr0LnV
   yQM21Y0W2fF8LV3I9tMOE5tAL4dUZEi4zsJpg5n9uNg0bfbMCEYW0Rr1Z
   g==;
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="116219231"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2022 02:46:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 30 Sep 2022 02:46:22 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 30 Sep 2022 02:46:20 -0700
Date:   Fri, 30 Sep 2022 10:45:56 +0100
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
Message-ID: <Yza61MO9hbuFytmM@wendy>
References: <20220824091215.141577-1-conor.dooley@microchip.com>
 <20220824091215.141577-4-conor.dooley@microchip.com>
 <20220915072152.y346csakn7wetpz5@pengutronix.de>
 <YyhmZBmfJvJ9/vBg@wendy>
 <20220919135008.sahwmwbfwvgplji4@pengutronix.de>
 <Yyh8v+MtHuc0LLf0@wendy>
 <20220930091316.kdkf4oeu6uvxzqa6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930091316.kdkf4oeu6uvxzqa6@pengutronix.de>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 11:13:16AM +0200, Uwe Kleine-König wrote:
> On Mon, Sep 19, 2022 at 03:29:19PM +0100, Conor Dooley wrote:
> > Hey Uwe,
> > 
> > On Mon, Sep 19, 2022 at 03:50:08PM +0200, Uwe Kleine-König wrote:
> > > On Mon, Sep 19, 2022 at 01:53:56PM +0100, Conor Dooley wrote:
> > > > Because I was running into conflicts between the reporting here and some
> > > > of the checks that I have added to prevent the PWM being put into an
> > > > invalid state. On boot both negedge and posedge will be zero & this was
> > > > preventing me from setting the period at all.
> > > 
> > > I don't understood that.
> > 
> > On startup, (negedge == posedge) is true as both are zero, but the reset
> > values for prescale and period are actually 0x8. If on reset I try to
> > set a small period, say "echo 1000 > period" apply() returns -EINVAL
> > because of a check in the pwm core in pwm_apply_state() as I am
> > attempting to set the period to lower than the out-of-reset duty cycle.
> 
> You're supposed to keep the period for pwm#1 untouched while configuring
> pwm#0 only if pwm#1 already has a consumer. So if pwm#1 isn't requested,
> you can change the period for pwm#0.

I must have done a bad job of explaining here, as I don't think this is
an answer to my question.

On reset, the prescale and period_steps registers are set to 0x8. If I
attempt to set the period to do "echo 1000 > period", I get -EINVAL back
from pwm_apply_state() (in next-20220928 it's @ L562 in pwm/core.c) as
the duty cycle is computed as twice the period as, on reset, we have
posedge = negedge = 0x0. The check of state->duty_cycle > state->period
fails in pwm_apply_state() as a result.

This failure to assign a value is unrelated to having multiple PWMs, I
think I may have horribly worded my statement when I originally replied
to you with:
> Because I was running into conflicts between the reporting here and some
> of the checks that I have added to prevent the PWM being put into an
> invalid state.

"reporting here" from that quote being the period/duty cycle
calculations in the drivers get_state(). By "the checks" I meant making
sure that a period where posedge = negedge is not set by the driver. I
think I also may have mistakenly assumed the -EINVAL came from my code
and not from the core - but I cannot be sure as it has been a few weeks.

The check in the core looks to be things "working as intended", and it
looks like I am working around it here. Should I just note what the
values are on reset in the "limitations" comment and the top & it is up
to applications that control the PWMs to first "fix" the duty cycle
before changing the period?

Hopefully I've done a better job at explaning this time,
Conor.


