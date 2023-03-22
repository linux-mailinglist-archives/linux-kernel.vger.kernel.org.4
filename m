Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350D26C44FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCVIdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCVIdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:33:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F412CFD6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:33:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn12so23900961edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679473991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivtJ17SntBidQVkbcFjsY9yFoBVm7miDvhKcewrMLjc=;
        b=tcV0JQhU7AvOb77j4GXs7g7T2t/Rfg5n/93Am0kLkPiZishIGYx+7eDt7cNSsK5UlZ
         UhkXDQ4Bk5uA1ZXMFxe/xcY5VY4n03jUazDpfNUCCdu5O+GJ3xlpKxHS03+qCK14TKf4
         qrTOyVf8ddJah+gkUXs/K+HUJ3e/3SH13WXOFCW2EgOGYn2KwgR45mIHz1O8Xro7Lot6
         aiuJaj4uosmTdK4KGl6IkPgIocQ8syBMrpfsdLn6I4bOE6Xd4ikFmb1xTMWXCFyso2qy
         0bOKb+ayZ/8jWELoOLSRnVxkNoP7BzxxXVECy2R73MBwExTDblRZLEfxOIItiush8hwQ
         rw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivtJ17SntBidQVkbcFjsY9yFoBVm7miDvhKcewrMLjc=;
        b=aJM4c8Y1f+OcokFIu3ADHIloTLFf+bmMetqBIekGjN3iZXvvpIx3QstrXhbNSOx7Dq
         YukyM4hoCuR7p0Z+7/JiTUJvkZCDspWaMtpD/0hEiXHcS5s4q7JWVusfOPqloX4k0Ubu
         xRyDhf/pWOVorVkSiMPgALLffrQ+/C/3vLbk03hjoF7wOPHWhCbQwmUyFqb4LTWMHX0N
         mc/70XI9MKre3B8OlE04BYbkn3QDHIR4sbyvC1pu/ACqv7teEJ3R2poCdw/qgAx+2gCd
         jLS7SBE/2dk/dCV3wNTVZryXvaZQS0HqXcvjI4i2OywyaE4HDSaTqS7gXZtWyxiwyxoW
         +FVg==
X-Gm-Message-State: AO0yUKVp9ndWvaKhjScHOcqwDaHCbn7ARUbumjW6aZSTpaQde8mxcD71
        WoOs+a2JKjFJX+fWPelGofq6IA==
X-Google-Smtp-Source: AK7set8iZr+rJsRD1W2LuqUuGK3/1SRsoc0lc7QCOzTHtqZ2RaPZ0AERgD8nfqF4UPk2ssYZKZU3bg==
X-Received: by 2002:a05:6402:c2:b0:501:c120:6e90 with SMTP id i2-20020a05640200c200b00501c1206e90mr5809096edu.3.1679473991638;
        Wed, 22 Mar 2023 01:33:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id e23-20020a50d4d7000000b004bf28bfc9absm7198839edj.11.2023.03.22.01.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:33:11 -0700 (PDT)
Message-ID: <86d56386-fe9e-320d-edd3-5b288520e92a@linaro.org>
Date:   Wed, 22 Mar 2023 09:33:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 7/8] dt-bindings: mfd: max77658: Add ADI MAX77658
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     Nurettin.Bolucu@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-8-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322055628.4441-8-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 06:56, Zeynep Arslanbenzer wrote:
> Add ADI MAX77658 devicetree document.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,max77658.yaml | 199 ++++++++++++++++++
>  1 file changed, 199 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77658.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,max77658.yaml b/Documentation/devicetree/bindings/mfd/adi,max77658.yaml
> new file mode 100644
> index 000000000000..6edb59e8f446
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/adi,max77658.yaml
> @@ -0,0 +1,199 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/adi,max77658.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX77643/MAX77654/MAX77658/MAX77659 PMIC from ADI
> +
> +maintainers:
> +  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> +
> +description: |
> +  MAX77643, MAX77654, MAX77658 and MAX77659 devices are a family of ADI PMICs
> +  providing battery charging and power supply solutions for
> +  low-power applications.
> +
> +  MAX77643 is a Power Management IC with 1 LDO regulator.
> +
> +  MAX77654 is a Power Management IC with 2 LDO regulators and 1 charger.
> +
> +  MAX77658 is a Power Management IC with 2 LDO regulators, 1 charger
> +  and 1 fuel gauge.
> +
> +  MAX77659 is a Power Management IC with 1 LDO regulator and 1 charger.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max77643
> +      - adi,max77654
> +      - adi,max77658
> +      - adi,max77659
> +
> +  reg:
> +    description: I2C address of the PMIC
> +    items:
> +      - enum: [0x40, 0x48]
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  charger:
> +    $ref: /schemas/power/supply/adi,max77658-charger.yaml
> +
> +  fuel-gauge:
> +    $ref: /schemas/power/supply/adi,max77658-battery.yaml
> +
> +  regulators:
> +    $ref: /schemas/regulator/adi,max77658-regulator.yaml
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,max77643
> +              - adi,max77654
> +              - adi,max77658
> +
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - const: 0x48
> +
> +    else:
> +      properties:
> +        reg:
> +          items:
> +            - const: 0x40
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    battery: battery-cell {
> +      compatible = "simple-battery";
> +      alert-celsius = <0 100>;
> +      constant-charge-current-max-microamp = <15000>;
> +    };
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pmic@48 {
> +        compatible = "adi,max77643";
> +        reg = <0x48>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> +        regulators {
> +          LDO0 {
> +            regulator-boot-on;
> +            regulator-always-on;
> +          };
> +        };
> +      };
> +    };

Four examples is too much. Keep only some relevant one or two.

Best regards,
Krzysztof

