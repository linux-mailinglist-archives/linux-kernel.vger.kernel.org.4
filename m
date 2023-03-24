Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E364A6C7862
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCXHDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXHDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:03:51 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB03133;
        Fri, 24 Mar 2023 00:03:48 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4220624E1E2;
        Fri, 24 Mar 2023 15:03:42 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Mar
 2023 15:03:42 +0800
Received: from [192.168.125.74] (113.72.145.117) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Mar
 2023 15:03:41 +0800
Message-ID: <0c9c19ad-815c-fb0f-3024-96ea55e7c6c0@starfivetech.com>
Date:   Fri, 24 Mar 2023 15:03:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v6 19/21] riscv: dts: starfive: Add initial StarFive
 JH7110 device tree
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
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
        Marc Zyngier <maz@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230320103750.60295-1-hal.feng@starfivetech.com>
 <20230320103750.60295-20-hal.feng@starfivetech.com>
 <60359574-8bce-40f2-99db-6d81f6e6c5c3@spud>
 <6ce5b897-f1c2-4b58-9353-9d9e881ad237@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <6ce5b897-f1c2-4b58-9353-9d9e881ad237@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.117]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 09:03:23 +0000, Conor Dooley wrote:
> On Wed, Mar 22, 2023 at 10:02:40PM +0000, Conor Dooley wrote:
>> On Mon, Mar 20, 2023 at 06:37:48PM +0800, Hal Feng wrote:
>> > From: Emil Renner Berthing <kernel@esmil.dk>
>> > 
>> > Add initial device tree for the JH7110 RISC-V SoC by StarFive
>> > Technology Ltd.
>> > 
>> > Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
>> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> > Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> > Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> > Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> > ---
>> 
>> > +		S7_0: cpu@0 {
>> > +			compatible = "sifive,s7", "riscv";
>> > +			reg = <0>;
>> > +			d-cache-block-size = <64>;
>> > +			d-cache-sets = <64>;
>> > +			d-cache-size = <8192>;
>> > +			d-tlb-sets = <1>;
>> > +			d-tlb-size = <40>;
>> > +			device_type = "cpu";
>> > +			i-cache-block-size = <64>;
>> > +			i-cache-sets = <64>;
>> > +			i-cache-size = <16384>;
>> > +			i-tlb-sets = <1>;
>> > +			i-tlb-size = <40>;
>> > +			mmu-type = "riscv,sv39";
>> > +			next-level-cache = <&ccache>;
>> > +			riscv,isa = "rv64imac_zba_zbb";
>> > +			tlb-split;
>> > +			status = "disabled";
>> 
>> Jess pointed out on IRC that this S7 entry looks wrong as it is claiming
>> that the S7 has an mmu. I didn't go looking back in the history of
>> u74-mc core complex manuals, but the latest version does not show an mmu
>> for the S7.
> 
> BTW Hal, if the dt-binding stuff is okay with Emil, I can just remove
> the mmu here if you confirm it is a mistake rather than you needing to
> resubmit to remove it.

I confirm that the S7 core has no L1 data cache and MMU, so some properties
should be deleted. I have submitted a new patch for the correction.

https://lore.kernel.org/all/20230324064651.84670-1-hal.feng@starfivetech.com/

Best regards,
Hal
