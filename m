Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2481265420C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLVNj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiLVNjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:39:51 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E711262C;
        Thu, 22 Dec 2022 05:39:50 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMBh8MW001873;
        Thu, 22 Dec 2022 14:39:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=JWSFMS/RjJJvWBd45Dlnuo9vEz3wrE67COqhffoMv6I=;
 b=i6mHZi6kuCrWx7KOhnVivhGqK5Oj+mo3k/JyMBsJYS85mXTQbcNrgMDCydoNG/sljHTc
 mFNOChS9QjmXAvRNO5u7cjZoHPYk+8n19KqgrmnKYwFSHhICrLiFMhHIVxDsEtPv72wc
 Fs3OBLwu1Ayyt8jrXX7W5y7d+g9A8i8j6b+/AuOu4EZExzXRAML9yHXmjDRUOb63yxoB
 v4H4bkmeVwMjZMAHUQ19qYI0+QXEbdYVrsk3IbI4pgRPnSU118swSKhavHm7YKgG7HAu
 LcJeRMrTecNwnp/g8lckgEGHRZNmt7Y22vEuElJhW5EDEwFQ4/cgzpeD+fZhsOdFElYA QA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mka9xgtvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 14:39:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2FA5410002A;
        Thu, 22 Dec 2022 14:39:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0B48B228A31;
        Thu, 22 Dec 2022 14:39:30 +0100 (CET)
Received: from [10.201.21.217] (10.201.21.217) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 22 Dec
 2022 14:39:29 +0100
Message-ID: <f785a9f9-a931-a4b0-5d97-d9e8ce24065a@foss.st.com>
Date:   Thu, 22 Dec 2022 14:39:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 2/7] dt-bindings: bus: add STM32 System Bus
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
 <20221221173055.11719-3-gatien.chevallier@foss.st.com>
 <d55cae92-0c4f-f957-4c7b-bdf7b9b6006a@kernel.org>
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <d55cae92-0c4f-f957-4c7b-bdf7b9b6006a@kernel.org>
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

Hello,

On 12/22/22 11:24, Krzysztof Kozlowski wrote:
> On 21/12/2022 18:30, Gatien Chevallier wrote:
>> Document STM32 System Bus. This bus is intended to control firewall
>> access for the peripherals connected to it.
>>
>> Signed-off-by: Loic PALLARDY <loic.pallardy@st.com>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel
As it is based on Oleksii's patchset and older threads:
[1]: 
https://lore.kernel.org/all/20190318100605.29120-1-benjamin.gaignard@st.com/
[2]: 
https://lore.kernel.org/all/20200701132523.32533-1-benjamin.gaignard@st.com/

I wanted to include people that have already been included or 
participated in these.

I'm sorry I did miss/added some (extra) people. I will double-check for 
next patchset version.

> 
>> ---
>>   .../devicetree/bindings/bus/st,sys-bus.yaml   | 88 +++++++++++++++++++
>>   1 file changed, 88 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/bus/st,sys-bus.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/bus/st,sys-bus.yaml b/Documentation/devicetree/bindings/bus/st,sys-bus.yaml
>> new file mode 100644
>> index 000000000000..9c0e86612695
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/bus/st,sys-bus.yaml
>> @@ -0,0 +1,88 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/bus/stm32,sys-bus.yaml
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title:  STM32 System Bus
> 
> Only one space.
> 

Ack. I already pushed a V2, that is now outdated with your review, where 
this error is fixed.

>> +
>> +description: |
>> +  The STM32 System Bus is an internal bus to which some internal peripherals
>> +  are connected. STM32 System Bus integrates a firewall controlling access to each
>> +  device. This bus prevents non-accessible devices to be probed.
>> +
>> +  To see which peripherals are securable, please check the SoC reference manual.
>> +
>> +maintainers:
>> +  - Gatien Chevallier <gatien.chevallier@foss.st.com>
>> +
>> +allOf:
>> +  - $ref: /schemas/feature-controllers/feature-domain-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - st,stm32mp13-sys-bus
>> +      - st,stm32mp15-sys-bus
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  '#feature-domain-cells':
> 
> Use consistent quotes, either ' or "

Ack, will change in V3.

> 
>> +    minItems: 1
> 
> No. Cells must be const. This does not match cells at all...
> 

Ack, will change to const in V3. What do imply by saying it does not 
match? Note that I've changed it to "minimum" in V2.

>> +
>> +  ranges: true
>> +
>> +  feature-domain-controller: true
>> +
>> +patternProperties:
>> +  "^.*@[0-9a-f]+$":
>> +    description: Devices attached to system bus
>> +    type: object
>> +    properties:
>> +      feature-domains:
>> +        $ref: /schemas/feature-controllers/feature-domain-controller.yaml#/properties/feature-domains
> 
> maxItems

I don't think setting a max here is relevant as there can be numerous 
feature-domains referenced.

Maybe a min?

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - feature-domain-controller
>> +  - '#feature-domain-cells'
>> +  - ranges
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    // In this example,
>> +    // - the foo1 device refers to etzpc as his domain controller.
>> +    // - same goes for foo2.
>> +    // Access rights are verified before creating devices.
>> +
>> +    etzpc: etzpc@5c007000 {
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 

Ack, will change to "etzpc: bus@5c007000" in V3

>> +        compatible = "st,stm32mp15-sys-bus";
>> +        reg = <0x5c007000 0x400>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges;
>> +        feature-domain-controller;
>> +        #feature-domain-cells = <1>;
>> +
>> +        foo1: foo@1000000 {
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Here, if I use real peripherals, I have an issue with the dependency to 
YAML files. The feature-domains property is not defined in their 
bindings. Therefore, the dt_binding_check fails on peripherals whose 
YAML declare "additionalProperties: false" because the link to the 
feature domain controller bindings does not exist.

What would be your recommandation here as declaring:

patternProperties:
   "^.*@[0-9a-f]+$":
     description: Devices attached to system bus
     type: object
     properties:
       feature-domains:
         $ref: 
/schemas/feature-controllers/feature-domain-controller.yaml#/properties/feature-domains

does not solve the issue?



> 
>> +          reg = <0x0 0x1000000>;
> 
> Missing compatible, missing proper device name. Don't use fake names,
> but describe real case.

Linked to above issue.

> 
>> +          feature-domains = <&etzpc 0>;
>> +        };
>> +
>> +        foo2: foo@2000000 {
>> +          reg = <0x0 0x2000000>;
>> +          feature-domains = <&etzpc 0>;
>> +        };
>> +    };
> 
> Best regards,
> Krzysztof
> 

Best regards,
Gatien
