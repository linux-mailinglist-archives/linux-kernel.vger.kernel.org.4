Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A8374FED8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjGLFpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjGLFox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:44:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221821980
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:44:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-992dcae74e0so833504266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689140689; x=1691732689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ouZomYFgUHpn/YJmr1JiZF0xkGrMDaTDJYudY8dp4M=;
        b=bvDjgm22UvS4P5aJYtI62PvGyl3FefCo0qkEKllhFf6M4CdzUxiqL695Nir4SdFfbA
         6SVBVj/eKAYHpyeS+YzXy5d2+6wdeUN2HfM0alKa1+Ggbe8pJx+7Je8YdnbsCJNCggzc
         X+YLurn9JM15dKsZPa4E4n8vwzdp0I5+wPblHPV4SDls9D6ReHgldmd1LwUos56CRwtw
         hACkG0wvBKCbvcB4u3C9DPZltjjbiEVUG0x3tR993eJtZuA6/xumm9ZkQ7O0UsLsk6nP
         Lg9DFChGsxhJ76cau5ShQDg67+lo5aUm3dQnT4kdXC2koBJS9kqb5MgYSm1aebGRfgqi
         sw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689140689; x=1691732689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ouZomYFgUHpn/YJmr1JiZF0xkGrMDaTDJYudY8dp4M=;
        b=fgvYC/uoCj+lCHmmVn3F4t0ftiaEDdAMv90A9J5WYuOTYx5+JiGssNzat4Yn1ne6il
         qcjQcWx1WByJgdfWaWx95mjJH4OUm8DJ4zT5ET4BnO1C58qKkxPXewhf7VqLFIA+XC7Y
         M1NI4OCHiRouJSmQzyfl2QZvPsYtzr0rDj+tVJ59SXH/+wyJoVShW5RcMbx1M7gftj4x
         CuEyGDvKQbUBdXZ6cBJaL6t9JZonUihmVlcSqyuWwBBjW6nvUAvTwDRZ2EvLMKWBXMbd
         3X/0pAZK6MBibvpHxW7jT3WzsnbmO9HKGSS69BI1TnesZI0CJ58BI4ZQxfYfL+OUucmY
         Gaog==
X-Gm-Message-State: ABy/qLYeC+5wBOiGwziK8lh0FG8uBz34+tNA7kLEShe2gXVXC78Ozu6B
        JZbqp2tK3OLdgRuorQqA/GKxcw==
X-Google-Smtp-Source: APBJJlHpKjhGOrY5gOYh/iHBm8gwLfa++FYIuS61a3m8tRrnYlnMMtS51wSD8v3uSldBMX6yMpTdog==
X-Received: by 2002:a17:907:c8f:b0:98d:b73b:b5f2 with SMTP id gi15-20020a1709070c8f00b0098db73bb5f2mr17159701ejc.71.1689140689368;
        Tue, 11 Jul 2023 22:44:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id d20-20020a170906371400b0098e2eaec395sm2049867ejc.130.2023.07.11.22.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 22:44:48 -0700 (PDT)
Message-ID: <1e3b4fa4-6de7-e7bb-f1f7-266a73d87fb0@linaro.org>
Date:   Wed, 12 Jul 2023 07:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
Cc:     vigneshr@ti.com, krzysztof.kozlowski+dt@linaro.org, afd@ti.com,
        s-vadapalli@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230710101705.154119-1-j-choudhary@ti.com>
 <20230710101705.154119-2-j-choudhary@ti.com>
 <23833669-b9f7-94aa-ea42-56843842cba6@linaro.org>
 <d0fce3b5-222c-fc0f-ba16-988e4cc0520e@ti.com>
 <20230711153144.jvofubaez5uoog5p@unmanaged>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230711153144.jvofubaez5uoog5p@unmanaged>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 17:31, Nishanth Menon wrote:
> On 12:01-20230711, Jayesh Choudhary wrote:
>>
>>
>> On 10/07/23 17:13, Krzysztof Kozlowski wrote:
>>> On 10/07/2023 12:17, Jayesh Choudhary wrote:
>>>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>
>>>> The system controller node manages the CTRL_MMR0 region.
>>>> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
>>>>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> [j-choudhary@ti.com: Add reg property to fix dtc warning]
>>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>> ---
>>>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 23 ++++++++++++++++++++++
>>>>   1 file changed, 23 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>>> index 2ea0adae6832..68cc2fa053e7 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>>> @@ -5,6 +5,9 @@
>>>>    * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>>>>    */
>>>> +#include <dt-bindings/mux/mux.h>
>>>> +#include <dt-bindings/mux/ti-serdes.h>
>>>
>>> Why? What do you use from that binding?
>>>
>>
>> Missed idle-state in the mux-controller node here for default values.
>> I will wait for more feedback and then re-spin the series.
> 
> btw, I am wondering if ti-serdes.h should even exist in dt-bindings -
> are any of the macros used in the driver? or should this follow the
> pinctrl style macros that could happily reside in arch/arm64/boot/dts/ti
> ?

I don't see any usage in drivers, which is a clear indication that it
might not be suitable for bindings. What are these values? Look like
some register values, which there is little sense in making a binding.

Best regards,
Krzysztof

