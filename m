Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC026169F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKBRES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKBREP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:04:15 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F145911A32;
        Wed,  2 Nov 2022 10:04:14 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A2H469x093702;
        Wed, 2 Nov 2022 12:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667408646;
        bh=rl4c4YwFqiQVdsamqsJtbq5KyzgRfRYaj2DX1UVoJmU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=l2B/1W2SoTmechaDRa5Idx+/k4Xc2NBSKcD+X22Oe+If1ZOSc8Z2wvaXqE4UKb0q5
         YwExipL20RjTAIGkWMUFH7G7txM3orCKHwdfIx/DD+RN0HiBSGUxe4b7YNnF7iL/x/
         AX3Esh54tuOSnuiIxjCBF6pQEUt6PhQma4UQIvJw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A2H46QH080418
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Nov 2022 12:04:06 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 2 Nov
 2022 12:04:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 2 Nov 2022 12:04:06 -0500
Received: from [10.249.33.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A2H45Pj118344;
        Wed, 2 Nov 2022 12:04:05 -0500
Message-ID: <4f954c08-6a2e-93b5-6806-7b27b247496e@ti.com>
Date:   Wed, 2 Nov 2022 12:04:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am65-main: drop RNG clock
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <j-keerthy@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221031213237.52275-1-j-choudhary@ti.com>
 <20221031213237.52275-2-j-choudhary@ti.com>
 <20221102151706.krsi5lujydb4nswa@daybreak>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221102151706.krsi5lujydb4nswa@daybreak>
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

On 11/2/22 10:17 AM, Nishanth Menon wrote:
> On 03:02-20221101, Jayesh Choudhary wrote:
>> Drop RNG clock property as it is not controlled by rng-driver.
> 
> Does'nt tell me what is the alternative? why is the hardware description
> not sufficient for control?
> 
> https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am65x_sr2/clocks.html#clocks-for-sa2-ul0-device
> Looks like a perfectly valid description - do we have a bug and firmware
> does'nt allow control here?
> 

We have three input clocks feeding the SA2UL module, x1, x2, pka. PKA goes
to the PKA sub-module (isn't it nice when they make things simple). But x1 and
x2 are miscellaneous and bus clocks respectively and route to several sub-modules.

All we drop here is the clock handle in the RNG sub-module, as that sub-module is
not the owner of that clock (the parent SA2UL is). The alternative we could implement
is to move the clock node up to the parent SA2UL node.

>>
>> Fixes: b366b2409c97 ("arm64: dts: ti: k3-am6: Add crypto accelarator node")
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index 4005a73cfea9..e166d7b7e3a1 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -126,7 +126,6 @@ rng: rng@4e10000 {
>>   			compatible = "inside-secure,safexcel-eip76";
>>   			reg = <0x0 0x4e10000 0x0 0x7d>;
>>   			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>> -			clocks = <&k3_clks 136 1>;
> 
> Does this mean that the crypto module's power-domains property should be
> dropped as well?
> 

Why? the power-domains property is in the correct spot (up in the parent node).

Now it is true we cant actually shut the SA2UL down since it is owned
by the security processor, but since it is marked TI_SCI_PD_SHARED this
should be fine.

Andrew

>>   			status = "disabled"; /* Used by OP-TEE */
>>   		};
>>   	};
>> -- 
>> 2.25.1
>>
> 
