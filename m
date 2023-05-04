Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08C76F654E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjEDGx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjEDGxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:53:54 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC23E4;
        Wed,  3 May 2023 23:53:51 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 167C024E23C;
        Thu,  4 May 2023 14:53:38 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 4 May
 2023 14:53:37 +0800
Received: from [192.168.125.107] (183.27.99.121) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 4 May
 2023 14:53:36 +0800
Message-ID: <482e812a-05dd-105c-189c-e926b4be9d28@starfivetech.com>
Date:   Thu, 4 May 2023 14:53:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
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
References: <20230419-labored-camper-644d51a7ca96@spud>
 <1a5b15fa-4f20-51c2-2ba1-a04a2911a694@starfivetech.com>
 <20230424-baffle-punch-ec73098f2b6a@spud>
 <d685a1d4-c07d-7dfa-f1fb-b35ceb2aa0eb@starfivetech.com>
 <20230425-unquote-eligible-09f743d81981@wendy>
 <a7cdfabf-2312-eaf3-f462-5bda7f0a120d@starfivetech.com>
 <68cb565d-bf39-10b0-9e3e-35ba7f54b90b@linaro.org>
 <0988495f-b87a-7f69-f222-37c67d6eae23@starfivetech.com>
 <20230425-resale-footrest-de667778c4fe@wendy>
 <663e9933-b9b3-a48f-98b6-2207215a8ed7@starfivetech.com>
 <20230425-commotion-prewashed-876247bed4ab@spud>
 <0b0f9187-ad6b-a1d9-6ec4-beb8989ca731@starfivetech.com>
 <3ed72340-accc-4ad1-098f-4a2eb6448828@linaro.org>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <3ed72340-accc-4ad1-098f-4a2eb6448828@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.99.121]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/4 14:13, Krzysztof Kozlowski wrote:
> On 04/05/2023 03:34, Changhuang Liang wrote:
>>
>>
>> On 2023/4/26 0:56, Conor Dooley wrote:
>>> On Tue, Apr 25, 2023 at 08:26:35PM +0800, Changhuang Liang wrote:
>>>> On 2023/4/25 17:35, Conor Dooley wrote:
>>>>> On Tue, Apr 25, 2023 at 05:18:10PM +0800, Changhuang Liang wrote:
>>>>>> On 2023/4/25 16:19, Krzysztof Kozlowski wrote:
>>>>>>> On 25/04/2023 09:57, Changhuang Liang wrote:
>>>>>>>> Yes, "starfive,jh7110-aon-pmu" is a child-node of "starfive,jh7110-aon-syscon".
>>>>>>>> In my opinion, "0x17010000" is "aon-syscon" on JH7110 SoC, and this "aon-pmu" is just 
>>>>>>>> a part of "aon-syscon" function, so I think it is inappropriate to make "aon-syscon"
>>>>>>>> to a power domain controller. I think using the child-node description is closer to
>>>>>>>> JH7110 SoC. 
>>>>>>>
>>>>>>> Unfortunately, I do not see the correlation between these, any
>>>>>>> connection. Why being a child of syscon block would mean that this
>>>>>>> should no be power domain controller? Really, why? These are two
>>>>>>> unrelated things.
>>>>>>
>>>>>> Let me summarize what has been discussed above. 
>>>>>>
>>>>>> There has two ways to describe this "starfive,jh7110-aon-syscon"(0x17010000).
>>>>>> 1. (0x17010000) is power-controller node:
>>>>>>
>>>>>> 	aon_pwrc: power-controller@17010000 {
>>>>>> 		compatible = "starfive,jh7110-aon-pmu", "syscon";
>>>>>> 		reg = <0x0 0x17010000 0x0 0x1000>;
>>>>>> 		#power-domain-cells = <1>;
>>>>>> 	};
>>>>>>
>>>>>>
>>>>>> 2. (0x17010000) is syscon node, power-controller is child-node of syscon:
>>>>>>
>>>>>> 	aon_syscon: syscon@17010000 {
>>>>>> 		compatible = "starfive,jh7110-aon-syscon", "syscon", "simple-mfd";
>>>>>> 		reg = <0x0 0x17010000 0x0 0x1000>;
>>>>>>
>>>>>> 		aon_pwrc: power-controller {
>>>>>> 			compatible = "starfive,jh7110-aon-pmu";
>>>>>> 			#power-domain-cells = <1>;
>>>>>> 		};
>>>>>> 	};
>>>>>
>>>>> I thought that Rob was suggesting something like this:
>>>>> 	aon_syscon: syscon@17010000 {
>>>>> 		compatible = "starfive,jh7110-aon-syscon", ...
>>>>> 		reg = <0x0 0x17010000 0x0 0x1000>;
>>>>> 		#power-domain-cells = <1>;
>>>>> 	};
>>>
>>>> I see the kernel:
>>>> https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/mediatek/mt8167.dtsi
>>>> this file line 42:
>>>> it's power-controller also has no meaningful properties.
>>>> What do you think?
>>>
>>> I'm not sure that I follow. It has a bunch of child-nodes does it not,
>>> each of which is a domain?
>>>
>>> I didn't see such domains in your dts patch, they're defined directly in
>>> the driver instead AFAIU. Assuming I have understood that correctly,
>>> your situation is different to that mediatek one?
>>>
>>> Cheers,
>>> Conor.
>>
>> Conor and Rob, 
>>
>> How about this way:
>>
>> aon_syscon: syscon@17010000 {
>> 	compatible = "starfive,jh7110-aon-syscon", "syscon", "simple-mfd";
>> 	reg = <0x0 0x17010000 0x0 0x1000>;
>> 	
>> 	aon_pwrc: power-controller {
>> 		compatible = "starfive,jh7110-aon-pmu";
>> 		regmap = <&aon_syscon>;
>> 		#power-domain-cells = <1>;
>> 	};
>> };
>>
>> Add a "regmap" property which is phandle. And it can keep the present child-node
>> structure. This is more consistent with our soc design.
> 
> Adding property from child to parent does not make any sense. Didn't you
> already receive comment on this?
> 
> Best regards,
> Krzysztof
> 

Krzysztof,

I am confused about what to do next. How to add this power-controller's
node in device tree?

Best regards,
Changhuang

