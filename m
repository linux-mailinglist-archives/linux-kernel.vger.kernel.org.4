Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE31265422F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiLVNxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiLVNxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:53:33 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9721CD9B;
        Thu, 22 Dec 2022 05:53:32 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMBuOtE006364;
        Thu, 22 Dec 2022 14:53:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=orkOALmHM5dS4VJrmcn/mvwkBSL4faYpF3SmcTP2AWs=;
 b=OXRsbjilMCAPPMLQGC0lLoIEhh0YdsCwDUhNolKhtIdeyQC3OqlWHGx9L2WrWUHvSYif
 aE87bBYqGDLZOw7xtdsCVG/Lod3lN/oS7tDpupUosyf/1yrGTvYKCzhMxLoaUFxQ2BB0
 bkunCrjkQq8ULby8DGDlel3epEpjQ1yl9CE4SRRzAJ2XerW+erWouxP67exgE9MCYkOV
 K0q1CoBAD1Js+s7/livFr5fWJaNDX5CGHs1nwudkoIIWh6HvGEeO4oyNlH3sis5T1fRK
 MwKSsyUMGBRtMZNwT4kK1HQb/KiEc2dOQyy5YC0ZLyeB3jpnqOUZUD7wuStGrbT/C99P Fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mkc8jf9w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 14:53:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A037010002A;
        Thu, 22 Dec 2022 14:53:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 99F4620E1D1;
        Thu, 22 Dec 2022 14:53:12 +0100 (CET)
Received: from [10.201.21.217] (10.201.21.217) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 22 Dec
 2022 14:53:12 +0100
Message-ID: <e667c7e0-9c31-a3d1-8599-29a7b81f9b59@foss.st.com>
Date:   Thu, 22 Dec 2022 14:53:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 4/7] dt-bindings: bus: add STM32MP13 ETZPC firewall
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
 <20221221173055.11719-5-gatien.chevallier@foss.st.com>
 <85c3352c-b427-c440-a1bd-57f830c14c50@kernel.org>
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <85c3352c-b427-c440-a1bd-57f830c14c50@kernel.org>
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
>> Adds the list of peripherals IDs under firewall bus on STM32MP13.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> ---
>>   include/dt-bindings/bus/stm32mp13_sys_bus.h | 60 +++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>   create mode 100644 include/dt-bindings/bus/stm32mp13_sys_bus.h
>>
>> diff --git a/include/dt-bindings/bus/stm32mp13_sys_bus.h b/include/dt-bindings/bus/stm32mp13_sys_bus.h
>> new file mode 100644
>> index 000000000000..1160de87bc4a
>> --- /dev/null
>> +++ b/include/dt-bindings/bus/stm32mp13_sys_bus.h
>> @@ -0,0 +1,60 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
>> + */
>> +#ifndef _DT_BINDINGS_BUS_STM32MP13_SYS_BUS_H
>> +#define _DT_BINDINGS_BUS_STM32MP13_SYS_BUS_H
>> +
>> +/* ETZPC IDs */
>> +#define STM32MP1_ETZPC_VREFBUF_ID	0
>> +#define STM32MP1_ETZPC_LPTIM2_ID	1
>> +#define STM32MP1_ETZPC_LPTIM3_ID	2
>> +#define STM32MP1_ETZPC_LTDC_ID		3
>> +#define STM32MP1_ETZPC_DCMIPP_ID	4
>> +#define STM32MP1_ETZPC_USBPHYCTRL_ID	5
>> +#define STM32MP1_ETZPC_DDRCTRLPHY_ID	6
>> +/* IDs 7-11 reserved */
>> +#define STM32MP1_ETZPC_IWDG1_ID		12
>> +#define STM32MP1_ETZPC_STGENC_ID	13
>> +/* IDs 14-15 reserved */
>> +#define STM32MP1_ETZPC_USART1_ID	16
>> +#define STM32MP1_ETZPC_USART2_ID	17
>> +#define STM32MP1_ETZPC_SPI4_ID		18
>> +#define STM32MP1_ETZPC_SPI5_ID		19
>> +#define STM32MP1_ETZPC_I2C3_ID		20
>> +#define STM32MP1_ETZPC_I2C4_ID		21
>> +#define STM32MP1_ETZPC_I2C5_ID		22
>> +#define STM32MP1_ETZPC_TIM12_ID		23
>> +#define STM32MP1_ETZPC_TIM13_ID		24
>> +#define STM32MP1_ETZPC_TIM14_ID		25
>> +#define STM32MP1_ETZPC_TIM15_ID		26
>> +#define STM32MP1_ETZPC_TIM16_ID		27
>> +#define STM32MP1_ETZPC_TIM17_ID		28
>> +/* IDs 29-31 reserved */
> 
> Same comments (all of them). IDs cannot be reserved.

My response on patch [RFC PATCH 4/7] applies to this as well

> 
> Best regards,
> Krzysztof
> 

Best regards,
Gatien
