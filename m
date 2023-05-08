Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256C86FB7CC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjEHTzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbjEHTzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:55:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6297DC
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 12:54:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965f7bdab6bso688206266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683575662; x=1686167662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkLqC0bGaOlVWnnBet4QRsS/pSWQwc9qaoFivs6O6Ms=;
        b=bGNr52Jcjr+zJbu0ApsHdwEfzDNOmdLjNBT2JEHjrehpcLwJJSlYyptOuDkdtvv80G
         6AkvKsFBgd4u5EG+bS4O/7a/TL75Q0bsPu1d5rc/E+gssy84f0RhRYEdvECHsVeJwJfy
         mr6qhVpCy5FiYeVs6pLl6OaN25u9+Ao8i3r9gBPot6DS67KJFYhJllACr0kXigHlbNhn
         AniITUi2mDmR9yzDM2z/T0GeW7RBG/w8Xpe71WFUH1Nfe4l3wE10EBQLf1TwL8nOFWxk
         cgJNuQBAnAiSP9stYotBLmXbDCdyI/kVLcp+7miEjbC8SJeDyiwnBfreVzky0T54LZX7
         xncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683575662; x=1686167662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkLqC0bGaOlVWnnBet4QRsS/pSWQwc9qaoFivs6O6Ms=;
        b=j+6CAyzIiWVw2y6W9pbQ7ECuo7jHTlP2JcGf5BvbSxUWEG6lKEPPQ3Lwo0jLunlEI0
         hgj1Bai2ppX0wwpQEvaAinO/tQMfYFEQSXCnowT+Z5l0VESavl7jYObOrKRA57HgLLb1
         HzjTlWd2b0gYUSPKMO3eLyfNfY93rIb90WDHXbEnmXibu5vpIZ0KjanAbTQY//ftkvGR
         3LtzKB6XQl8+Iv3cSfe45xcQfEcNBG/cYOcHLez9FV6tKUetVPq7P9KJnntNsPE+//8L
         cM9+2YU2/VXpVX+RUDWY9qr0ycdR98aG/zIIGkbeCcja+rK9los+HVHGrzGBJVmvXjL1
         PhVw==
X-Gm-Message-State: AC+VfDzNVQkjASNVz3XmrfMusVQDRiqj5TWH47i5mmTWAgviN55Z4tJq
        4dpFkRiBmPWxsw+EOAitKpTKDw==
X-Google-Smtp-Source: ACHHUZ5M1ZAUXpF/qt6oeM0HV6JJuGDgWeKPoQQW/4gtdMcTUFm5ocYnqXBweR27SWq2FPIlTBQY4Q==
X-Received: by 2002:a17:907:72d6:b0:960:f1a6:6a12 with SMTP id du22-20020a17090772d600b00960f1a66a12mr10729673ejc.55.1683575662625;
        Mon, 08 May 2023 12:54:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac? ([2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906128e00b009660df2e6c6sm353843ejb.168.2023.05.08.12.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 12:54:21 -0700 (PDT)
Message-ID: <9c916321-a2c6-6665-bfea-b1778ea4f983@linaro.org>
Date:   Mon, 8 May 2023 21:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 4/7] dt-bindings: power: supply: max77658: Add ADI
 MAX77658 Battery
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-5-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508131045.9399-5-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 15:10, Zeynep Arslanbenzer wrote:
> Add ADI MAX77658 power supply devicetree document.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../power/supply/adi,max77658-battery.yaml    | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77658-battery.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/adi,max77658-battery.yaml b/Documentation/devicetree/bindings/power/supply/adi,max77658-battery.yaml
> new file mode 100644
> index 000000000000..112296d2b1f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/adi,max77658-battery.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/adi,max77658-battery.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery for MAX77658 PMICs family from ADI
> +
> +maintainers:
> +  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> +
> +description: |
> +  This module is part of the MAX77658 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/adi,max77658.yaml.
> +
> +  The fuel gauge is represented as a sub-node of the PMIC node on the device tree.
> +
> +properties:
> +  compatible:
> +    const: adi,max77658-battery
> +
> +  adi,valrt-min-microvolt:
> +    description: alert when battery voltage is lower than this value
> +
> +  adi,valrt-max-microvolt:
> +    description: alert when battery voltage is higher than this value

Use the same approach/solution as battery.yaml.

> +
> +  adi,ialrt-min-microamp:
> +    description: alert when battery current is lower than this value
> +
> +  adi,ialrt-max-microamp:
> +    description: alert when battery current is higher than this value

Also here.

> +
> +  monitored-battery:
> +    description: >
> +      This property must be a phandle to a node using the format described
> +      in battery.yaml, with the following properties being required:
> +      - alert-celsius
> +
> +required:
> +  - compatible
> +  - monitored-battery
> +
> +additionalProperties: false
> +
> +...

Best regards,
Krzysztof

