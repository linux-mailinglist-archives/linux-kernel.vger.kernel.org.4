Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF63619FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKDSZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiKDSYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:24:43 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64DD15831;
        Fri,  4 Nov 2022 11:24:24 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A4IO3LR060985;
        Fri, 4 Nov 2022 13:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667586243;
        bh=8ETERx3slYS0YvwAHPAt1tHEj7ePcY+jVnmLR69eRuE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=rlvAG86/GDDBZ5fxhUVaMVADwJxxY5DSIgPwh6iccIXPOknueMCmoc4clDXLqyMi0
         m/4Z8ZA7epUbeawm2wNdddat7blaEi0X4M0tEHIdzVD3nG3LJb4fF/ROm52ozfGwP3
         3dIcjcEH3LLPWj0iJOGz2y88X5SAKWE40wEcN8GM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A4IO3Tt051765
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Nov 2022 13:24:03 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 4 Nov
 2022 13:24:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 4 Nov 2022 13:24:02 -0500
Received: from [10.250.232.76] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A4INw5L018692;
        Fri, 4 Nov 2022 13:23:58 -0500
Message-ID: <7c63a1b5-ee51-d395-d545-6d9046d63f69@ti.com>
Date:   Fri, 4 Nov 2022 23:53:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am65-main: drop RNG clock
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <j-keerthy@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221031213237.52275-1-j-choudhary@ti.com>
 <20221031213237.52275-2-j-choudhary@ti.com>
 <20221102151706.krsi5lujydb4nswa@daybreak>
 <4f954c08-6a2e-93b5-6806-7b27b247496e@ti.com>
 <20221102194420.umwuyk374g2mgg45@unlucky>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20221102194420.umwuyk374g2mgg45@unlucky>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/22 01:14, Nishanth Menon wrote:
> On 12:04-20221102, Andrew Davis wrote:
>> On 11/2/22 10:17 AM, Nishanth Menon wrote:
>>> On 03:02-20221101, Jayesh Choudhary wrote:
>>>> Drop RNG clock property as it is not controlled by rng-driver.
>>>
>>> Does'nt tell me what is the alternative? why is the hardware description
>>> not sufficient for control?
>>>
>>> https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am65x_sr2/clocks.html#clocks-for-sa2-ul0-device
>>> Looks like a perfectly valid description - do we have a bug and firmware
>>> does'nt allow control here?
>>>
>>
>> We have three input clocks feeding the SA2UL module, x1, x2, pka. PKA goes
>> to the PKA sub-module (isn't it nice when they make things simple). But x1 and
>> x2 are miscellaneous and bus clocks respectively and route to several sub-modules.
>>
>> All we drop here is the clock handle in the RNG sub-module, as that sub-module is
>> not the owner of that clock (the parent SA2UL is). The alternative we could implement
>> is to move the clock node up to the parent SA2UL node.
>>
>>>>
>>>> Fixes: b366b2409c97 ("arm64: dts: ti: k3-am6: Add crypto accelarator node")
>>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>> ---
>>>>    arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 -
>>>>    1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>>> index 4005a73cfea9..e166d7b7e3a1 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>>> @@ -126,7 +126,6 @@ rng: rng@4e10000 {
>>>>    			compatible = "inside-secure,safexcel-eip76";
>>>>    			reg = <0x0 0x4e10000 0x0 0x7d>;
>>>>    			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>>>> -			clocks = <&k3_clks 136 1>;
>>>
>>> Does this mean that the crypto module's power-domains property should be
>>> dropped as well?
>>>
>>
>> Why? the power-domains property is in the correct spot (up in the parent node).
>>
>> Now it is true we cant actually shut the SA2UL down since it is owned
>> by the security processor, but since it is marked TI_SCI_PD_SHARED this
>> should be fine.
> 
> The idea of the descriptions were to describe what is controllable by
> firmware, if there is no control due to the specified reason, it is a
> device tree bug, and should be documented when dropping it. If it serves
> a purpose in the firmware by indicating usage for example - it has valid
> reason to stick around as it is expected to be used by firmware for some
> specific reason.

The x1-clk to sa2ul is always running and fixed. What we can do is gate
off the clock specific to trng module (x1-clk) by using TRNG_EN MMR to
disable TRNG.
Hence, uncontrollable.

> 
> The commit description does bring up the above mentioned questions and
> must be explained appropriately.
> 

Okay, I will update the description properly in v2 for dropping this
clock and for each patch (and not just in the cover-letter).
