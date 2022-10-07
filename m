Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DDD5F74D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJGHpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiJGHpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:45:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295FC8E0C0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:45:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu30so5986975wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=HZsbpC7Fo58je5AmkmLVo75u4dpgKURYG9fcUKw+/7E=;
        b=Wxr7jwjN3154+ni1xb93XMsuqfMBGVqPSr1kFsCJAKLaL2DSvJmrF3P/RsDpTWrRez
         gHWnvNSUiTxFCEsbh6DB/jtIOVc1MU1QzJwWLgv78pE+eJQKPV2zjoxoYAXcgvdbTDX3
         JAKxTmKZZct9kmAhhs5leZqRwkZld8vPFo9saBXFh+lPI/YdbeMdouiFt3xLtNJl7PZf
         4hCQIw67aXbzYv14pRLGXf5WkrH6onm3dO92DtBi+kHMc9Qgfr58Z1/G7hgpLF96Fh9X
         U87XurpP7oK8Xy07/eLy2n1SzV5aRm5TSl07sOMLS+068rWSn/hM12AT9C8DOiu8jUIf
         A41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=HZsbpC7Fo58je5AmkmLVo75u4dpgKURYG9fcUKw+/7E=;
        b=W5tX1n43Hri+fmUHBa5eCGAIE6MpVH8wWMJ7SQkE0ztkIJWILAkiZyQuSkb6YBsmNq
         6duYHsgwF7qoyIv5XCa/AmtBEBQ5GYa2liUbuRvG3AjOEMKOepdb60knwXJnohqDTBaE
         WP+65VuZjaQnDyv+Y4r27qy+UDfmJ7r8098mDsy2Ahzqyw7eBg3gvg+IiZhdTUvkmFpm
         sa6A/5hlnQB8UAkBHgoHOiaXVYlEy9p8XoWeN60rz0d65KYdZuUtnsKBBWBg9UZPmGdS
         FshOD40hevcV56KynLHJUbjP0VLKiKnasu0SyZbQ0xm3wBO6ZnS+2W0mgY/kbGbmENtp
         W0nQ==
X-Gm-Message-State: ACrzQf0TlwMsLQCSSqoHjvoH/Ub2j2eRi+oKWbHJ91UQBM2RXwqghFlI
        ZE1Q5MQvOoFLwEFkl45FWsZ4ig==
X-Google-Smtp-Source: AMsMyM4efyzJENR3pFVQbCNJGQaFRP38aks/hCC41uhribF9GuF9AwMXNsiR0ywxFEVjzHWmugT8yA==
X-Received: by 2002:a5d:6245:0:b0:225:41ae:a930 with SMTP id m5-20020a5d6245000000b0022541aea930mr2298053wrv.342.1665128711357;
        Fri, 07 Oct 2022 00:45:11 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c154b00b003a3442f1229sm8185520wmg.29.2022.10.07.00.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 00:45:10 -0700 (PDT)
Message-ID: <96160129-e9a0-ec0f-20d9-c92d1487eac6@linaro.org>
Date:   Fri, 7 Oct 2022 09:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Organization: Linaro Developer Services
In-Reply-To: <83649505-d8eb-b0b5-da9d-4536f58a7daa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/10/2022 09:04, Krzysztof Kozlowski wrote:
> On 06/10/2022 17:48, Neil Armstrong wrote:
>> On 06/10/2022 16:11, Krzysztof Kozlowski wrote:
>>> On 06/10/2022 12:57, Amjad Ouled-Ameur wrote:
>>>> Hi Krzysztof,
>>>>
>>>> Thank you for the review.
>>>>
>>>> On 10/5/22 10:14, Krzysztof Kozlowski wrote:
>>>>> On 04/10/2022 13:10, Amjad Ouled-Ameur wrote:
>>>>>> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
>>>>>> pin biais when idle. Therefore define three pinctrl names:
>>>>>> - default: SPI pins are controlled by spi function.
>>>>>> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
>>>>>> by spi function.
>>>>>> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
>>>>>> by spi function.
>>>>>>
>>>>>> Reported-by: Da Xue <da@libre.computer>
>>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>>>>>> ---
>>>>>>     .../devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml   | 15 +++++++++++++++
>>>>>>     1 file changed, 15 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>>>>> index 0c10f7678178..53013e27f507 100644
>>>>>> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>>>>> @@ -43,6 +43,14 @@ properties:
>>>>>>         minItems: 1
>>>>>>         maxItems: 2
>>>>>>     
>>>>>> +  pinctrl-0:
>>>>>> +    minItems: 1
>>>>> maxItems?
>>>>>
>>>> Will fill it in next version.
>>>>>> +
>>>>>> +  pinctrl-1:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  pinctrl-names: true
>>>>> Why do you need all these in the bindings?
>>>>
>>>> SPI clock bias needs to change at runtime depending on SPI mode, here is an example of
>>>>
>>>> how this is supposed to be used ("spi_idle_low_pins" and "spi_idle_low_pins" are defined
>>>>
>>>> in the second patch of this series):
>>>
>>> I know what it the point in general of pinctrl configuration... But the
>>> question is why do you need to specify them in the bindings? Core
>>> handles that. IOW, do you require them and missing/incomplete pinctrl
>>> should be reported?
>>
>> Looking at other bindings, when specific pinctrl state names were requires, they were
>> documented.
> 
> Yes, the required and/or necessary entries were added to few other
> bindings. Since Amjad did not make them required, why adding them? So I
> repeat the question for the third time - why do you need to add them to
> the bindings?
> 
>> There's some bindings with pinctrl-names for specific states like rockchip/rockchip,dw-hdmi.yaml,
>> mediatek/mediatek,dpi.yaml, mmc/mtk-sd.yaml or mmc/fsl-imx-esdhc.yaml
> 
> And? Just because someone did something is not itself an argument. They
> might have their reasons. If their reasons are applicable here, please
> state them.

OK, I thought the reason was explicit, we find it worth documenting
those optional pinctrl states for when the spi lines are in idle state.

If it's not an enough good reason, we'll drop this patch.

> 
> Best regards,
> Krzysztof
> 

Thanks,
Neil
