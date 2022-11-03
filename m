Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11DB61739F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKCBOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKCBOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:14:15 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FAD25F6;
        Wed,  2 Nov 2022 18:14:13 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A31DkdA074343;
        Wed, 2 Nov 2022 20:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667438026;
        bh=g87VIu80dnT7p+aQPGGUELPndmBH8kRxZATib9cYrnI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=V0bxZfgWWXTfn8KvvEtD7NMtJDipTdy4GaMym2mf4UZJxG8ZgPcTqMzNgcAyFmY75
         oGAKtENQAhm0FNkSdz4Blcjiou9yl0TYLMRfxPEux1A0L8MK/44LmyDl4Gbcbi0D8K
         ulI9Vop5bfwL0EcobG5mV9f3nPb10kfq3I46ZrBc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A31DkFM090578
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Nov 2022 20:13:46 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 2 Nov
 2022 20:13:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 2 Nov 2022 20:13:45 -0500
Received: from [10.249.33.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A31Djxv087808;
        Wed, 2 Nov 2022 20:13:45 -0500
Message-ID: <904b42ea-0655-2fae-98d6-17429533de2e@ti.com>
Date:   Wed, 2 Nov 2022 20:13:44 -0500
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
 <c5e39861-dd81-7c9f-cbb5-2bfbef55ed41@ti.com>
 <20221102212645.GA459441-robh@kernel.org>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221102212645.GA459441-robh@kernel.org>
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

On 11/2/22 4:26 PM, Rob Herring wrote:
> On Wed, Nov 02, 2022 at 02:05:28PM -0500, Andrew Davis wrote:
>> On 11/2/22 12:35 PM, Rob Herring wrote:
>>> On Tue, Nov 01, 2022 at 04:57:56PM -0500, Andrew Davis wrote:
>>>> The TI Nspire devices contain a set of registers with a seemingly
>>>> miscellaneous set of functionality. This area is known simply as the
>>>> "misc" region.
>>>>
>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>> ---
>>>>    .../bindings/mfd/ti,nspire-misc.yaml          | 55 +++++++++++++++++++
>>>>    1 file changed, 55 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
>>>> new file mode 100644
>>>> index 0000000000000..d409eae7537bd
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
>>>> @@ -0,0 +1,55 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +# Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/mfd/ti,nspire-misc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: TI Nspire MISC hardware block
>>>> +
>>>> +maintainers:
>>>> +  - Andrew Davis <afd@ti.com>
>>>> +
>>>> +description: |
>>>> +  System controller node represents a register region containing a set
>>>> +  of miscellaneous registers. The registers are not cohesive enough to
>>>> +  represent as any specific type of device. The typical use-case is
>>>> +  for some other node's driver, or platform-specific code, to acquire
>>>> +  a reference to the syscon node (e.g. by phandle, node path, or
>>>> +  search using a specific compatible value), interrogate the node (or
>>>> +  associated OS driver) to determine the location of the registers,
>>>> +  and access the registers directly.
>>>
>>> Looks like you copied the generic description? Describe what MISC
>>> contains.
>>>
>>
>> I don't know what all MISC contains (or maybe I do, but it is not
>> publicly available so I'm not going to add anything that hasn't
>> already been found by clean-room reverse engineering [0]).
> 
> Put whatever you are comfortable with, but not a duplicate generic
> description. You know it at least it has reboot registers...
> 
>> This is the point I was trying to make in that thread on v3. The
>> node's content *is* the hardware description. Every time a new
>> register is found it could have just been added to the DT. But now
>> we also have to go back here and add the exact same information
>> to the binding, every time. We don't require that for simple-bus,
>> should simple-mfd be given the same flexibility?
> 
> The thing with any MFD is it makes up a device even if it's 'simple', so
> it's important to get a full picture of the device. It could evolve to
> not being 'simple'.
> 

It would not evolve as a generic simple-mfd binding would not allow
any extra non-node properties.

'^.*$':
   type: object
additionalProperties: false

Maybe I'm thinking about this group of registers wrong, maybe it
is a simple-bus not a simple-mfd. I mean from software what else
is a bus but a space of addressable registers.. The issue would
be each child node of a simple-bus needs a unit-address and 'reg'.
Which we *could* do here if not for all this syscon weirdness :(

> For example, if you came along and wanted to make it a clock provider,
> you'd probably create a clock child node that's just a compatible and
> '#clock-cells'. The feedback would be just add '#clock-cells' to the
> 'ti,nspire-misc' node. So yes, I want to see additions.
> 

And then that would still fail the dtbs_check, since the simple-mfd binding
would only allow for child nodes, nothing else, that's what makes them "simple".
Each child node would need a compatible and therefor a binding. You would
still see everything and could prevent malformed nodes just the same.

Andrew
