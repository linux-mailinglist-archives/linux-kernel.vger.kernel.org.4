Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5576D6EDD64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjDYH5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDYH5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:57:51 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DFD5247;
        Tue, 25 Apr 2023 00:57:38 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9B8A17F8E;
        Tue, 25 Apr 2023 15:57:26 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Apr
 2023 15:57:26 +0800
Received: from [192.168.125.106] (113.72.145.137) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Apr
 2023 15:57:25 +0800
Message-ID: <a7cdfabf-2312-eaf3-f462-5bda7f0a120d@starfivetech.com>
Date:   Tue, 25 Apr 2023 15:57:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <vkoul@kernel.org>,
        <linux-phy@lists.infradead.org>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-2-changhuang.liang@starfivetech.com>
 <20230419-labored-camper-644d51a7ca96@spud>
 <1a5b15fa-4f20-51c2-2ba1-a04a2911a694@starfivetech.com>
 <20230424-baffle-punch-ec73098f2b6a@spud>
 <d685a1d4-c07d-7dfa-f1fb-b35ceb2aa0eb@starfivetech.com>
 <20230425-unquote-eligible-09f743d81981@wendy>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230425-unquote-eligible-09f743d81981@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.137]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>>  
>>>>>>  description: |
>>>>>>    StarFive JH7110 SoC includes support for multiple power domains which can be
>>>>>> @@ -17,6 +18,7 @@ properties:
>>>>>>    compatible:
>>>>>>      enum:
>>>>>>        - starfive,jh7110-pmu
>>>>>> +      - starfive,jh7110-aon-pmu
>>>
>>> I was speaking to Rob about this over the weekend, he asked:
>>> 'Why isn't "starfive,jh7110-aon-syscon" just the power-domain provider
>>> itself?'
>>
>> Maybe not, this syscon only offset "0x00" configure power switch.
>> other offset configure other functions, maybe not power, so this
>> "starfive,jh7110-aon-syscon" not the power-domain itself.
>>
>>> Do we actually need to add a new binding for this at all?
>>>
>>> Cheers,
>>> Conor.
>>>
>>
>> Maybe this patch do that.
>> https://lore.kernel.org/all/20230414024157.53203-6-xingyu.wu@starfivetech.com/
> 
> This makes it a child-node right? I think Rob already said no to that in
> and earlier revision of this series. What he meant the other day was
> making the syscon itself a power domain controller, since the child node
> has no meaningful properties (reg, interrupts etc).
> 
> Cheers,
> Conor.

Yes, "starfive,jh7110-aon-pmu" is a child-node of "starfive,jh7110-aon-syscon".
In my opinion, "0x17010000" is "aon-syscon" on JH7110 SoC, and this "aon-pmu" is just 
a part of "aon-syscon" function, so I think it is inappropriate to make "aon-syscon"
to a power domain controller. I think using the child-node description is closer to
JH7110 SoC. 
