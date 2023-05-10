Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71ED6FDFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbjEJOWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjEJOWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:22:43 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3FF3AA9;
        Wed, 10 May 2023 07:22:41 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AARLSF003420;
        Wed, 10 May 2023 16:22:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=KPcKF2alaU6EYzoeowQfXYviPM8+Cm+PPF8ke7qvULk=;
 b=SyfyPZu99HLkHkofrMkgRvJ8/xYUS88mq/rUbBsDn9xQVfl+UjqGWjCyF92jdeQlS38N
 ILOeBc7PqajfXASKmM2YgidBKbfwFMtbw/YuEws/PneqKGDGMDLTo6H+INjnwx1h6GYX
 YOmsa486K+C8rzuctkiLcxq/II0Fw0UL72S7Z1W9yPk61z/agGsG72XHhjl4MIXbWeee
 f/IA2Xq2iP3Q5otupIk1PA9opC6Q6+ADRM+ZoXgPL1/4/bFO96k5cp7OSR+R4cE7a2Oj
 aiojbOM3QqBM05qaJPWxjbLkEsfd/zsp9ksix5lIxmqhOqT+MuA9Jj++ktizTV6LSRpq HA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qg9hf9bkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 16:22:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A3937100038;
        Wed, 10 May 2023 16:22:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 919192248CE;
        Wed, 10 May 2023 16:22:12 +0200 (CEST)
Received: from [10.48.1.0] (10.48.1.0) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 10 May
 2023 16:22:12 +0200
Message-ID: <7884b0d8-199c-4415-4113-ddce4b640508@foss.st.com>
Date:   Wed, 10 May 2023 16:22:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dt-bindings: rcc: stm32: Fix STM32MP13 include file
To:     Rob Herring <robh@kernel.org>, <gabriel.fernandez@foss.st.com>
CC:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <gabriel.fernandez@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Loic PALLARDY <loic.pallardy@st.com>
References: <20230407201526.1.I417093ddcea282be479f10a37147d1935a9050b7@changeid>
 <20230412151404.GA2372294-robh@kernel.org>
Content-Language: en-US
From:   Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230412151404.GA2372294-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.1.0]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/12/23 17:14, Rob Herring wrote:
> On Fri, Apr 07, 2023 at 08:15:33PM +0200, Patrick Delaunay wrote:
>> Minor cosmetic change, aligned with files in U-Boot:
>> - change obsolete SPDX id : GPL-2.0+
>> - use correct address gabriel.fernandez@foss.st.com
>> - remove extra space
> Make the subject reflect the purpose: 'Sync with u-boot copy'


Ok


>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>>   include/dt-bindings/clock/stm32mp13-clks.h   | 6 +++---
>>   include/dt-bindings/reset/stm32mp13-resets.h | 4 ++--
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/dt-bindings/clock/stm32mp13-clks.h b/include/dt-bindings/clock/stm32mp13-clks.h
>> index 02befd25edce..da4cb7567430 100644
>> --- a/include/dt-bindings/clock/stm32mp13-clks.h
>> +++ b/include/dt-bindings/clock/stm32mp13-clks.h
>> @@ -1,7 +1,7 @@
>> -/* SPDX-License-Identifier: GPL-2.0+ or BSD-3-Clause */
>> +/* SPDX-License-Identifier: GPL-2.0-or-later or BSD-3-Clause */
>>   /*
>>    * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
>> - * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
>> + * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
>>    */
>>   
>>   #ifndef _DT_BINDINGS_STM32MP13_CLKS_H_
>> @@ -64,7 +64,7 @@
>>   #define CK_MCO1		38
>>   #define CK_MCO2		39
>>   
>> -/*  IP clocks */
>> +/* IP clocks */
>>   #define SYSCFG		40
>>   #define VREF		41
>>   #define DTS		42
>> diff --git a/include/dt-bindings/reset/stm32mp13-resets.h b/include/dt-bindings/reset/stm32mp13-resets.h
>> index 934864e90da6..1b83a01de8f0 100644
>> --- a/include/dt-bindings/reset/stm32mp13-resets.h
>> +++ b/include/dt-bindings/reset/stm32mp13-resets.h
>> @@ -1,7 +1,7 @@
>> -/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
>> +/* SPDX-License-Identifier: GPL-2.0-or-later or BSD-3-Clause */
> Really, the Linux copy came first, so you should use its license. Your
> company's lawyers are good with GPLv3 and then v4?


We have a long debate on the licenses, and particular for device tree,

and as conclusion we are using for STM32MP SoCs:

- For code (in Linux kernel driver) => GPL-2.0-only

- For device tree and binding .h files; the dual licenses => 
GPL-2.0-or-later OR BSD-3-Clause


It is because the modifications in device tree files and binding file s 
can be applied on

other SW with using any licenses:

    - GPL2 (Linux /u-Boot)

    - BSD (TF-A/OP-TEE)

    - GPL3/GPL4 license (any other SW component)


Just indicate GPL-2.0-or-later in the device tree or binding files won't 
contaminate

all the projects with GPL3/GPL4 license if it only use this DT, or 
binding files.


NB: it is already the case for other files used by STM32MP SoC, for 
example :

./include/dt-bindings/pinctrl/stm32-pinfunc.h:
     /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */


and we have no reason to use a different license for the 2 files for 
STM32MP13 RCC binding:

   include/dt-bindings/reset/stm32mp13-resets.h
   include/dt-bindings/clock/stm32mp13-clks.h

This patch corrects a mistake in the initial commit for RCC binding 
up-streamed

by Gabriel in parallel in U-Boot and Linux repositories; this 
inconsistency in the license

was corrected only when the same patch was pushed in U-Boot.


PS: using the GPL2-only is not a issue for U-Boot but perhaps for other 
user of device tree in other components,
       So if it is a blocking issue for Linux I can change it to 
"GPL-2.0-only" in Linux and U-Boot


Patrick

>
>>   /*
>>    * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
>> - * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
>> + * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
>>    */
>>   
>>   #ifndef _DT_BINDINGS_STM32MP13_RESET_H_
>> -- 
>> 2.25.1
>>
