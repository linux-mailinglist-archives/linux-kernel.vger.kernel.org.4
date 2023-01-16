Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E639666C217
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjAPOVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjAPOVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:21:16 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546CD24485;
        Mon, 16 Jan 2023 06:07:11 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G9eUvf000401;
        Mon, 16 Jan 2023 15:06:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ZUFiwmuXUVXgB50AexCJ2aYXXaHlJR5y5ppvtTRfE5M=;
 b=Ynb3g2gvkWCA3S6BQnWw+9IsEdYk6PRDDSoS5+Ixdvlq4gNMlHpP6Vi91He0GXFybI0c
 PKgmKzxS/BJlagpQyZVjPRqAe/6+93YzeYUMmNluKe2K7w1PpT/+mUKvV2pEMR62c+Lt
 xr0Rj1il4tHdOpSIDJy1U9kVdOZcRoXyNorvmZ+O6CRzzgBwia9i870GAUl1Rn00JSon
 40PDQRyxmp7JebhBwlbfMlYArt8i237IBpOvSYKtMB9Sje6BjPylSmZjFbqXV8mfgcEm
 MubhEpSbkiZvUakCwF6cwjf8/SShJ0UinfSkUy3kIbaWBE3RuzX+TWeVSSC8xh909/da gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n3mm6a9vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 15:06:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E994010002A;
        Mon, 16 Jan 2023 15:06:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D66472194F2;
        Mon, 16 Jan 2023 15:06:38 +0100 (CET)
Received: from [10.201.21.177] (10.201.21.177) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 16 Jan
 2023 15:06:38 +0100
Message-ID: <b90e4b78-d84d-3a63-1aef-e7214d4b29d9@foss.st.com>
Date:   Mon, 16 Jan 2023 15:06:06 +0100
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
 <19157c67-fa83-e598-d7ee-c313f3d4b198@foss.st.com>
 <f169d05a-7a07-aedf-bad2-30cb4a88fc16@kernel.org>
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <f169d05a-7a07-aedf-bad2-30cb4a88fc16@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.177]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_11,2023-01-13_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 1/11/23 13:32, Krzysztof Kozlowski wrote:
> On 09/01/2023 12:54, Gatien CHEVALLIER wrote:
>>>>> Then why do you define them in bindings? Use raw numbers. Do you see
>>>>> anywhere in arm/arm64 bindings for GIC_SPI interrupt numbers?
>>>>>
>>>>
>>>> What would you think of simply removing the comments that state that IDs
>>>> are reserved, mimicking the way it is for qcom bindings? Fundamentally,
>>>> they are indeed only IDs and could be raw numbers.
>>>
>>> If these are IDs then there are no reserved numbers and they are
>>> continuous from 0 to X. Without gaps.
>>>
>>>> IMO, this makes reading the device tree harder. Because you'd have to
>>>> look what the raw number corresponds to.
>>>
>>> Sure, but that's not the reason to put numbers to the bindings... You
>>> mix defines with bindings.
>>>
>>>> To take an example, it has already been done for SCMI clocks and I find
>>>> it eases comprehension.
>>>
>>> You need to be a bit more specific...
>>
>> Please see include/dt-bindings/clock/stm32mp1-clks.h, where there are
>> various clock IDs defined, some of them not contiguous.
> 
> These are pretty often added to accommodate space for exposing these
> clocks in the future. IOW, these might be IDs just not all are shared
> via header. There are such platforms and it is OK.
> 
>>
>> Errata: for SCMI clocks they are indeed contiguous but not clock IDs.
>>
>>>
>>> Anyway, IDs should be placed in bindings. Some mapping of
>>> internal/hardware ports, registers, offsets, values - usually not.
>>>
>>> I don't know where exactly your case fits, but when some IDs are
>>> reserved it is a clear sign that these are not IDs (again - IDs start
>>> from 0 and go incrementally by one, without gaps).
>>>
>>
>> I do agree with your statement that IDs should not be reserved.
>>
>> I think I've missed something to better highlight my point of view: It
>> would be perfectly fine using numbers that are not described in this
>> bindings file. It would just not correspond to an ID of a peripheral
>> described in the SoC reference manual, thus making no sense to use them.
>> Stating that they are reserved was incorrect, it's just that peripherals
>> get a firewall ID, depending on the platform.
> 
> Why peripheral ID should be put into the bindings? Why bindings is a
> place for it? Interrupt numbers, GPIO indices/numbers, register offsets,
> IOMMU ports - none of these are suitable for bindings.
> 
>>
>> I think it should be okay not describing IDs that are not relevant, what
>> do you think? I found that in include/dt-bindings/arm/qcom,ids.h, IDs
>> are not continuous. Not mentioning an ID could be used for deprecation.
> 
> These are not IDs of clocks. These are unique identifiers assigned by
> vendor and used by different pieces: firmware/bootloaders, DTS and Linux
> driver. We have no control of them but they exist. They also do not
> represent any hardware number.
> 
> You bring some examples as an argument, but these examples are not
> always related to your case. To be clear - we talk here about bindings,
> so they bind different interfaces of software components (e.g. Linux
> kernel with DTS). Now, what is the different interface here in your
> case? If you say your peripheral hardware ID, then answer is no - this
> is not software interface.

I see what you want to avoid,

These bindings are indeed presented as pure helpers here. They are not 
used by the firewall bus driver on Linux except for the value that they 
represent, thus your comment.
However, they will be shared between different boot chain components. I 
do not have an upstreamed example to give but please see that we might 
use them in OP-TEE:

[1] 
https://github.com/STMicroelectronics/optee_os/blob/3.16.0-stm32mp/core/include/dt-bindings/soc/stm32mp13-etzpc.h

They could be used and used differently depending on the software 
component (e.g: lock of secure configuration for a particular 
peripheral, ...). This change is here for consistency between those.

> 
> Best regards,
> Krzysztof
> 

Best regards,
Gatien
