Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB76651E93
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiLTKP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiLTKPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:15:23 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A612AF1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:15:19 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b13so17884727lfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9GdfxfR5+EYFRbQQTp+s7HyhqzEMbsaLXxL7CcHk+g=;
        b=cpGUGSLwT13nmqNu6iSP2AElp+dsMPLQa++MS8J6/OvNCC3S/BxRQVT8tSurRsYtO4
         G2WvOu6I7stSzI0dl6QE7g6uselrW4jxG/wGWkk3vlvAv1O5zpGN9FAQqdebWtUHpgys
         vNVT4GipuclKgDNW52xzrhHv2HdwgaJmJZ81hDMgj3Uwv6CJKP5knXb8VmRq7fihDIHL
         Q/yY2n33GvfvM5VdbbfDjxwV2/EQLpzfZ2JM6YX14Zzi9qLVkm+5mbaUMjstJ8uhpPwW
         8YHcuVScluC156Gw3KLOxBkbzxhlJtwcjpxVfaiRaUwRHZHNkog9fis1OcizySMJOog2
         EOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9GdfxfR5+EYFRbQQTp+s7HyhqzEMbsaLXxL7CcHk+g=;
        b=mTXD2Oa3EW/f6huU/WyliVcGPstXVVrtgCMG0KWQoxHmT1Uv3mVwLzarlhYBoF1ooV
         v3bLUNytI1c9eA+n1m38hvkMjWIXWbiWTNb1jq0Z68qOtb9Hfo5HiPtJaJCXNqgc8K53
         NGtipEslwuRXIJIcjpL3p52eSZkKH3RQvZPd9lt+fFj2NN8Kv1+DTTgAsvz3PzjLWWNS
         ZBe3S9ZVJW060q4Q2G6BBDt4cBPmsZxJM7DHz0G0wtxwIutrDAUWj/tRiWQ5116hiV6W
         Q5D7Ujh6/EAixEQh2CLLfB7I6aagVOwW991pfTsBA4OJl2g+fsTgNNKqW3N2trRVRQ1E
         l0xQ==
X-Gm-Message-State: ANoB5pm3TZagBjJLommM8eydMWiJ0TECTDuPZASnnKHCVOUtaKvjEWMG
        jqcTB41+3shbz4CV6zleA4PKKw==
X-Google-Smtp-Source: AA0mqf7k5zItWg0Bot3y5LRFmvevyM5Cr0btlX+T/QPdsl6i0E5eWOSOxaCnbN66mFi8QSxTwZGa1Q==
X-Received: by 2002:a05:6512:3b86:b0:4b5:5f2b:ddfa with SMTP id g6-20020a0565123b8600b004b55f2bddfamr17468217lfv.30.1671531318166;
        Tue, 20 Dec 2022 02:15:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d4-20020ac244c4000000b004b57277474esm1395906lfm.106.2022.12.20.02.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:15:17 -0800 (PST)
Message-ID: <e0f620b4-5780-fbea-4446-fd68f281281a@linaro.org>
Date:   Tue, 20 Dec 2022 11:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/4] dt-bindings: hwmon: adi,ltc2945: Add binding
Content-Language: en-US
To:     "Cormier, Jonathan" <jcormier@criticallink.com>,
        linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
References: <20221214220727.1350784-1-jcormier@criticallink.com>
 <20221220000457.1163446-1-jcormier@criticallink.com>
 <20221220000457.1163446-2-jcormier@criticallink.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220000457.1163446-2-jcormier@criticallink.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 01:04, Cormier, Jonathan wrote:
> Create initial binding for the LTC2945 I2C power monitor.
> Also adds shunt-resistor-micro-ohms parameter

The last sentence does not make sense. I propose to skip it.

> 
> Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>
> ---
>  .../bindings/hwmon/adi,ltc2945.yaml           | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> new file mode 100644
> index 000000000000..f90d40919ee6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,ltc2945.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2945 wide range i2c power monitor
> +
> +maintainers:
> +  - Guenter Roeck <linux@roeck-us.net>

Maintainer of binding is person interested in the device, e.g. having
the hardware or datasheet. Not the subsystem maintainer. Unless by
coincidence this is the same person here?

> +
> +description: |
> +  Analog Devices LTC2945 wide range i2c power monitor over I2C.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/LTC2945.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2945
> +
> +  reg:
> +    maxItems: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Shunt resistor value in micro-Ohms
> +    default: 1000
> +
> +required:
> +  - compatible
> +  - reg
> +
> +
This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> +additionalProperties: false
> +

Best regards,
Krzysztof

