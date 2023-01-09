Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3786624C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbjAILz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbjAILyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:54:53 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C301DEC5;
        Mon,  9 Jan 2023 03:54:51 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309A7Muk031252;
        Mon, 9 Jan 2023 12:54:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=iOhZPcoRafAEpEAF7mdZJd24KSFmRfUYGieziEtvSEE=;
 b=y91emgsL4msZFLCYWpJcNOejxyU+PHeFMgOYbTbK7yRn91iTMue8vHjQ9H8rlAB4gioS
 A3l8M2NBi2+ze9/u5P1r8UJh8gDSD+qrZSEigekPQhHW3MujAugPhJmfhxG01VqvhiDy
 LUOZ2C/UzIxw0/U5S0hGczZsMuSmKf9lFMFDd2oCbW5/Ov58L01oNG5W/FPlSxm+6C1B
 MHMx2FzL1ZI4SPN2SgNvXfffxUXvPWlffvkEYn8xEVbYar9WbaOMlEwTLQWtdjStRFwZ
 swsh5UQMpXgaaOmR/GoZ9FbdGbGNfXRxP86GNqZ7bz04mH3lMHbNJyMogEU5MKHTN51g dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3my0gntx3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 12:54:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C4A7410002A;
        Mon,  9 Jan 2023 12:54:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9B66A21863A;
        Mon,  9 Jan 2023 12:54:15 +0100 (CET)
Received: from [10.201.21.177] (10.201.21.177) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 9 Jan
 2023 12:54:15 +0100
Message-ID: <19157c67-fa83-e598-d7ee-c313f3d4b198@foss.st.com>
Date:   Mon, 9 Jan 2023 12:54:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 3/7] dt-bindings: bus: add STM32MP15 ETZPC firewall
 bus bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <Oleksii_Moisieiev@epam.com>, <linus.walleij@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <devicetree@vger.kernel.org>, <mark.rutland@arm.com>,
        <arnd@arndb.de>
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
 <20221221173055.11719-4-gatien.chevallier@foss.st.com>
 <879325d2-4b2d-bc1d-310c-ece4c449ad8f@kernel.org>
 <8357d887-c8ab-39bc-4ef0-62e9225fb2a6@foss.st.com>
 <118e7f0c-bf5d-4bda-ee70-92eb2b71649c@kernel.org>
 <8f022dc8-d728-ba91-35ed-8a4006855f0d@foss.st.com>
 <dfe328fc-349b-3357-a8ac-6fc363f403fc@kernel.org>
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <dfe328fc-349b-3357-a8ac-6fc363f403fc@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.177]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_04,2023-01-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/23 22:53, Krzysztof Kozlowski wrote:
> On 04/01/2023 14:43, Gatien CHEVALLIER wrote:
>> Hello Krzysztof,
>>
>> On 12/22/22 14:57, Krzysztof Kozlowski wrote:
>>> On 22/12/2022 14:51, Gatien CHEVALLIER wrote:
>>>> Hello,
>>>>
>>>> On 12/22/22 11:26, Krzysztof Kozlowski wrote:
>>>>> On 21/12/2022 18:30, Gatien Chevallier wrote:
>>>>>> Adds the list of peripherals IDs under firewall bus on STM32MP15.
>>>>>>
>>>>>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>>>>> ---
>>>>>>     include/dt-bindings/bus/stm32mp15_sys_bus.h | 98 +++++++++++++++++++++
>>>>>>     1 file changed, 98 insertions(+)
>>>>>>     create mode 100644 include/dt-bindings/bus/stm32mp15_sys_bus.h
>>>>>>
>>>>>> diff --git a/include/dt-bindings/bus/stm32mp15_sys_bus.h b/include/dt-bindings/bus/stm32mp15_sys_bus.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..97eacc7b5f16
>>>>>> --- /dev/null
>>>>>> +++ b/include/dt-bindings/bus/stm32mp15_sys_bus.h
>>>>>
>>>>> That's wrong in multiple ways:
>>>>> 1. No underscores
>>>>> 2. Missing vendor prefix
>>>>> 3. Name not matching compatible.
>>>>
>>>> Sure, will comply in V3.
>>>>
>>>>>
>>>>>> @@ -0,0 +1,98 @@
>>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>>>> +/*
>>>>>> + * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
>>>>>> + */
>>>>>> +#ifndef _DT_BINDINGS_BUS_STM32MP15_SYS_BUS_H
>>>>>> +#define _DT_BINDINGS_BUS_STM32MP15_SYS_BUS_H
>>>>>> +
>>>>>> +/* ETZPC IDs */
>>>>>> +#define STM32MP1_ETZPC_STGENC_ID	0
>>>>>> +#define STM32MP1_ETZPC_BKPSRAM_ID	1
>>>>>> +#define STM32MP1_ETZPC_IWDG1_ID		2
>>>>>> +#define STM32MP1_ETZPC_USART1_ID	3
>>>>>> +#define STM32MP1_ETZPC_SPI6_ID		4
>>>>>> +#define STM32MP1_ETZPC_I2C4_ID		5
>>>>>> +/* ID 6 reserved */
>>>>>
>>>>> Reserved why? These are IDs so they start from 0 and go by 0. Don't
>>>>> hard-code some register offsets.
>>>>
>>>> Here, I do define IDs. Some appear as reserved based on what I've seen
>>>> in the SoC datasheet that states these as "indexes"
>>>>
>>>> Please see the table 94 in chapter 15.6 (ETZPC) of the STM32MP157
>>>> Reference manual:
>>>> [1] https://www.st.com/resource/en/reference_manual/DM00327659-.pdf
>>>
>>> Then why do you define them in bindings? Use raw numbers. Do you see
>>> anywhere in arm/arm64 bindings for GIC_SPI interrupt numbers?
>>>
>>
>> What would you think of simply removing the comments that state that IDs
>> are reserved, mimicking the way it is for qcom bindings? Fundamentally,
>> they are indeed only IDs and could be raw numbers.
> 
> If these are IDs then there are no reserved numbers and they are
> continuous from 0 to X. Without gaps.
> 
>> IMO, this makes reading the device tree harder. Because you'd have to
>> look what the raw number corresponds to.
> 
> Sure, but that's not the reason to put numbers to the bindings... You
> mix defines with bindings.
> 
>> To take an example, it has already been done for SCMI clocks and I find
>> it eases comprehension.
> 
> You need to be a bit more specific...

Please see include/dt-bindings/clock/stm32mp1-clks.h, where there are 
various clock IDs defined, some of them not contiguous.

Errata: for SCMI clocks they are indeed contiguous but not clock IDs.

> 
> Anyway, IDs should be placed in bindings. Some mapping of
> internal/hardware ports, registers, offsets, values - usually not.
> 
> I don't know where exactly your case fits, but when some IDs are
> reserved it is a clear sign that these are not IDs (again - IDs start
> from 0 and go incrementally by one, without gaps).
> 

I do agree with your statement that IDs should not be reserved.

I think I've missed something to better highlight my point of view: It 
would be perfectly fine using numbers that are not described in this 
bindings file. It would just not correspond to an ID of a peripheral 
described in the SoC reference manual, thus making no sense to use them. 
Stating that they are reserved was incorrect, it's just that peripherals 
get a firewall ID, depending on the platform.

I think it should be okay not describing IDs that are not relevant, what 
do you think? I found that in include/dt-bindings/arm/qcom,ids.h, IDs 
are not continuous. Not mentioning an ID could be used for deprecation.

> 
> Best regards,
> Krzysztof
> 

Best regards,
Gatien
