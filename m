Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513176893EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjBCJfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjBCJfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:35:51 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA42D9DC81;
        Fri,  3 Feb 2023 01:35:24 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 500C624E1F2;
        Fri,  3 Feb 2023 17:35:23 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 17:35:23 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 17:35:22 +0800
Message-ID: <f043e351-1875-ad64-e6b5-6c77bae09f69@starfivetech.com>
Date:   Fri, 3 Feb 2023 17:35:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: Add mmc node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
 <20230203081913.81968-4-william.qiu@starfivetech.com>
 <3c5bda9f-08b9-f2ba-6951-9fc614d4debc@linaro.org>
 <afe28108-9b85-982c-90ee-8cd58c9b6fb2@starfivetech.com>
 <ab9a4a7f-a8fa-fa29-95e9-941096359de1@linaro.org>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <ab9a4a7f-a8fa-fa29-95e9-941096359de1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/3 17:30, Krzysztof Kozlowski wrote:
> On 03/02/2023 10:23, William Qiu wrote:
>> 
>> 
>> On 2023/2/3 17:02, Krzysztof Kozlowski wrote:
>>> On 03/02/2023 09:19, William Qiu wrote:
>>>> This adds the mmc node for the StarFive JH7110 SoC.
>>>
>>> Do not use "This xxx". Use imperative mode.
>>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>>>
>>>> Set mmco node to emmc and set mmc1 node to sd.
>>>>
>>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>>
>>>
>>>> +
>>>>  &gmac0_rmii_refin {
>>>>  	clock-frequency = <50000000>;
>>>>  };
>>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>>> index 64d260ea1f29..ae1a664e7af5 100644
>>>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>>> @@ -370,6 +370,11 @@ syscrg: clock-controller@13020000 {
>>>>  			#reset-cells = <1>;
>>>>  		};
>>>>  
>>>> +		sysreg: syscon@13030000 {
>>>> +			compatible = "starfive,sysreg", "syscon";
>>>
>>> No:
>>> 1. Undocumented.
>>> 2. A bit too generic. You should have here SoC specific compatible as
>>> well (either as second or third compatible, if all your SoCs share
>>> register layout).
>>>
>> 
>> Hi Krzysztof,
>> 
>> As for the compatible, I will change it to "starfive,jh7110-sysreg"
>> in next version,but for undocumented, I don't get it, can you
>> clarify that.
>> Thank you anyway.
> 
> You need bindings for it. I don't see it in linux-next, cover letter
> dependencies nor here.
> 

I see, I will update it in next version.
Thank you for taking time to review and provide helpful comments for this patch.

Best regards,
William Qiu
> Best regards,
> Krzysztof
> 
