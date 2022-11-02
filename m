Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA4616D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiKBTGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKBTGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:06:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927A92D4;
        Wed,  2 Nov 2022 12:06:01 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A2J5TAb077081;
        Wed, 2 Nov 2022 14:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667415929;
        bh=mzZxMJVEQJpXDhPObxYGdoDYN7/gCqvCB8snGGAKPqw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ud4Dk8CNutSABAEQ8bFYxzZUYQMXzbgLf+Tgt8LFI1Lr+7fYPpXCTzBchXH1fixL/
         91oxTNbVg//JFqaLWf/j5vWzyb8vXGIn/Ejar8qqbY6j7kKMkUlx3VeSTGv7ubaScU
         t45aWlDphfeVnhZqLSQK82OGKVkLGuHYuJoroVg8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A2J5TbQ018384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Nov 2022 14:05:29 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 2 Nov
 2022 14:05:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 2 Nov 2022 14:05:29 -0500
Received: from [10.249.33.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A2J5SAm110083;
        Wed, 2 Nov 2022 14:05:28 -0500
Message-ID: <c5e39861-dd81-7c9f-cbb5-2bfbef55ed41@ti.com>
Date:   Wed, 2 Nov 2022 14:05:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/9] dt-bindings: mfd: Add TI-Nspire misc registers
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221101215804.16262-1-afd@ti.com>
 <20221101215804.16262-2-afd@ti.com>
 <20221102173558.GA4193055-robh@kernel.org>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221102173558.GA4193055-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 11/2/22 12:35 PM, Rob Herring wrote:
> On Tue, Nov 01, 2022 at 04:57:56PM -0500, Andrew Davis wrote:
>> The TI Nspire devices contain a set of registers with a seemingly
>> miscellaneous set of functionality. This area is known simply as the
>> "misc" region.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   .../bindings/mfd/ti,nspire-misc.yaml          | 55 +++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
>> new file mode 100644
>> index 0000000000000..d409eae7537bd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
>> @@ -0,0 +1,55 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/ti,nspire-misc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI Nspire MISC hardware block
>> +
>> +maintainers:
>> +  - Andrew Davis <afd@ti.com>
>> +
>> +description: |
>> +  System controller node represents a register region containing a set
>> +  of miscellaneous registers. The registers are not cohesive enough to
>> +  represent as any specific type of device. The typical use-case is
>> +  for some other node's driver, or platform-specific code, to acquire
>> +  a reference to the syscon node (e.g. by phandle, node path, or
>> +  search using a specific compatible value), interrogate the node (or
>> +  associated OS driver) to determine the location of the registers,
>> +  and access the registers directly.
> 
> Looks like you copied the generic description? Describe what MISC
> contains.
> 

I don't know what all MISC contains (or maybe I do, but it is not
publicly available so I'm not going to add anything that hasn't
already been found by clean-room reverse engineering [0]).

This is the point I was trying to make in that thread on v3. The
node's content *is* the hardware description. Every time a new
register is found it could have just been added to the DT. But now
we also have to go back here and add the exact same information
to the binding, every time. We don't require that for simple-bus,
should simple-mfd be given the same flexibility?

[0] https://hackspire.org/index.php?title=Memory-mapped_I/O_ports_on_Classic#900A0000_-_Miscellaneous

>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - ti,nspire-misc
>> +      - const: syscon
>> +      - const: simple-mfd
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  reboot:
>> +    $ref: "../power/reset/syscon-reboot.yaml"
> 
> /schemas/power/...
> 
> And no quotes needed.
> 

Will fix.

Andrew

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reboot
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    misc: misc@900a0000 {
>> +      compatible = "ti,nspire-misc", "syscon", "simple-mfd";
>> +      reg = <0x900a0000 0x1000>;
>> +
>> +      reboot {
>> +        compatible = "syscon-reboot";
>> +        offset = <0x08>;
>> +        value = <0x02>;
>> +      };
>> +    };
>> -- 
>> 2.37.3
>>
>>
