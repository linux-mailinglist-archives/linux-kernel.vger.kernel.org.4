Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8D7717945
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjEaH6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjEaH6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:58:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA81D1703
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:57:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96fab30d1e1so141142066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685519866; x=1688111866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qX3wCILele8uoAh+Ad7WZ/vlKQvPjoQ0nfu/yoKu41g=;
        b=flD6sSA/TdOv3sMP5SAlv3GyMkxQsWff4xhE6fu7Q3oeRFc1ee1khC3Gj05ODRrkeq
         lgrVlfyVHQS0H+ZtcYMJnM4z/vyY0zMKNMNgLdBodXDoT79fZHzjyXtNsr2luO7/h8iL
         yrj10/PHT15jcZGajsUGBsdSkGziH3/fXYzbQVNPLjkWGCdmgQoK2CwqvIJby9YXL5na
         XrNINK+LXN+/SvNW3QtD6enGR03KHF3aP2SgOmj3Sb2QlR+KF/ptTKtGxIXfaLMgQRTP
         I2kcfJztOF5CuG1zWM0NYwPraM58lKIunij8sNtDHGL6j5DI+Si5hIDoYrrU6x+a9lgD
         dsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519866; x=1688111866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qX3wCILele8uoAh+Ad7WZ/vlKQvPjoQ0nfu/yoKu41g=;
        b=l3zoCdIuI0VKjkvgayf/0q97+lIlq5DkLjRkuIR1pV/hvKBpuRxh+iaMmDkplbiDKr
         1s3FD/8D1yvPTditruKmRkzAEMhN5OjdY860Z1Ooqgq6fAvQplPXZM7oeXke0WEUmYUY
         S99b2HrfkJEXu+6BSkXpg5SfwvphmiH2VDICPrZYd3Le7ddoMyiqBC1Rf+iErofWhGXb
         yHnZEM0jcYcN9BbV8+akZWaiV1njRQjBi+mgwp8Y1ulsoTLXWp2laNosce1jnqQCK0g4
         Fvza5BpWFpjDMi4mV4lux9TzcFy7GvQUfN/gttooOls+edUnnRGdS1F3M45dWrMmupR1
         tAFg==
X-Gm-Message-State: AC+VfDxDflYsEIyCcOBy0S/TXmBMs7+LZnW+64m8T5x+O00N+gDwIU7O
        Jyn/KznXyiPhlc/VQ+UGCse2nA==
X-Google-Smtp-Source: ACHHUZ5fQqJmewtqVZHAJCN32Csc6ijmMvPanRmYM/zvlBubU9p9InzqP/N0Rr0hEZYtC/nYwJ5xbA==
X-Received: by 2002:a17:907:1ca2:b0:953:834d:899b with SMTP id nb34-20020a1709071ca200b00953834d899bmr13078693ejc.29.1685519866366;
        Wed, 31 May 2023 00:57:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906341300b00965f98eefc1sm8550340ejb.116.2023.05.31.00.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:57:45 -0700 (PDT)
Message-ID: <80108a00-4416-a419-e45a-e5e4c1f111a8@linaro.org>
Date:   Wed, 31 May 2023 09:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: thermal: mediatek: Move auxdac binding
 to yaml
Content-Language: en-US
To:     matthias.bgg@kernel.org, rafael@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20230530150413.12918-1-matthias.bgg@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530150413.12918-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 17:04, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Convert the older binding to yaml syntax.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> 
>  .../bindings/thermal/mediatek,thermal.yaml    | 168 ++++++++++++++++++
>  .../bindings/thermal/mediatek-thermal.txt     |  52 ------
>  2 files changed, 168 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
>  delete mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
> new file mode 100644
> index 000000000000..7aa2bdc43567
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
> @@ -0,0 +1,168 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Thermal Sensor
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +
> +description: |
> +  The MediaTek thermal controller measures the on-SoC temperatures.
> +  This device does not have its own ADC, instead it directly controls
> +  the AUXADC via AHB bus accesses. For this reason this device needs
> +  phandles to the AUXADC. Also it controls a mux in the apmixedsys
> +  register space via AHB bus accesses, so a phandle to the APMIXEDSYS
> +  is also needed.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-thermal
> +          - mediatek,mt2712-thermal
> +          - mediatek,mt7622-thermal
> +          - mediatek,mt7986-thermal
> +          - mediatek,mt8173-thermal
> +          - mediatek,mt8183-thermal
> +          - mediatek,mt8365-thermal
> +      - items:
> +          - const: mediatek,mt7981-thermal
> +          - const: mediatek,mt7986-thermal
> +      - items:
> +          - const: mediatek,mt8516-thermal
> +          - const: mediatek,mt2701-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2

maxItems instead

> +
> +  clock-names:
> +    items:
> +      - const: therm
> +      - const: auxadc
> +
> +  resets:
> +    maxItems: 1
> +    description: Reference to the reset controller controlling the thermal controller.

You can drop description, it's obvious.

> +
> +  reset-names:
> +    items:
> +      - const: therm
> +
> +  nvmem-cells:
> +    items:
> +      - description: Calibration eFuse data. If unspecified default values are used.
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: calibration-data
> +
> +  mediatek,auxadc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A phandle to the AUXADC which the thermal controller uses.
> +
> +  mediatek,apmixedsys:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A phandle to the APMIXEDSYS controller.
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +  bank0-supply:
> +    description: Regulator node supplying voltage to the first bank
> +
> +  bank1-supply:
> +    description: Regulator node supplying voltage to the second bank

These were not present before. Mention this in commit msg. Also drop "node".

> +
> +

Just one blank line.

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - mediatek,auxadc
> +  - mediatek,apmixedsys
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/reset/mt8173-resets.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      auxadc: auxadc@11001000 {
> +        compatible = "mediatek,mt8173-auxadc";
> +        reg = <0 0x11001000 0 0x1000>;
> +        clocks = <&pericfg CLK_PERI_AUXADC>;
> +        clock-names = "main";
> +        #io-channel-cells = <1>;
> +      };
> +
> +      apmixedsys: clock-controller@10209000 {
> +        compatible = "mediatek,mt8173-apmixedsys";
> +        reg = <0 0x10209000 0 0x1000>;
> +        #clock-cells = <1>;
> +      };

Drop both examples, not really relevant to thermal. It grows the example
with code already documented somewhere else.

> +
> +      thermal: thermal@1100b000 {
> +        #thermal-sensor-cells = <1>;
> +        compatible = "mediatek,mt8173-thermal";
> +        reg = <0 0x1100b000 0 0x1000>;
> +        interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
> +        clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
> +        clock-names = "therm", "auxadc";
> +        resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
> +        reset-names = "therm";
> +        mediatek,auxadc = <&auxadc>;
> +        mediatek,apmixedsys = <&apmixedsys>;
> +        nvmem-cells = <&thermal_calibration_data>;
> +        nvmem-cell-names = "calibration-data";
> +      };
> +
> +      thermal-zones {
> +        cpu_thermal: cpu-thermal {
> +          polling-delay-passive = <1000>;
> +          polling-delay = <1000>;
> +
> +          thermal-sensors = <&thermal 0>;
> +          sustainable-power = <1500>;
> +
> +          trips {
> +            threshold: trip-point0 {
> +              temperature = <68000>;
> +              hysteresis = <2000>;
> +              type = "passive";
> +            };
> +
> +            target: trip-point1 {
> +              temperature = <85000>;
> +              hysteresis = <2000>;
> +              type = "passive";
> +            };
> +
> +            cpu_crit: cpu_crit0 {

No underscores in node names.


Best regards,
Krzysztof

