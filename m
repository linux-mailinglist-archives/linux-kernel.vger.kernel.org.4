Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523EF6A5187
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjB1C6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjB1C6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:58:18 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4AF40D1;
        Mon, 27 Feb 2023 18:58:05 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4BAA124E1A4;
        Tue, 28 Feb 2023 10:58:03 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 10:58:03 +0800
Received: from [192.168.125.82] (113.72.145.171) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 10:58:02 +0800
Message-ID: <9a0f4aa1-be98-cac7-adc4-5af67792a2e2@starfivetech.com>
Date:   Tue, 28 Feb 2023 10:58:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 19/19] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-20-hal.feng@starfivetech.com>
 <CAJM55Z_QMtzKeRFN1iGf498z4+vga6RBgwybCQi6aOUYCr_P-Q@mail.gmail.com>
 <2af3f84b-2c2b-dc79-c76c-9411fcbcf7ca@starfivetech.com>
 <Y/zykfydb+bJ7G2l@spud> <Y/0L4SKKtl49C95j@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y/0L4SKKtl49C95j@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 20:00:33 +0000, Conor Dooley wrote:
> On Mon, Feb 27, 2023 at 06:12:40PM +0000, Conor Dooley wrote:
>> On Thu, Feb 23, 2023 at 04:50:20PM +0800, Hal Feng wrote:
>> > On Tue, 21 Feb 2023 16:03:08 +0100, Emil Renner Berthing wrote:
>> > > On Tue, 21 Feb 2023 at 03:47, Hal Feng <hal.feng@starfivetech.com> wrote:
>> > >> From: Emil Renner Berthing <kernel@esmil.dk>
>> > >>
>> > >> Add a minimal device tree for StarFive JH7110 VisionFive 2 board
>> > >> which has version A and version B. Support booting and basic
>> > >> clock/reset/pinctrl/uart drivers.
>> > >>
>> > >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> > >> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> > >> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> > >> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> > >> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>> > >> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> > >> ---
>> > >>  arch/riscv/boot/dts/starfive/Makefile         |   6 +-
>> > >>  .../jh7110-starfive-visionfive-2-v1.2a.dts    |  13 ++
>> > >>  .../jh7110-starfive-visionfive-2-v1.3b.dts    |  13 ++
>> > >>  .../jh7110-starfive-visionfive-2.dtsi         | 215 ++++++++++++++++++
>> > >>  4 files changed, 246 insertions(+), 1 deletion(-)
>> > >>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dts
>> > >>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
>> > >>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> > >>
>> > >> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
>> > >> index 039c143cba33..cd73519b907b 100644
>> > >> --- a/arch/riscv/boot/dts/starfive/Makefile
>> > >> +++ b/arch/riscv/boot/dts/starfive/Makefile
>> > >> @@ -1,2 +1,6 @@
>> > >>  # SPDX-License-Identifier: GPL-2.0
>> > >> -dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb jh7100-starfive-visionfive-v1.dtb
>> > >> +dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb
>> > >> +dtb-$(CONFIG_SOC_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
>> > >> +
>> > >> +dtb-$(CONFIG_SOC_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
>> > >> +dtb-$(CONFIG_SOC_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
>> 
>> If you could rebase on top of v6.3-rc1 for the next version & use ARCH_
>> not SOC_ here that'd be great.

I will use the ARCH_ symbol instead and tell the other people from StarFive
to do so.

>> 
>> > >> +/ {
>> > >> +       aliases {
>> > >> +               serial0 = &uart0;
>> > >> +               i2c0 = &i2c0;
>> > >> +               i2c2 = &i2c2;
>> > >> +               i2c5 = &i2c5;
>> > >> +               i2c6 = &i2c6;
>> > > 
>> > > Let's keep these sorted alphabetically.
>> > 
>> > OK, will fix it.
>> > 
>> 
>> > > It would be great to have some sort of order to this file so it's
>> > > obvious where to add new nodes. I suggest we do
>> > > - root node
>> > > - external clocks
>> > > - other node references in alphabetical order
>> > > 
>> > > You're almost there with this patch except the uart0 node is out of place.
>> > 
>> > Will fix accordingly. Thanks for your suggestions.
>> 
>> With Emil's suggestions implemented:
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Actually, there's one thing that I don't think was (explicitly?) mentioned,
> could you sort the external clocks alphanumerically too?

OK. I will sort them in the next version. Thanks.

Best regards,
Hal
