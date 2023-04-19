Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9476E759D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjDSIra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjDSIrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:47:24 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A15C977B;
        Wed, 19 Apr 2023 01:47:21 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33J8kvJ4032837;
        Wed, 19 Apr 2023 03:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681894017;
        bh=YiUjVEmZdfGzufCilXwC4IbrxjW/0FomwxeodPBkuFw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Fki/i83dL5yDTTYrqwvltvG8qkIDxvQtZiHtxOY1yQ+ZoT2p4PTiRZVNE4kO+vZnS
         YwDqEaVrM6DVRAXLBQxGMZzOutybLAuw+16+9lPspl650hoIdMzh42vVRV2V6/IsA1
         5McjGq21HGU/mdFYkXGydQwaZmhoPowMHxeyQm9k=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33J8kves076089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 03:46:57 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 03:46:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 03:46:57 -0500
Received: from [172.24.145.235] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33J8krC9046994;
        Wed, 19 Apr 2023 03:46:54 -0500
Message-ID: <874a4c0d-5447-4e74-fd9f-9493a8b1fa24@ti.com>
Date:   Wed, 19 Apr 2023 14:16:53 +0530
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
        <linux-arm-kernel@lists.infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20230414105225.194195-1-n-francis@ti.com>
 <20230414105225.194195-2-n-francis@ti.com>
 <40498f71-d0cd-e7af-6515-c60a8d1edce8@linaro.org>
 <d4a017e6-6df4-fc50-49c4-12c53719b7c0@ti.com>
 <eb6bfe2e-1e44-bfb5-01b9-bbf53eba6501@linaro.org>
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <eb6bfe2e-1e44-bfb5-01b9-bbf53eba6501@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On 18/04/23 21:40, Krzysztof Kozlowski wrote:
> On 17/04/2023 10:56, Neha Malcom Francis wrote:
>> Hi Krzysztof
>>
>> On 14/04/23 17:10, Krzysztof Kozlowski wrote:
>>> On 14/04/2023 12:52, Neha Malcom Francis wrote:
>>>> Document the binding for TI K3 ESM (Error Signaling Module) block.
>>>>
>>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>>> ---
>>>>    .../devicetree/bindings/misc/esm-k3.yaml      | 54 +++++++++++++++++++
>>>>    1 file changed, 54 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/misc/esm-k3.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/misc/esm-k3.yaml b/Documentation/devicetree/bindings/misc/esm-k3.yaml
>>>> new file mode 100644
>>>> index 000000000000..5e637add3b0e
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/misc/esm-k3.yaml
>>>
>>> Filename matching compatible. Missing vendor prefix and device name.
>>>
>>>> @@ -0,0 +1,54 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +# Copyright (C) 2022 Texas Instruments Incorporated
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/misc/esm-k3.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Texas Instruments K3 ESM Binding
>>>
>>> Drop: Binding
>>>
>>>> +
>>>> +maintainers:
>>>> +  - Neha Malcom Francis <n-francis@ti.com>
>>>> +
>>>> +description: |
>>>> +  The ESM (Error Signaling Module) is an IP block on TI K3 devices
>>>> +  that allows handling of safety events somewhat similar to what interrupt
>>>> +  controller would do. The safety signals have their separate paths within
>>>> +  the SoC, and they are handld by the ESM, which routes them to the proper
>>>
>>> typo: handled
>>>
>>>> +  destination, which can be system reset, interrupt controller, etc. In the
>>>> +  simplest configuration the signals are just routed to reset the SoC.
>>>
>>> There is no proper bindings directory for ESM? Misc is discouraged.
>>>
>>
>> There is no other directory I see fit for a block like ESM; it could
>> either remain in misc/ or maybe create a directory error/ for all error
>> signaling and correction mechanisms? I see misc/xlnx,sd-fec.txt that
>> could also go in error/
>>
>> What do you think is fit?
> 
> I don't know. Maybe it is something like hwmon? Or maybe along with
> xlnx,sd-fec, tmr-inject and tmr-manager should be moved to some "fault"
> directory for all fault-management-and-handling hardware?
> 

I think hwmon would be a fit for now. Maybe we can move to a common 
fault directory in a future patch if there is enough bindings.

> Best regards,
> Krzysztof
> 

-- 
Thanking You
Neha Malcom Francis
