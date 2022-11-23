Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C2635F49
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbiKWNX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiKWNXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:23:07 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894C01F9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:02:27 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id a7so493209ljq.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUEe+xvo6A9bHKL3WK6VHdimu7vun/3ExSCGDYJweEg=;
        b=y0sFuHh0+K0wq6VzFe3oKGdWnx5+CfVCg3XFcbMQz32cMMuXuO1TlrU1gJaCosrhLC
         Ik8BY0drtu8PucxwsTRSYqdJM3F/oG31rbPMf9FgclXEojCyPO45fhVsPi9GOQkYxehW
         S9qNwcGKbqEUTH1G/UVtMv+S8gOJlWf8UjEWtzzUCg2hHem8RR+ITe/aqynuahKqmxOj
         A87gX0uXXhnYLWS2ZspJrGvVGeC9zRNkP2rzR4dk/NwEuj1kBhYRyDLM6s+YXc2qPSuf
         5WTIvFBzZm20BOzLilDiZkewal5Mo31sfO2GWH5BXRHcVb6ZH5VsqLffaIypSiuMUKgP
         k3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUEe+xvo6A9bHKL3WK6VHdimu7vun/3ExSCGDYJweEg=;
        b=ApWT/YDhBELgAoU6YugBXEncaNPTaFHlOsPFkyPdjEEigWlN07oW/4TUTEXjahJ9Lp
         at5S5dg1Z3fFqze+tMh2bYwKUUdZ0Z8BzsbJNzrk9beapiIzXp0b4AlT3qURTEsHTTIh
         jqOYG+OZM1/qKuW0x7LeCLh7E8pb4xlo4ZDXDtvcLVq+BJXEkPLStl0w0vi3mjJZjBjI
         UpNSkmeoRnUj0kGg4KYwUbLiKRjrfF9AMFMvY2DYNsp5GuBjdlj/vFosPF7H25PAY3pB
         MIYhfSnNtkk9/ce8pTZVKtTWB3qV0YckY9iq+s3xHurXfyWWkZBVVljF7Y+KBcxo8fsO
         pqbg==
X-Gm-Message-State: ANoB5pnmjs6JHg3mPXdvYgC7Sh9qbDug431LlSPvJsSfo7cdgkHLls3d
        U2BHRyPSEk2cqKMEz0vury5Txw==
X-Google-Smtp-Source: AA0mqf70gL5arrMjHAnvTcCUxrJKMuIh2LzxlvsWO54zS2pI8ANGvVSfxKuPIAZ4LAMQafD4IQQ5Rg==
X-Received: by 2002:a05:651c:1601:b0:277:3a1:e86d with SMTP id f1-20020a05651c160100b0027703a1e86dmr4179100ljq.152.1669208544042;
        Wed, 23 Nov 2022 05:02:24 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k21-20020a05651239d500b00494618889c0sm2882886lfu.42.2022.11.23.05.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 05:02:23 -0800 (PST)
Message-ID: <8dbb3ce2-c8d9-70be-d1de-ed875de0ea1b@linaro.org>
Date:   Wed, 23 Nov 2022 14:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V5 4/4] arm64: dts: meson: add S4 Soc Peripheral clock
 controller in DT
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com
References: <20221123021346.18136-1-yu.tu@amlogic.com>
 <20221123021346.18136-5-yu.tu@amlogic.com>
 <ae43fadf-9255-7db7-8b5e-01200e02a2c6@linaro.org>
 <9858039f-e635-2749-80a2-75072d6e9cea@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9858039f-e635-2749-80a2-75072d6e9cea@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 12:27, Yu Tu wrote:
> Hi Krzysztof,
> 	
> On 2022/11/23 18:10, Krzysztof Kozlowski wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 23/11/2022 03:13, Yu Tu wrote:
>>> Added information about the S4 SOC Peripheral Clock controller in DT.
>>>
>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>> ---
>>>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 26 +++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>> index bd9c2ef83314..e7fab6e400be 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>> @@ -6,6 +6,8 @@
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>   #include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
>>> +#include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>>>   
>>>   / {
>>>   	cpus {
>>> @@ -100,6 +102,30 @@ clkc_pll: clock-controller@8000 {
>>>   				#clock-cells = <1>;
>>>   			};
>>>   
>>> +			clkc_periphs: clock-controller {
>>> +				compatible = "amlogic,s4-peripherals-clkc";
>>> +				reg = <0x0 0x0 0x0 0x49c>;
>>
>> This is broken... did you check for warnings?
> Yes, i do.
> You can have a look at the results of my test, as follows.
> 
> total: 0 errors, 0 warnings, 0 checks, 38 lines checked
> 
> ../patch_clk_v5_1122/0004-arm64-dts-meson-add-S4-Soc-Peripheral-clock-controll.patch 
> has no obvious style problems and is ready for submission.
> 

This is a checkpatch output. I am talking about DTS broken. dtc should
warn you.

Best regards,
Krzysztof

