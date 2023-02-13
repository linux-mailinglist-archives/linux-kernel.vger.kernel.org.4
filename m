Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2C6943C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjBMLDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjBMLDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:03:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C392126FA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:03:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so8698354wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tHAxmSnCLm2NgMlRnfLJnGtOO2fga/60NcX7zQbcUh8=;
        b=KfF7fBNilKnMZqgcE6V8XPcUiYk09Hm4sT39lg6RRFTIBSwdml42IIrUDwc7iTTsYu
         Cr/8MWtZVhejzfRlpN02l90KG0ATpCEUmbEMSJwNoivP8iQnAE+dMMGoc1YaC1YdhD37
         42s36Ol1/6uT4sNd/fspFVsvaXcpylPEzYv+mHOphQJtVsegpEoznNDDAqHbKoMBxWUY
         15xx/4FLu6A5xVNS08tRP/QR+NgsfvL7U0gDDThpUB3A8ek7o7d/ZHXxnInf4GQa+1qV
         RzIbekNUAS7s503q0UzLiLP6Fss2RbYuKvxIzo/EGLbGDHIOd6o/LXLO9yevI32SJNyl
         F3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHAxmSnCLm2NgMlRnfLJnGtOO2fga/60NcX7zQbcUh8=;
        b=btg3XS4e8cGdt2QvCCEP91PWaGan+Z8y8vsxLn9sHWJBNBZHEMbkE40HvnbPgzz3eU
         RxhT7DWMEbIiqhvWgPwUh9AVGr7nMflTx40JgXbRHH2XUw25wAPV2OajKKUD+DkHuoy9
         9mi7iLcuPB2n1vdF4MAT95fXJP50k+cdnL5e5Zb+JnnEPP72DguGxFZ7a+yw1rm62Vbi
         J2s34VTiqdLiaRsrZOur4zSyzhgnvsj/p4xSdGD/XHpgJmGm9bzfb1WgPsIFQ52ZbO5/
         AfwGrLi4cUidsrdc+lnr4QXcYhHzxHqm+O3EJRMYWxQo5p5CG2RrzD7fXtci02sq1pTv
         ha6g==
X-Gm-Message-State: AO0yUKWpRUSmic1NRGpgzB/bQ5vsfeZEIzBRtRQyT8Wxp0SNctgc3kAe
        axfmoEgXm2K3EnUF2HSr18AoYQ==
X-Google-Smtp-Source: AK7set8BpKWzPhhIpgB4loHWn1A3+YVw2UfajMQoSDwIsHKfg2wAshtqeb5KaWuSutw8xR73pFyMOA==
X-Received: by 2002:a05:600c:3d98:b0:3e1:e149:b67b with SMTP id bi24-20020a05600c3d9800b003e1e149b67bmr5445197wmb.18.1676286194624;
        Mon, 13 Feb 2023 03:03:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:6e1e:131f:8bc1:aad8? ([2a01:e0a:982:cbb0:6e1e:131f:8bc1:aad8])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003dfdeb57027sm16654252wmc.38.2023.02.13.03.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:03:14 -0800 (PST)
Message-ID: <039e9f93-5b97-bb5e-e3c0-b8bf2c52a2a3@linaro.org>
Date:   Mon, 13 Feb 2023 12:03:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 6/6] dt-bindings: soc: amlogic: update sysctrl
 clock-controller subnode type
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
 <20230209-b4-amlogic-bindings-convert-take2-v1-6-c4fe9049def9@linaro.org>
 <f18230c9-7c9b-9e59-993f-24d40b74ba9d@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <f18230c9-7c9b-9e59-993f-24d40b74ba9d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/02/2023 12:00, Krzysztof Kozlowski wrote:
> On 09/02/2023 14:41, Neil Armstrong wrote:
>> Since the clock controllers are now documented define the right ref
>> for the clock-controller subnodes and fill up the example node.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml         | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
>> index 672eabd90c09..57eae355f1b9 100644
>> --- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
>> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
>> @@ -43,6 +43,10 @@ allOf:
>>               - amlogic,meson-gx-hhi-sysctrl
>>               - amlogic,meson-axg-hhi-sysctrl
>>       then:
>> +      properties:
>> +        clock-controller:
>> +          $ref: /schemas/clock/amlogic,gxbb-clkc.yaml#
> 
> You just added this binding. I don't understand the split.

It's a chicken and egg problem, the clock controller bindings (patches 4 & 6)
I've added the system-controller top node in the DT example, but this
example won't be valid until I add the system-controller bindings.

To solve this, I add it in 2 steps, but if it's an *real* issue I can remove
the top system-controller nodes in the clock controller bindings and add them
later on and add the sysctrl bindings in one step.

Neil

> 
>> +
>>         required:
>>           - power-controller
>>   
>> @@ -53,6 +57,10 @@ allOf:
>>               - amlogic,meson-gx-ao-sysctrl
>>               - amlogic,meson-axg-ao-sysctrl
>>       then:
>> +      properties:
>> +        clock-controller:
>> +          $ref: /schemas/clock/amlogic,gxbb-aoclkc.yaml#
>> +
>>         required:
>>           - pinctrl
>>   
>> @@ -81,7 +89,12 @@ examples:
>>           compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
>>           reg = <0 0x400>;
>>   
>> -        clock-controller { };
>> +        clock-controller {
>> +            compatible = "amlogic,gxbb-clkc";
>> +            #clock-cells = <1>;
>> +            clocks = <&xtal>;
>> +            clock-names = "xtal";
> 
> 
> Best regards,
> Krzysztof
> 

