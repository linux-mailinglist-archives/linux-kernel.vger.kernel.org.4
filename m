Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7E86D903D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbjDFHMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjDFHMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:12:32 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F336310D1;
        Thu,  6 Apr 2023 00:12:28 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id B452724E32C;
        Thu,  6 Apr 2023 15:03:16 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 6 Apr
 2023 15:03:16 +0800
Received: from [192.168.125.87] (183.27.97.179) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 6 Apr
 2023 15:03:15 +0800
Message-ID: <ce311dcf-67a5-bf15-d0da-88967baf4ee9@starfivetech.com>
Date:   Thu, 6 Apr 2023 15:03:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v7 00/22] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
To:     Conor Dooley <conor@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Marc Zyngier" <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
 <20230405-wharf-rejoin-5222e5958611@spud>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230405-wharf-rejoin-5222e5958611@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.179]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Apr 2023 22:30:45 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> On Sat, 01 Apr 2023 19:19:12 +0800, Hal Feng wrote:
>> This patch series adds basic clock, reset & DT support for StarFive
>> JH7110 SoC.
>> 
>> @Stephen and @Conor, I have made this series start with the shared
>> dt-bindings, so it will be easier to merge.
>> 
>> @Conor, patch 1, 2, 16~21 were already in your branch. Patch 22 is the
>> same with the patch [1] I submitted before, which you had accepted but
>> not merge it into your branch.
>> 
>> [...]
> 
> Applied to riscv-dt-for-next, thanks!

Thank you so much.

> 
> [01/22] dt-bindings: clock: Add StarFive JH7110 system clock and reset generator
>         https://git.kernel.org/conor/c/7fce1e39f019
> [02/22] dt-bindings: clock: Add StarFive JH7110 always-on clock and reset generator
>         https://git.kernel.org/conor/c/3de0c9103258
> 
> These two are shared with clk.
> 
> [16/22] dt-bindings: timer: Add StarFive JH7110 clint
>         https://git.kernel.org/conor/c/1ff5482ab9a5
> [17/22] dt-bindings: interrupt-controller: Add StarFive JH7110 plic
>         https://git.kernel.org/conor/c/8406d19ca049
> 
> I took these bindings too, as Palmer has done that in the past for new
> SoC support.
> 
> [18/22] dt-bindings: riscv: Add SiFive S7 compatible
>         https://git.kernel.org/conor/c/8868caa2a073
> [19/22] riscv: dts: starfive: Add initial StarFive JH7110 device tree
>         https://git.kernel.org/conor/c/60bf0a39842e
> [20/22] riscv: dts: starfive: Add StarFive JH7110 pin function definitions
>         https://git.kernel.org/conor/c/e22f09e598d1
> [21/22] riscv: dts: starfive: Add StarFive JH7110 VisionFive 2 board device tree
>         https://git.kernel.org/conor/c/54baba33392d
> [22/22] riscv: dts: starfive: jh7110: Correct the properties of S7 core
>         (squashed)
> 
> Hal, can you get your folks to resend whatever dts bits that are now
> applicable? IOW, the dt-bindings for the entries are in a for-next
> branch for some subsystem.

Of course. As far as I know, these nodes include trng / pmu / mmc / qspi.

Best regards,
Hal
