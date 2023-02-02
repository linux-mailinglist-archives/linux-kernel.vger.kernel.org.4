Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94D0687364
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 03:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjBBCml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 21:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBBCmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 21:42:39 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADED2199DA;
        Wed,  1 Feb 2023 18:42:35 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DC29024E02F;
        Thu,  2 Feb 2023 10:42:33 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 2 Feb
 2023 10:42:34 +0800
Received: from [192.168.125.110] (113.72.144.84) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 2 Feb
 2023 10:42:32 +0800
Message-ID: <0ff800a1-5e90-64bc-af53-2736e698c9e4@starfivetech.com>
Date:   Thu, 2 Feb 2023 10:42:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
From:   Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
To:     Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
 <20221220011247.35560-7-hal.feng@starfivetech.com>
 <0db7824b-184d-dfae-f61d-3048392c9895@starfivetech.com>
 <39F228FA-2298-4813-9BDE-7100DE920213@kernel.org>
Content-Language: en-US
In-Reply-To: <39F228FA-2298-4813-9BDE-7100DE920213@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.84]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 06:17:17 +0000, Conor Dooley wrote:
> On 31 January 2023 02:00:26 GMT, Hal Feng <hal.feng@starfivetech.com> wrote:
>>On Tue, 20 Dec 2022 09:12:46 +0800, Hal Feng wrote:
>>> From: Emil Renner Berthing <kernel@esmil.dk>
>>> 
>>> Add initial device tree for the JH7110 RISC-V SoC by StarFive
>>> Technology Ltd.
>>> 
>>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>>> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>>> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>> ---
>>>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 411 +++++++++++++++++++++++
>>>  1 file changed, 411 insertions(+)
>>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
>>
>>I wanna add i2c nodes (i2c0-6) in the next version, so someone else
>>can use them when they submit i2c driver patches.
> 
> All of the other series depend on this one for enablement,
> so unless the binding for i2c is already upstream I'd advise keeping it separate.

The i2c IP of JH7110 is from Synopsys and the same as the i2c IP in JH7100.
The binding and driver for i2c are already upstream. It works as long as we
add the i2c nodes and configure pins for i2c in device tree. It will simplify
the dependency if we do that.

By the way, I am checking the ISA of U74-MC on JH7110 with someone else.
I will reply you today.

Best regards,
Hal
