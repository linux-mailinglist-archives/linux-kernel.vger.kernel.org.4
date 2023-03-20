Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F3F6C0EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjCTKcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjCTKbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:31:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CE623DBF;
        Mon, 20 Mar 2023 03:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308297; x=1710844297;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=u75KIvpojk8bOs9GDkjrsePIrDttzD1llg3QobSi+Xo=;
  b=RgqFIs8c49Ngm0KBuDSrnD/HYCQSwjMXpsC6o4Oz4ZBeWG2kvQvV/teZ
   6o2eiUmKnOJ/lQTRm+9NEXdqZ43zrVnKOTCkLW/2L3FtjSolJgv3FF20/
   D98Tsj3TWVON3NHPhSPSrCF7xOhkEECmq5F227bCoz2sZghCD1HLnrUeL
   kqAFvvbOpGjq+sTk9wNRMypXC+/bNv+lDvRxwKJiBIEJDlpMyn3+woiVl
   GsEprTcQFYZln+64sV4ftMa4/dBh4JlRzI6328CwGqM3z9mjCvrpnAVyk
   /6YWjHybehmr1G8RsLnwz1Ot32W3roloN3f0td9KtT1QknNNvTDItXbpZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997580"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997580"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:31:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523451"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523451"
Received: from mbouhaou-mobl1.ger.corp.intel.com ([10.252.61.151])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:31:31 -0700
Date:   Mon, 20 Mar 2023 12:31:29 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>
cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH 12/15] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
In-Reply-To: <00c3748b-61fa-f14b-f92c-b60fd9d6b4ee@gmail.com>
Message-ID: <9115473c-2e88-da76-9631-ca19b9129be4@linux.intel.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com> <20230315072902.9298-13-ychuang570808@gmail.com> <8b5854d3-2793-bc33-137e-5a2673d72329@linux.intel.com> <00c3748b-61fa-f14b-f92c-b60fd9d6b4ee@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1678519641-1679307619=:2177"
Content-ID: <3549237f-f963-10e-aa4c-3c3227b3c958@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1678519641-1679307619=:2177
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <7de21190-7ef6-abd3-494-1cf39f4974d4@linux.intel.com>

On Sun, 19 Mar 2023, Jacky Huang wrote:

> 
> On 2023/3/16 下午 11:56, Ilpo Järvinen wrote:
> > On Wed, 15 Mar 2023, Jacky Huang wrote:
> > 
> > > From: Jacky Huang <ychuang3@nuvoton.com>
> > > 
> > > The clock controller generates clocks for the whole chip, including
> > > system clocks and all peripheral clocks. This driver support ma35d1
> > > clock gating, divider, and individual PLL configuration.
> > > 
> > > There are 6 PLLs in ma35d1 SoC:
> > >    - CA-PLL for the two Cortex-A35 CPU clock
> > >    - SYS-PLL for system bus, which comes from the companion MCU
> > >      and cannot be programmed by clock controller.
> > >    - DDR-PLL for DDR
> > >    - EPLL for GMAC and GFX, Display, and VDEC IPs.
> > >    - VPLL for video output pixel clock
> > >    - APLL for SDHC, I2S audio, and other IPs.
> > > CA-PLL has only one operation mode.
> > > DDR-PLL, EPLL, VPLL, and APLL are advanced PLLs which have 3
> > > operation modes: integer mode, fraction mode, and spread specturm mode.
> > > 
> > > Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> > > ---

> > > +};
> > > +
> > > +#define to_ma35d1_adc_clk_divider(_hw)	\
> > > +	container_of(_hw, struct ma35d1_adc_clk_divider, hw)
> > static inline
> 
> 
> I will modify these "static" functions as "static inline".

No, that's not what I meant. Make the container_of define static inline
function instead, no other functions. (Or if you have more than one of 
such, all of them of course).

> > > +}
> > > diff --git a/drivers/clk/nuvoton/clk-ma35d1-pll.c
> > > b/drivers/clk/nuvoton/clk-ma35d1-pll.c
> > > new file mode 100644
> > > index 000000000000..79e724b148fa
> > > --- /dev/null
> > > +++ b/drivers/clk/nuvoton/clk-ma35d1-pll.c
> > > @@ -0,0 +1,534 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2023 Nuvoton Technology Corp.
> > > + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/io.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/bitfield.h>
> > > +
> > > +#include "clk-ma35d1.h"
> > > +
> > > +#define to_ma35d1_clk_pll(clk) \
> > > +	(container_of(clk, struct ma35d1_clk_pll, clk))
> > static inline
> 
> 
> I am sorry cannot get "static inline" refer to which one.
> 
> Would you give more advice here?
> 
> Thank you.

static inline struct ...type_here... *to_ma35d1_clk_pll(struct ...type_here... *clk)
{
	return container_of(clk, struct ma35d1_clk_pll, clk);
}


> > > +	} else {
> > > +		pr_err("Failed to set rate %ld\n", u64PllFreq);
> > > +		return 0;
> > > +	}
> > > +
> > > +	u64P = (u64FCLKO >= VSIPLL_FCLK_MIN_FREQ) ? 1 :
> > > +	       ((VSIPLL_FCLK_MIN_FREQ / u64FCLKO) +
> > > +		((VSIPLL_FCLK_MIN_FREQ % u64FCLKO) ? 1 : 0));
> > Ditto.
> > 
> > Is here some ...ROUND_UP() trick hidden too?
> 
> 
> This follows the description of PLL spec.

Right but I was looking into what the math does. To me this looks like 
rounding up:
 VSIPLL_FCLK_MIN_FREQ / u64FCLKO + (VSIPLL_FCLK_MIN_FREQ % u64FCLKO ? 1 : 0)

When modulo is > 0, add one, which is round up, no?

There are helpers which you should use for rounding up, search for 
*_ROUND_UP. I think math64.h had one 64-bit one.

> > > +	u64X = u64tmp % 1000;
> > > +	u32FRAC = ((u64X << 24) + 500) / 1000;

I missed this earlier, is this rounding? ...Use a helper if it is. 
Otherwise define what 500 is. (No need to answer despite question mark, 
just do the change).

> > > +
> > > +	u64SSRATE = ((PllSrcClk >> 1) / (u32Fmod * 2)) - 1;
> > > +	u64SLOPE = ((u64tmp * u32SR / u64SSRATE) << 24) / 100 / 1000;
> > > +
> > > +	u64PllClk = (PllSrcClk * u64tmp) / u64P / u64M / 1000;
> > Is some *SEC_PER_*SEC define relevant for 1000 ?
> > 
> > Or some other units, e.g., HZ related?
> 
> 
> 1000 is for kHz to MHz, and 100 is for percentage.

Okay, then use KHZ_PER_MHZ from linux/units.h.

We don't have anything for percents under include/ I think so that can be 
left as literal.

> > > +	switch (pll->mode) {
> > > +	case VSIPLL_INTEGER_MODE:
> > > +		u64PllClk = CLK_CalPLLFreq_Mode0(PllSrcClk, u64PllFreq,
> > > +						 u32Reg);
> > One line.
> 
> 
> It will exceed 80 characters in one line.

Yeah, the semicolon won't fit to 80 chars :-) which means there won't be 
significant information loss even on 80 chars terminal. This kind of cases 
is why checkpatch won't complain until 100 chars. Use common sense (don't 
hide most of the logic to 80-100 but don't be afraid of breaking the 80 
chars where the information loss is not significant issue).

Besides, once you removed the types from variable names, it will be 
shorter anyway.


-- 
 i.
--8323329-1678519641-1679307619=:2177--
