Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF6567B0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbjAYLO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbjAYLO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:14:26 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E5F582A8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:14:21 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id fl24so168260wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADMVvJ6tYjJ/l+5CJQ/3ram1FhkVHFeUTiIqd9RqeZ0=;
        b=lplwJ6LFnFBslMpFQXK7Qj2RgFsm0apBVis1zFeIol2oCAQXp/4alqJaEMkR/lmFZO
         8kQvtlnZTylENe0xGYPRKWvACND4L2JQDBcxhQMrsh/Jj6DR3kDSHSiBVfjSKoNQMiV1
         B6/VJAFMiydkCIJh5WIp4G0rzay5CsZuye8ETdAz3jCtejU94gnF9aQ5Nb1L1X5SMLHr
         6NetafPWZdj5DIxvErmbr5RqJGFbEq7zsCjVFED4BvIUOIgHV/+fdDqZjc5xDmQXhFPb
         iSHePyyX1Oq4Ny49EcE+fBCMQ3F9paO1ro+w1ZUzP2IBjSLPN1X4REQCScHc6DEGSMBY
         HSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADMVvJ6tYjJ/l+5CJQ/3ram1FhkVHFeUTiIqd9RqeZ0=;
        b=ObIdAYxrggRqb5D5FPL7pbVX2IDD89QNdUV6Lob8sPeUKknIgQhtETkpUA9OoxdgOa
         wn8Cw/vd15nvT8QWiBdummNMJDJx4OQVJiH9RXB2ORV3vSg7ztldnftzvVTM7JRR5ZT4
         o+nV3mjoV3TCTJQbC97hLHRFhEi0j3Q85ALWRbaV5OvS9xxaD1FEdBW0c/zUnHWT7UTk
         zZ5VuqOCF1btNelpbtabJHcZcswH7shO8ptNuW1v+ySj4Ihs7LHo2M6vjUYqQ/YO86bt
         Qb9NvCHFiXDIz4ufDL3tVTtOO24w9d8ygtjtzGMDUcV8Gh3cSPMLkQGNQuqn2LONH6kn
         6l7w==
X-Gm-Message-State: AO0yUKVNsnqbsnfj/rV0HyOXqEwlhaGgh7oHeIcJGU9UrHq3AG0aVa4t
        3b4yqCfkwpV5hI2cUGcJWqELgQ==
X-Google-Smtp-Source: AK7set8zfpH3GItcQG4IPh/bHvQ8qSxPfw03c6ev7WteTb0dpmAuSL72AIoK56QbNyIG4pkh7B+zAA==
X-Received: by 2002:a05:600c:444a:b0:3dc:16d3:8c95 with SMTP id v10-20020a05600c444a00b003dc16d38c95mr5026808wmn.30.1674645259511;
        Wed, 25 Jan 2023 03:14:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e26-20020a05600c4b9a00b003d9780466b0sm1467568wmp.31.2023.01.25.03.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:14:19 -0800 (PST)
Message-ID: <2471a5de-b7a6-fea7-152f-4fe25063abf9@linaro.org>
Date:   Wed, 25 Jan 2023 12:14:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v11 2/6] dt-bindings/thermal/mediatek: Add LVTS thermal
 controllers dt-binding definition
Content-Language: en-US
To:     bchihi@baylibre.com, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-1-bchihi@baylibre.com>
 <20230124131717.128660-3-bchihi@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230124131717.128660-3-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 14:17, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS thermal controllers dt-binding definition for mt8195.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---

Krzysztof, Rob,

are you ok with these changes ?


>   .../thermal/mediatek,lvts-thermal.yaml        | 107 ++++++++++++++++++
>   include/dt-bindings/thermal/mediatek-lvts.h   |  19 ++++
>   2 files changed, 126 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
>   create mode 100644 include/dt-bindings/thermal/mediatek-lvts.h
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> new file mode 100644
> index 000000000000..12bfbdd8ff89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/mediatek,lvts-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek SoC Low Voltage Thermal Sensor (LVTS)
> +
> +maintainers:
> +  - Balsam CHIHI <bchihi@baylibre.com>
> +
> +description: |
> +  LVTS is a thermal management architecture composed of three subsystems,
> +  a Sensing device - Thermal Sensing Micro Circuit Unit (TSMCU),
> +  a Converter - Low Voltage Thermal Sensor converter (LVTS), and
> +  a Digital controller (LVTS_CTRL).
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8195-lvts-ap
> +      - mediatek,mt8195-lvts-mcu
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +    description: LVTS reset for clearing temporary data on AP/MCU.
> +
> +  nvmem-cells:
> +    minItems: 1
> +    items:
> +      - description: Calibration eFuse data 1 for LVTS
> +      - description: Calibration eFuse data 2 for LVTS
> +
> +  nvmem-cell-names:
> +    minItems: 1
> +    items:
> +      - const: lvts-calib-data-1
> +      - const: lvts-calib-data-2
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - nvmem-cells
> +  - nvmem-cell-names
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/reset/mt8195-resets.h>
> +    #include <dt-bindings/thermal/mediatek-lvts.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      lvts_mcu: thermal-sensor@11278000 {
> +        compatible = "mediatek,mt8195-lvts-mcu";
> +        reg = <0 0x11278000 0 0x1000>;
> +        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
> +        clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
> +        resets = <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
> +        nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
> +        nvmem-cell-names = "lvts-calib-data-1", "lvts-calib-data-2";
> +        #thermal-sensor-cells = <1>;
> +      };
> +    };
> +
> +    thermal_zones: thermal-zones {
> +      cpu0-thermal {
> +        polling-delay = <1000>;
> +        polling-delay-passive = <250>;
> +        thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU0>;
> +
> +        trips {
> +          cpu0_alert: trip-alert {
> +            temperature = <85000>;
> +            hysteresis = <2000>;
> +            type = "passive";
> +          };
> +
> +          cpu0_crit: trip-crit {
> +            temperature = <100000>;
> +            hysteresis = <2000>;
> +            type = "critical";
> +          };
> +        };
> +      };
> +    };
> diff --git a/include/dt-bindings/thermal/mediatek-lvts.h b/include/dt-bindings/thermal/mediatek-lvts.h
> new file mode 100644
> index 000000000000..428a95c18509
> --- /dev/null
> +++ b/include/dt-bindings/thermal/mediatek-lvts.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Balsam CHIHI <bchihi@baylibre.com>
> + */
> +
> +#ifndef __MEDIATEK_LVTS_DT_H
> +#define __MEDIATEK_LVTS_DT_H
> +
> +#define MT8195_MCU_BIG_CPU0	0
> +#define MT8195_MCU_BIG_CPU1	1
> +#define MT8195_MCU_BIG_CPU2	2
> +#define MT8195_MCU_BIG_CPU3	3
> +#define MT8195_MCU_LITTLE_CPU0	4
> +#define MT8195_MCU_LITTLE_CPU1	5
> +#define MT8195_MCU_LITTLE_CPU2	6
> +#define MT8195_MCU_LITTLE_CPU3	7
> +
> +#endif /* __MEDIATEK_LVTS_DT_H */

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

