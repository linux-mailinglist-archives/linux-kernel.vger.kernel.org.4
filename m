Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9D70BFD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjEVNcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjEVNcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:32:23 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91843CD;
        Mon, 22 May 2023 06:32:16 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 8BF6B5FD53;
        Mon, 22 May 2023 16:32:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684762333;
        bh=6u9V8vHtTafBR0YnVPjYmlnDi14L5422DGaJYz+Dxq8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=NmIgAjKRuI5WAoj2t1m+b4UA9fcDT9PtSDg76v2enOK5vghDOPI/uzUVntbCerZyv
         FvJE/fokfX2PP7bRgR6VqqnI8xbxgR4MkJl34imEQYv1sbzqiqPzdPF0wmDFTrpuMJ
         zo1qxQ8KqDqkbOyceIP3SKiyJbh4f1Z1CM3jlIJOVMv1ufPTqqird9raJPgFOAU8+N
         x/NUEkzEUdfOszk3c1ZdCZQmadT44YBTdjxJNh3PiXU+EtTn7zD9hbdpbVSpuVI2du
         rgeVrNvpM/wPxUSt95Cg3Aklp+V9nqbkBtN0SqscGKpbLPVZCNHLNP/Rwm1/crFXlO
         Gpuyw3RsqrIJg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 22 May 2023 16:32:13 +0300 (MSK)
Date:   Mon, 22 May 2023 16:32:12 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v15 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
Message-ID: <20230522133212.fcxgsml4hmvj65bb@CAB-WSD-L081021>
References: <20230517133309.9874-1-ddrokosov@sberdevices.ru>
 <20230517133309.9874-7-ddrokosov@sberdevices.ru>
 <CAFBinCBs7-9CvfQLxLoG5=FjmSK+S5eGsLXOAyQN9kNOg2q-2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCBs7-9CvfQLxLoG5=FjmSK+S5eGsLXOAyQN9kNOg2q-2g@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/22 08:14:00 #21365129
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

Thank you so much for the review, I really appreciate it!
Please find my comments below.

On Fri, May 19, 2023 at 11:03:54PM +0200, Martin Blumenstingl wrote:
> Hi Dmitry,
> 
> On Wed, May 17, 2023 at 3:33 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> [...]
> > +static struct clk_regmap sys_b_sel = {
> > +       .data = &(struct clk_regmap_mux_data){
> > +               .offset = SYS_CLK_CTRL0,
> > +               .mask = 0x7,
> > +               .shift = 26,
> > +               .table = mux_table_sys,
> > +       },
> > +       .hw.init = &(struct clk_init_data){
> > +               .name = "sys_b_sel",
> > +               .ops = &clk_regmap_mux_ro_ops,
> the sys_*_sel muxes and sys_*_gate are _ro...
> 
> > +               .parent_data = sys_parents,
> > +               .num_parents = ARRAY_SIZE(sys_parents),
> > +       },
> > +};
> > +
> > +static struct clk_regmap sys_b_div = {
> > +       .data = &(struct clk_regmap_div_data){
> > +               .offset = SYS_CLK_CTRL0,
> > +               .shift = 16,
> > +               .width = 10,
> > +       },
> > +       .hw.init = &(struct clk_init_data){
> > +               .name = "sys_b_div",
> > +               .ops = &clk_regmap_divider_ops,
> ...but the sys_*_div aren't
> Is this on purpose? If it is: why can the divider be changed at
> runtime but the mux can't?
> 

Ah, that's a good catch. Since the system clock is set up by the BootROM
code, all sys_* dividers and gates should be read-only. I'll make sure
to change that in the next version.

> [...]
> > +/*
> > + * the index 2 is sys_pll_div16, it will be implemented in the CPU clock driver,
> We need to add the "sys_pll_div16" input to the dt-bindings since they
> should always describe the hardware (regardless of what the driver
> implements currently).
> I'm not sure how to manage this while we don't have the CPU clock
> driver ready yet but I'm sure Rob or Krzysztof will be able to help us
> here.
> 

I've shared my thoughts about it in the bindings thread. Please take a
look.

> > + * the index 4 is the clock measurement source, it's not supported yet
> I suspect that this comes from the clock measurer IP block and if so
> the dt-bindings should probably describe this input. But again, we'd
> need to keep it optional for now since our clock measurer driver
> doesn't even implement a clock controller.
> 

Indeed, this is a similar situation to what we have with the inputs and
clocks of the CPU and Audio clock controllers. It seems like there is
only one option here: we should mark it with a TODO tag...

> [...]
> > +static struct clk_regmap pwm_a_sel = {
> > +       .data = &(struct clk_regmap_mux_data){
> > +               .offset = PWM_CLK_AB_CTRL,
> > +               .mask = 0x1,
> > +               .shift = 9,
> > +       },
> > +       .hw.init = &(struct clk_init_data){
> > +               .name = "pwm_a_sel",
> > +               .ops = &clk_regmap_mux_ops,
> > +               .parent_data = pwm_abcd_parents,
> > +               .num_parents = ARRAY_SIZE(pwm_abcd_parents),
> > +               /* For more information, please refer to rtc clock */
> > +               .flags = CLK_SET_RATE_NO_REPARENT,
> As mentioned in [0] we'll work with Heiner to see if we can improve
> the decision making process of the PWM controller driver so that we
> can just have .flags = 0 here.
> This applies to all other occurrences of the same comment about the rtc clock.

Sure, I'll make the change in v16. In my opinion, we should remove the
CLK_SET_RATE_NO_REPARENT flag from all RTC related clock objects,
including PWM, regardless of the outcome of the Heiner discussion. Based
on our IRC talk, the decision has more pros than cons -
https://libera.irclog.whitequark.org/linux-amlogic/2023-05-18

-- 
Thank you,
Dmitry
