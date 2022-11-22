Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB576331BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiKVBCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiKVBCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:02:51 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5112B1144F;
        Mon, 21 Nov 2022 17:02:45 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id EFE6924E1B5;
        Tue, 22 Nov 2022 09:02:37 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 09:02:38 +0800
Received: from [192.168.125.106] (113.72.144.23) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 09:02:38 +0800
Message-ID: <1db979d5-1fb6-f3c9-8ce0-e3e2e23e5d14@starfivetech.com>
Date:   Tue, 22 Nov 2022 09:02:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 07/14] dt-bindings: clock: Add StarFive JH7110 system
 and always-on clock definitions
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
 <20221118010627.70576-8-hal.feng@starfivetech.com>
 <4d1fbddc-ee8b-1ab3-d1a9-8496bda3f668@linaro.org>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <4d1fbddc-ee8b-1ab3-d1a9-8496bda3f668@linaro.org>
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

On Mon, 21 Nov 2022 09:45:11 +0100, Krzysztof Kozlowski wrote:
> On 18/11/2022 02:06, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> > 
> > Add all clock outputs for the StarFive JH7110 system (SYS) and
> > always-on (AON) clock generator.
> > 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  MAINTAINERS                                 |   5 +-
> >  include/dt-bindings/clock/starfive-jh7110.h | 234 ++++++++++++++++++++
> >  2 files changed, 237 insertions(+), 2 deletions(-)
> >  create mode 100644 include/dt-bindings/clock/starfive-jh7110.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e6f1060e7964..e97dac9c0ee4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19598,12 +19598,13 @@ M:	Ion Badulescu <ionut@badula.org>
> >  S:	Odd Fixes
> >  F:	drivers/net/ethernet/adaptec/starfire*
> >  
> > -STARFIVE JH7100 CLOCK DRIVERS
> > +STARFIVE CLOCK DRIVERS
> >  M:	Emil Renner Berthing <kernel@esmil.dk>
> > +M:	Hal Feng <hal.feng@starfivetech.com>
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/clock/starfive,jh7100-*.yaml
> >  F:	drivers/clk/starfive/
> > -F:	include/dt-bindings/clock/starfive-jh7100*.h
> > +F:	include/dt-bindings/clock/starfive*
> >  
> >  STARFIVE JH7100 PINCTRL DRIVER
> >  M:	Emil Renner Berthing <kernel@esmil.dk>
> > diff --git a/include/dt-bindings/clock/starfive-jh7110.h b/include/dt-bindings/clock/starfive-jh7110.h
> 
> Filename based / the same as compatible (or bindings filename).

Should I split this file into two files for "SYSCRG" and "AONCRG", which
maybe named as "starfive-jh7110-sys.h" and "starfive-jh7110-aon.h". Ditto
for the patch 8.

Best regards,
Hal
