Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F327505E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjGLLWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGLLWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:22:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE746E5C;
        Wed, 12 Jul 2023 04:22:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5311E61711;
        Wed, 12 Jul 2023 11:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0EFC433C7;
        Wed, 12 Jul 2023 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689160922;
        bh=2f3WMUFJriM4eWQBGMsNH4BT/EkREVrNR4sI+CspH/E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j8BUqp4geJu2D1Qm8k0Xx3onP9FogMNzG+kkajjO8msvKWtsR6eQ7AgOAEIH8yaBk
         yGOYyOGBUtOOWX1nlTw518mN7kG+2ce66cTRxL+jxrpd2Fue6m+IfYpJluNjI1/Onq
         eCyJwLK2rJ3YZx6LKlq68hMApTOpS5TvgxSRffwfEAbHh3o/rP/KOeIhvNCkUxWIzO
         YC9l9XSfYAdDublFFvp/keoS6XPpI3kDt/6/slACVDQecDfqNjuuINzcgro0GpLdYu
         y5q48GUD4EHK2EzZzWVr2hHQzd+0cYijvVdVCWy15zdb9dSxNIOfpFxwEakSdhBCD+
         3aX4kq4amhfNw==
Message-ID: <b24c2124-fe3b-246c-9af9-3ecee9fb32d4@kernel.org>
Date:   Wed, 12 Jul 2023 14:21:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Cc:     vigneshr@ti.com, krzysztof.kozlowski+dt@linaro.org, afd@ti.com,
        s-vadapalli@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230710101705.154119-1-j-choudhary@ti.com>
 <20230710101705.154119-2-j-choudhary@ti.com>
 <23833669-b9f7-94aa-ea42-56843842cba6@linaro.org>
 <d0fce3b5-222c-fc0f-ba16-988e4cc0520e@ti.com>
 <20230711153144.jvofubaez5uoog5p@unmanaged>
 <1e3b4fa4-6de7-e7bb-f1f7-266a73d87fb0@linaro.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <1e3b4fa4-6de7-e7bb-f1f7-266a73d87fb0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/2023 08:44, Krzysztof Kozlowski wrote:
> On 11/07/2023 17:31, Nishanth Menon wrote:
>> On 12:01-20230711, Jayesh Choudhary wrote:
>>>
>>>
>>> On 10/07/23 17:13, Krzysztof Kozlowski wrote:
>>>> On 10/07/2023 12:17, Jayesh Choudhary wrote:
>>>>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>>
>>>>> The system controller node manages the CTRL_MMR0 region.
>>>>> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
>>>>>
>>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>> [j-choudhary@ti.com: Add reg property to fix dtc warning]
>>>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>>> ---
>>>>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 23 ++++++++++++++++++++++
>>>>>   1 file changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>>>> index 2ea0adae6832..68cc2fa053e7 100644
>>>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>>>> @@ -5,6 +5,9 @@
>>>>>    * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>>>>>    */
>>>>> +#include <dt-bindings/mux/mux.h>
>>>>> +#include <dt-bindings/mux/ti-serdes.h>
>>>>
>>>> Why? What do you use from that binding?
>>>>
>>>
>>> Missed idle-state in the mux-controller node here for default values.
>>> I will wait for more feedback and then re-spin the series.
>>
>> btw, I am wondering if ti-serdes.h should even exist in dt-bindings -
>> are any of the macros used in the driver? or should this follow the
>> pinctrl style macros that could happily reside in arch/arm64/boot/dts/ti
>> ?
> 
> I don't see any usage in drivers, which is a clear indication that it
> might not be suitable for bindings. What are these values? Look like
> some register values, which there is little sense in making a binding.
> 
> Best regards,
> Krzysztof
> 
> 

You are right. They are constants not used in the driver directly.
mmio-mux driver uses it to set the idle state of the mux via the
'idle-states' property.

I agree with Nishanth that they should be moved to arch/arm64/boot/dts/ti

-- 
cheers,
-roger
