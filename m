Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E2F7050DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjEPOeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjEPOd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:33:57 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11416A8;
        Tue, 16 May 2023 07:33:53 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GE580o015630;
        Tue, 16 May 2023 16:33:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ZOHvPLARUacy7nqUqtK+6md229aHrzcf8Fijn/GrLZ0=;
 b=4wbhNw0Wxskx9jw7OBPD+h22nH8hiUjzHbNF6Gper4o5/ee7ZUt1SmMJfy8z4uEKWWoL
 Q7+TYpLoiKuURW2wDlky0vC86RisTmTX9pXWE1EujcUt9ixB83wjHhqzxQAhPsQVfZ2F
 Dm5A8Z5okS02KDlMXR9ugIiMlwdXHp3qtc1iK8vZA10VSqgxa5oW84uL4Dda0RfzDGjQ
 CPwKJmt7JcQV/yGbSBr4NYDuvBqRLYaZGQSig9WOFBv5DOq+2MVFbMJllrTmHuXFa53L
 1uLkNA1LlIL9YrwXZuskVe0yzvwEknYGN8wL6YD4o9yKHjM9xCEFIqvISMiw3OtumSej Qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qm7tf9qb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 16:33:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C71EC10002A;
        Tue, 16 May 2023 16:33:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C02FB229A97;
        Tue, 16 May 2023 16:33:37 +0200 (CEST)
Received: from [10.252.0.230] (10.252.0.230) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 16 May
 2023 16:33:34 +0200
Message-ID: <6f146b61-4386-1f2f-f16b-55148b74bb6a@foss.st.com>
Date:   Tue, 16 May 2023 16:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/4] stm32mp15: update remoteproc to support SCMI
 Device tree
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230512093926.661509-1-arnaud.pouliquen@foss.st.com>
 <ZGJrj9Vu2H9NZdlH@p14s>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <ZGJrj9Vu2H9NZdlH@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.0.230]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_07,2023-05-16_01,2023-02-09_01
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu

On 5/15/23 19:27, Mathieu Poirier wrote:
> On Fri, May 12, 2023 at 11:39:22AM +0200, Arnaud Pouliquen wrote:
>> Update vs V2[1]:
>> ---------------
>> - update yaml to remove label in examples
>> - fix error management for  devm_reset_control_get_optional(dev, "hold_boot")
>> - rebased on commit ac9a78681b92 ("Linux 6.4-rc1")
>>
>> [1]https://lore.kernel.org/lkml/20230504094641.870378-1-arnaud.pouliquen@foss.st.com/T/
>>
>>
>> Description:
>> -----------
>> This series updates the stm32_rproc driver and associated DT node to
>> support device tree configuration with and without SCMI server.
>> The impact is mainly on the MCU hold boot management.
>>
>> Three configurations have to be supported:
>>
>> 1) Configuration without OP-TEE SCMI (legacy): Trusted context not activated
>> - The MCU reset is controlled through the Linux RCC reset driver.
>> - The MCU HOLD BOOT is controlled through The RCC sysconf.
>>
>> 2) Configuration with SCMI server: Trusted context activated
>> - The MCU reset is controlled through the SCMI reset service.
>> - The MCU HOLD BOOT is no more controlled through a SMC call service but
>>    through the SCMI reset service.
>>
>> 3) Configuration with OP-TEE SMC call (deprecated): Trusted context activated
>> - The MCU reset is controlled through the Linux RCC reset driver.
>> - The MCU HOLD BOOT is controlled through The SMC call.
>>
>> In consequence this series:
>> - adds the use of the SCMI reset service to manage the MCU hold boot,
>> - determines the configuration to use depending on the presence of the
>>    "reset-names" property
>>    if ( "reset-names" property contains "hold_boot")
>>    then use reset_control services
>>    else use regmap access based on "st,syscfg-holdboot" property.
>> - set the DT st,syscfg-tz property as deprecated
>>
>> Arnaud Pouliquen (4):
>>    dt-bindings: remoteproc: st,stm32-rproc: Rework reset declarations
>>    remoteproc: stm32: Allow hold boot management by the SCMI reset
>>      controller
>>    ARM: dts: stm32: Update reset declarations
>>    ARM: dts: stm32: fix m4_rproc references to use SCMI
>>
>>   .../bindings/remoteproc/st,stm32-rproc.yaml   | 44 +++++++++--
>>   arch/arm/boot/dts/stm32mp151.dtsi             |  2 +-
>>   arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts    |  6 +-
>>   arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts    |  6 +-
>>   arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts    |  6 +-
>>   arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts    |  6 +-
>>   drivers/remoteproc/stm32_rproc.c              | 76 ++++++++++++++-----
>>   7 files changed, 111 insertions(+), 35 deletions(-)
>>
> 
> I have applied patch 1 and 2.  Unless Alexandre wants to proceed differently,
> patches 3 and 4 should go through his tree.

I will merge DT patches in STM32 tree.

cheers
Alex

> 
> Thanks,
> Mathieu
> 
>> -- 
>> 2.25.1
>>

