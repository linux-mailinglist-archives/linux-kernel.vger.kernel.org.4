Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29B369418B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBMJly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBMJlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:41:51 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14F23AA5;
        Mon, 13 Feb 2023 01:41:21 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 75D0B24E154;
        Mon, 13 Feb 2023 17:41:04 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Feb
 2023 17:41:04 +0800
Received: from [192.168.125.110] (183.27.97.168) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Feb
 2023 17:41:03 +0800
Message-ID: <e1d2646e-b5de-298e-bb91-19ad12fd31af@starfivetech.com>
Date:   Mon, 13 Feb 2023 17:41:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-7-hal.feng@starfivetech.com> <Y6zHy9oL4xzl+6Rd@spud>
 <c507e0b2-5ca3-cffe-55d2-873ed8c24e3d@starfivetech.com>
 <Y9og8Q2UnJ452KH/@wendy>
 <df6755ed-a358-ea01-d89e-f3c004b9c297@starfivetech.com>
 <Y9wR7Up+iObw5qoE@spud> <Y+TU98PLIvtkD8/R@wendy>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y+TU98PLIvtkD8/R@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.168]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 11:11:51 +0000, Conor Dooley wrote:
> On Thu, Feb 02, 2023 at 07:41:33PM +0000, Conor Dooley wrote:
>> On Fri, Feb 03, 2023 at 02:56:41AM +0800, Hal Feng wrote:
>> > On Wed, 1 Feb 2023 08:21:05 +0000, Conor Dooley wrote:
>> > > On Wed, Feb 01, 2023 at 03:21:48PM +0800, Hal Feng wrote:
>> > >> On Wed, 28 Dec 2022 22:48:43 +0000, Conor Dooley wrote:
>> > >> > On Tue, Dec 20, 2022 at 09:12:46AM +0800, Hal Feng wrote:
> 
>> FWIW, the deadline for getting material in for v6.3 has already passed,
>> so you can send the next version of this series without waiting for
>> clarification on the compatibles & ISA string. We should have plenty of
>> time to get those fixed up before the series gets applied.
> 
> Also, as it looks like the pinctrl driver is going to land in time for
> v6.3, that leaves just this series and the clock driver required for
> base support.
> 
> In the original submission, you sent the clock driver and dt in the same
> series & I think it might make the process a bit faster if you sent them
> both together for the next version again.
> 
> That way, both the drivers and dts can go together as their have an
> inter dependence.
> 
> That's my opinion anyway, will make trying to sequence things between
> trees easier.

Good idea. But how can I write the change log if we do so? Will it make
the history confused? Thanks.

Best regards,
Hal
