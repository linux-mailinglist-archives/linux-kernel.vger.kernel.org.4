Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B586639AC8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 14:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiK0NEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 08:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiK0NEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 08:04:43 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F20C76B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 05:04:41 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u27so2535457lfc.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 05:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uv9NLyVdtUPDSFmo+p+xxyh2cAXEC6AD0ovZO/N6E8=;
        b=y3J5j5lRwuZApCxV9igxu0BtDwjD6P7LeqvkP93Q1OSK4JoMm6pTiK2WXdgHQl1vNY
         VUzsVV+r1jAKg/uI/np4YeWks10CnqV+YIOlOEQGZlxEn53yqrNWQtb3vn9yfm74I11H
         alsXNVmQsRtmzq5VN5wiaKfzVWxDdKq3Rh1XJLrujCMFJASEYvvPuQf4xrO56h7PvXKM
         /QcdPYSdcVGcBHBWyGIyjIdDPFx5RTLL9qFg52vwo0ENIx6/vHW3SurcS9kikcy02Vf7
         ggl0Cew+FoBa9prMEMbczVcJZKowMtvrnMEIM0rSbpWnk9BDzlPVXE1+NSUSBuj1UCsd
         vo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uv9NLyVdtUPDSFmo+p+xxyh2cAXEC6AD0ovZO/N6E8=;
        b=ysP3HcMpXd59wYP/7BwMQQrlIz5R+m5ge6LcR6gBKFSwQ6KyK53gODSmNNZj7lGFLu
         hka/df8FYxFdoVxU+JsQZbChh4DE+1UBTbaAZbrPGXlL0sfQIQ40SplJoX7TGKgP6KQ0
         YqbE8rmr8gq4c/Amky/8MmsytCyW9sBOSmHuv2KH7OCvYnIjSGoL37808yBBy8A3K9jz
         wRCdEtvU50/sbizzKbgtBts+/ja/9gs5dYX6y0IRXV6IC5Nv8iGHMufZEik7IOLjek2q
         zXH9Wx4pVIypCHym3S8AYS27MgIq/aVIt74LSIdyuIiw/0E8IUpmA8CTaMpOc3Gb8co+
         miug==
X-Gm-Message-State: ANoB5pngQdNIYhq/05xbUbN6E36qCKPXzQvbo/zSZXsuFyEBEDT8cfjS
        fdcahK/4oYlVMybv2eU2XmBY+A==
X-Google-Smtp-Source: AA0mqf4pCS3dyEaJ5waPK1zi9fCTtlO14uQl3Soiryfi5LpCuEPfg3klj+cVNDrbtzGueCzcv8XeBg==
X-Received: by 2002:a05:6512:20cb:b0:4a2:23f5:c1f6 with SMTP id u11-20020a05651220cb00b004a223f5c1f6mr16412604lfr.472.1669554279695;
        Sun, 27 Nov 2022 05:04:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d7-20020a196b07000000b00497a32e2576sm1280391lfa.32.2022.11.27.05.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 05:04:39 -0800 (PST)
Message-ID: <a9a47e08-1a08-abe5-1dbe-1537d3414af6@linaro.org>
Date:   Sun, 27 Nov 2022 14:04:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 05/10] dt-bindings: soc: mediatek: convert pwrap
 documentation
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
 <20221005-mt6357-support-v6-5-4f589756befa@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005-mt6357-support-v6-5-4f589756befa@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 16:10, Alexandre Mergnat wrote:
> - Convert soc/mediatek/pwrap.txt to soc/mediatek/mediatek,pwrap.yaml
> - Add syscon compatible const for mt8186 and mt8195 to match the DTS needs.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../devicetree/bindings/leds/leds-mt6323.txt       |   2 +-
>  Documentation/devicetree/bindings/mfd/mt6397.txt   |   2 +-
>  .../bindings/soc/mediatek/mediatek,pwrap.yaml      | 147 +++++++++++++++++++++
>  .../devicetree/bindings/soc/mediatek/pwrap.txt     |  75 -----------
>  4 files changed, 149 insertions(+), 77 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> index 45bf9f7d85f3..73353692efa1 100644
> --- a/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> @@ -9,7 +9,7 @@ MT6323 PMIC hardware.
>  For MT6323 MFD bindings see:
>  Documentation/devicetree/bindings/mfd/mt6397.txt
>  For MediaTek PMIC wrapper bindings see:
> -Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
>  
>  Required properties:
>  - compatible : Must be "mediatek,mt6323-led"
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 79aaf21af8e9..3bee4a42555d 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -13,7 +13,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
>  It is interfaced to host controller using SPI interface by a proprietary hardware
>  called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
>  See the following for pwarp node definitions:
> -../soc/mediatek/pwrap.txt
> +../soc/mediatek/mediatek,pwrap.yaml
>  
>  This document describes the binding for MFD device and its sub module.
>  
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> new file mode 100644
> index 000000000000..3969871eaced
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,pwrap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek PMIC Wrapper
> +
> +maintainers:
> +  - Flora Fu <flora.fu@mediatek.com>
> +  - Alexandre Mergnat <amergnat@baylibre.com>
> +
> +description:
> +  On MediaTek SoCs the PMIC is connected via SPI. The SPI master interface
> +  is not directly visible to the CPU, but only through the PMIC wrapper
> +  inside the SoC. The communication between the SoC and the PMIC can
> +  optionally be encrypted. Also a non standard Dual IO SPI mode can be
> +  used to increase speed.
> +
> +  IP Pairing
> +
> +  On MT8135 the pins of some SoC internal peripherals can be on the PMIC.
> +  The signals of these pins are routed over the SPI bus using the pwrap
> +  bridge. In the binding description below the properties needed for bridging
> +  are marked with "IP Pairing". These are optional on SoCs which do not support
> +  IP Pairing
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt2701-pwrap
> +              - mediatek,mt6765-pwrap
> +              - mediatek,mt6779-pwrap
> +              - mediatek,mt6797-pwrap
> +              - mediatek,mt6873-pwrap
> +              - mediatek,mt7622-pwrap
> +              - mediatek,mt8135-pwrap
> +              - mediatek,mt8173-pwrap
> +              - mediatek,mt8183-pwrap
> +              - mediatek,mt8186-pwrap
> +              - mediatek,mt8188-pwrap
> +              - mediatek,mt8195-pwrap
> +              - mediatek,mt8365-pwrap
> +              - mediatek,mt8516-pwrap
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-pwrap
> +              - mediatek,mt8195-pwrap
> +          - const: syscon
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: PMIC wrapper registers
> +      - description: IP pairing registers
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: pwrap
> +      - const: pwrap-bridge
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    items:
> +      - description: SPI bus clock
> +      - description: Main module clock
> +      - description: System module clock
> +      - description: Timer module clock
> +
> +  clock-names:
> +    minItems: 2
> +    items:
> +      - const: spi
> +      - const: wrap
> +      - const: sys
> +      - const: tmr
> +
> +  resets:
> +    minItems: 1
> +    items:
> +      - description: PMIC wrapper reset
> +      - description: IP pairing reset
> +
> +  reset-names:
> +    minItems: 1
> +    items:
> +      - const: pwrap
> +      - const: pwrap-bridge
> +
> +  pmic:
> +    type: object

What's here? Other schema? If not then maybe compatible? What about
description?

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +dependentRequired:
> +  resets: [reset-names]

Drop.

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8365-pwrap
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +
> +        clock-names:
> +          minItems: 4

else:
???

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/mt8135-resets.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pwrap@1000d000 {
> +            compatible = "mediatek,mt8135-pwrap";
> +            reg = <0 0x1000f000 0 0x1000>,

This does not match your unit address. No warnings when compile testing?

> +                  <0 0x11017000 0 0x1000>;
> +            reg-names = "pwrap", "pwrap-bridge";
> +            interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clk26m>, <&clk26m>;
> +            clock-names = "spi", "wrap";
> +            resets = <&infracfg MT8135_INFRA_PMIC_WRAP_RST>,
> +                     <&pericfg MT8135_PERI_PWRAP_BRIDGE_SW_RST>;
> +            reset-names = "pwrap", "pwrap-bridge";

Missing pmic. Make your example complete.


Best regards,
Krzysztof

