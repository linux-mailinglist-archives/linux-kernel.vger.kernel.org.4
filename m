Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9069EC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBVBsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBVBsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:48:07 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2718DEB50;
        Tue, 21 Feb 2023 17:48:00 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E426F24E1D1;
        Wed, 22 Feb 2023 09:47:51 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 22 Feb
 2023 09:47:51 +0800
Received: from [192.168.125.128] (113.72.147.165) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 22 Feb
 2023 09:47:50 +0800
Message-ID: <7b3e09f0-a44f-0735-a049-eef7f0acec4c@starfivetech.com>
Date:   Wed, 22 Feb 2023 09:48:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 01/11] dt-bindings: clock: Add StarFive JH7110
 System-Top-Group clock and reset generator
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
 <20230221083323.302471-2-xingyu.wu@starfivetech.com>
 <430318ed-5b30-e549-a5ce-df83aa18adf9@linaro.org>
 <43d00fd9-ab24-442e-3f82-208edaf399d0@starfivetech.com>
 <ae468e63-d8d3-dbfb-64da-75a147e1cd2d@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <ae468e63-d8d3-dbfb-64da-75a147e1cd2d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.165]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/21 21:37, Krzysztof Kozlowski wrote:
> On 21/02/2023 14:01, Xingyu Wu wrote:
>> On 2023/2/21 19:25, Krzysztof Kozlowski wrote:
>>> On 21/02/2023 09:33, Xingyu Wu wrote:
>>>> Add bindings for the System-Top-Group clock and reset generator (STGCRG)
>>>> on the JH7110 RISC-V SoC by StarFive Ltd.
>>>>
>>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>
>>>
>>>> +    };
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 93eb504c3b21..2e70c9f21989 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -19914,6 +19914,7 @@ F:	arch/riscv/boot/dts/starfive/
>>>>  STARFIVE JH71X0 CLOCK DRIVERS
>>>>  M:	Emil Renner Berthing <kernel@esmil.dk>
>>>>  M:	Hal Feng <hal.feng@starfivetech.com>
>>>> +M:	Xingyu Wu <xingyu.wu@starfivetech.com>
>>>
>>> No improvements here. You add here new bindings for one device and then
>>> - without explanation - add yourself to all Starfive clock bindings.
>>> Either explain it or drop it or move it to separate patch.
>>>
>>> You already got comment for this.
>>>
>> 
>> Sorry, I didn't understand what you meant before. Now my understanding is that, 
>> If I improvements JH71X0 driver no JH7110 driver, I could add this here. Right?
>> 
>> Is it OK if I do it this way to move it to separate patch like this?:
>> +STARFIVE JH7110 STG CLOCK DRIVERS
>> +M:	Xingyu Wu <xingyu.wu@starfivetech.com>
> 
> If you want to be the maintainer of all drivers, add separate commit for
> this, so this is obvious. Or at least explain this change in commit msg.
> 

OK, got it. Thanks.

Best regard,
Xingyu Wu

