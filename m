Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1BD639D25
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiK0VJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiK0VJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:09:23 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B54B1EB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:09:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so14552870lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bk3OVChHwOyqICTyQ+rx2LQ9mTbuf/Zlp6NcOI2QYiQ=;
        b=IgcHJq5xCuXqgRhr3YzFVvKvIwot57Rsbx2sya6O+Ngy/Uf4JO647wXHi9T4Ma66kR
         BSsbH5oZRKzVDOrtDx3nSCVtpKtYPk7Dbo1vk6L8buDAleST2+cwbKXmmhGsEuu9nhVr
         ubGnaOH1SHzCl1hJ0UNEA5oTrzONM51FbjOabwqpTL+crJNdC7V3XP43zYLdSgKz/H+6
         2bTQB0TTI1gHEUB1lCLEcp3g2hktzb5K8nKCrDepn3bVqqbrXxy8/ZABonEKFNB21S6H
         NoJS3kELKpaOP0QKLsSFsa7Ntfs9fps7tZnbLUEfRWN0jvgs7SmFsOk6+NTcwJt0uquW
         Fl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk3OVChHwOyqICTyQ+rx2LQ9mTbuf/Zlp6NcOI2QYiQ=;
        b=la+efHOb/iUKM8AEqQTnyz5EeU8IAav9QCUHUXiQN8ix/Ld4Qff/cpXfgiIcWw14Ko
         drHFPLI2a8EUQaL6aLkcQd6l+VN6t/nUaSIxZkfyYLX3mM8/1EsFSYr9FMb7iXOwtU46
         HKnbJmryOiLZUDK79LY0n/s5RxCmD8Rn70dPjRt7UCxvIdQ23VJtMrpqQ82IiRVfGsHi
         jzjTHNUMDSHnzAawpW1+G9d7jYBelGHkkWOtREBvBnrR4+Ois25pgjdXfEVe8zBP9Pqk
         w+OdiMuerrjXcJC2criqG1UxjB5elN5QdvkbvMsrLhCq/bl427tZ0MaJmS45C8aTJSYZ
         sEsA==
X-Gm-Message-State: ANoB5plJltWMRbq+pdzUUTFbwdA9bAU98m/ZiOky2qdjwVPSmWz+mJng
        jm0aJTcTEZ0ih9S2sykkgtN9Jg==
X-Google-Smtp-Source: AA0mqf4te/gm5I1huS/EdZaliP8msqFpV7zTVF0a4hJqEMXNLlS3XoGMBewedlFEDGNoP43GLAB5tw==
X-Received: by 2002:a05:6512:2310:b0:4b5:da7:87ff with SMTP id o16-20020a056512231000b004b50da787ffmr1985122lfu.315.1669583360420;
        Sun, 27 Nov 2022 13:09:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p11-20020a05651212cb00b00497feee98basm1386185lfg.274.2022.11.27.13.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 13:09:20 -0800 (PST)
Message-ID: <0ea76be9-dbb3-f439-a929-753cf2f1a5c1@linaro.org>
Date:   Sun, 27 Nov 2022 22:09:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,adc081c: Document the binding
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221125220903.8632-1-samuel@sholland.org>
 <e4be94a3-cdfc-cdf8-5d69-0eef480033f9@linaro.org>
 <20221127174219.34d0406c@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127174219.34d0406c@jic23-huawei>
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

On 27/11/2022 18:42, Jonathan Cameron wrote:
> On Sun, 27 Nov 2022 13:51:19 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 25/11/2022 23:09, Samuel Holland wrote:
>>> Linux has a driver for these ADCs at drivers/iio/adc/ti-adc081c.c, but
>>> the compatible strings were undocumented. Add a binding for them. The
>>> hardware has an alert interrupt output, but existing ti,adc081c users
>>> do not provide the 'interrupts' property, so leave it as optional.
>>>
>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>> ---
>>>
>>>  .../bindings/iio/adc/ti,adc081c.yaml          | 55 +++++++++++++++++++
>>>  1 file changed, 55 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
>>> new file mode 100644
>>> index 000000000000..caaad777580c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
>>> @@ -0,0 +1,55 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/adc/ti,adc081c.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: TI Single-channel I2C ADCs
>>> +
>>> +maintainers:
>>> +  - Jonathan Cameron <jic23@kernel.org>
>>> +  - Lars-Peter Clausen <lars@metafoo.de>
>>> +
>>> +description: |
>>> +  Single-channel ADC supporting 8, 10, or 12-bit samples and high/low alerts.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ti,adc081c
>>> +      - ti,adc101c
>>> +      - ti,adc121c
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  vref-supply:
>>> +    description:
>>> +      Regulator for the combined power supply and voltage reference
>>> +
>>> +  "#io-channel-cells":
>>> +    const: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg  
>>
>> Why not requiring io-channel-cells? If it is an IIO ADC provider, you
>> need the cells, right?
> 
> Only if anyone is using it as a provider.  If it's purely being used via
> IIO then there are no consumers registered.
> 
> So historically I've left it up to those defining the binding to decide if
> they think #io-channel-cells should be required or optional.
> 
> It gets a bit non obvious with some of the more complex special ADCs on whether
> they will ever be consumed.  This one is generic, so quite likely it will be.

I remember I asked some time ago and got the same answer... need to
write it down into my notes :)

Best regards,
Krzysztof

