Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9740727ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjFHLdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjFHLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:33:03 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C191734;
        Thu,  8 Jun 2023 04:32:50 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 0B9655FD17;
        Thu,  8 Jun 2023 14:32:48 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686223968;
        bh=ArxZiYt0qp/hxI5ZPD4sF0OBh5tn0afXnbxC4eDwIyU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=bNFA395QIg2BsNA+rX3UafWQ9sOwa9yOQtgOmsdIl2UtMWN8utqHCarZsMceg9yum
         KO5qBWnXTDOGZ5d09RwLOdneTdZYl9ZTuOfvqgygCi6sfwggkdbHzBgXuhIX20l5sV
         s4U9VZqLgVMxUL01k51Hdt1XY2TusRAQMDEodZVEkdYMoamrXWKTus5+M8S1lPSh6V
         qTwKcegboO/TsdBUWvvRlc8reLOrBEP4+iW/J1pckPOIRxucnuR0daee7Gq+CAih68
         RaV64ihAmqTqzBvJKJ+A0ixZCbKMQkadopYAYDLjZxD/4b6WOKuxyquvRd9FmcglkR
         TGwxwbPprNI0A==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  8 Jun 2023 14:32:44 +0300 (MSK)
Date:   Thu, 8 Jun 2023 14:32:44 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     Yu Tu <yu.tu@amlogic.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <kelvin.zhang@amlogic.com>, <qi.duan@amlogic.com>
Subject: Re: [PATCH V9 3/4] clk: meson: S4: add support for Amlogic S4 SoC
 PLL clock driver
Message-ID: <20230608113244.jvf7w4flwjy5soud@CAB-WSD-L081021>
References: <20230517070215.28463-1-yu.tu@amlogic.com>
 <20230517070215.28463-4-yu.tu@amlogic.com>
 <1j5y804q7u.fsf@starbuckisacylon.baylibre.com>
 <73acf297-3f60-1ce1-2f05-af048aa37199@amlogic.com>
 <1jttvi9vnq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jttvi9vnq.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/08 06:55:00 #21458577
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jerome,

On Thu, Jun 08, 2023 at 10:53:31AM +0200, Jerome Brunet wrote:
> 
> >>> +
> >>> +static struct clk_regmap s4_fclk_div4 = {
> >>> +     .data = &(struct clk_regmap_gate_data){
> >>> +             .offset = ANACTRL_FIXPLL_CTRL1,
> >>> +             .bit_idx = 21,
> >>> +     },
> >>> +     .hw.init = &(struct clk_init_data){
> >>> +             .name = "fclk_div4",
> >>> +             /*
> >>> +              * For more information, please refer to s4_fixed_pll_dco.
> >>> +              */
> >> While div2 and div3 got an explanation from previous SoCs, they others -
> >> like div4/div7/etc ... - have been able to cope with rw ops so far.
> >> Why is the S4 different for all these clocks ?
> >
> > The chip was changed fixed pll for security reasons.
> >
> > Fixed PLL registers are not writable in the kernel phase. Write of fixed
> > PLL-related register will cause the system to crash.
> >
> 
> That is definitely worth mentionning
> 
> >> Requiring RO ops (or fishy clock flags) is usually a sign that a clock
> >> is used without an appropriate driver.
> >>
> 
> Neil is currently dealing with the dt-bindings, please
> * Adjust your patchset accordingly
> * Wait for his v2 to land, you'll need it.
> 

I saw Neil patch series with merging 'private' and 'public' clock
bindings parts. Should I send the same patchset for a1 clocks after v6.5
landed?

> >>> +             .ops = &clk_regmap_gate_ro_ops,
> >>> +             .parent_hws = (const struct clk_hw *[]) {
> >>> +                     &s4_fclk_div4_div.hw
> >>> +             },
> >>> +             .num_parents = 1,
> >>> +     },
> >>> +};
> >>> +
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
