Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A477867DF0E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjA0I1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjA0I1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:27:11 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7B38026
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:27:09 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso27010wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DdfiCXvxE3+wXETvP9iNhM7stAIscaaJ/d3hkQdjD+0=;
        b=B/RuS1NL29Yrb76eGHNw/76TdWb4k2B7kme4TaLgHYSrSLwmjABNDw2Dhagn/rnWpn
         pNotOIkOVgeg+wRR2soNop4lqhB6w3PzoKYGRgSB6LKbHYIETB8ygoZwnD54jkXnGwc3
         lZ19lCIY6dL9kvzLqDr14qQ3aBQhGPheWX/Wy4HdcIent4fBN2vr9jkLOd8uZP1L7phE
         CqeQGY9cSrlU71PS4W1+tGTceGG4bUjehcDcoytFpxsWjd4IsPL7eYQQ4hqch9misqPn
         in4Qw2yFFkiPegKQ/JSUfuSVOga0A/MdISZPWXiDYA1E8WSX+PgFQ0cJZRwwtfrw+gEK
         A/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdfiCXvxE3+wXETvP9iNhM7stAIscaaJ/d3hkQdjD+0=;
        b=yOQW7pjCSdRE5wsgBiGi+UQBolhQffvOUlrKff38CmCzwys3UM9ma/JOibXMCavuGc
         PRMSdt4EgEreLBif26zlodqlOKiX7VDgIWaSquTDQu7Z6uQOuNJhbXWgxum5vH7lcYhZ
         t9nprTSLKdq0NQQbroucBzbbOQAZT+HCqJFOFBQjJenE6KS1+GxERg4cws6Zv7n8llWZ
         2RhrE5Fk8HpqrUpyBABOBnVy2mdPZ5PD8VYnfKG6IP0VE6bo2GEcuxUOQOFTGCBw8XAP
         dnRopS0R0fTWog5eaPI6HGfvisZx0ygIxNCV6M9kTjvsh2P6dmUhkf8Gv8Fexei2LZVK
         5B4w==
X-Gm-Message-State: AO0yUKWYSMlzWsvXFQ5pqdot2Zw7aBo7JDN2SKK/I9ooKcJ6Vpok4Cze
        TaY/JKDSnpiAZlh2g4+rj97l0A==
X-Google-Smtp-Source: AK7set83wpkelfN7j+E1uxuUMRJdC66UYA7JuiqRtNdQUL0FEULzXsRPzprLT/NQQZrpkURjk+U6WQ==
X-Received: by 2002:a05:600c:354a:b0:3dc:357a:f4ab with SMTP id i10-20020a05600c354a00b003dc357af4abmr1641253wmq.15.1674808028475;
        Fri, 27 Jan 2023 00:27:08 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c19cc00b003db0ee277b2sm7719863wmq.5.2023.01.27.00.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 00:27:07 -0800 (PST)
Message-ID: <291ad4d3-6c8b-507d-08ff-997e0c4bd482@linaro.org>
Date:   Fri, 27 Jan 2023 09:27:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add
 notification LED
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230122-msm8974-bacon-features-v1-0-4049f565c24c@z3ntu.xyz>
 <4455893.LvFx2qVVIh@g550jk> <dbfa802a-968f-0504-a131-59e2a8f52c9f@linaro.org>
 <1840339.tdWV9SEqCh@g550jk>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1840339.tdWV9SEqCh@g550jk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 21:41, Luca Weiss wrote:
> On Donnerstag, 26. Jänner 2023 10:41:24 CET Krzysztof Kozlowski wrote:
>> On 25/01/2023 21:51, Luca Weiss wrote:
>>> On Montag, 23. Jänner 2023 18:18:16 CET Krzysztof Kozlowski wrote:
>>>> On 22/01/2023 17:48, Luca Weiss wrote:
>>>>> Add the node describing the sn3193 that's used to provide notification
>>>>> LED.
>>>>>
>>>>> Unfortunately the driver currently supports neither multicolor API nor
>>>>> using the properties function & color, so we use label instead.
>>>>>
>>>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>>>> ---
>>>>>
>>>>>  .../arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 28
>>>>>  ++++++++++++++++++++++ 1 file changed, 28 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
>>>>> b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts index
>>>>> ffb486ceb6a6..a672c45d7070 100644
>>>>> --- a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
>>>>> +++ b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
>>>>> @@ -114,6 +114,34 @@ led@0 {
>>>>>
>>>>>  			default-brightness = <80>;
>>>>>  		
>>>>>  		};
>>>>>  	
>>>>>  	};
>>>>>
>>>>> +
>>>>> +	led-controller@68 {
>>>>> +		compatible = "si-en,sn3193";
>>>>> +		reg = <0x68>;
>>>>> +
>>>>> +		shutdown-gpios = <&tlmm 45 GPIO_ACTIVE_HIGH>;
>>>>> +
>>>>> +		#address-cells = <1>;
>>>>> +		#size-cells = <0>;
>>>>> +
>>>>> +		led@1 {
>>>>> +			reg = <1>;
>>>>> +			label = "red:status";
>>>>
>>>> These should be colors and functions.
>>>
>>> Hi Krzysztof,
>>>
>>> please check the commit message for this. I tried using it but it didn't
>>> work, the driver in general might need an overhaul at some point...
>>>
>>>> Unfortunately the driver currently supports neither multicolor API nor
>>>> using the properties function & color, so we use label instead.
>>>
>>> Or maybe I messed up but pretty sure this was the case when I wrote the
>>> dts.
>> I don't understand how driver is related here - it's not the driver's
>> property, but LED core. If the driver "supports" label, then it supports
>> color and status.
> 
> The leds-is31fl319x.c driver uses devm_led_classdev_register but the function 
> where 'function' and 'color' is parsed is led_parse_fwnode_props which is 
> called from led_compose_name which is called from led_classdev_register_ext 
> (or with the devm_ prefix), and not called from the register method without 
> _ext suffix.

No, devm_led_classdev_register calls devm_led_classdev_register_ext
which calls led_classdev_register_ext which calls led_compose_name (if
initdata is set). The point is that we lack initdata, so indeed color
and function cannot be used.

> 
> So in other words, the led driver would need changes to use the new 
> registration API to be able to use 'function' and 'color' instead of 'label'.
> 
> Regards
> Luca
> 
>>
>> Best regards,
>> Krzysztof
> 
> 
> 
> 

Best regards,
Krzysztof

