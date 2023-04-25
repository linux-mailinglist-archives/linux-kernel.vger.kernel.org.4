Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDF06EDCE8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDYHlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjDYHlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:41:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECF8B8;
        Tue, 25 Apr 2023 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682408458; x=1713944458;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XiDBaOoJ3jGweq2Q6xUecOIExo6JNQOkp8Ggtb4AxSY=;
  b=kV9VRZZclJgvz6WctfT4J49CZ/DrEqmKTgsA7QNXuiY8C4ns6vWK9jYe
   Vggy66X+/RfCewRQOzjcwT8gSOxP+oRBwig8f4Rr5CF/p2oLCxOTbN8CE
   VVuNId2hQ+1dWC8sfhIeXNjC/vq1e8QKZlyHhUx6pZyvGrAP3HSx+c2/U
   kd+qIJmbwRSoNb/+zrIazDNh8X41Y+TSFIs3cYrhjGIw2K22tAUPv4fRS
   Y5Dd1GibEbJUB89s2XNYKnT6ykF67T9wyIKKQidUfdKZkduPjFUJ6RFDz
   ltylj1JtqUUhPgS9KlhCRRzGZohuvcpOjmM+NnrFjrDXLh+hHG8Wh1Ps7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="344168856"
X-IronPort-AV: E=Sophos;i="5.99,224,1677571200"; 
   d="scan'208";a="344168856"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 00:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="782741513"
X-IronPort-AV: E=Sophos;i="5.99,224,1677571200"; 
   d="scan'208";a="782741513"
Received: from rolfneux-mobl.ger.corp.intel.com ([10.252.34.113])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 00:40:50 -0700
Date:   Tue, 25 Apr 2023 10:40:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>
cc:     Philipp Zabel <p.zabel@pengutronix.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>, arnd@arndb.de,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v7 10/12] reset: Add Nuvoton ma35d1 reset driver
 support
In-Reply-To: <4e1cd1c7-e681-fb25-1dcf-16d68e5e525b@gmail.com>
Message-ID: <7f5fb515-a0a4-48fb-fdd5-247aff414d7d@linux.intel.com>
References: <20230412053824.106-1-ychuang570808@gmail.com> <20230412053824.106-11-ychuang570808@gmail.com> <20230424192137.GB30248@pengutronix.de> <4e1cd1c7-e681-fb25-1dcf-16d68e5e525b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1391869021-1682408453=:1992"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1391869021-1682408453=:1992
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 25 Apr 2023, Jacky Huang wrote:

> 
> 
> On 2023/4/25 上午 03:21, Philipp Zabel wrote:
> > Hi Jacky,
> > 
> > On Wed, Apr 12, 2023 at 05:38:22AM +0000, Jacky Huang wrote:
> > > From: Jacky Huang <ychuang3@nuvoton.com>
> > > 
> > > This driver supports individual IP reset for ma35d1. The reset
> > > control registers is a subset of system control registers.
> > > 
> > > Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> > > ---
> > > 
> > > +static const struct {
> > > +	unsigned long id;
> > Why store the id? ids should be contiguous and should start at 0,
> > so the id could just be an index into the array.
> 
> Thank you, I didn't notice that the IDs were already consecutive.
> The id field is indeed unnecessary, and I will remove it.

I recommend you still keep the IDs in the array initializer though, like 
this:

...
} ma35d1_reset_map[] = {
	[MA35D1_RESET_CHIP] = {0x20, 0},
	[MA35D1_RESET_CA35CR0] = {0x20, 1},
	...

> > > +	u32 reg_ofs;
> > > +	u32 bit;
> > > +} ma35d1_reset_map[] = {
> > > +	{ MA35D1_RESET_CHIP,    0x20, 0  },
> > > +	{ MA35D1_RESET_CA35CR0,	0x20, 1  },
> > > +	{ MA35D1_RESET_CA35CR1, 0x20, 2  },
> > > +	{ MA35D1_RESET_CM4,     0x20, 3  },
> > > +	{ MA35D1_RESET_PDMA0,   0x20, 4  },
> > > +	{ MA35D1_RESET_PDMA1,   0x20, 5  },
> > > +	{ MA35D1_RESET_PDMA2,   0x20, 6  },
> > > +	{ MA35D1_RESET_PDMA3,   0x20, 7  },
> > > +	{ MA35D1_RESET_DISP,    0x20, 9  },
> > > +	{ MA35D1_RESET_VCAP0,   0x20, 10 },
> > > +	{ MA35D1_RESET_VCAP1,   0x20, 11 },
> > > +	{ MA35D1_RESET_GFX,     0x20, 12 },
> > > +	{ MA35D1_RESET_VDEC,    0x20, 13 },
> > > +	{ MA35D1_RESET_WHC0,    0x20, 14 },
> > > +	{ MA35D1_RESET_WHC1,    0x20, 15 },
> > > +	{ MA35D1_RESET_GMAC0,   0x20, 16 },
> > > +	{ MA35D1_RESET_GMAC1,   0x20, 17 },
> > > +	{ MA35D1_RESET_HWSEM,   0x20, 18 },
> > > +	{ MA35D1_RESET_EBI,     0x20, 19 },
> > > +	{ MA35D1_RESET_HSUSBH0, 0x20, 20 },
> > > +	{ MA35D1_RESET_HSUSBH1, 0x20, 21 },
> > > +	{ MA35D1_RESET_HSUSBD,  0x20, 22 },
> > > +	{ MA35D1_RESET_USBHL,   0x20, 23 },
> > > +	{ MA35D1_RESET_SDH0,    0x20, 24 },
> > > +	{ MA35D1_RESET_SDH1,    0x20, 25 },
> > > +	{ MA35D1_RESET_NAND,    0x20, 26 },
> > > +	{ MA35D1_RESET_GPIO,    0x20, 27 },
> > > +	{ MA35D1_RESET_MCTLP,   0x20, 28 },
> > > +	{ MA35D1_RESET_MCTLC,   0x20, 29 },
> > > +	{ MA35D1_RESET_DDRPUB,  0x20, 30 },
> > > +	{ MA35D1_RESET_TMR0,    0x24, 2  },
> > > +	{ MA35D1_RESET_TMR1,    0x24, 3  },
> > > +	{ MA35D1_RESET_TMR2,    0x24, 4  },
> > > +	{ MA35D1_RESET_TMR3,    0x24, 5  },
> > > +	{ MA35D1_RESET_I2C0,    0x24, 8  },
> > > +	{ MA35D1_RESET_I2C1,    0x24, 9  },
> > > +	{ MA35D1_RESET_I2C2,    0x24, 10 },
> > > +	{ MA35D1_RESET_I2C3,    0x24, 11 },
> > > +	{ MA35D1_RESET_QSPI0,   0x24, 12 },
> > > +	{ MA35D1_RESET_SPI0,    0x24, 13 },
> > > +	{ MA35D1_RESET_SPI1,    0x24, 14 },
> > > +	{ MA35D1_RESET_SPI2,    0x24, 15 },
> > > +	{ MA35D1_RESET_UART0,   0x24, 16 },
> > > +	{ MA35D1_RESET_UART1,   0x24, 17 },
> > > +	{ MA35D1_RESET_UART2,   0x24, 18 },
> > > +	{ MA35D1_RESET_UAER3,   0x24, 19 },
> > > +	{ MA35D1_RESET_UART4,   0x24, 20 },
> > > +	{ MA35D1_RESET_UART5,   0x24, 21 },
> > > +	{ MA35D1_RESET_UART6,   0x24, 22 },
> > > +	{ MA35D1_RESET_UART7,   0x24, 23 },
> > > +	{ MA35D1_RESET_CANFD0,  0x24, 24 },
> > > +	{ MA35D1_RESET_CANFD1,  0x24, 25 },
> > > +	{ MA35D1_RESET_EADC0,   0x24, 28 },
> > > +	{ MA35D1_RESET_I2S0,    0x24, 29 },
> > > +	{ MA35D1_RESET_SC0,     0x28, 0  },
> > > +	{ MA35D1_RESET_SC1,     0x28, 1  },
> > > +	{ MA35D1_RESET_QSPI1,   0x28, 4  },
> > > +	{ MA35D1_RESET_SPI3,    0x28, 6  },
> > > +	{ MA35D1_RESET_EPWM0,   0x28, 16 },
> > > +	{ MA35D1_RESET_EPWM1,   0x28, 17 },
> > > +	{ MA35D1_RESET_QEI0,    0x28, 22 },
> > > +	{ MA35D1_RESET_QEI1,    0x28, 23 },
> > > +	{ MA35D1_RESET_ECAP0,   0x28, 26 },
> > > +	{ MA35D1_RESET_ECAP1,   0x28, 27 },
> > > +	{ MA35D1_RESET_CANFD2,  0x28, 28 },
> > > +	{ MA35D1_RESET_ADC0,    0x28, 31 },
> > > +	{ MA35D1_RESET_TMR4,    0x2C, 0  },
> > > +	{ MA35D1_RESET_TMR5,    0x2C, 1  },
> > > +	{ MA35D1_RESET_TMR6,    0x2C, 2  },
> > > +	{ MA35D1_RESET_TMR7,    0x2C, 3  },
> > > +	{ MA35D1_RESET_TMR8,    0x2C, 4  },
> > > +	{ MA35D1_RESET_TMR9,    0x2C, 5  },
> > > +	{ MA35D1_RESET_TMR10,   0x2C, 6  },
> > > +	{ MA35D1_RESET_TMR11,   0x2C, 7  },
> > > +	{ MA35D1_RESET_UART8,   0x2C, 8  },
> > > +	{ MA35D1_RESET_UART9,   0x2C, 9  },
> > > +	{ MA35D1_RESET_UART10,  0x2C, 10 },
> > > +	{ MA35D1_RESET_UART11,  0x2C, 11 },
> > > +	{ MA35D1_RESET_UART12,  0x2C, 12 },
> > > +	{ MA35D1_RESET_UART13,  0x2C, 13 },
> > > +	{ MA35D1_RESET_UART14,  0x2C, 14 },
> > > +	{ MA35D1_RESET_UART15,  0x2C, 15 },
> > > +	{ MA35D1_RESET_UART16,  0x2C, 16 },
> > > +	{ MA35D1_RESET_I2S1,    0x2C, 17 },
> > > +	{ MA35D1_RESET_I2C4,    0x2C, 18 },
> > > +	{ MA35D1_RESET_I2C5,    0x2C, 19 },
> > > +	{ MA35D1_RESET_EPWM2,   0x2C, 20 },
> > > +	{ MA35D1_RESET_ECAP2,   0x2C, 21 },
> > > +	{ MA35D1_RESET_QEI2,    0x2C, 22 },
> > > +	{ MA35D1_RESET_CANFD3,  0x2C, 23 },
> > > +	{ MA35D1_RESET_KPI,     0x2C, 24 },
> > > +	{ MA35D1_RESET_GIC,     0x2C, 28 },
> > > +	{ MA35D1_RESET_SSMCC,   0x2C, 30 },
> > > +	{ MA35D1_RESET_SSPCC,   0x2C, 31 }
> > > +};


-- 
 i.
--8323329-1391869021-1682408453=:1992--
