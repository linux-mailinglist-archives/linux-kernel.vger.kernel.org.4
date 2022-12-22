Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA4654176
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiLVNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiLVNCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:02:10 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A755526492;
        Thu, 22 Dec 2022 05:02:09 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMC3dY8016973;
        Thu, 22 Dec 2022 14:01:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=VfXLK2ENqOHIyN2VaJvWoWk54NjhoqbK7T93glbOHVw=;
 b=APyrqvCMtyI7tjM0vzRax+L5j54dvsPvQ/4AwhOTP8aCo5BZ34d4wrVM3XifSSw7amT0
 0mtIosOHPVOV3VBHvLIh5bRB0qMFoUm2lCR9bB5EgD8aFq6IjP8eezE8WMGkJwuBOMX7
 gyK53sY5RsyCk45ZI2UaDvENCesFIO3zQBoSsyIs+7HhI9OoDZuFJ/frmBE/BHL+VYoB
 gtp6e1ovQfzWAfbopsAG26GfNxp/F0gAZfg164gPrjbYzIH1fRKKtckwmSiXnXmIWFd0
 BOpiG8skjzMxL7OqxbGnpshsRtjoxc5Pby0ZsxOuKJXGiMVWRn/tCkpUm2zQwqvbMbYL Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mh605w3as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 14:01:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D56C10004A;
        Thu, 22 Dec 2022 14:01:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 610A62291C4;
        Thu, 22 Dec 2022 14:01:06 +0100 (CET)
Received: from [10.201.21.217] (10.201.21.217) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 22 Dec
 2022 14:01:05 +0100
Message-ID: <6e14aecb-e6f5-ec10-a5c5-af6fd1b54e89@foss.st.com>
Date:   Thu, 22 Dec 2022 14:01:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 1/7] dt-bindings: Document common device controller
 bindings
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
 <20221221173055.11719-2-gatien.chevallier@foss.st.com>
 <2a4b5094-013f-f873-4c0e-bb48ca6ac19e@kernel.org>
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <2a4b5094-013f-f873-4c0e-bb48ca6ac19e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.217]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_06,2022-12-22_02,2022-06-22_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Krzysztof,

On 12/22/22 11:22, Krzysztof Kozlowski wrote:
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> 
> On 21/12/2022 18:30, Gatien Chevallier wrote:
>> From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
> 
> You same From as SoB.
> 
>>
>> Introducing of the common device controller bindings for the controller
>> provider and consumer devices. Those bindings are intended to allow
>> divided system on chip into muliple domains, that can be used to
>> configure hardware permissions.
>>
>> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> 
> Missing SoB.
> 
> Missing changelog. This is not v1 but v7 or something >
> 
> 
>> ---
>>   .../feature-domain-controller.yaml            | 84 +++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml b/Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml
>> new file mode 100644
>> index 000000000000..90a7c38c833c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml
>> @@ -0,0 +1,84 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/feature-controllers/feature-domain-controller.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Generic Domain Controller bindings
> 
> Drop "bindings".
> 
> Anyway you duplicate work here:
> https://lore.kernel.org/all/c869d2751125181a55bc8a88c96e3a892b42f37a.1668070216.git.oleksii_moisieiev@epam.com/
> and maybe you duplicate comments.
> 
> I don't think there is point to review things twice, so NAK.
This is a result of me not knowing how to handle this particular case. 
It is a patch that I need to have in my patch set in order to pass Rob's 
bindings check. Otherwise, feature domains bindings defined here will 
not be known in the STM32 System Bus binding file, where they are used.

I wanted to illustrate the use of Oleksii's binding with a practical 
use-case that we want to implement.

What would be the correct way of managing this dependency?
-Specify something like "On top of ...." in the cover letter/patch and 
reference the other thread?
-Use a "Depends-On" tag on the YAML binding commit?
-Something else?

Best regards,
Gatien

> 
> 
> Best regards,
> Krzysztof
> 
