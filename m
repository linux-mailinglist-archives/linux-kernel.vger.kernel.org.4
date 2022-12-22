Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316E465422C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiLVNwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiLVNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:52:34 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF321D9B;
        Thu, 22 Dec 2022 05:52:33 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMBtgPt016822;
        Thu, 22 Dec 2022 14:52:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=s6wf2KhNnD3O8dvdr1848PKt2d+/470l8hwYZ7/fvTQ=;
 b=4P6WTofKzk4ZDMzsumeIuAQvJpNn2xVlksRsSFC4dI4k4/V444FrKU0Kaco15P64IDlN
 Q3Ty5BcGun4p6Ck/2R5VcOvtAx3UEqGIbB3beogIDeCb26FjADYpvaEYH2xSiZbJTgHZ
 NWYu6cMjOcRv1491+ZFrgIQ+ANoLnm2kawmFR3rNuGcudEI8BcIeCjVGaQ/b3ZRINYG6
 zTb3K5loalSfqCXMVuVS1cy09Q0WaSYrgwHfuxCYKgMEL/XhYGFygK0wbYeHOW152mDs
 REofWvmM+gga0MKxtMRAjrrqmdQL4rb4/nKyuL71/CHwh4q3xLzNvVCddxmcFVSPSOeT ZA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mh605wbs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 14:52:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB29F10005D;
        Thu, 22 Dec 2022 14:52:13 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3DFFF22FA2A;
        Thu, 22 Dec 2022 14:51:07 +0100 (CET)
Received: from [10.201.21.217] (10.201.21.217) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 22 Dec
 2022 14:51:06 +0100
Message-ID: <8357d887-c8ab-39bc-4ef0-62e9225fb2a6@foss.st.com>
Date:   Thu, 22 Dec 2022 14:51:06 +0100
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
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <879325d2-4b2d-bc1d-310c-ece4c449ad8f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.217]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_06,2022-12-22_03,2022-06-22_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 12/22/22 11:26, Krzysztof Kozlowski wrote:
> On 21/12/2022 18:30, Gatien Chevallier wrote:
>> Adds the list of peripherals IDs under firewall bus on STM32MP15.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> ---
>>   include/dt-bindings/bus/stm32mp15_sys_bus.h | 98 +++++++++++++++++++++
>>   1 file changed, 98 insertions(+)
>>   create mode 100644 include/dt-bindings/bus/stm32mp15_sys_bus.h
>>
>> diff --git a/include/dt-bindings/bus/stm32mp15_sys_bus.h b/include/dt-bindings/bus/stm32mp15_sys_bus.h
>> new file mode 100644
>> index 000000000000..97eacc7b5f16
>> --- /dev/null
>> +++ b/include/dt-bindings/bus/stm32mp15_sys_bus.h
> 
> That's wrong in multiple ways:
> 1. No underscores
> 2. Missing vendor prefix
> 3. Name not matching compatible.

Sure, will comply in V3.

> 
>> @@ -0,0 +1,98 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
>> + */
>> +#ifndef _DT_BINDINGS_BUS_STM32MP15_SYS_BUS_H
>> +#define _DT_BINDINGS_BUS_STM32MP15_SYS_BUS_H
>> +
>> +/* ETZPC IDs */
>> +#define STM32MP1_ETZPC_STGENC_ID	0
>> +#define STM32MP1_ETZPC_BKPSRAM_ID	1
>> +#define STM32MP1_ETZPC_IWDG1_ID		2
>> +#define STM32MP1_ETZPC_USART1_ID	3
>> +#define STM32MP1_ETZPC_SPI6_ID		4
>> +#define STM32MP1_ETZPC_I2C4_ID		5
>> +/* ID 6 reserved */
> 
> Reserved why? These are IDs so they start from 0 and go by 0. Don't
> hard-code some register offsets.

Here, I do define IDs. Some appear as reserved based on what I've seen 
in the SoC datasheet that states these as "indexes"

Please see the table 94 in chapter 15.6 (ETZPC) of the STM32MP157 
Reference manual:
[1] https://www.st.com/resource/en/reference_manual/DM00327659-.pdf

> 
> Best regards,
> Krzysztof
> 

Best regards,
Gatien
