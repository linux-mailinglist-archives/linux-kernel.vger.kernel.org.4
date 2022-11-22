Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEAA633220
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiKVB1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiKVB05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:26:57 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C4DEAF6;
        Mon, 21 Nov 2022 17:26:55 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9ECF524E09F;
        Tue, 22 Nov 2022 09:26:48 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 09:26:48 +0800
Received: from [192.168.125.106] (113.72.144.23) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 09:26:49 +0800
Message-ID: <37d5a252-6540-7ba1-41f0-f68cb1c817d1@starfivetech.com>
Date:   Tue, 22 Nov 2022 09:26:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 08/14] dt-bindings: reset: Add StarFive JH7110 system
 and always-on reset definitions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-9-hal.feng@starfivetech.com>
 <e4237444-2d3a-d168-f95f-d1b1e6ac95ec@linaro.org>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <e4237444-2d3a-d168-f95f-d1b1e6ac95ec@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.23]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 09:50:13 +0100, Krzysztof Kozlowski wrote:
> On 18/11/2022 02:06, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> > 
> > Add resets for the StarFive JH7110 system (SYS) and always-on (AON)
> > reset controller.
> > 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  MAINTAINERS                                 |   5 +-
> >  include/dt-bindings/reset/starfive-jh7110.h | 154 ++++++++++++++++++++
> >  2 files changed, 157 insertions(+), 2 deletions(-)
> >  create mode 100644 include/dt-bindings/reset/starfive-jh7110.h
> > 
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > +#define JH7110_SYSRST_TIMER0			118
> > +#define JH7110_SYSRST_TIMER1			119
> > +#define JH7110_SYSRST_TIMER2			120
> > +#define JH7110_SYSRST_TIMER3			121
> > +#define JH7110_SYSRST_INT_CTRL_APB		122
> > +#define JH7110_SYSRST_TEMP_APB			123
> > +#define JH7110_SYSRST_TEMP_CORE			124
> > +#define JH7110_SYSRST_JTAG_CERTIFICATION	125
> > +
> > +#define	JH7110_SYSRST_END			126
> 
> Drop weird indentation in the middle of syntax.

Will fix it.

> 
> > +
> > +/* AONCRG resets */
> > +#define JH7110_AONRST_GMAC0_AXI			0
> > +#define JH7110_AONRST_GMAC0_AHB			1
> > +#define JH7110_AONRST_AON_IOMUX			2
> > +#define JH7110_AONRST_PMU_APB			3
> > +#define JH7110_AONRST_PMU_WKUP			4
> > +#define JH7110_AONRST_RTC_APB			5
> > +#define JH7110_AONRST_RTC_CAL			6
> > +#define JH7110_AONRST_RTC_32K			7
> > +
> > +#define	JH7110_AONRST_END			8
> 
> Ditto

Will fix it. Thanks.

Best regards,
Hal
