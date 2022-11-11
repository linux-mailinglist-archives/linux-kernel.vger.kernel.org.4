Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217A2625FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiKKQmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiKKQmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:42:16 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC2DC845C4;
        Fri, 11 Nov 2022 08:42:14 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 12 Nov 2022 01:42:13 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 0DD232059027;
        Sat, 12 Nov 2022 01:42:13 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Sat, 12 Nov 2022 01:42:13 +0900
Received: from [10.212.158.220] (unknown [10.212.158.220])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6200EB62A4;
        Sat, 12 Nov 2022 01:42:12 +0900 (JST)
Message-ID: <3200aea8-55df-9718-01ac-e15633e13de7@socionext.com>
Date:   Sat, 12 Nov 2022 01:42:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 5/5] arm64: dts: uniphier: Add NX1 SoC and boards
 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221107103410.3443-1-hayashi.kunihiko@socionext.com>
 <20221107103410.3443-6-hayashi.kunihiko@socionext.com>
 <f8f83839-2e76-e500-a16e-5fd2985a278d@linaro.org>
 <df21cfca-67ed-0c78-7f1e-13e321edabe1@socionext.com>
 <a1e4a039-3b65-2f2b-2196-340cc754b1c1@linaro.org>
 <afdb63d2-217b-1ed5-3398-3e610bce8ecb@socionext.com>
 <36680a5e-7b0c-4d7e-f039-734e9304dc18@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <36680a5e-7b0c-4d7e-f039-734e9304dc18@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/11 23:40, Krzysztof Kozlowski wrote:
> On 11/11/2022 09:48, Kunihiko Hayashi wrote:
>> Hi Krzysztof,
>>
>> On 2022/11/09 0:11, Krzysztof Kozlowski wrote:
>>> On 08/11/2022 15:30, Kunihiko Hayashi wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 2022/11/08 20:13, Krzysztof Kozlowski wrote:
>>>>> On 07/11/2022 11:34, Kunihiko Hayashi wrote:
>>>>>> Initial version of devicetree sources for NX1 SoC and boards.
>>>>>>
>>>>>> NX1 SoC belongs to the UniPhier armv8 architecture platform, and is
>>>>>> designed for IoT and AI/ML application fields.
>>>>>>
>>>>>
>>>>>> +
>>>>>> +		soc_glue: syscon@1f800000 {
>>>>>> +			compatible = "socionext,uniphier-nx1-soc-glue",
>>>>>> +				     "simple-mfd", "syscon";
>>>>>> +			reg = <0x1f800000 0x2000>;
>>>>>> +
>>>>>> +			pinctrl: pinctrl {
>>>>>> +				compatible = "socionext,uniphier-nx1-pinctrl";
>>>>>
>>>>> So instead of documenting the hardware precisily, you have one big bag
>>>>> for everything under simple-mfd. This is not how the SoC should be
>>>>> described in DTS.
>>>>
>>>> Sorry I don't understand. This is inherited from the previous
>>>> descriptions,
>>>> but is there some example to express DTS correctly about that?
>>>
>>> I think yes, although it actually depends what is this hardware.
>>> Generally speaking, do not use simple-mfd and syscon when these are not
>>> really simple devices. There are quite many in your DTS, which got my
>>> attention. Instead - have regular device with or without children.
>>>
>>> There is no real need to have this a simple-mfd with one children
>>> without any resources (no address space, no clocks, no interrupts,
>>> nothing).
>>>
>>> Why this syscon/mfd and pinctrl is not a regular, one device?
>>
>> The mfd/syscon.yaml says:
>>     System controller node represents a register region containing a set
>>     of miscellaneous registers.
>>
>> The "soc-glue" is exactly this, it contains various register functions
>> and might be referred to the drivers.
>>
>> For example in this NX1 dts, ethernet node points to "soc-glue" node.
>>
>>       eth: ethernet@15000000 {
>>           compatible = "socionext,uniphier-nx1-ave4";
>>           ...
>>           socionext,syscon-phy-mode = <&soc_glue 0>;
>>       };
>>
>> Since such register region is not often systematically designed,
>> it is tough to cut out as specific memory region for "pinctrl".
> 
> So your choice is instead use entire address space as pinctrl - as a
> child device without IO address space. That's also not a good solution.

This structure follow the existing UniPhier SoCs, so it is necessary
to re-think the structure of all SoCs, not just this NX1 SoC.

>>
>> And more, the existing pinctrl driver uses of_get_parent() and
>> syscon_node_to_regmap(), so this change breaks compatibility.
> 
> This is a new DTS, so what compatibility is broken? With old kernel?
> There was no compatibility with this Devicetree. Anyway using driver
> implementation as reason for specific hardware description (DTS) is also
> not correct.

In this same area, mode selector, clock selector, phy configuration etc,
exist together in a mixed manner. There is a kind of design issues.

 From this point of view, I should separate the new devicetree once
from this patch series, and it is necessary to consider syscon DT schema
and related drivers for existing SoCs.

>>>>>> +			};
>>>>>> +		};
>>>>>> +
>>>>>> +		soc-glue@1f900000 {
>>>>>> +			compatible = "simple-mfd";
>>>>>
>>>>> No, it is not allowed on its own. You need a specific compatible and
>>>>> bindings describing its children.
>>>>
>>>> I saw the definition of "simple-mfd" itself is only in mfd/mfd.txt.
>>>>
>>>> Currently there are only efuse devices as children, and this space means
>>>> nothing. I think it had better define the devices directly.
>>>
>>> You need to start describe the hardware. efuse is an efuse, not MFD.
>>> pinctrl is pinctrl not MFD + pinctrl.
>>
>> This region also has multiple functions, though, the efuse might be
>> cut out as specific region without "simple-mfd", unlike pinctrl.
> 
> simple-mfd itself does not mean region has multiple functions, but that
> children do not depend on anything from the parent device.
 >
> You over-use syscon and simple-mfd in multiple places. of course some of
> them will be reasonable, but now it does not.

It takes more time to review existing structures, especially patch 1/5.

Thank you,

---
Best Regards
Kunihiko Hayashi
