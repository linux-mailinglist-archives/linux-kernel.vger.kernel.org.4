Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72A15F649F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiJFK57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJFK55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:57:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B988998CA6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:57:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a3so2160365wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 03:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbv2nHTUDzNiZ9nBgts2ji/CMIP6Gv2pRdL0he3cIgg=;
        b=dQA1MwmY32f6mMOh4FebesRI3KpmxdKASSXF3XNuJ1f5B+AsXOFW7kU2xAamd3DN74
         McmUWagQo3TwI39dvke4dYZr08Rr+nREfOYAyL10Sf3eYIhBxMUgqSEj0BxsvnuYIfPY
         mDfvkk9+xKm8BOSPGU2qmuCf8mzNq32V4RZpsgHkkkWxlCekYHUHyVQ66PqZiC5M/U57
         RhZUfbdX12Z6eHnMdyeGGssGzuY6pcRjXWSdQihGSDaQpSNCleZB0mEFi5mNVn5KjwHl
         dgkkiGgBjNbbpH6gUZh1Y2My2qr8i2S5AsVXEmoGhkT6KLpgNm502H9GcUZd6bdx1VZb
         7wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbv2nHTUDzNiZ9nBgts2ji/CMIP6Gv2pRdL0he3cIgg=;
        b=NUgV4TUjoi75bXM6xTEsWEkzbt9/9KWadeQCxel4yw90kABKWNvixcck3qyzcdGeOy
         +q6Fw9UYfIsUHsob3dofNCzQEQHHwNHaus2NYg7FO+MyAF1UlmaQC4YDHbdPLN3iQTqa
         wWggkNsWtOezbBAxylNjmBhmOMK+IU8tQTHwMn6PqUyQ1FFKyubm9cxR98TGnTWzDCiy
         QM1oeM2Vlu7d4MRpRWKly8jHgULMUyB4szncXciZrDH1ERee9AA7F28Vsm4pGDTH6Z4k
         my00ydpz7XxmZl20eQ3UPb2gHvqe0kPNHIVn+gH4oMu3m2lfk7ccd5nJOEdm/12ikAi7
         9dTQ==
X-Gm-Message-State: ACrzQf2wiPcW0BfK4YXNduDKoA/0aA6t7I/o0gDCAYPKUZJefFEd4LBF
        T4m0VFlhR6D9bmiLMYcGPAS/5g==
X-Google-Smtp-Source: AMsMyM6nhQ5i2ukKQyJBrZwm0pxC9L1Un6AVLfuF3eK/z8umqKVDErHz9KN/EfjKDk5f/Rjlorlh+Q==
X-Received: by 2002:a5d:4c8e:0:b0:22e:3979:7dc9 with SMTP id z14-20020a5d4c8e000000b0022e39797dc9mr2632995wrs.41.1665053874257;
        Thu, 06 Oct 2022 03:57:54 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id c66-20020a1c3545000000b003bdb2c7f3d1sm4819568wma.32.2022.10.06.03.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 03:57:53 -0700 (PDT)
Message-ID: <fb2706e3-f758-a0b0-d595-75ef362a853e@baylibre.com>
Date:   Thu, 6 Oct 2022 12:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
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
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <d2ce98d7-1025-9c6e-e207-00e91942077a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the review.

On 10/5/22 10:14, Krzysztof Kozlowski wrote:
> On 04/10/2022 13:10, Amjad Ouled-Ameur wrote:
>> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
>> pin biais when idle. Therefore define three pinctrl names:
>> - default: SPI pins are controlled by spi function.
>> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
>> by spi function.
>> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
>> by spi function.
>>
>> Reported-by: Da Xue <da@libre.computer>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> ---
>>   .../devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml   | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>> index 0c10f7678178..53013e27f507 100644
>> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>> @@ -43,6 +43,14 @@ properties:
>>       minItems: 1
>>       maxItems: 2
>>   
>> +  pinctrl-0:
>> +    minItems: 1
> maxItems?
>
Will fill it in next version.
>> +
>> +  pinctrl-1:
>> +    maxItems: 1
>> +
>> +  pinctrl-names: true
> Why do you need all these in the bindings?

SPI clock bias needs to change at runtime depending on SPI mode, here is an example of

how this is supposed to be used ("spi_idle_low_pins" and "spi_idle_low_pins" are defined

in the second patch of this series):

&spicc {
     pinctrl-0 = <&spi_pins>;
     pinctrl-1 = <&spi_pins>, <&spi_idle_high_pins>;
     pinctrl-2 = <&spi_pins>, <&spi_idle_low_pins>;
     pinctrl-names = "default", "idle-high", "idle-low";

     [...]

};

>> +
>>   if:
>>     properties:
>>       compatible:
>> @@ -69,6 +77,13 @@ else:
>>         items:
>>           - const: core
>>   
>> +    pinctrl-names:
>> +      minItems: 1
>> +      items:
>> +        - const: default
>> +        - const: idle-high
>> +        - const: idle-low
> This does not match what you wrote in the bindings - you mentioned only
> two set of pin controls.

Right, there are actually three set of pin controls, will correct the bindings above.


Regards,

Amjad

>
> Best regards,
> Krzysztof
>
