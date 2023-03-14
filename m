Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8712D6B978E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjCNOTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCNOTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:19:06 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD9E93EB;
        Tue, 14 Mar 2023 07:19:04 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id B666124DCBE;
        Tue, 14 Mar 2023 22:19:00 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Mar
 2023 22:19:00 +0800
Received: from [192.168.125.74] (113.72.145.194) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Mar
 2023 22:18:59 +0800
Message-ID: <518f47e4-7fc6-7715-93dd-2a3b1b4acadf@starfivetech.com>
Date:   Tue, 14 Mar 2023 22:18:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 11/21] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ben Dooks <ben.dooks@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-riscv@lists.infradead.org>, Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <linux-clk@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
 <20230311090733.56918-12-hal.feng@starfivetech.com>
 <167854282659.42837.5915012938593380363.robh@kernel.org>
 <80549148-1bad-9190-c4ea-a9555d15ca38@starfivetech.com>
 <834fb899-7a03-ba0a-8302-f64ea58c60dd@linaro.org>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <834fb899-7a03-ba0a-8302-f64ea58c60dd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.194]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 08:51:20 +0100, Krzysztof Kozlowski wrote:
> On 13/03/2023 03:47, Hal Feng wrote:
>> On Sat, 11 Mar 2023 08:17:00 -0600, Rob Herring wrote:
>>> On Sat, 11 Mar 2023 17:07:23 +0800, Hal Feng wrote:
>>>> From: Emil Renner Berthing <kernel@esmil.dk>
>>>>
>>>> Add bindings for the system clock and reset generator (SYSCRG) on the
>>>> JH7110 RISC-V SoC by StarFive Ltd.
>>>>
>>>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>>> ---
>>>>  .../clock/starfive,jh7110-syscrg.yaml         | 104 +++++++++
>>>>  MAINTAINERS                                   |   8 +-
>>>>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 203 ++++++++++++++++++
>>>>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 142 ++++++++++++
>>>>  4 files changed, 454 insertions(+), 3 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>>>>  create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>>>>  create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
>>>>
>>>
>>>
>>> Please add Acked-by/Reviewed-by tags when posting new versions. However,
>>> there's no need to repost patches *only* to add the tags. The upstream
>>> maintainer will do that for acks received on the version they apply.
>>>
>>> If a tag was not added on purpose, please state why and what changed.
>>>
>>> Missing tags:
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>> 
>> This patch has been changed a lot and I am not sure whether it's still
>> the one you want. So I removed the Reviewed-by tag.
> 
> Then mention it in changelog, just like Rob asked:
> "If a tag was not added on purpose, please state why and what changed."
> I don't see any explanation in the changelog about it.

So sorry for missing that. Thank you for your suggestions.

Best regards,
Hal
