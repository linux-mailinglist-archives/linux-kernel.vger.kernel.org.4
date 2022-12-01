Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6E63EB1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLAIaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLAIaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:30:13 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 841E855CBC;
        Thu,  1 Dec 2022 00:30:10 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 01 Dec 2022 17:30:09 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id CEE632059054;
        Thu,  1 Dec 2022 17:30:09 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 1 Dec 2022 17:30:09 +0900
Received: from [10.212.157.157] (unknown [10.212.157.157])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id F368CA855D;
        Thu,  1 Dec 2022 17:30:08 +0900 (JST)
Message-ID: <fff6d183-ade3-c9d2-5a9c-3edfcca8a266@socionext.com>
Date:   Thu, 1 Dec 2022 17:30:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 7/8] dt-bindings: soc: socionext: Add UniPhier DWC3 USB
 glue layer
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-8-hayashi.kunihiko@socionext.com>
 <12a98c77-5464-0f25-9081-13217f396484@linaro.org>
 <c9e1ee72-6201-3a1e-307a-d5869a22e01c@socionext.com>
 <2978c071-4e3c-8d4d-3819-3ddbf7bc1385@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <2978c071-4e3c-8d4d-3819-3ddbf7bc1385@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/01 0:32, Krzysztof Kozlowski wrote:
> On 30/11/2022 10:00, Kunihiko Hayashi wrote:
>> Hi Krzysztof,
>>
>> On 2022/11/29 23:52, Krzysztof Kozlowski wrote:
>>> On 29/11/2022 11:35, Kunihiko Hayashi wrote:
>>>> Add DT binding schema for components belonging to the platform-specific
>>>> DWC3 USB glue layer implemented in UniPhier SoCs.
>>>>
>>>> This USB glue layer works as a sideband logic for the host controller,
>>>> including core reset, vbus control, PHYs, and some signals to the
>>>> controller.
>>>>
>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

(snip)

>>>> +examples:
>>>> +  - |
>>>> +    usb-controller@65b00000 {
>>>
>>> Node name: usb. There is no usage of "usb-controller".
>>
>> I'm confusing about that.
>>
>> This is an interface logic and doesn't have USB functions by itself.
>> Surely there is a USB host controller node "usb@..." in the same SoC.
>> Can this node be renamed to "usb"?
>>
>> I've renamed the dts node name once in commit 4cc752a88ca9
>> ("arm64: dts: uniphier: Rename usb-glue node for USB3 to usb-controller").
> 
> In (almost?) all other cases it is still called "usb". A bit akward to
> have usb in usb, but usb-controller did not stick...

I see.
I understand that it is still better to use the generic name "usb"
rather than "usb-controller".

Thank you,

---
Best Regards
Kunihiko Hayashi
