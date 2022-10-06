Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925075F6624
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiJFMeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJFMeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:34:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F0637B;
        Thu,  6 Oct 2022 05:34:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DCC9D6602301;
        Thu,  6 Oct 2022 13:34:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665059642;
        bh=qkkpSsxIMeDT9BV02FWV/AHFBaKuCtwlZphzAFH4cCk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VEqNn94fof5Ie5QMY9/ws1jnX2t+w8B3WepGN2ReqqHvTu1tuCGr3C1tuVN/L44Tt
         IefnVUZahCnaLb/Yw6SuWHxXVm/PPPalZIjralwVQcDt954qmQWdSSo5v2obAR0klS
         FTif35BrPjVadDfbrcYit4ANdFzOybiWe61HWCCLDoSYHZ5OZ4iReEF+5epu2xXC+8
         rTNYuZFjk3XCBLhbExuBMufffoMehrPAuSnvWf6kiqRRsaHNhsE42CU+Bfufd65C8+
         gQ7lWMMLPU+OM8zMF+JgEfK/lMRSzlAFb7q6VBNbfIDzD4LtzSWDK4JqHjErf6y3vV
         O+YzNBdP0G6hg==
Message-ID: <8fd7c872-fadb-5dc2-6bc1-5b59a9a3b133@collabora.com>
Date:   Thu, 6 Oct 2022 14:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Content-Language: en-US
To:     =?UTF-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>, "robh@kernel.org" <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?S3Vhbi1Ic2luIExlZSAo5p2O5Yag5pawKQ==?= 
        <Kuan-Hsin.Lee@mediatek.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?UTF-8?B?WXUtQ2hhbmcgV2FuZyAo546L54Wc5qifKQ==?= 
        <Yu-Chang.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?UTF-8?B?RWR3YXJkLUpXIFlhbmcgKOaliuWTsue2rSk=?= 
        <Edward-JW.Yang@mediatek.com>
References: <20220929114624.16809-1-johnson.wang@mediatek.com>
 <20220929114624.16809-3-johnson.wang@mediatek.com>
 <ed723cb2-ba79-55d7-7869-abf153e4af0a@collabora.com>
 <20220930190703.GA657929-robh@kernel.org>
 <5b84c81d0d7f71bb83fcbef860433e4704ae5c72.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <5b84c81d0d7f71bb83fcbef860433e4704ae5c72.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/10/22 13:23, Johnson Wang (王聖鑫) ha scritto:
> On Fri, 2022-09-30 at 14:07 -0500, Rob Herring wrote:
>> On Thu, Sep 29, 2022 at 03:07:49PM +0200, AngeloGioacchino Del Regno
>> wrote:
>>> Il 29/09/22 13:46, Johnson Wang ha scritto:
>>>> Add the new binding documentation for MediaTek frequency hopping
>>>> and spread spectrum clocking control.
>>>>
>>>> Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
>>>> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
>>>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>>>> ---
>>>>    .../arm/mediatek/mediatek,mt8186-fhctl.yaml   | 53
>>>> +++++++++++++++++++
>>>>    1 file changed, 53 insertions(+)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
>>>> fhctl.yaml
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
>>>> fhctl.yaml
>>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
>>>> fhctl.yaml
>>>> new file mode 100644
>>>> index 000000000000..258dff7ce6bc
>>>> --- /dev/null
>>>> +++
>>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
>>>> fhctl.yaml
>>>> @@ -0,0 +1,53 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id:
>>>> https://urldefense.com/v3/__http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-fhctl.yaml*__;Iw!!CTRNKA9wMg0ARbw!xVt73f8PaQKph8n0ffGHHmQIxdzooUtGr0xDNVqy_6V0vwcs5k-FLrmkB3PZupSu1ciC$
>>>>   
>>>> +$schema:
>>>> https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!xVt73f8PaQKph8n0ffGHHmQIxdzooUtGr0xDNVqy_6V0vwcs5k-FLrmkB3PZulXwBACk$
>>>>   
>>>> +
>>>> +title: MediaTek frequency hopping and spread spectrum clocking
>>>> control
>>>> +
>>>> +maintainers:
>>>> +  - Edward-JW Yang <edward-jw.yang@mediatek.com>
>>>> +
>>>> +description: |
>>>> +  Frequency hopping control (FHCTL) is a piece of hardware that
>>>> control
>>>> +  some PLLs to adopt "hopping" mechanism to adjust their
>>>> frequency.
>>>> +  Spread spectrum clocking (SSC) is another function provided by
>>>> this hardware.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: mediatek,mt8186-fhctl
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    description: Phandles of the PLL with FHCTL hardware
>>>> capability.
>>>> +    minItems: 1
>>>> +    maxItems: 30
>>>> +
>>>> +  mediatek,hopping-ssc-percent:
>>>> +    description: The percentage of spread spectrum clocking for
>>>> one PLL.
>>>> +    minItems: 1
>>>> +    maxItems: 30
>>>> +    items:
>>>> +      default: 0
>>>> +      minimum: 0
>>>> +      maximum: 8
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - clocks
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/clock/mt8186-clk.h>
>>>> +    fhctl: fhctl@1000ce00 {
>>>> +        compatible = "mediatek,mt8186-fhctl";
>>>> +        reg = <0x1000c000 0xe00>;
>>>> +        clocks = <&apmixedsys CLK_APMIXED_MSDCPLL>;
>>>> +        mediatek,hopping-ssc-percent = <3>;
>>>> +    };
>>>
>>>
>>> .... a more realistic example:
>>
>> One or 2 cells is really outside the scope of the binding as either
>> is
>> valid. If the parent bus only has 32-bits of address space, there's
>> little reason to use 2 cells.
>>
> 
> Hi Rob,
> 
> Thanks for the explanation.
> 
> Then I will keep this example the same in the next version.

That was just to have it 1:1 with how it'll be written in the devicetree....
....in any case, Johnson, there's a discrepancy in the iospace:
1000ce00 vs 0c1000c000 - that has to be fixed anyway.

Cheers,
Angelo

> 
> BRs,
> Johnson Wang
>>>
>>>      #include <dt-bindings/clock/mt8186-clk.h>
>>>
>>>      soc {
>>>          #address-cells = <2>;
>>>          #size-cells = <2>;
>>>
>>>          fhctl: fhctl@1000ce00 {
>>>              compatible = "mediatek,mt8186-fhctl";
>>>              reg = <0 0x1000c000 0 0xe00>;
>>>              clocks = <&apmixedsys CLK_APMIXED_MSDCPLL>;
>>>              mediatek,hopping-ssc-percent = <3>;
>>>          };
>>>      };
>>>
>>> After which...
>>>
>>> Reviewed-by: AngeloGioacchino Del Regno <
>>> angelogioacchino.delregno@collabora.com>
>>>

