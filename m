Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73739653402
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiLUQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiLUQaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:30:15 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AF21EAC1;
        Wed, 21 Dec 2022 08:30:13 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BLGU6pJ028493;
        Wed, 21 Dec 2022 10:30:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671640206;
        bh=V+O2kyqjvZQ2MtUQk5LJauVhMSblR4w4ZEty/UQzvc8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Rs65zQatxmZn+MDquKBxeEQaVFl8wb9nfBGfjtFvbVpaviuY3o+pblCYmd8926S9z
         U9YxsdTO/tCH+t9JIqxtgr0ubtQXMka+N6UK4WItVqFh8D1Ky+Y6fiBO3tnHtnoVE1
         dx8XwMMZrRrQMib2RsuC7hLTn7GXagLICo9SuIFI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BLGU6qZ082599
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Dec 2022 10:30:06 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 21
 Dec 2022 10:30:05 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 21 Dec 2022 10:30:05 -0600
Received: from [10.0.2.15] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BLGU0cC016135;
        Wed, 21 Dec 2022 10:30:01 -0600
Message-ID: <2c058ebf-c39c-9cb5-4a6f-afe88940104a@ti.com>
Date:   Wed, 21 Dec 2022 21:59:19 +0530
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
 <645aca4d-b19c-390d-b899-fd40a924a096@ti.com>
 <12010f8f-d1d2-be18-8d4e-e1d282cb1670@linaro.org>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <12010f8f-d1d2-be18-8d4e-e1d282cb1670@linaro.org>
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

Hi Krzysztof,

On 21/12/22 15:06, Krzysztof Kozlowski wrote:
> On 21/12/2022 08:42, Devarsh Thakkar wrote:
>> Hi Krzysztof,
>>
>> Thanks for the review. Please find my response inline.
>>
>> On 30/11/22 20:33, Krzysztof Kozlowski wrote:
>>> On 30/11/2022 14:40, Devarsh Thakkar wrote:
>>>> AM62 family of devices don't have a R5F cluster, instead
>>>> they have single core DM R5F.
>>>> Add new compatible string ti,am62-r5fss to support this scenario.
>>>>
>>>> When this new compatible is used don't allow cluster-mode
>>>> property usage in device-tree as this implies that there
>>>> is no R5F cluster available and only single R5F core
>>>> is present.
>>>>
>>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>>> ---
>>>> V2: Avoid acronyms, use "Device Manager" instead of "DM"
>>>
>>> Use subject prefixes matching the subsystem (git log --oneline -- ...).
>> Agreed, I will update the prefix as dt-bindings: remoteproc: k3-r5f: in V3.
>>>
>>>> ---
>>>>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 48 +++++++++++++------
>>>>  1 file changed, 34 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>>> index fb9605f0655b..91357635025a 100644
>>>> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>>> @@ -21,6 +21,9 @@ description: |
>>>>    called "Single-CPU" mode, where only Core0 is used, but with ability to use
>>>>    Core1's TCMs as well.
>>>>  
>>>> +  AM62 SoC family support a single R5F core only which runs Device Manager
>>>> +  firmware and can also be used as a remote processor with IPC communication.
>>>> +
>>>>    Each Dual-Core R5F sub-system is represented as a single DTS node
>>>>    representing the cluster, with a pair of child DT nodes representing
>>>>    the individual R5F cores. Each node has a number of required or optional
>>>> @@ -28,6 +31,9 @@ description: |
>>>>    the device management of the remote processor and to communicate with the
>>>>    remote processor.
>>>>  
>>>> +  Since AM62 SoC family only support a single core, there is no cluster-mode
>>>> +  property setting required for it.
>>>> +
>>>>  properties:
>>>>    $nodename:
>>>>      pattern: "^r5fss(@.*)?"
>>>> @@ -38,6 +44,7 @@ properties:
>>>>        - ti,j721e-r5fss
>>>>        - ti,j7200-r5fss
>>>>        - ti,am64-r5fss
>>>> +      - ti,am62-r5fss
>>>
>>> Some order? Alphabetical, so before am64? Same in other places.
>> Agreed, I will update in V3 accordingly.
>>>
>>>
>>>>        - ti,j721s2-r5fss
>>>>  
>>>>    power-domains:
>>>> @@ -80,7 +87,8 @@ patternProperties:
>>>>        node representing a TI instantiation of the Arm Cortex R5F core. There
>>>>        are some specific integration differences for the IP like the usage of
>>>>        a Region Address Translator (RAT) for translating the larger SoC bus
>>>> -      addresses into a 32-bit address space for the processor.
>>>> +      addresses into a 32-bit address space for the processor. For AM62x,
>>>> +      should only define one R5F child node as it has only one core available.
>>>>  
>>>>        Each R5F core has an associated 64 KB of Tightly-Coupled Memory (TCM)
>>>>        internal memories split between two banks - TCMA and TCMB (further
>>>> @@ -104,6 +112,7 @@ patternProperties:
>>>>            - ti,j721e-r5f
>>>>            - ti,j7200-r5f
>>>>            - ti,am64-r5f
>>>> +          - ti,am62-r5f
>>>>            - ti,j721s2-r5f
>>>>  
>>>>        reg:
>>>> @@ -207,20 +216,31 @@ patternProperties:
>>>>        - firmware-name
>>>>  
>>>>      unevaluatedProperties: false
>>>
>>> Blank line.
>> Agreed, I will remove it in V3.
>>>
>>>> +allOf:
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          enum:
>>>> +            - ti,am64-r5fss
>>>> +    then:
>>>> +      properties:
>>>> +        ti,cluster-mode:
>>>> +          enum: [0, 2]
>>>> +
>>>> +    else:
>>>> +      properties:
>>>> +        ti,cluster-mode:
>>>
>>> It's not really valid anymore for ti,am62-r5fss, so this cannot be
>>> simple "else".  Instead you need to list all compatibles.
>> I agree that the else block is not valid for am62x, but my understanding is that since all the blocks under allOf are checked for validity,
>> I thought to add a separate if block only for am62x to set cluster-mode to false [1], which I believe would negate the effect of above else condition for am62x,
>> so that we don't have to list all compatibles under separate if blocks.
>>
>> Just to verify this, I deliberately set cluster-mode=1 in am62x devicetree and then ran a dtbs-check and got below log : 
[2]
>> "linux-next/arch/arm64/boot/dts/ti/k3-am625-sk.dtb: r5fss@78000000: ti,cluster-mode: False schema does not allow [[1]]"
>>
>> and above warning log goes away when i remove the cluster-mode node in am62x devicetree.
>> But please do let me know if I am missing something here or there is a better/more proper way to do this.
> 
> This was three weeks ago, so hundreds of patches ago, I don't remember
> anymore.
My apologies for the delay.
> 
> Just look at your patch - it is clearly incorrect. You said in the patch
> that for compatibles other than ti,am64-r5fss cluster mode is BOTH [0,
> 1] AND false.

cluster-mode is BOTH [0,1] and false only in case of AM62x as per below snippet, but since it's under allOf the impact of latter will supersede, schema validation will fail even if cluster-mode set to 0 or 1 for am62x due to below snippet as shared in obesrvation log above [2]. 

"  - if:
      properties:
        compatible:
          enum:
            - ti,am62-r5fss
    then:
      properties:
        ti,cluster-mode: false"

Sorry for the back and forth, I just thought to describe more clearly what I was up-to as I thought above should be functionally fine and it also saves us from having separate if blocks for each compatible, but I am open to adding separate if blocks as you earlier suggested if that seems more cleaner solution.

Best Regards,
Devarsh
> 
> I gave you the way to fix it. Feel free to fix it other ways if it gives
> correct result.
> 
> Best regards,
> Krzysztof
> 
