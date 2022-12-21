Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF19652D60
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiLUHms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUHmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:42:45 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C86B6555;
        Tue, 20 Dec 2022 23:42:43 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BL7gYlk113506;
        Wed, 21 Dec 2022 01:42:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671608554;
        bh=Ez96FijQFklJTz8IMFPnWCRlr1eR4+kdyeMz2055puc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=lKl5Rz3dGRDIv9eNmOQzwZ70i4kCtD4rcddfn3n5Y3Ub/1/1M+L+wH9IDjXoiykb7
         nAXfnQHGqJZJV1mOgGqEtZOGx8A2p8FNwd5LMh6eoijxiL1sG7yD4ymbTCshJzBt6P
         DqtsLC9fy75iLCfL2JD6LrBSf9o7Ey6e5lAj1slQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BL7gYAo003429
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Dec 2022 01:42:34 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 21
 Dec 2022 01:42:33 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 21 Dec 2022 01:42:33 -0600
Received: from [10.0.2.15] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BL7gS8P100590;
        Wed, 21 Dec 2022 01:42:28 -0600
Message-ID: <645aca4d-b19c-390d-b899-fd40a924a096@ti.com>
Date:   Wed, 21 Dec 2022 13:12:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] Documentation: dt-bindings: k3-r5f-rproc: Add new
 compatible for AM62 SoC family
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <s-anna@ti.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>
References: <20221130134052.7513-1-devarsht@ti.com>
 <20221130134052.7513-2-devarsht@ti.com>
 <b4b608bf-e347-5500-eb94-bec3611f6a56@linaro.org>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <b4b608bf-e347-5500-eb94-bec3611f6a56@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the review. Please find my response inline.

On 30/11/22 20:33, Krzysztof Kozlowski wrote:
> On 30/11/2022 14:40, Devarsh Thakkar wrote:
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
> 
> Use subject prefixes matching the subsystem (git log --oneline -- ...).
Agreed, I will update the prefix as dt-bindings: remoteproc: k3-r5f: in V3.
> 
>> ---
>>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 48 +++++++++++++------
>>  1 file changed, 34 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>> index fb9605f0655b..91357635025a 100644
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
>> @@ -28,6 +31,9 @@ description: |
>>    the device management of the remote processor and to communicate with the
>>    remote processor.
>>  
>> +  Since AM62 SoC family only support a single core, there is no cluster-mode
>> +  property setting required for it.
>> +
>>  properties:
>>    $nodename:
>>      pattern: "^r5fss(@.*)?"
>> @@ -38,6 +44,7 @@ properties:
>>        - ti,j721e-r5fss
>>        - ti,j7200-r5fss
>>        - ti,am64-r5fss
>> +      - ti,am62-r5fss
> 
> Some order? Alphabetical, so before am64? Same in other places.
Agreed, I will update in V3 accordingly.
> 
> 
>>        - ti,j721s2-r5fss
>>  
>>    power-domains:
>> @@ -80,7 +87,8 @@ patternProperties:
>>        node representing a TI instantiation of the Arm Cortex R5F core. There
>>        are some specific integration differences for the IP like the usage of
>>        a Region Address Translator (RAT) for translating the larger SoC bus
>> -      addresses into a 32-bit address space for the processor.
>> +      addresses into a 32-bit address space for the processor. For AM62x,
>> +      should only define one R5F child node as it has only one core available.
>>  
>>        Each R5F core has an associated 64 KB of Tightly-Coupled Memory (TCM)
>>        internal memories split between two banks - TCMA and TCMB (further
>> @@ -104,6 +112,7 @@ patternProperties:
>>            - ti,j721e-r5f
>>            - ti,j7200-r5f
>>            - ti,am64-r5f
>> +          - ti,am62-r5f
>>            - ti,j721s2-r5f
>>  
>>        reg:
>> @@ -207,20 +216,31 @@ patternProperties:
>>        - firmware-name
>>  
>>      unevaluatedProperties: false
> 
> Blank line.
Agreed, I will remove it in V3.
> 
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
>> +    else:
>> +      properties:
>> +        ti,cluster-mode:
> 
> It's not really valid anymore for ti,am62-r5fss, so this cannot be
> simple "else".  Instead you need to list all compatibles.
I agree that the else block is not valid for am62x, but my understanding is that since all the blocks under allOf are checked for validity,
I thought to add a separate if block only for am62x to set cluster-mode to false [1], which I believe would negate the effect of above else condition for am62x,
so that we don't have to list all compatibles under separate if blocks.

Just to verify this, I deliberately set cluster-mode=1 in am62x devicetree and then ran a dtbs-check and got below log : 
"linux-next/arch/arm64/boot/dts/ti/k3-am625-sk.dtb: r5fss@78000000: ti,cluster-mode: False schema does not allow [[1]]"

and above warning log goes away when i remove the cluster-mode node in am62x devicetree.
But please do let me know if I am missing something here or there is a better/more proper way to do this.

Best Regards,
Devarsh

> 
>> +          enum: [0, 1]
>> +
[1]
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - ti,am62-r5fss
>> +    then:
>> +      properties:
>> +        ti,cluster-mode: false
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
>>  
>>  required:
>>    - compatible
> 
> Best regards,
> Krzysztof
> 
