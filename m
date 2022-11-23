Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714A663602D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiKWNky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbiKWNk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:40:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44102638B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:27:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b12so15579705wrn.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fT/xDuYv9xGq77UWP89SFz3uGJYiuqZ8uj1zssl6LEI=;
        b=m4LuSbWqBjT7NwHQH0tifRloLcrY3pwxm1CueZ4AmCT2gUl/V1p8xjXwKORPOqJCsK
         Rqu8SpS/v32Bq9OdGT9TY7Dhs5p1nLKSPt2dtKY3io58zqaHQj9BW4tpcFHZFlNu9Ib8
         AcGwX4cq5h7T4zTzji74Ahi3vC6i3D9LJbAoPYVTBvtel4xOpslBxfIsDolwComWC8RI
         Zi/Y0k4GpHPk6mU9ViYMW2fhXCLlqg6PomorrJEoA5YVpfLNcaTH2vgwZrR4XSt4nvOl
         QPVb5zDfc6vW0uX45KhY20BpCTHoeBQdpxpLnJigbUlq1ck3dMtNMvRYGQgHLY8l5Ezn
         PeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fT/xDuYv9xGq77UWP89SFz3uGJYiuqZ8uj1zssl6LEI=;
        b=LhEjzemNGbb4RiBMJo/U0jI76G9+GpWWtFN/LKaQlr/ddt+TO4KgLOtoaE5fhSVikn
         TRaqfFFWqTEefJuWrFrpeYuf5Zx6afO/lDd1czOVTMoF1hH5y5FIyx4SKPRhLkXnFR4B
         Zn/Wl1808iwfECWGJ4L3AiyDAoPe0KVrYzCbuyzNMpgbZ3OyD9poQPhX78tK8qNysVP/
         QtMCTrw+SmPIdC7Rj7tzLo8FtHmCnLMjjX4EzuYQF99t9ZoLXz2if1fsK4pr4O57Wonk
         e0HjPOpNV5S2ivhy/W1UwOpaOtap23jfUL2FlYEleRGv65uJsrBIGl1l9qOuZSC8URwz
         zcAQ==
X-Gm-Message-State: ANoB5plygnTO3kVYTMFcGl9SMRY0miaqbFkF8ede8/VkmL3919IBZizo
        +oEyI6hZlG6GM6rq6nlwJtRo/g==
X-Google-Smtp-Source: AA0mqf6rOqEuavZEDT+cCpsbo0nI8+NuQqSYhObPcsBGUEd3IpX2Pk1gKE8zWfzCrTcLpzL9QcyX8g==
X-Received: by 2002:a5d:6b0c:0:b0:241:c595:9f05 with SMTP id v12-20020a5d6b0c000000b00241c5959f05mr14052664wrw.439.1669210054818;
        Wed, 23 Nov 2022 05:27:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:e551:24c3:152c:7c05? ([2a01:e0a:982:cbb0:e551:24c3:152c:7c05])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003c6cd82596esm2609540wmq.43.2022.11.23.05.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 05:27:34 -0800 (PST)
Message-ID: <9961d579-9463-c585-34a6-a3abcd4b3e52@linaro.org>
Date:   Wed, 23 Nov 2022 14:27:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V5 4/4] arm64: dts: meson: add S4 Soc Peripheral clock
 controller in DT
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@linaro.org>,
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
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <ae43fadf-9255-7db7-8b5e-01200e02a2c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 11:10, Krzysztof Kozlowski wrote:
> On 23/11/2022 03:13, Yu Tu wrote:
>> Added information about the S4 SOC Peripheral Clock controller in DT.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 26 +++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> index bd9c2ef83314..e7fab6e400be 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> @@ -6,6 +6,8 @@
>>   #include <dt-bindings/interrupt-controller/irq.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
>> +#include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>>   
>>   / {
>>   	cpus {
>> @@ -100,6 +102,30 @@ clkc_pll: clock-controller@8000 {
>>   				#clock-cells = <1>;
>>   			};
>>   
>> +			clkc_periphs: clock-controller {
>> +				compatible = "amlogic,s4-peripherals-clkc";
>> +				reg = <0x0 0x0 0x0 0x49c>;
> 
> This is broken... did you check for warnings?

This is actually fine, the parent node has a ranges property:
https://github.com/torvalds/linux/blob/eb7081409f94a9a8608593d0fb63a1aa3d6f95d8/arch/arm64/boot/dts/amlogic/meson-s4.dtsi#L93

Neil

> 
> 
> Best regards,
> Krzysztof
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

