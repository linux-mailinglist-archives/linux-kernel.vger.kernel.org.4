Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5965B5BDBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiITE5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiITE5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:57:03 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B12958DC9;
        Mon, 19 Sep 2022 21:57:02 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28K4ufqe003851;
        Mon, 19 Sep 2022 23:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663649801;
        bh=8KOilXQeO0JEZa4fCJ5Ej6qxCCZNlBHDegq2hXI2lMM=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=lgHGL0PoyBAOscAKWonYb66zAR6WfTpF6PjNmVbU0Y1Swaf6bdxHCMmKLYXMw4g7q
         od+p3RW3XWkK4cs/94mD58EA8pff77fPdAKiLnKbiVOeyfZIYDmVfnW2w9W0PT1n/S
         jkAt8YqtQSdT3lp8GJFTCjEME3zDeOW/vcdAuab4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28K4ufYW009288
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Sep 2022 23:56:41 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 19
 Sep 2022 23:56:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 19 Sep 2022 23:56:41 -0500
Received: from [10.24.69.241] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28K4uaHc034689;
        Mon, 19 Sep 2022 23:56:37 -0500
Message-ID: <2f830a26-c9f0-2902-302c-371c59994a6f@ti.com>
Date:   Tue, 20 Sep 2022 10:26:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
CC:     <lee.jones@linaro.org>, <kishon@ti.com>, <vkoul@kernel.org>,
        <dan.carpenter@oracle.com>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <sjakhade@cadence.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for
 J721e
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>
References: <20220914093911.187764-1-s-vadapalli@ti.com>
 <20220914093911.187764-2-s-vadapalli@ti.com>
 <20220914161527.GA2269201-robh@kernel.org>
 <d48e5ef4-6d5b-0977-ed45-de810e42356c@ti.com>
 <31028736-ba81-122e-b630-b66e9d9d491a@linaro.org>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <31028736-ba81-122e-b630-b66e9d9d491a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hello Krzysztof,

On 19/09/22 15:47, Krzysztof Kozlowski wrote:
> On 15/09/2022 07:28, Siddharth Vadapalli wrote:
>>>> @@ -65,12 +66,19 @@ properties:
>>>>      description: |
>>>>        Required only for QSGMII mode. Array to select the port for
>>>>        QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
>>>> -      ports automatically. Any one of the 4 CPSW5G ports can act as the
>>>> -      main port with the rest of them being the QSGMII_SUB ports.
>>>> -    maxItems: 1
>>>> -    items:
>>>> -      minimum: 1
>>>> -      maximum: 4
>>>> +      ports automatically. For J7200 CPSW5G with the compatible:
>>>> +      ti,j7200-cpsw5g-phy-gmii-sel, ti,qsgmii-main-ports is an
>>>> +      array of only one element, which is the port number ranging from
>>>> +      1 to 4. For J721e CPSW9G with the compatible:
>>>> +      ti,j721e-cpsw9g-phy-gmii-sel, ti,qsgmii-main-ports is an array
>>>> +      of two elements, which corresponds to two potential QSGMII main
>>>> +      ports. The first element and second element of the array can both
>>>> +      range from 1 to 8 each, corresponding to two QSGMII main ports.
>>>> +      For J721e CPSW9G, to configure port 2 as the first QSGMII main
>>>> +      port and port 7 as the second QSGMII main port, we specify:
>>>> +      ti,qsgmii-main-ports = <2>, <7>;
>>>> +      If only one QSGMII main port is desired, mention the same main
>>>> +      port twice.
>>>
>>> Two different forms for the same property name is not great. Just make a 
>>> new property if you need something different.
>>
>> Thank you for reviewing the patch. Based on the discussion for the
>> previous series at [1], I had planned to reuse the same property
>> "ti,qsgmii-main-ports" for TI's J721e device too. The reason for this is
>> that the property represents the same feature on both devices which is
>> that of the QSGMII main port. The only difference between the two of
>> them is that J7200's CPSW5G has 4 external ports while J721e's CPSW9G
>> has 8 external ports. Thus, J7200 can have at most one QSGMII main port
>> while J721e can have up to two. Adding a new property which describes
>> the same feature appears to be redundant to me. Please let me know.
>>
> 
> The trouble is that you wrote the description like it were two different
> properties (for xx this is one element, for yy this is something else).
> You need to describe the property in unified way.

Thank you for reviewing the patch. I plan to update the description to
the following:
"Required only for QSGMII mode. Array to select the port/s for QSGMII
main mode. The size of the array corresponds to the number of QSGMII
interfaces and thus, the number of distinct QSGMII main ports, supported
by the device. If the device supports two QSGMII interfaces but only one
QSGMII interface is desired, repeat the QSGMII main port value
corresponding to the QSGMII interface in the array."

I intend to describe the property in detail to help users understand the
property and its usage better. In the process, I might have
unintentionally made it appear as two different properties in the
previous description. I hope the new description shows that the property
describes the same feature across devices while making its usage clear
to the users at the same time. Please let me know if this is fine.

Regards,
Siddharth.
