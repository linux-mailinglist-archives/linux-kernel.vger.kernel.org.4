Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C464E6CA5D3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjC0N2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjC0N2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:28:25 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A04D272C;
        Mon, 27 Mar 2023 06:27:53 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id A602B5FD0E;
        Mon, 27 Mar 2023 16:27:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679923671;
        bh=0YUCwwr3FkfqiCryYd0cXJ9WkdrM/lnNsAXWs5dkDmY=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=PiIIdlWyfXI2YxfuVPMiERyUtS3e8apzsM0jw8aWpq7UM21heILNGgtUKsImAyvvL
         fRKo6cr4JvAZ/FuUdfCeC+124LPi0DnRDf89y91DfYUrT7cJsbMhabscgA6+fd9LqU
         DsBtoKouTA9kMPpc4atAN9fueKNM9qyPZLYSViLl7ptJpiwlrxTmy63hrYt15QEaOu
         zScE0x+rQYGgaFGzlwJ3dthhuSWZ5r5GcMyWx13I3iLq/+pSJg3/AQMdZ72aLFQ3qO
         076PL8UYUfdrqiljM3ocAVjeRlIfZj+zB/NkgUCOlPL38tgnIljPIgWLsJcNvrneQP
         Gz1zhQgd+F+5A==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 27 Mar 2023 16:27:51 +0300 (MSK)
Date:   Mon, 27 Mar 2023 16:27:50 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v11 5/5] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
Message-ID: <20230327132750.pnao5t3mbm3pmzbe@CAB-WSD-L081021>
References: <20230321193014.26349-1-ddrokosov@sberdevices.ru>
 <20230321193014.26349-6-ddrokosov@sberdevices.ru>
 <1jtty6o5so.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jtty6o5so.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/27 05:49:00 #21016052
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:58:30AM +0200, Jerome Brunet wrote:
> 
> On Tue 21 Mar 2023 at 22:30, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> 
> > Introduce Peripherals clock controller for Amlogic A1 SoC family.
> >
> > A1 SoC has four clock controllers on the board: PLL, Peripherals, CPU,
> > and Audio.
> > This patchset adds support for Amlogic A1 Peripherals clock driver and
> > allows to generate clocks for all A1 SoC peripheral IPs.
> >
> > Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  drivers/clk/meson/Kconfig  |   10 +
> >  drivers/clk/meson/Makefile |    1 +
> >  drivers/clk/meson/a1.c     | 2344 ++++++++++++++++++++++++++++++++++++
> >  drivers/clk/meson/a1.h     |   49 +
> >  4 files changed, 2404 insertions(+)
> >  create mode 100644 drivers/clk/meson/a1.c
> >  create mode 100644 drivers/clk/meson/a1.h
> >
> 
> [...]
> 
> > +static struct clk_regmap dspa_b_sel = {
> > +	.data = &(struct clk_regmap_mux_data){
> > +		.offset = DSPA_CLK_CTRL0,
> > +		.mask = 0x7,
> > +		.shift = 26,
> > +		.table = mux_table_dsp_ab,
> > +	},
> > +	.hw.init = &(struct clk_init_data){
> > +		.name = "dspa_b_sel",
> > +		.ops = &clk_regmap_mux_ops,
> > +		.parent_data = dsp_ab_parent_data,
> > +		.num_parents = ARRAY_SIZE(dsp_ab_parent_data),
> > +		/*
> > +		 * DSPA_B clk can be inherited from more accurate RTC clock,
> > +		 * so in some situations we may want to freeze its parent.
> > +		 * Therefore force dsp parent setup on device tree side
> > +		 */
> 
> This gets copy-pasted A LOT.
> Please comment this once and for all ... then reference the comment if
> you need to.
> 

Agree. No problem. I'll collapse them in the next version.

> > +		.flags = CLK_SET_RATE_NO_REPARENT,
> > +	},
> > +};
> 
> [...]
> 
> > +static struct clk_regmap cecb_32k_sel = {
> > +	.data = &(struct clk_regmap_mux_data) {
> > +		.offset = CECB_CLK_CTRL1,
> > +		.mask = 0x1,
> > +		.shift = 31,
> > +		.flags = CLK_MUX_ROUND_CLOSEST,
> > +	},
> > +	.hw.init = &(struct clk_init_data){
> > +		.name = "cecb_32k_sel",
> > +		.ops = &clk_regmap_mux_ops,
> > +		.parent_hws = (const struct clk_hw *[]) {
> > +			&cecb_32k_sel_pre.hw,
> > +			&rtc.hw,
> > +		},
> > +		.num_parents = 2,
> > +		/*
> > +		 * CECB_32K clk can be inherited from more accurate RTC clock,
> > +		 * so in some situations we may want to freeze its parent.
> > +		 * Therefore force cecb_32k parent setup on device tree side
> > +		 */
> 
> How do you plan on doing that ?
> 
> You've made the parent "private" and it is not even available to be
> referenced in DT.
> 
> This whole concept of public and private to seems broken to me.
> I would much prefer you keep the existing model, with one big table and
> possibly some IDs not exposed in the bindings.
> 
> This gives an hint about the clocks we think consummers should use while
> allowing us to change things if we got it wrong, and keep the IDs stable
> for DT. This has been working so far. I don't see the benefit of
> changing that right now.
> 

As we disccused in the IRC, there is two approaches:

1) public/private clock bindings based on splitting bindings headers
2) public/private clock objects based on limited clock hw provider
   registration

I'll redesign the whole patch series to the 1st approach with keeping the
following strict rules in the mind:
"There is no option to chage public or private CLKID list numbers.
"Never said you were allowed to change the meaning of the ID, you are just
allowed to have them declared in the bindings (or not)"

[...]

-- 
Thank you,
Dmitry
