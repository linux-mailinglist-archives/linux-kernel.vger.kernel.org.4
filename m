Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F7697DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBOOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBOOEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:04:00 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBEE2940C;
        Wed, 15 Feb 2023 06:03:55 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 7AD6B24E313;
        Wed, 15 Feb 2023 22:03:45 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 22:03:45 +0800
Received: from [192.168.125.110] (183.27.97.168) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 22:03:44 +0800
Message-ID: <af42ed91-95aa-014a-1efb-6f70ee5a0433@starfivetech.com>
Date:   Wed, 15 Feb 2023 22:03:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 7/7] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Conor Dooley" <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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
        <linux-kernel@vger.kernel.org>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-8-hal.feng@starfivetech.com>
 <CAJM55Z9Y_fF+4Dtu++C_jVS0+ohXp5U0GyuJCBpUh-SpTMGrVA@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z9Y_fF+4Dtu++C_jVS0+ohXp5U0GyuJCBpUh-SpTMGrVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.168]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
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

On 2/14/2023 5:53 PM, Emil Renner Berthing wrote:
> On Tue, 20 Dec 2022 at 02:12, Hal Feng <hal.feng@starfivetech.com> wrote:
>>
>> From: Emil Renner Berthing <kernel@esmil.dk>
>>
>> Add a minimal device tree for StarFive JH7110 VisionFive 2 board
>> which has version A and version B. Support booting and basic
>> clock/reset/pinctrl/uart drivers.
>>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  arch/riscv/boot/dts/starfive/Makefile         |   1 +
>>  .../jh7110-starfive-visionfive-2-va.dts       |  13 ++
>>  .../jh7110-starfive-visionfive-2-vb.dts       |  13 ++
>>  .../jh7110-starfive-visionfive-2.dtsi         | 111 ++++++++++++++++++
>>  4 files changed, 138 insertions(+)
>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts
>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts
>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>>
>> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
>> index 0ea1bc15ab30..79e925a4a227 100644
>> --- a/arch/riscv/boot/dts/starfive/Makefile
>> +++ b/arch/riscv/boot/dts/starfive/Makefile
>> @@ -1,2 +1,3 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb
>> +dtb-$(CONFIG_SOC_STARFIVE) += jh7110-starfive-visionfive-2-va.dtb jh7110-starfive-visionfive-2-vb.dtb
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts
>> new file mode 100644
>> index 000000000000..188d3fddbe88
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
>> + */
>> +
>> +/dts-v1/;
>> +#include "jh7110-starfive-visionfive-2.dtsi"
>> +
>> +/ {
>> +       model = "StarFive VisionFive 2 VA";
>> +       compatible = "starfive,visionfive-2-va", "starfive,jh7110";
>> +};
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts
>> new file mode 100644
>> index 000000000000..f75c10536f84
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
>> + */
>> +
>> +/dts-v1/;
>> +#include "jh7110-starfive-visionfive-2.dtsi"
>> +
>> +/ {
>> +       model = "StarFive VisionFive 2 VB";
>> +       compatible = "starfive,visionfive-2-vb", "starfive,jh7110";
> 
> Hi Hal,
> 
> I just want to double check, is "VisionFive 2 VA" / "visoinfive-2-va"
> and "VisionFive 2 VB" / "visionfive-2-vb" really what you want? I
> still think having these names match what is printed on the silkscreen
> makes it a lot easier for everybody. Even your own releases calls the
> boards "v1.2A" and "v1.3B":
> https://github.com/starfive-tech/VisionFive2/releases/
> 
> So I'd suggest
> model = "StarFive VisionFive 2 v1.3B";
> compatible = "starfive,visionfive-2-v1.3b", "starfive,jh7110";
> 
> I haven't seen these "VA" and "VB" anywhere else, so if you don't want
> the version numbers and can promise that there will be no incompatible
> future revisions of the boards then maybe just drop the "V". Eg.
> model = "StarFive VisionFive 2 B";
> compatible = "starfive,visionfive-2-b", "starfive,jh7110";

The version A board has reached the end of life. As far as I know, the
version B board will not update also unless there are some important
requirements and StarFive decides to update. Furthermore, it's too late
to change the compatible as patch 1 was already accepted. Will it be
easier to read if I modify it as below?

	model = "StarFive VisionFive 2 vB";
	compatible = "starfive,visionfive-2-vb", "starfive,jh7110";

Best regards,
Hal
