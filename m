Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DB76E42F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjDQI4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDQI4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:56:45 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D699346BF;
        Mon, 17 Apr 2023 01:56:42 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33H8uUbb041635;
        Mon, 17 Apr 2023 03:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681721790;
        bh=yzptaXuOq27eKuFA1U5AHvuUaV8N+INkrgU3LkJGkzg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=vX9M0Pmevcx4H6ERbAGrUdcdEAjHtFoyavYjeyPlvc91pghsGHTeSyokpHSxBPpYO
         AJXkfsPoOOYvgwExmrLIvo0V2OTaV1A5E1xEOcNHSD8pDPPq3SWpqaDadAUDfsB3VW
         Q28VQmpJn0SIs+MPjkeoPHyhSijYyw394FsrdzNI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33H8uT58021083
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 03:56:30 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 03:56:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 03:56:29 -0500
Received: from [172.24.145.247] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33H8uQA3077069;
        Mon, 17 Apr 2023 03:56:27 -0500
Message-ID: <d4a017e6-6df4-fc50-49c4-12c53719b7c0@ti.com>
Date:   Mon, 17 Apr 2023 14:26:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] dt-bindings: misc: esm: Add ESM support for TI K3
 devices
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <u-boot@lists.denx.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20230414105225.194195-1-n-francis@ti.com>
 <20230414105225.194195-2-n-francis@ti.com>
 <40498f71-d0cd-e7af-6515-c60a8d1edce8@linaro.org>
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <40498f71-d0cd-e7af-6515-c60a8d1edce8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On 14/04/23 17:10, Krzysztof Kozlowski wrote:
> On 14/04/2023 12:52, Neha Malcom Francis wrote:
>> Document the binding for TI K3 ESM (Error Signaling Module) block.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   .../devicetree/bindings/misc/esm-k3.yaml      | 54 +++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/esm-k3.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/misc/esm-k3.yaml b/Documentation/devicetree/bindings/misc/esm-k3.yaml
>> new file mode 100644
>> index 000000000000..5e637add3b0e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/esm-k3.yaml
> 
> Filename matching compatible. Missing vendor prefix and device name.
> 
>> @@ -0,0 +1,54 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2022 Texas Instruments Incorporated
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/misc/esm-k3.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments K3 ESM Binding
> 
> Drop: Binding
> 
>> +
>> +maintainers:
>> +  - Neha Malcom Francis <n-francis@ti.com>
>> +
>> +description: |
>> +  The ESM (Error Signaling Module) is an IP block on TI K3 devices
>> +  that allows handling of safety events somewhat similar to what interrupt
>> +  controller would do. The safety signals have their separate paths within
>> +  the SoC, and they are handld by the ESM, which routes them to the proper
> 
> typo: handled
> 
>> +  destination, which can be system reset, interrupt controller, etc. In the
>> +  simplest configuration the signals are just routed to reset the SoC.
> 
> There is no proper bindings directory for ESM? Misc is discouraged.
> 

There is no other directory I see fit for a block like ESM; it could 
either remain in misc/ or maybe create a directory error/ for all error 
signaling and correction mechanisms? I see misc/xlnx,sd-fec.txt that 
could also go in error/

What do you think is fit?

>> +
>> +properties:
>> +  compatible:
>> +    const: ti,j721e-esm
>> +
>> +  reg:
>> +    items:
>> +      - description: physical address and length of the registers which
>> +          contain revision and debug features
> 
> Drop useless "physical address and length of the registers which". reg
> cannot be anything else.
> 
>> +      - description: physical address and length of the registers which
>> +          indicate strapping options
>> +
>> +  ti,esm-pins:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +      integer array of ESM event IDs to route to external event pin which can
>> +      be used to reset the SoC. The array can have an arbitrary amount of event
>> +      IDs listed on it.
> 
> What is ESM event ID? The property name suggests pins...
> 
> 
>> +    minItems: 1
>> +    maxItems: 255
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - ti,esm-pins
>> +
>> +examples:
>> +  - |
>> +    main_esm: esm@700000 {
> 
> Drop label.
> 

Thanks for the reviews! I'll send v2 after we decide on the location.

>> +        compatible = "ti,j721e-esm";
>> +        reg = <0x0 0x700000 0x0 0x1000>;
>> +        ti,esm-pins = <344>, <345>;
>> +    };
> 
> Best regards,
> Krzysztof
> 

-- 
Thanking You
Neha Malcom Francis
