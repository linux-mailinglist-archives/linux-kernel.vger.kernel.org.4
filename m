Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8B66568F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiL0Jiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiL0Jil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:38:41 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B633095AE;
        Tue, 27 Dec 2022 01:38:38 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BR9cTJK129802;
        Tue, 27 Dec 2022 03:38:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672133909;
        bh=sBFcxIfmVFWwHDXc/9DJHMlWRkChsqo7NpNib9YU6Gc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=u6tJmSvTadIK9mmTL8LeKqS5+wRL5N4avWLv/FaHU16eGvfThFxnOr4VYnKcLDdg+
         QWrCssyHVrf2BnahCb0k3OAXNOWwLalQJfr95+98o636bhpvsjnDY6yPOnT1/itfUu
         Natw49NKRRNtHvCExBrOybXhOgjbP3yZAWSmCGN8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BR9cTfd026954
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Dec 2022 03:38:29 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 27
 Dec 2022 03:38:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 27 Dec 2022 03:38:28 -0600
Received: from [172.24.145.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BR9cOqu080668;
        Tue, 27 Dec 2022 03:38:25 -0600
Message-ID: <01a0ee96-051d-9f0b-88e6-8b6feaffacb8@ti.com>
Date:   Tue, 27 Dec 2022 15:08:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/2] dt-bindings: remoteproc: ti: Add new compatible
 for AM62 SoC family
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>
References: <20221223115638.20192-1-devarsht@ti.com>
 <20221223115638.20192-2-devarsht@ti.com>
 <374d0b5c-55f4-ee30-c804-4488a3fedb48@linaro.org>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <374d0b5c-55f4-ee30-c804-4488a3fedb48@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/12/22 17:48, Krzysztof Kozlowski wrote:
> On 23/12/2022 12:56, Devarsh Thakkar wrote:
>> AM62 family of devices don't have a R5F cluster, instead
>> they have single core DM R5F.
>> Add new compatible string ti,am62-r5fss to support this scenario.
>>
>> When this new compatible is used don't allow cluster-mode
>> property usage in device-tree as this implies that there
>> is no R5F cluster available and only single R5F core
>> is present.
>>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>> V2: Avoid acronyms, use "Device Manager" instead of "DM"
>> V3:
>> - Use separate if block for each compatible for ti,cluster-mode property
>> - Rearrange compatibles as per alphabatical order
>> ---
>>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 68 +++++++++++++------
>>  1 file changed, 47 insertions(+), 21 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>> index fb9605f0655b..e8a861179bd9 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>> @@ -21,6 +21,9 @@ description: |
>>    called "Single-CPU" mode, where only Core0 is used, but with ability to use
>>    Core1's TCMs as well.
>>  
>> +  AM62 SoC family support a single R5F core only which runs Device Manager
>> +  firmware and can also be used as a remote processor with IPC communication.
>> +
>>    Each Dual-Core R5F sub-system is represented as a single DTS node
>>    representing the cluster, with a pair of child DT nodes representing
>>    the individual R5F cores. Each node has a number of required or optional
>> @@ -28,16 +31,20 @@ description: |
>>    the device management of the remote processor and to communicate with the
>>    remote processor.
>>  
>> +  Since AM62 SoC family only support a single core, there is no cluster-mode
>> +  property setting required for it.
>> +
>>  properties:
>>    $nodename:
>>      pattern: "^r5fss(@.*)?"
>>  
>>    compatible:
>>      enum:
>> +      - ti,am62-r5fss
>> +      - ti,am64-r5fss
>>        - ti,am654-r5fss
>> -      - ti,j721e-r5fss
>>        - ti,j7200-r5fss
>> -      - ti,am64-r5fss
>> +      - ti,j721e-r5fss
>>        - ti,j721s2-r5fss
>>  
>>    power-domains:
>> @@ -80,7 +87,9 @@ patternProperties:
>>        node representing a TI instantiation of the Arm Cortex R5F core. There
>>        are some specific integration differences for the IP like the usage of
>>        a Region Address Translator (RAT) for translating the larger SoC bus
>> -      addresses into a 32-bit address space for the processor.
>> +      addresses into a 32-bit address space for the processor. For AM62x,
>> +      the R5F Sub-System device node should only define one R5F child node
>> +      as it has only one core available.
>>  
>>        Each R5F core has an associated 64 KB of Tightly-Coupled Memory (TCM)
>>        internal memories split between two banks - TCMA and TCMB (further
>> @@ -100,11 +109,12 @@ patternProperties:
>>      properties:
>>        compatible:
>>          enum:
>> -          - ti,am654-r5f
>> -          - ti,j721e-r5f
>> -          - ti,j7200-r5f
>> -          - ti,am64-r5f
>> -          - ti,j721s2-r5f
>> +          - ti,am62-r5fss
>> +          - ti,am64-r5fss
>> +          - ti,am654-r5fss
>> +          - ti,j7200-r5fss
>> +          - ti,j721e-r5fss
>> +          - ti,j721s2-r5fss
>>  
There is a problem here, the compatibles still need to be "-r5f" I will
correct it in V4.
>>        reg:
>>          items:
>> @@ -208,19 +218,35 @@ patternProperties:
>>  
>>      unevaluatedProperties: false
>>  
>> -if:
>> -  properties:
>> -    compatible:
>> -      enum:
>> -        - ti,am64-r5fss
>> -then:
>> -  properties:
>> -    ti,cluster-mode:
>> -      enum: [0, 2]
>> -else:
>> -  properties:
>> -    ti,cluster-mode:
>> -      enum: [0, 1]
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - ti,am64-r5fss
>> +    then:
>> +      properties:
>> +        ti,cluster-mode:
>> +          enum: [0, 2]
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum: ["ti,am654-r5fss", "ti,j7200-r5fss", "ti,j721e-r5fss",  "ti,j721s2-r5fss"]
> 
> That's not how enums are spelled for such cases. Git grep for examples -
> this should be a enum with each item in new entry, no quotes.
Yeah, that was my initial thought but then I looked at section 4.9.3 of
https://json-schema.org/understanding-json-schema/UnderstandingJSONSchema.pdf
which had below example and based on that did this change thus avoiding
separate entries for each enum.

Example:
{
"enum": ["red", "amber", "green", null, 42]
}

To confirm whether the change works fine, I deliberately modified cluster-mode
values for each of the SoC's beyond acceptable ranges as seen in
https://gist.github.com/devarsht/1956063c8e39f1bdbad3574ea96b95a3
and then ran "make dtbs_check" and it was able to catch the inappropriate
values of cluster-mode as seen in below logs :

https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L392
https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L500
https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L712
https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L741
https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L750
https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L766
https://gist.github.com/devarsht/bc8cfb82c55b75d85649585d3fd536a0#file-gistfile1-txt-L773

Kindly let me know if you see some issues with this approach.

Best Regards,
Devarsh

> 
> Best regards,
> Krzysztof
> 
