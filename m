Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3E653E71
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiLVKkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiLVKkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:40:19 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653136454;
        Thu, 22 Dec 2022 02:40:16 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BMAe4lr040147;
        Thu, 22 Dec 2022 04:40:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671705604;
        bh=1jT5Fj1arrg7WdmKeWHfIf5n+IT2qdlbceDBEC4vDg4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UXhHWEknsrR+NJFGPf1lAwYPquGkdhO0h2U/BTd4HKSHbvHSoSQTY91I7iLg0cm4N
         Nt3ieC2hXfDlr9QWK3sQN70RYhLCj5ZZq8CA7AKNrKINkXvthK2CPvHOwP5+qK5CAb
         AfPigBZiJEcJnRrWU1zHWcAnRTvpqGMaq91LoO+M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BMAe4oP071291
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Dec 2022 04:40:04 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 22
 Dec 2022 04:40:04 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 22 Dec 2022 04:40:04 -0600
Received: from [10.250.234.78] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BMAdn6v034347;
        Thu, 22 Dec 2022 04:39:53 -0600
Message-ID: <a22a2c32-3b52-8bdf-f959-c95554125c64@ti.com>
Date:   Thu, 22 Dec 2022 16:09:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: dts: ti: k3-j721s2: Add support for
 ADC nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>
References: <20221220101249.46450-1-b-kapoor@ti.com>
 <ff5b09db-4900-0b5b-e821-fa05b8d907a4@linaro.org>
 <a4d11974-eb97-bfa2-790f-3016950ea961@ti.com>
 <79ffe459-3827-ea67-e854-8eef3d9b630b@linaro.org>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <79ffe459-3827-ea67-e854-8eef3d9b630b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/12/22 13:24, Krzysztof Kozlowski wrote:
> On 21/12/2022 06:42, Bhavya Kapoor wrote:
>> On 20/12/22 16:20, Krzysztof Kozlowski wrote:
>>> On 20/12/2022 11:12, Bhavya Kapoor wrote:
>>>> J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
>>>> for 8 channel ADCs for J721s2 SoC.
>>>>
>>>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>>>> ---
>>>>    .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>>>>    .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 42 ++++++++++++++++++-
>>>>    2 files changed, 55 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>>> index a7aa6cf08acd..67593aa69327 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>>> @@ -309,3 +309,17 @@ &mcu_mcan1 {
>>>>    	pinctrl-0 = <&mcu_mcan1_pins_default>;
>>>>    	phys = <&transceiver2>;
>>>>    };
>>>> +
>>>> +&tscadc0 {
>>>> +	status = "okay";
>>>> +	adc {
>>>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&tscadc1 {
>>>> +	status = "okay";
>>>> +	adc {
>>>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>>>> +	};
>>>> +};
>>>> \ No newline at end of file
>>> This is a friendly reminder during the review process.
>>>
>>> It seems my previous comments were not fully addressed. Maybe my
>>> feedback got lost between the quotes, maybe you just forgot to apply it.
>>> Please go back to the previous discussion and either implement all
>>> requested changes or keep discussing them.
>>>
>>> Thank you.
>>>
>>> Best regards,
>>> Krzysztof
>> Hi , I thought i did addressed the feedback since tscadc is just a
>> wrapper node.
>>
>> The actual adc node is inside of tscadc node.
> Read the feedback, from all emails.
> Best regards,
> Krzysztof


Hi , i have gone through all earlier mails but can't find anything else. 
Can you point out again whats the issue.

Regards

