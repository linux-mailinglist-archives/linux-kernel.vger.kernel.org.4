Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795446C1F28
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjCTSLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjCTSKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:10:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B049B3E617
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:04:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b20so17261978edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679335464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlbvOvcRdjikHkGUAlyi2gafrmdSiUtbdmOmB2pwxAQ=;
        b=vF7FFDLUxwbbu19+9bi9lG2X3u9NftQ5nmLJ3gRFUsq1cLs0kxIhqz/Z20haoPEqYU
         gKGXtaz67MTUrptzTWpNiRsRBLmqwAqIijoCeZsEUeCgwWX8w3cQJbqPOHHMvH/UxYG5
         Catw6Y0mRkhSLO+GEkiKkJyetu3DNTQ4hLLICj7Qi08leeZ+syj20rY90xGFAiVvPswq
         XYBKI1KjP6IyNr796auFZIqgSBRGbm7XSiGAdyNh//c8D2urdRZaPvtt7RmvdMcCRLio
         /7VgJQuByjEM2ASpHDzmIoaXyL/GfF/y0/7tqZkx7aZkZ0Dop2YTNZyoaucJ842gj4e4
         vShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlbvOvcRdjikHkGUAlyi2gafrmdSiUtbdmOmB2pwxAQ=;
        b=3RJEoD0UJL2tW6GbW1jO+wFPImAdLlzpgNV5I2Dvhb0/NdWx8VMRXr5NtK45r3NTya
         GxHNvuz72ltqwc/IEALcpsKONDwl6h036mx2xBZ6c+3ZxHvIAwfQ6KC1S6vWSBYrwf7K
         6kNyp4NS3/xfCeFtK0RJYyMC4Q6sxs0NFf6Qx37ODyoxWC1sP30cDh6qUtOJ6KUR/v6K
         dY1JDQ1WuRTud0eAQGRRNpycdMMZKGEBXMtWr499A6PBsbJFYn73p/DA1UC4f4nl3MEU
         8fb4gplyLOOBdmUHfqzP4B9No8AnAk8Wo6vPHL/w6elreOABkr/AyiNKwSxyNiiieWL5
         55XQ==
X-Gm-Message-State: AO0yUKXRzRMWs8EEr8DzyUT2EyCcfIWEYoI/9nVp01jP0U8eeQpDzzJ2
        lB5xRhdzpaf3MXuadAhnU7Shrg==
X-Google-Smtp-Source: AK7set+3A23KwD3p9Eh/ZVXzZ3ZMSeEl55VrVNQ0P3GLWZqCiYEP3aXfFUQWpAk/8Ym3CRDLeTbQIg==
X-Received: by 2002:aa7:c7c2:0:b0:4fb:9372:f837 with SMTP id o2-20020aa7c7c2000000b004fb9372f837mr482985eds.4.1679335463946;
        Mon, 20 Mar 2023 11:04:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id q30-20020a50aa9e000000b004fadc041e13sm5239875edc.42.2023.03.20.11.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:04:23 -0700 (PDT)
Message-ID: <922eab51-6931-8533-db51-51cd911a36b3@linaro.org>
Date:   Mon, 20 Mar 2023 19:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: aw2013: Document vddio-supply
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230320174949.174600-1-linmengbo0689@protonmail.com>
 <20230320175131.174657-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320175131.174657-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 18:55, Lin, Meng-Bo wrote:
> Some LEDs controllers are used with external pull-up for the interrupt
> line and the I2C lines, so we might need to enable a regulator to bring
> the lines into usable state.

Not a property of this device.

> Otherwise, this might cause spurious
> interrupts and reading from I2C will fail.
> 
> Document support for "vddio-supply" that is enabled by the aw2013 driver
> so that the regulator gets enabled when needed.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-aw2013.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
> index 08f3e1cfc1b1..79b69cf1d1fe 100644
> --- a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
> @@ -23,6 +23,11 @@ properties:
>    vcc-supply:
>      description: Regulator providing power to the "VCC" pin.
>  
> +  vddio-supply:
> +    description: |
> +      Optional regulator that provides digital I/O voltage,

NAK. I responded to your patch and you just send a v2 without explanation.

The device does not have VDDIO pin, either.

Best regards,
Krzysztof

