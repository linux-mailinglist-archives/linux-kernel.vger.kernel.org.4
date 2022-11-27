Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB99639D22
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiK0VJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiK0VJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:09:03 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF4E2DD1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:09:02 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id n1so6406027ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFXO/ZdPtFpFLdCwGkdQebz3vpWArKXR7PrKFQW6Dxs=;
        b=zWQBXzeM0tiFaOXdakwLj7/dhxke40mbwENUulJGokGlmc19QrasgxKzAixXq5CZGX
         zpk385VoY0qdR22b8iPyDor96yjNqNAQ/WtXgmfHizDL9V6ghu7YRNyJ7mDiHmBYzZO1
         YWtHoW/CcNUq30Kx/ItUblgaC+A8r2K1UEkEHdM7495ZGgDuSlKuxORlckAeRi0yxai1
         A5lMtoIeuRWJs1zqDjxuWDetySWty7S3RJ/XKBqzwqer3ajK997waiYXhj/44Wvxj/Wl
         ugEYGDCsDMY/hro7WMDqtO4IVjA7yiDpr3lCLozMvbby7fOlJybEC6dt8GryzL94x6SW
         3WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFXO/ZdPtFpFLdCwGkdQebz3vpWArKXR7PrKFQW6Dxs=;
        b=mSEhLmYfwS2O9OTHZy1wD8VsADC1VJVEeLK3D43Rie+OLL6ZNH4BMkUAAcR/373w7g
         J/sHaOnPQcMOBlwETJ9oBA+ipuMZ68i+npw/72EFPnBwRoO4UjU0RRt8mmrdgp9hq4ci
         bd6Wmw4AlvDU6BrjxmZrlTcgwMFX34+dmIlmYyuJI6HyR5apVNBsrmrKJZAklVydzll7
         2FRgYoocjTSRjjVVWPA7P7jg8QQzezKwu34vEN/y3HDSYQP1LTwmAJ5zfh7NDOzyU/Qd
         fWzUjrK4upTQVOoilJEWF4cr7dXPghxC8OphKAsoNFDRVVcuuQg6qNz3tWqHLpOPM1nV
         xafQ==
X-Gm-Message-State: ANoB5pnn2/FHDWiJzOAbKPXLmc2am+Ds4jCXdRvbR84TH8UyhZmCfn4m
        fXWbdO59/scL7Zp/Id4PfzgYpA==
X-Google-Smtp-Source: AA0mqf4QuObC2nLAN7sETiquwquoqdWx9FhIpw5ZC1oOtrp7tnJ6ywv7zRPd7Es/4lDNiHT8UPgn6A==
X-Received: by 2002:a2e:9007:0:b0:279:84ce:5f71 with SMTP id h7-20020a2e9007000000b0027984ce5f71mr6062064ljg.207.1669583340496;
        Sun, 27 Nov 2022 13:09:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o21-20020a056512231500b0049311968ca4sm1404143lfu.261.2022.11.27.13.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 13:09:00 -0800 (PST)
Message-ID: <ea76b70e-6060-7c23-48b5-b2e5b35fe85f@linaro.org>
Date:   Sun, 27 Nov 2022 22:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,adc081c: Document the binding
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221125220903.8632-1-samuel@sholland.org>
 <e4be94a3-cdfc-cdf8-5d69-0eef480033f9@linaro.org>
 <20221127174219.34d0406c@jic23-huawei>
 <b68807e9-3907-9f9a-8eee-b7f24be3c78f@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b68807e9-3907-9f9a-8eee-b7f24be3c78f@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 19:01, Samuel Holland wrote:
> On 11/27/22 11:42, Jonathan Cameron wrote:
>> On Sun, 27 Nov 2022 13:51:19 +0100
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>>> On 25/11/2022 23:09, Samuel Holland wrote:
>>>> Linux has a driver for these ADCs at drivers/iio/adc/ti-adc081c.c, but
>>>> the compatible strings were undocumented. Add a binding for them. The
>>>> hardware has an alert interrupt output, but existing ti,adc081c users
>>>> do not provide the 'interrupts' property, so leave it as optional.
>>>>
>>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>>> ---
>>>>
>>>>  .../bindings/iio/adc/ti,adc081c.yaml          | 55 +++++++++++++++++++
>>>>  1 file changed, 55 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
>>>> new file mode 100644
>>>> index 000000000000..caaad777580c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
>>>> @@ -0,0 +1,55 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/iio/adc/ti,adc081c.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: TI Single-channel I2C ADCs
>>>> +
>>>> +maintainers:
>>>> +  - Jonathan Cameron <jic23@kernel.org>
>>>> +  - Lars-Peter Clausen <lars@metafoo.de>
>>>> +
>>>> +description: |
>>>> +  Single-channel ADC supporting 8, 10, or 12-bit samples and high/low alerts.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - ti,adc081c
>>>> +      - ti,adc101c
>>>> +      - ti,adc121c
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  vref-supply:
>>>> +    description:
>>>> +      Regulator for the combined power supply and voltage reference
>>>> +
>>>> +  "#io-channel-cells":
>>>> +    const: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg  
>>>
>>> Why not requiring io-channel-cells? If it is an IIO ADC provider, you
>>> need the cells, right?
>>
>> Only if anyone is using it as a provider.  If it's purely being used via
>> IIO then there are no consumers registered.
>>
>> So historically I've left it up to those defining the binding to decide if
>> they think #io-channel-cells should be required or optional.
>>
>> It gets a bit non obvious with some of the more complex special ADCs on whether
>> they will ever be consumed.  This one is generic, so quite likely it will be.
> 
> I kept #io-channel-cells optional because there are already a handful of
> boards using ti,adc081c without it.
> 
> On the board I am adding (Clockwork DevTerm), the ADC is used a
> temperature sensor for a thermal printer. So whether or not the ADC is
> used as an OF provider depends on how the printer driver gets implemented.

Thanks, it's fine.

Best regards,
Krzysztof

