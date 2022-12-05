Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052B46425B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiLEJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiLEJWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:22:04 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC78F1275C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:22:02 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x28so231384lfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/hCkIS668u6PWnFlv85mQb/OtO7OLmAzj+V1xfIf9Q=;
        b=L1MEGbS0EtSN16BOSO11ZsuQdudg+LMzkmre+65/5/3i6zjUeXJ6uGHFCJWlzwS9QI
         e9OY1llnlDbkEf3PQ3C4FDSbMb50yTNVBuDfaiJsAEDce+k2iL6z6yVhNCrp8Oqd5w1L
         8jICKDpabdW4zP5Z2MBy75AjgsRydoWxvWMnRMFe8jdjMP2CXPSudXRbilGQ7N/uDx5k
         lOembDquEyOBFQPNvcHKbIjZlWpCea7rZw0yq/GHE07xuq92nQOKEqq53Dk+rcv1sRVY
         sL/lQFUZZ8u6NACWxcjPDPaK2CPsF7Oup5wJnmzQfvL2KBuWefAh84EWSmuK3HtEdS8R
         v9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/hCkIS668u6PWnFlv85mQb/OtO7OLmAzj+V1xfIf9Q=;
        b=clGGLey5zDKt1nemVkkLwFHFQmKqFP5SZ0UkmOudz6dsG+NtCL/Z7KC/wWeHflgtRf
         hvK26yvOr4DmqMpEjj64ZNR2bgHwt6bMiOMLL0y3UaQsn9xYUshq5YpllCodacgzLaX5
         rDmdyBQT1QbyaWyzUNcD1USFfwO25gmB3z1XQTuGhemeh4n6dwoCukyX1jUvMnhAJD+k
         1tjSvKgyHeGMunocgtQ2kMq1bVyVr9Uql1b0kWC5TfmQKz21j1KfpgZnjBo6bRyP+96b
         GG5E827FsQZ1XXoXjOyTF30bJXetaAesKaiSWhtR4k7RxtopFtWV/kxqLdsAWByHJkob
         eekA==
X-Gm-Message-State: ANoB5pk1GJr+JF6HdSZ9eHBILhrtN8cYt+g0Wk+LV71MlPzVu9iNRsJL
        ScZOAbxjP9q6nT0dF6z9KELU+g==
X-Google-Smtp-Source: AA0mqf4tfYxG7XmYk/2eQi+wnhLgLrpNUTLYv3yAtcllanEUC60fqFUsCPmYqPeEiefVbaGr6lKAvA==
X-Received: by 2002:a05:6512:31d6:b0:4b4:f497:80e1 with SMTP id j22-20020a05651231d600b004b4f49780e1mr18672204lfe.119.1670232121091;
        Mon, 05 Dec 2022 01:22:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f3-20020ac25083000000b0049c29389b98sm2051974lfm.151.2022.12.05.01.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 01:22:00 -0800 (PST)
Message-ID: <3a9b5a27-e18f-226b-065b-f09c568b4d85@linaro.org>
Date:   Mon, 5 Dec 2022 10:21:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 8/9] dt-bindings: mtd: Split ECC engine with rawnand
 controller
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
 <20221205065756.26875-9-xiangsheng.hou@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205065756.26875-9-xiangsheng.hou@mediatek.com>
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

On 05/12/2022 07:57, Xiangsheng Hou wrote:
> 1. Split MediaTek ECC engine with rawnand controller and convert to
> YAML schema.
> 2. Change the existing node name in order to match NAND controller DT
> bindings.

One patch - one logical change. Not two. This applies to all your
patches, so whenever you want to enumerate, please think twice.

> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>  .../bindings/mtd/mediatek,mtk-nfc.yaml        | 171 +++++++++++++++++
>  .../mtd/mediatek,nand-ecc-engine.yaml         |  62 ++++++
>  .../devicetree/bindings/mtd/mtk-nand.txt      | 176 ------------------
>  arch/arm/boot/dts/mt2701.dtsi                 |   2 +-
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   2 +-
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   2 +-

Do not combine bindings and DTS.

>  6 files changed, 236 insertions(+), 179 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
>  create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml b/Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
> new file mode 100644
> index 000000000000..2b1c92edc9d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
> @@ -0,0 +1,171 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/mediatek,mtk-nfc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek(MTK) SoCs raw NAND FLASH controller (NFC)
> +
> +maintainers:
> +  - Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt2701-nfc
> +      - mediatek,mt2712-nfc
> +      - mediatek,mt7622-nfc
> +
> +  reg:
> +    items:
> +      - description: Base physical address and size of NFI.
> +
> +  interrupts:
> +    items:
> +      - description: NFI interrupt
> +
> +  clocks:
> +    items:
> +      - description: clock used for the controller
> +      - description: clock used for the pad
> +
> +  clock-names:
> +    items:
> +      - const: nfi_clk
> +      - const: pad_clk
> +
> +  ecc-engine: true

I don't think this could be anything. You need to describe it, so $ref
and description.

> +
> +  partitions:
> +    $ref: mtd.yaml#

How the partitions are MTD device? Open that file and see how it should
be defined... Anyway mtd.yaml is part of nand-chip, not nand-controller.

> +
> +allOf:
> +  - $ref: nand-controller.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt2701-nfc
> +    then:
> +      patternProperties:
> +        "^nand@[a-f0-9]$":
> +          type: object

No need for type, the definition is already there through
nand-controller.yaml.

> +          properties:
> +            reg:
> +              minimum: 0
> +              maximum: 1

This is the same as other variant, so should be defined in top-level
pattern properties.

> +            nand-ecc-mode:
> +              const: hw

Ditto

> +            nand-ecc-step-size:
> +              enum: [ 512, 1024 ]> +            nand-ecc-strength:
> +              enum: [4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 28, 32, 36,
> +                     40, 44, 48, 52, 56, 60]
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt2712-nfc
> +    then:
> +      patternProperties:
> +        "^nand@[a-f0-9]$":
> +          type: object
> +          properties:
> +            reg:
> +              minimum: 0
> +              maximum: 1
> +            nand-ecc-mode:
> +              const: hw
> +            nand-ecc-step-size:
> +              enum: [ 512, 1024 ]
> +            nand-ecc-strength:
> +              enum: [4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 28, 32, 36,
> +                     40, 44, 48, 52, 56, 60, 68, 72, 80]
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt7622-nfc
> +    then:
> +      patternProperties:
> +        "^nand@[a-f0-9]$":
> +          type: object
> +          properties:
> +            reg:
> +              minimum: 0
> +              maximum: 1
> +            nand-ecc-mode:
> +              const: hw
> +            nand-ecc-step-size:
> +              const: 512
> +            nand-ecc-strength:
> +              enum: [4, 6, 8, 10, 12]
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - ecc-engine
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt2701-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        nand-controller@1100d000 {
> +            compatible = "mediatek,mt2701-nfc";
> +            reg = <0 0x1100d000 0 0x1000>;
> +            interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_LOW>;
> +            clocks = <&pericfg CLK_PERI_NFI>,
> +                     <&pericfg CLK_PERI_NFI_PAD>;
> +            clock-names = "nfi_clk", "pad_clk";
> +            ecc-engine = <&bch>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            nand@0 {
> +                reg = <0>;
> +
> +                nand-on-flash-bbt;
> +                nand-ecc-mode = "hw";
> +                nand-ecc-step-size = <1024>;
> +                nand-ecc-strength = <24>;
> +
> +                partitions {
> +                    compatible = "fixed-partitions";
> +                    #address-cells = <1>;
> +                    #size-cells = <1>;
> +
> +                    preloader@0 {
> +                        label = "pl";
> +                        read-only;
> +                        reg = <0x0 0x400000>;
> +                    };
> +                    android@400000 {
> +                        label = "android";
> +                        reg = <0x400000 0x12c00000>;
> +                    };
> +                };
> +            };
> +        };
> +
> +        bch: ecc@1100e000 {
> +            compatible = "mediatek,mt2701-ecc";
> +            reg = <0 0x1100e000 0 0x1000>;
> +            interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_LOW>;
> +            clocks = <&pericfg CLK_PERI_NFI_ECC>;
> +            clock-names = "nfiecc_clk";

You already have example of ecc in other binding, so drop from this one.

> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml b/Documentation/devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml
> new file mode 100644
> index 000000000000..b13d801eda76
> --- /dev/null


Best regards,
Krzysztof

