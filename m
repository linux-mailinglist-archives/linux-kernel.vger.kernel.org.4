Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D785669658
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjAMMDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjAMMDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:03:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4AE83E1C;
        Fri, 13 Jan 2023 03:54:29 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso14215074wmq.3;
        Fri, 13 Jan 2023 03:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzbNjSUYq3lJOoU05SBD+iYcga1U6ox8imF8t/9BQK8=;
        b=Aa7B72HDB1zekRgERXJJwJamxmE6crmVUsKekfOybzfu19PhWBG4FJLl+96bFdH8Wy
         rLVyNceHkj8IJoYYf6E9GH1gkOkDqB1fGco5A9n/Yv5TuzHIGMQsi+7Ud9s3mbjjUPgm
         W13DO00dgVyProTDkuDLprrXjDmwjJ2LXwJGuhKjlHhgAL56KlcQQw25H7gm/1291F5+
         VqyG9g9h6ZuUSnQmIQ51nGyT7xvsHkmzsVEPqy1lp7elPDTeRr6EGne4C+vNQmdHvSXE
         6F5b7PIE5aOkcLinlKTUlFQ85lIvBLCrbFF5o0N+rwewhrDanewnHDity52Q/ku+6vLI
         aiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzbNjSUYq3lJOoU05SBD+iYcga1U6ox8imF8t/9BQK8=;
        b=zbgSeR+Tz88IGKLci0f9WZbS9iuCVlE3Go9QRp9CfNFQqRZSKhByle8KCJQ7CYpXrs
         q73ZnE15c9QISeQgxpVVlqgVLIbDtazcy3wChQk86AOGMavFg3SxsqQF7FH4v3NFJVyb
         ZinDoZejZ3IMJU46xE0uJq2GO0RZZMiOdtGKbHYZX+dawkb9jby2WFREc2Ac9JV4B4+/
         k+IpC+jX+Ih9lx/hUNb6aM1FBiHB7ZeinHZ3qkPhoVxTjd0LzBtT/KBZnjibYWNMNcbL
         YjzC+vspp0RcLjE2OAq98wZWpvSwxHq8z549cRPhIkFfUJ3exbMZh8qPDFUAW4JazU/H
         +bsw==
X-Gm-Message-State: AFqh2kpC6EGMc8hdhIPf8jyDOJtLxnfzAirJ2CRcU+Jtg2H2Y/LClinU
        MmqmNrNskQEdJRD+n27kEaQ=
X-Google-Smtp-Source: AMrXdXsl/E0OL1OrzaPYsol/4C1UNXj1AoUqRxQ+VOS8jMaTTSzcHpS/zAO7tvU18WVbLEcQH+HqGg==
X-Received: by 2002:a05:600c:d2:b0:3d2:2b70:f2fd with SMTP id u18-20020a05600c00d200b003d22b70f2fdmr59320360wmm.21.1673610868049;
        Fri, 13 Jan 2023 03:54:28 -0800 (PST)
Received: from [192.168.0.30] ([37.222.254.155])
        by smtp.gmail.com with ESMTPSA id l13-20020adfe58d000000b00296730b5c3esm18911503wrm.102.2023.01.13.03.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 03:54:27 -0800 (PST)
Message-ID: <96384f72-19aa-b038-75c6-76b0957750c7@gmail.com>
Date:   Fri, 13 Jan 2023 12:54:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 2/6] dt-bindings/thermal/mediatek: Add dt-binding
 document for LVTS thermal controllers
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230112152855.216072-1-bchihi@baylibre.com>
 <20230112152855.216072-3-bchihi@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230112152855.216072-3-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2023 16:28, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add dt-binding document for mt8192 and mt8195 LVTS thermal controllers.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>   .../thermal/mediatek,lvts-thermal.yaml        | 140 ++++++++++++++++++
>   1 file changed, 140 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> new file mode 100644
> index 000000000000..43b8777fc1b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> @@ -0,0 +1,140 @@
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
> +      - mediatek,mt8192-lvts-mcu
> +      - mediatek,mt8192-lvts-ap

I wonder: you provide the binding description for mt8192 but no implementation 
in the driver. Are you sure the description is correct?

Regards,
Matthias

> +      - mediatek,mt8195-lvts-mcu
> +      - mediatek,mt8195-lvts-ap
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
> +allOf:
> +  - $ref: thermal-sensor.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8192-lvts-mcu
> +              - mediatek,mt8192-lvts-ap
> +    then:
> +      properties:
> +        nvmem-cells:
> +          maxItems: 1
> +
> +        nvmem-cell-names:
> +          maxItems: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8195-lvts-mcu
> +              - mediatek,mt8195-lvts-ap
> +    then:
> +      properties:
> +        nvmem-cells:
> +          maxItems: 2
> +
> +        nvmem-cell-names:
> +          maxItems: 2
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
> +        thermal-sensors = <&lvts_mcu MT819x_MCU_LITTLE_CPU0>;
> +        trips {
> +          cpu0_alert: trip-alert {
> +            temperature = <85000>;
> +            hysteresis = <2000>;
> +            type = "passive";
> +          };
> +          cpu0_crit: trip-crit {
> +            temperature = <100000>;
> +            hysteresis = <2000>;
> +            type = "critical";
> +          };
> +        };
> +      };
> +    };
