Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA615F7487
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJGHEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJGHEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:04:30 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF50F58161
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:04:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 10so5993941lfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bOopO7iInZ6v4M6diUeOsQ/w2XzIGMRIZK6/NGVmq/k=;
        b=xecmTBJswUtmpr6bh9RyicfAAzhPbv42QAIs3jo2ukqvObnnkDi5zOxYLoY7jbhhns
         sWKPqghMf+63zfp8ZBi74MhI5Oaeklq74oeX3s1xGFYLk5ins4sSQcgcwAtbJ57ivkU6
         NLnB2kUttnTxtqSpzJRzP7AM+bAmV5OeSCeGfmM6IoEXxzh4IbVA1P3fL5QJ3ynQBLrM
         eUegGUxGvaz/mAjBxXj/K6lq/pPCsevxBEiLP4GkYp4jEsybKRKdAG3GBwF5rwnHU1C6
         hrrwnpmW4PjJkeigmbH1kQ0M5pOCZQST5pA4uL6P11rzKpeLXKbWmf10pBLdh73IMq7K
         /onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bOopO7iInZ6v4M6diUeOsQ/w2XzIGMRIZK6/NGVmq/k=;
        b=XS5v5fWFwOD4Zptf/OEDhztNeLdn5EgvHrStPN/wu1CXrWebKLoOqv1gasmA4tKhCJ
         uLjcFca41FY1liySfbPdJIs7xCzOXjN21LTsgZu2V+04V2QkgbM/hLKQnOe2wrLCUKb+
         lHNcefhVg5WEiYYYF/PXeQET75UbkVtDNCzt/iIrCM4oeQQMUbvQakf2mj7CTioq3COS
         iWw9FFDp6u0YWhhVHlCndRQ1dnz99IqdQphDBBMbCZTJ5kRP9RcJc7FuoMgfWO/QZLZ9
         Tpd2JStLmtaqBb79ljt4bBfGTISyb5hbtVlfPHeEyQ+qdCrQENdBGYArKmfAATEALyB7
         eSvA==
X-Gm-Message-State: ACrzQf24ooD6xuf5Ytx5aLJ5SxSYoayUKuYlUUjy04RN3okXGf6XSbiV
        fbGyuraNj57QxUJXMSDsvwnqhA==
X-Google-Smtp-Source: AMsMyM6xfHtLgCZOkFNZnuZ1kHmM9FRRqWr0iWMXX8Xl5O742LzcdVWTSipWALqXoAfSaiPeQyk04Q==
X-Received: by 2002:a05:6512:1196:b0:4a2:4ddb:8415 with SMTP id g22-20020a056512119600b004a24ddb8415mr1392413lfr.518.1665126266550;
        Fri, 07 Oct 2022 00:04:26 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u19-20020ac24c33000000b0049485e2cb91sm172281lfq.231.2022.10.07.00.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 00:04:25 -0700 (PDT)
Message-ID: <83649505-d8eb-b0b5-da9d-4536f58a7daa@linaro.org>
Date:   Fri, 7 Oct 2022 09:04:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221004-up-aml-fix-spi-v2-0-3e8ae91a1925@baylibre.com>
 <20221004-up-aml-fix-spi-v2-1-3e8ae91a1925@baylibre.com>
 <d2ce98d7-1025-9c6e-e207-00e91942077a@linaro.org>
 <fb2706e3-f758-a0b0-d595-75ef362a853e@baylibre.com>
 <7bcb9ef1-6b56-2f5f-3ac9-acc9ed9370df@linaro.org>
 <2c22e3b9-3da4-78c4-e068-78b84e24b2c3@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2c22e3b9-3da4-78c4-e068-78b84e24b2c3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 17:48, Neil Armstrong wrote:
> On 06/10/2022 16:11, Krzysztof Kozlowski wrote:
>> On 06/10/2022 12:57, Amjad Ouled-Ameur wrote:
>>> Hi Krzysztof,
>>>
>>> Thank you for the review.
>>>
>>> On 10/5/22 10:14, Krzysztof Kozlowski wrote:
>>>> On 04/10/2022 13:10, Amjad Ouled-Ameur wrote:
>>>>> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
>>>>> pin biais when idle. Therefore define three pinctrl names:
>>>>> - default: SPI pins are controlled by spi function.
>>>>> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
>>>>> by spi function.
>>>>> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
>>>>> by spi function.
>>>>>
>>>>> Reported-by: Da Xue <da@libre.computer>
>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>>>>> ---
>>>>>    .../devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml   | 15 +++++++++++++++
>>>>>    1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>>>> index 0c10f7678178..53013e27f507 100644
>>>>> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>>>> @@ -43,6 +43,14 @@ properties:
>>>>>        minItems: 1
>>>>>        maxItems: 2
>>>>>    
>>>>> +  pinctrl-0:
>>>>> +    minItems: 1
>>>> maxItems?
>>>>
>>> Will fill it in next version.
>>>>> +
>>>>> +  pinctrl-1:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  pinctrl-names: true
>>>> Why do you need all these in the bindings?
>>>
>>> SPI clock bias needs to change at runtime depending on SPI mode, here is an example of
>>>
>>> how this is supposed to be used ("spi_idle_low_pins" and "spi_idle_low_pins" are defined
>>>
>>> in the second patch of this series):
>>
>> I know what it the point in general of pinctrl configuration... But the
>> question is why do you need to specify them in the bindings? Core
>> handles that. IOW, do you require them and missing/incomplete pinctrl
>> should be reported?
> 
> Looking at other bindings, when specific pinctrl state names were requires, they were
> documented.

Yes, the required and/or necessary entries were added to few other
bindings. Since Amjad did not make them required, why adding them? So I
repeat the question for the third time - why do you need to add them to
the bindings?

> There's some bindings with pinctrl-names for specific states like rockchip/rockchip,dw-hdmi.yaml,
> mediatek/mediatek,dpi.yaml, mmc/mtk-sd.yaml or mmc/fsl-imx-esdhc.yaml

And? Just because someone did something is not itself an argument. They
might have their reasons. If their reasons are applicable here, please
state them.

Best regards,
Krzysztof

