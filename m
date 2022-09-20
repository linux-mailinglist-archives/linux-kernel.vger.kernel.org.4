Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170475BDBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiITE2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiITE2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:28:19 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C2955083;
        Mon, 19 Sep 2022 21:27:52 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28K4RZOw122334;
        Mon, 19 Sep 2022 23:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663648055;
        bh=rAOq7hsqSEamlac1gLlAoEPrKmraVO5yGCsSAtiqTog=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=L4Q+ooU5dJJT4L7O+LORB/CxpMqHS6zZNlCcSNR3EGGG+mpzzFSfvco5OPTeeIQDU
         KKT0wef2AvT02t/suBW2VVzA7kfifbKMzc7NjL5HKOHhC+R2UIM6uV/f0KgOZ7nZr8
         H6ZDvSjF1IAPIiv3ibwfQjbQGiPz8aVmdXX3sDUI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28K4RZAa031823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Sep 2022 23:27:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 19
 Sep 2022 23:27:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 19 Sep 2022 23:27:34 -0500
Received: from [10.24.69.241] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28K4RUik012556;
        Mon, 19 Sep 2022 23:27:31 -0500
Message-ID: <fdeb4f4f-2712-fe35-a5c2-935d3a4baf38@ti.com>
Date:   Tue, 20 Sep 2022 09:57:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
CC:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <rogerq@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <sjakhade@cadence.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for
 J721e
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
References: <20220914093911.187764-1-s-vadapalli@ti.com>
 <20220914093911.187764-2-s-vadapalli@ti.com>
 <2dfb57cd-d9d4-9a26-dd4c-f116894c9baf@linaro.org>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <2dfb57cd-d9d4-9a26-dd4c-f116894c9baf@linaro.org>
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

On 19/09/22 15:45, Krzysztof Kozlowski wrote:
> On 14/09/2022 11:39, Siddharth Vadapalli wrote:
>> TI's J721e SoC supports additional PHY modes like QSGMII and SGMII
>> that are not supported on earlier SoCs. Add a compatible for it.
>>
>> Extend ti,qsgmii-main-ports property to support selection of upto
>> two main ports at once across the two QSGMII interfaces.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 52 ++++++++++++++++---
>>  1 file changed, 46 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>> index da7cac537e15..1e19efab018b 100644
>> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>> @@ -54,6 +54,7 @@ properties:
>>        - ti,dm814-phy-gmii-sel
>>        - ti,am654-phy-gmii-sel
>>        - ti,j7200-cpsw5g-phy-gmii-sel
>> +      - ti,j721e-cpsw9g-phy-gmii-sel
>>  
>>    reg:
>>      maxItems: 1
>> @@ -65,12 +66,19 @@ properties:
>>      description: |
>>        Required only for QSGMII mode. Array to select the port for
>>        QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
>> -      ports automatically. Any one of the 4 CPSW5G ports can act as the
>> -      main port with the rest of them being the QSGMII_SUB ports.
>> -    maxItems: 1
>> -    items:
>> -      minimum: 1
>> -      maximum: 4
> 
> minItems: 1
> maxItems: 2
>   items:
>     minimum: 1
>     maximum: 8

Thank you for reviewing the patch. I assume that you want me to mention
the values for "minItems", "maxItems", "minimum" and "maximum" here and
modify them later based on the compatible where applicable. I will do so
in the v2 series.

> 
>> +      ports automatically. For J7200 CPSW5G with the compatible:
>> +      ti,j7200-cpsw5g-phy-gmii-sel, ti,qsgmii-main-ports is an
>> +      array of only one element, which is the port number ranging from
>> +      1 to 4. For J721e CPSW9G with the compatible:
>> +      ti,j721e-cpsw9g-phy-gmii-sel, ti,qsgmii-main-ports is an array
>> +      of two elements, which corresponds to two potential QSGMII main
>> +      ports. The first element and second element of the array can both
>> +      range from 1 to 8 each, corresponding to two QSGMII main ports.
>> +      For J721e CPSW9G, to configure port 2 as the first QSGMII main
>> +      port and port 7 as the second QSGMII main port, we specify:
>> +      ti,qsgmii-main-ports = <2>, <7>;
>> +      If only one QSGMII main port is desired, mention the same main
>> +      port twice.
>>  
>>  allOf:
>>    - if:
>> @@ -81,12 +89,43 @@ allOf:
>>                - ti,dra7xx-phy-gmii-sel
>>                - ti,dm814-phy-gmii-sel
>>                - ti,am654-phy-gmii-sel
>> +              - ti,j7200-cpsw5g-phy-gmii-sel
>> +              - ti,j721e-cpsw9g-phy-gmii-sel
>>      then:
>>        properties:
>>          '#phy-cells':
>>            const: 1
>>            description: CPSW port number (starting from 1)
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - ti,j7200-cpsw5g-phy-gmii-sel
>> +    then:
>> +      properties:
>> +        ti,qsgmii-main-ports:
>> +          maxItems: 1
>> +          items:
>> +            minimum: 1
>> +            maximum: 4
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - ti,j721e-cpsw9g-phy-gmii-sel
>> +    then:
>> +      properties:
>> +        ti,qsgmii-main-ports:
>> +          minItems: 2
>> +          maxItems: 2
>> +          items:
>> +            minimum: 1
>> +            maximum: 8
>> +
>>    - if:
>>        not:
>>          properties:
>> @@ -94,6 +133,7 @@ allOf:
>>              contains:
>>                enum:
>>                  - ti,j7200-cpsw5g-phy-gmii-sel
>> +                - ti,j721e-cpsw9g-phy-gmii-sel
>>      then:
>>        properties:
>>          ti,qsgmii-main-ports: false
> 
> This is interesting here... Did you test the bindings with your DTS?

Yes, I tried it out with different compatibles in the DTS file for the
node, making sure that the property "ti,qsgmii-main-ports" is allowed
only for the "ti,j7200-cpsw5g-phy-gmii-sel" and the
"ti,j721e-cpsw9g-phy-gmii-sel" compatibles. Additionally, I also tested
that the "minItems", "maxItems", "minimum" and "maximum" checks apply.
All of the rules within the "allOf", are enforced one after the other in
sequence, based on my testing. Please let me know in case of any
suggestions to implement it in a better way.

Regards,
Siddharth.
