Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816496E5686
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjDRBik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDRBij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:38:39 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3A05279;
        Mon, 17 Apr 2023 18:38:34 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 4510D24E12B;
        Tue, 18 Apr 2023 09:38:26 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Apr
 2023 09:38:26 +0800
Received: from [192.168.125.106] (113.72.144.253) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Apr
 2023 09:38:25 +0800
Message-ID: <95dae9c7-ccf9-8e4b-e99b-b4e4bb62257a@starfivetech.com>
Date:   Tue, 18 Apr 2023 09:38:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/7] dt-bindings: power: Constrain properties for
 JH7110 PMU
To:     Conor Dooley <conor@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
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
 <84300997-31f8-b36e-e54e-876c266fc953@starfivetech.com>
 <20230417-ramrod-carpool-cd05b0def1a2@spud>
Content-Language: en-US
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230417-ramrod-carpool-cd05b0def1a2@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/18 2:55, Conor Dooley wrote:
> On Fri, Apr 14, 2023 at 10:20:31AM +0800, Changhuang Liang wrote:
>>
>>
>> On 2023/4/12 19:29, Krzysztof Kozlowski wrote:
>>> On 12/04/2023 11:42, Conor Dooley wrote:
>>>> On Wed, Apr 12, 2023 at 04:51:16PM +0800, Changhuang Liang wrote:
>>>>>
>>>>>
>>>>> On 2023/4/12 16:35, Krzysztof Kozlowski wrote:
>>>>>> On 11/04/2023 08:47, Changhuang Liang wrote:
>>>>>>> When use "starfive,jh7110-pmu-dphy" compatible, do not need the reg and
>>>>>>> interrupts properties.
>>>>> [...]
>>>>>>>  
>>>>>>>  description: |
>>>>>>>    StarFive JH7110 SoC includes support for multiple power domains which can be
>>>>>>> @@ -17,6 +18,7 @@ properties:
>>>>>>>    compatible:
>>>>>>>      enum:
>>>>>>>        - starfive,jh7110-pmu
>>>>>>> +      - starfive,jh7110-pmu-dphy
>>>>>>
>>>>>> You do here much more than commit msg says.
>>>>>>
>>>>>> Isn'y DPHY a phy? Why is it in power?
>>>>>>
>>>>>
>>>>> OK, I will add more description. This is a power framework used to turn on/off 
>>>>> DPHY. So it in power, not a phy.
>>
>> I found something wrong with my description here, not turn on/off DPHY,
>> is turn on/off DPHY power switch. 
>>
>>>>
>>>> Perhaps tie it less to its role w/ the phy, and more to do with its
>>>> location, say "jh7110-aon-pmu"?
>>>> There's already "aon"/"sys"/"stg" stuff used in clock-controller and
>>>> syscon compatibles etc.
>>>>
>>>> Krzysztof, what do you think of that? (if you remember the whole
>>>> discussion we previously had about using those identifiers a few weeks
>>>> ago).
>>>
>>> Depends whether this is the same case or not. AFAIR, for AON/SYS/STG
>>> these were blocks with few features, not only clock controller.
>>>
>>> This sounds like just phy. Powering on/off phy is still a job of phy
>>> controller... unless it is a power domain controller.
>>> Best regards,
>>> Krzysztof
>>>
>>
>> So, next version the compatible can be changed to "jh7110-aon-pmu"?
> 
> Hmm, is the dphy the only thing that's power is controlled by registers
> in the aon syscon? I tried looking in the "preliminary" TRM that I have,
> but it's not really got a proper register map so I could not tell.
> 
> If there are, it'd help your case I think Changhuang Liang.

I made a discussion with Walker, We don't use other bit on the visionfive2 
board. And I first naming by function. So I will change to "jh7110-aon-pmu"
next version.
