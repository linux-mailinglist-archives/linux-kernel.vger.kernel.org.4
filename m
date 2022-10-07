Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141C75F7522
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJGISK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJGISF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:18:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1957A5986
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:18:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g1so6184323lfu.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 01:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AoVjw78GbpU+AjrkJU2K9o3JUXYwMLmjzxFbox+6q/Y=;
        b=VP2rugN7Bgs7isqx1TLJPn93UgEBqBLNYLHf6Jh5VYRWeztgg72Hqqmd6XRMEuXNAT
         QJfYk+UTSnwvsZOCLmWd22AlvRhifP4wJh0gt+vGJtYirtwNa2ulg5jLwHEHfye5vmWt
         md91rKn4NuESJYLrAXwc1ZGQa4yJDgeN7cEjnkt8cQF/NeRvqeOFj+9vRkL4eyqmLVJg
         IDSodAYi3DNT1gOemlf03ZYIhJsZm1PcusWWDsfnuiIl+c+aw1TeMZqVbG4LZHC9gmDr
         tlui44vcFgGiWPyT29UdBaj+7WMSbJCfN9pMFVvu9dwTMOmTTFrXj4ATaW9ZjjzfBVw+
         9vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AoVjw78GbpU+AjrkJU2K9o3JUXYwMLmjzxFbox+6q/Y=;
        b=p6IQNRUKA2RpliAAxHrk14+MqiZudVifh0l0eNRT7FTP/vYdXD4F3tJcQ5j1KjWmQ1
         EWXGx5e9k6Ak2X1wH21EEu5H1+qzICzGvgXmO5YzaPWC2a1Tu4htB5UQfrIGvg1csinx
         GnHcSpMzrTL/VlDmvzdO2JNm+t+SAFVv+gKAgW6aTf5BUJCQWBqmuk1BO3rYPULjKFoH
         IwY+VvlYVbrUfq4YMgFVvQ8RKS8zBmY4iFZxU10jWggKmIG57hGz71Q0GXZDOns2xDm1
         Btw21+OKbDt4X1u/M+QfNaqCQ9uRUfSzFjeLsEA/bDMve/pnHWivpOH8b/mRFFY88Zte
         vBuw==
X-Gm-Message-State: ACrzQf2H5jW75+k+JoKGjpH7NOB3m4XDzeWheQRFAAGciD6keAg/AXSE
        lxO1SKol7nmmR9qt+XtCx/E36Q==
X-Google-Smtp-Source: AMsMyM4OP9t48H5JdeSqZeXqArIQWhO/8DDCchMQldqBAxER5Q/AO8OlQbCNFtLjLnPCP8zROdOekg==
X-Received: by 2002:ac2:4e06:0:b0:4a2:6e63:e919 with SMTP id e6-20020ac24e06000000b004a26e63e919mr1465693lfr.37.1665130681724;
        Fri, 07 Oct 2022 01:18:01 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f22-20020a2eb5b6000000b0026bf0d71b1esm152969ljn.93.2022.10.07.01.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 01:18:01 -0700 (PDT)
Message-ID: <dbc3bcbf-cc46-79a3-8ce6-2d981d9e7d05@linaro.org>
Date:   Fri, 7 Oct 2022 10:17:59 +0200
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
 <83649505-d8eb-b0b5-da9d-4536f58a7daa@linaro.org>
 <96160129-e9a0-ec0f-20d9-c92d1487eac6@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <96160129-e9a0-ec0f-20d9-c92d1487eac6@linaro.org>
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

On 07/10/2022 09:45, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 07/10/2022 09:04, Krzysztof Kozlowski wrote:
>> On 06/10/2022 17:48, Neil Armstrong wrote:
>>> On 06/10/2022 16:11, Krzysztof Kozlowski wrote:
>>>> On 06/10/2022 12:57, Amjad Ouled-Ameur wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> Thank you for the review.
>>>>>
>>>>> On 10/5/22 10:14, Krzysztof Kozlowski wrote:
>>>>>> On 04/10/2022 13:10, Amjad Ouled-Ameur wrote:
>>>>>>> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
>>>>>>> pin biais when idle. Therefore define three pinctrl names:
>>>>>>> - default: SPI pins are controlled by spi function.
>>>>>>> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
>>>>>>> by spi function.
>>>>>>> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
>>>>>>> by spi function.
>>>>>>>
>>>>>>> Reported-by: Da Xue <da@libre.computer>
>>>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>>>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>>>>>>> ---
>>>>>>>     .../devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml   | 15 +++++++++++++++
>>>>>>>     1 file changed, 15 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>>>>>> index 0c10f7678178..53013e27f507 100644
>>>>>>> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>>>>>> @@ -43,6 +43,14 @@ properties:
>>>>>>>         minItems: 1
>>>>>>>         maxItems: 2
>>>>>>>     
>>>>>>> +  pinctrl-0:
>>>>>>> +    minItems: 1
>>>>>> maxItems?
>>>>>>
>>>>> Will fill it in next version.
>>>>>>> +
>>>>>>> +  pinctrl-1:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  pinctrl-names: true
>>>>>> Why do you need all these in the bindings?
>>>>>
>>>>> SPI clock bias needs to change at runtime depending on SPI mode, here is an example of
>>>>>
>>>>> how this is supposed to be used ("spi_idle_low_pins" and "spi_idle_low_pins" are defined
>>>>>
>>>>> in the second patch of this series):
>>>>
>>>> I know what it the point in general of pinctrl configuration... But the
>>>> question is why do you need to specify them in the bindings? Core
>>>> handles that. IOW, do you require them and missing/incomplete pinctrl
>>>> should be reported?
>>>
>>> Looking at other bindings, when specific pinctrl state names were requires, they were
>>> documented.
>>
>> Yes, the required and/or necessary entries were added to few other
>> bindings. Since Amjad did not make them required, why adding them? So I
>> repeat the question for the third time - why do you need to add them to
>> the bindings?
>>
>>> There's some bindings with pinctrl-names for specific states like rockchip/rockchip,dw-hdmi.yaml,
>>> mediatek/mediatek,dpi.yaml, mmc/mtk-sd.yaml or mmc/fsl-imx-esdhc.yaml
>>
>> And? Just because someone did something is not itself an argument. They
>> might have their reasons. If their reasons are applicable here, please
>> state them.
> 
> OK, I thought the reason was explicit, we find it worth documenting
> those optional pinctrl states for when the spi lines are in idle state.
> 
> If it's not an enough good reason, we'll drop this patch.

No one wrote here any reason... The post from Amjad was about DTS usage,
yours about other bindings. Neither of them are reasons.

Core schema already documents pinctrl states. This can be documented if
it is different than what core checks for, e.g. required or some
specific names are being enforced.

Best regards,
Krzysztof

