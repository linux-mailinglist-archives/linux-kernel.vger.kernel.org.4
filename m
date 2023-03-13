Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F986B6DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCMDD0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 12 Mar 2023 23:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCMDDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:03:19 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D9B3AB9;
        Sun, 12 Mar 2023 20:03:13 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 465AD24E3ED;
        Mon, 13 Mar 2023 11:03:06 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 10:29:13 +0800
Received: from [192.168.125.74] (183.27.96.115) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 10:29:12 +0800
Message-ID: <df2464d3-9e9e-c299-675d-0a3f69856361@starfivetech.com>
Date:   Mon, 13 Mar 2023 10:29:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 10/19] dt-bindings: clock: Add StarFive JH7110
 always-on clock and reset generator
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-11-hal.feng@starfivetech.com>
 <dc88e0df-4e2f-d2b8-4ecb-514862d01c3c@linux-m68k.org>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <dc88e0df-4e2f-d2b8-4ecb-514862d01c3c@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.96.115]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 15:22:54 +0100, Geert Uytterhoeven wrote:
>     Hi Hal, Esmil,
> 
> On Tue, 21 Feb 2023, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>>
>> Add bindings for the always-on clock and reset generator (AONCRG) on the
>> JH7110 RISC-V SoC by StarFive Ltd.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
>> @@ -0,0 +1,76 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-aoncrg.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 Always-On Clock and Reset Generator
>> +
>> +maintainers:
>> +  - Emil Renner Berthing <kernel@esmil.dk>
>> +
> 
> This lacks a top-level "description" section, to anwer the question:
> What is an "Always-On Clock and Reset Generator"?
> 
> To me, "always-on" sounds like it's critical, and thus the driver
> must always be built-in?

AON is a part of JH7110 circuit which is always powered on, but the
AON clocks can be turned off if not used. The JH7110 can boot up
successfully without the AON clock driver, so it's fine to build it
as a module. Thanks.

Best regards,
Hal
