Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCF6654C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLWGWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWGWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:22:13 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF87165A9;
        Thu, 22 Dec 2022 22:22:11 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E996E24E035;
        Fri, 23 Dec 2022 14:22:06 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 23 Dec
 2022 14:22:06 +0800
Received: from [192.168.125.65] (183.27.97.120) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 23 Dec
 2022 14:22:06 +0800
Message-ID: <20e6b9af-3bee-6a4a-880f-df22ebcbe3b5@starfivetech.com>
Date:   Fri, 23 Dec 2022 14:23:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 02/11] clk: starfive: Rename "jh7100" to "jh71x0" for
 the common code
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-3-hal.feng@starfivetech.com> <Y6IyRlEtiS6ye96q@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y6IyRlEtiS6ye96q@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.120]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2022 22:08:06 +0000, Conor Dooley wrote:
> On Tue, Dec 20, 2022 at 08:50:45AM +0800, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> > 
> > Rename "clk-starfive-jh7100.h" to "clk-starfive-jh71x0.h" and rename
> > some variables from "jh7100" or "JH7100" to "jh71x0" or "JH71X0".
> > 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  .../clk/starfive/clk-starfive-jh7100-audio.c  |  74 ++--
> >  drivers/clk/starfive/clk-starfive-jh7100.c    | 388 +++++++++---------
> >  drivers/clk/starfive/clk-starfive-jh7100.h    | 114 -----
> >  drivers/clk/starfive/clk-starfive-jh71x0.c    | 284 ++++++-------
> >  drivers/clk/starfive/clk-starfive-jh71x0.h    | 114 +++++
> >  5 files changed, 487 insertions(+), 487 deletions(-)
> >  delete mode 100644 drivers/clk/starfive/clk-starfive-jh7100.h
> >  create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.h
> > 
> > diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> > index 8473a65e219b..02aefb7264f8 100644
> > --- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> > +++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> > @@ -16,7 +16,7 @@
> >  
> >  #include <dt-bindings/clock/starfive-jh7100-audio.h>
> >  
> > -#include "clk-starfive-jh7100.h"
> > +#include "clk-starfive-jh71x0.h"
> >  
> >  /* external clocks */
> >  #define JH7100_AUDCLK_AUDIO_SRC			(JH7100_AUDCLK_END + 0)
> > @@ -28,66 +28,66 @@
> >  #define JH7100_AUDCLK_I2SDAC_LRCLK_IOPAD	(JH7100_AUDCLK_END + 6)
> >  #define JH7100_AUDCLK_VAD_INTMEM                (JH7100_AUDCLK_END + 7)
> >  
> > -static const struct jh7100_clk_data jh7100_audclk_data[] = {
> > -	JH7100__GMD(JH7100_AUDCLK_ADC_MCLK, "adc_mclk", 0, 15, 2,
> > +static const struct jh71x0_clk_data jh7100_audclk_data[] = {
> > +	JH71X0__GMD(JH7100_AUDCLK_ADC_MCLK, "adc_mclk", 0, 15, 2,
> 
> Heh, I'm not sure what to think about these _s for alignment!

Maybe it looks clearer. These code are made previously.

> This one is a little harder to verify with my git show wizardary, but it
> also looks like it does what it says on the tin. Might've been easier to
> verify with git show if the renaming of variables and code movement had
> been split.

Should I split it?

Best regards,
Hal

> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

