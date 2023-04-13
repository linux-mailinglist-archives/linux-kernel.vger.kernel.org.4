Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223AF6E03FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 04:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDMCMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 22:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDMCMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:12:07 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9D74C3D;
        Wed, 12 Apr 2023 19:12:05 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A23618016;
        Thu, 13 Apr 2023 10:11:55 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Apr
 2023 10:11:55 +0800
Received: from [192.168.125.82] (183.27.97.249) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Apr
 2023 10:11:54 +0800
Message-ID: <bc14ff65-a4ad-c9cd-8348-c27249418eab@starfivetech.com>
Date:   Thu, 13 Apr 2023 10:11:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/7] dt-bindings: power: Constrain properties for
 JH7110 PMU
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-2-changhuang.liang@starfivetech.com>
 <cb97cf01-2dfd-7f93-2048-e05a806d468f@linaro.org>
 <ee406b3d-0719-9332-cab5-62fe7537bcf1@starfivetech.com>
 <20230412-trifle-outplayed-8a1c795fab8b@wendy>
 <d59439c1-bce1-b4a1-0e05-77afc4fc2ebb@linaro.org>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <d59439c1-bce1-b4a1-0e05-77afc4fc2ebb@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/12 19:29, Krzysztof Kozlowski wrote:
> On 12/04/2023 11:42, Conor Dooley wrote:
>> On Wed, Apr 12, 2023 at 04:51:16PM +0800, Changhuang Liang wrote:
>>>
>>>
>>> On 2023/4/12 16:35, Krzysztof Kozlowski wrote:
>>>> On 11/04/2023 08:47, Changhuang Liang wrote:
>>>>> When use "starfive,jh7110-pmu-dphy" compatible, do not need the reg and
>>>>> interrupts properties.
>>> [...]
>>>>>  
>>>>>  description: |
>>>>>    StarFive JH7110 SoC includes support for multiple power domains which can be
>>>>> @@ -17,6 +18,7 @@ properties:
>>>>>    compatible:
>>>>>      enum:
>>>>>        - starfive,jh7110-pmu
>>>>> +      - starfive,jh7110-pmu-dphy
>>>>
>>>> You do here much more than commit msg says.
>>>>
>>>> Isn'y DPHY a phy? Why is it in power?
>>>>
>>>
>>> OK, I will add more description. This is a power framework used to turn on/off 
>>> DPHY. So it in power, not a phy.
>>
>> Perhaps tie it less to its role w/ the phy, and more to do with its
>> location, say "jh7110-aon-pmu"?
>> There's already "aon"/"sys"/"stg" stuff used in clock-controller and
>> syscon compatibles etc.
>>
>> Krzysztof, what do you think of that? (if you remember the whole
>> discussion we previously had about using those identifiers a few weeks
>> ago).
> 
> Depends whether this is the same case or not. AFAIR, for AON/SYS/STG
> these were blocks with few features, not only clock controller.
> 
> This sounds like just phy. Powering on/off phy is still a job of phy
> controller... unless it is a power domain controller.
> Best regards,
> Krzysztof
> 

Hi, Coner and Krzysztof,

Next version I will change commit message:

dt-bindings: power: Add JH7110 DPHY PMU support.

Add DPHY PMU for StarFive JH7110 SoC, it can be used to turn on/off DPHY rx/tx
power switch, and it don't need the reg and interrupt properties.

I think this commit message will helpful for you to understand it.

Best regards,
Changhuang
