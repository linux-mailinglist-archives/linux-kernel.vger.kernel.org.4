Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86156B6578
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCLLaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCLLaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:30:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8473A367D1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:29:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id fd5so4083533edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678620550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vEbvtEaqzurViy1oyu/fH6sSXoT67QNwu/aM1BVtT5Q=;
        b=UiaN9s31eDeV25UHlbG88LmmDbVVTEkypEvQ8hej1Cgqy7kspk5tRWXzQ2v/iKm9YY
         H0c64wjopB13GnzKYYxfISo7Iyf56+8d+V+BJFUXHfpcxyrvL9jtUYR8SLyyiv7sVGNT
         LpQIEd0rxJWeNSaUSOvV0HkdWioiJEPHf0G7omfi2T0C/RLO8LP95qglM1Bj9/UApbbJ
         4TSEy6sK3kS79ppHEmhdKmbW7L5shTDToZIqVCfMtFHhiTSOXBf256aTX/GV1B6vR7SZ
         8k/51oFrp725LX/7MUhMpPqsCH0u17ulLHUhPvKLFKa9dovFmXEQtMLEcWdntitdPQ0i
         fEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678620550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEbvtEaqzurViy1oyu/fH6sSXoT67QNwu/aM1BVtT5Q=;
        b=4VbE7Fby6csjsmf+a+RqGc3/hXBYpouppVLSkQdenR/0YGcCo0MDuOLgc3SnkLryts
         W93deJEbp6SUieib1oBWHfsU3r6Ae302zFVPB4AVVR732hnOiH2xOp5pNm5W5N9QfBLz
         KX9e7nx1OQDlzWywA1SOBV/NXGWGK7a/3kCWgjP40lpuN2c0xr1bYElQftNiyrw6Brwt
         jrL9l+x/E6i8PAn2KbIDVcMcAeBQJ78CcVZvdOUP8oSlh3bHJCzhkqZc0lDlZFaEDgsB
         gjf+/DymVl5acXAwIlG6Z+yjiGkvg0nQY3Tojxx/Xgod2lKopX1o7/aGviSNrWHJiOeD
         ZCcQ==
X-Gm-Message-State: AO0yUKXhIv84VKG3FHqpsN5wmgBuJU/mPxzHy7SpnFeVB1BL5Ul5RMuO
        PLuaRg9kh39d8cQ3VCt1f4hDzA==
X-Google-Smtp-Source: AK7set+nnpVq56bCEEs1ofeUA3yrwLzE2dg0GdiAHnT9kDhhE1HoI6vlTdI7GjQxALpD4fVwpuGGkw==
X-Received: by 2002:a05:6402:1610:b0:4c6:f2cd:9d76 with SMTP id f16-20020a056402161000b004c6f2cd9d76mr30567280edv.19.1678620550691;
        Sun, 12 Mar 2023 04:29:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id m8-20020a509988000000b004bb810e0b87sm2102550edb.39.2023.03.12.04.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 04:29:10 -0700 (PDT)
Message-ID: <255e857e-c4a4-c90a-f8bc-8c20b02f0839@linaro.org>
Date:   Sun, 12 Mar 2023 12:29:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv1 01/11] dt-bindings: power: supply: adc-battery: add
 binding
Content-Language: en-US
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-2-sre@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230309225041.477440-2-sre@kernel.org>
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

On 09/03/2023 23:50, Sebastian Reichel wrote:
> Add binding for a battery that is only monitored via ADC
> channels and simple status GPIOs.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Thank you for your patch. There is something to discuss/improve.


> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description: |

Don't need '|'.

> +  Basic Battery, which only reports (in circuit) voltage and optionally
> +  current via an ADC channel.
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: adc-battery
> +
> +  charged-gpios:
> +    description:
> +      GPIO which signals that the battery is fully charged.
> +    maxItems: 1
> +
> +  io-channels:
> +    minItems: 1
> +    maxItems: 3
> +
> +  io-channel-names:

Simpler:

minItems: 1
items:
  - const: voltage
  - enum: [ current, power ]
  - const: power

> +    oneOf:
> +      - const: voltage
> +      - items:
> +          - const: voltage
> +          - enum:
> +              - current
> +              - power
> +      - items:
> +          - const: voltage
> +          - const: current
> +          - const: power
> +

What about temperature? For max17040 this was recently proposed and I
wonder whether it is desirable.

https://lore.kernel.org/all/74ba115e-9838-4983-7b93-188a8260dd8a@linaro.org/

Best regards,
Krzysztof

