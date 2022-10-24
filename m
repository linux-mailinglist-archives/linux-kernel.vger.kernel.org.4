Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3614860B9B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiJXUSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiJXUSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:18:03 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78F9E0C9;
        Mon, 24 Oct 2022 11:34:57 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1324e7a1284so12825839fac.10;
        Mon, 24 Oct 2022 11:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzBt4DjigXC8g0JvW9vu6ypNBWVdZc7Uwm5ix9PgU48=;
        b=l8RhsPRNCjYRjue3uFjnsWByocEsvT7aPHlQZmLfzcVH9U64nylMaX/fp8PJhbxRzV
         CKUZmWhAV5ZBxD0aGfpV9oukJeHmc3HzbEk2HV/7b07TRdlqusbZIni3geBge7NonGiu
         Gqwohtm5tlNGmfrehunugFajB7+vFDOqK6MaOq+yZWT4GhAjSPOht9LKCDuf744nslTi
         Kq+TDrveXCgm9LqIcB7lf+ZrjASSXGA7RmrZ0Gut3KkV1WI7JBaEXgwWH7/Sdv1ZXto0
         qHfE0UIYs1o/nHMHHdL1f3ilY/yxTTQk4ufl1Xxd6AynTphR76K0fH/oC9GUC1it0kiW
         UH7Q==
X-Gm-Message-State: ACrzQf2kzoc6TXirbEIoj0tgMD4MDm1bPdNtx4oGEBUawZ8d9TPBt6Vo
        1rpNhVrGo36rd+Iatni55cqkJWzkpQ==
X-Google-Smtp-Source: AMsMyM63340yiZHw0ES1B2eox2gZas5JR6G5Od4D1kId77fzF0hcyOGQovRxJgZLV1pXg57kCsy0hQ==
X-Received: by 2002:a05:6870:7020:b0:137:360d:1f7 with SMTP id u32-20020a056870702000b00137360d01f7mr21622717oae.255.1666636436938;
        Mon, 24 Oct 2022 11:33:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b24-20020a4ae818000000b004807de5c302sm293117oob.17.2022.10.24.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:33:56 -0700 (PDT)
Received: (nullmailer pid 2018985 invoked by uid 1000);
        Mon, 24 Oct 2022 18:33:57 -0000
Date:   Mon, 24 Oct 2022 13:33:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Message-ID: <20221024183357.GA2012388-robh@kernel.org>
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
 <20221021082719.18325-11-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021082719.18325-11-trevor.wu@mediatek.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:27:17PM +0800, Trevor Wu wrote:
> Add mt8188 audio afe document.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mt8188-afe-pcm.yaml        | 187 ++++++++++++++++++
>  1 file changed, 187 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8188-afe-pcm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8188-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8188-afe-pcm.yaml
> new file mode 100644
> index 000000000000..b2c548c31e4d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8188-afe-pcm.yaml
> @@ -0,0 +1,187 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt8188-afe-pcm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek AFE PCM controller for mt8188
> +
> +maintainers:
> +  - Trevor Wu <trevor.wu@mediatek.com>
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8188-afe
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: audiosys
> +
> +  mediatek,topckgen:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of the mediatek topckgen controller
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: 26M clock
> +      - description: audio pll1 clock
> +      - description: audio pll2 clock
> +      - description: clock divider for i2si1_mck
> +      - description: clock divider for i2si2_mck
> +      - description: clock divider for i2so1_mck
> +      - description: clock divider for i2so2_mck
> +      - description: clock divider for dptx_mck
> +      - description: a1sys hoping clock
> +      - description: audio intbus clock
> +      - description: audio hires clock
> +      - description: audio local bus clock
> +      - description: mux for dptx_mck
> +      - description: mux for i2so1_mck
> +      - description: mux for i2so2_mck
> +      - description: mux for i2si1_mck
> +      - description: mux for i2si2_mck
> +      - description: audio 26m clock
> +
> +  clock-names:
> +    items:
> +      - const: clk26m
> +      - const: apll1_ck
> +      - const: apll2_ck
> +      - const: apll12_div0
> +      - const: apll12_div1
> +      - const: apll12_div2
> +      - const: apll12_div3
> +      - const: apll12_div9
> +      - const: a1sys_hp_sel
> +      - const: aud_intbus_sel
> +      - const: audio_h_sel
> +      - const: audio_local_bus_sel
> +      - const: dptx_m_sel
> +      - const: i2so1_m_sel
> +      - const: i2so2_m_sel
> +      - const: i2si1_m_sel
> +      - const: i2si2_m_sel
> +      - const: adsp_audio_26m
> +
> +patternProperties:
> +  "^mediatek,etdm-in[1-2]-chn-disabled$":
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    maxItems: 16
> +    description: |

Don't need '|'

> +      Specify which input channel should be disabled, so the data of
> +      specified channel won't be outputted to memory.

I'm not clear on what each of the 16 entries represents. What's index 0, 
1, 2, etc.?

> +    items:
> +      enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

maximum: 15


> +
> +  "^mediatek,etdm-in[1-2]-mclk-always-on-rate-hz$":
> +    description: Specify etdm in mclk output rate for always on case.
> +
> +  "^mediatek,etdm-out[1-3]-mclk-always-on-rate-hz$":
> +    description: Specify etdm out mclk output rate for always on case.
> +
> +  "^mediatek,etdm-in[1-2]-multi-pin-mode$":
> +    type: boolean
> +    description: if present, the etdm data mode is I2S.
> +
> +  "^mediatek,etdm-out[1-3]-multi-pin-mode$":
> +    type: boolean
> +    description: if present, the etdm data mode is I2S.
> +
> +  "^mediatek,etdm-in[1-2]-cowork-source$":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      etdm modules can share the same external clock pin. Specify
> +      which etdm clock source is required by this etdm in moudule.
> +    enum:
> +      - 0 # etdm1_in
> +      - 1 # etdm2_in
> +      - 2 # etdm1_out
> +      - 3 # etdm2_out
> +
> +  "^mediatek,etdm-out[1-2]-cowork-source$":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      etdm modules can share the same external clock pin. Specify
> +      which etdm clock source is required by this etdm out moudule.
> +    enum:
> +      - 0 # etdm1_in
> +      - 1 # etdm2_in
> +      - 2 # etdm1_out
> +      - 3 # etdm2_out
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - resets
> +  - reset-names
> +  - mediatek,topckgen
> +  - power-domains
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    afe: afe@10b10000 {
> +        compatible = "mediatek,mt8188-afe";
> +        reg = <0x10b10000 0x10000>;
> +        interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH 0>;
> +        resets = <&watchdog 14>;
> +        reset-names = "audiosys";
> +        mediatek,topckgen = <&topckgen>;
> +        power-domains = <&spm 13>; //MT8188_POWER_DOMAIN_AUDIO
> +        clocks = <&clk26m>,
> +                 <&topckgen 72>, //CLK_TOP_APLL1
> +                 <&topckgen 73>, //CLK_TOP_APLL2
> +                 <&topckgen 186>, //CLK_TOP_APLL12_CK_DIV0
> +                 <&topckgen 187>, //CLK_TOP_APLL12_CK_DIV1
> +                 <&topckgen 188>, //CLK_TOP_APLL12_CK_DIV2
> +                 <&topckgen 189>, //CLK_TOP_APLL12_CK_DIV3
> +                 <&topckgen 191>, //CLK_TOP_APLL12_CK_DIV9
> +                 <&topckgen 83>, //CLK_TOP_A1SYS_HP
> +                 <&topckgen 31>, //CLK_TOP_AUD_INTBUS
> +                 <&topckgen 32>, //CLK_TOP_AUDIO_H
> +                 <&topckgen 69>, //CLK_TOP_AUDIO_LOCAL_BUS
> +                 <&topckgen 81>, //CLK_TOP_DPTX
> +                 <&topckgen 77>, //CLK_TOP_I2SO1
> +                 <&topckgen 78>, //CLK_TOP_I2SO2
> +                 <&topckgen 79>, //CLK_TOP_I2SI1
> +                 <&topckgen 80>, //CLK_TOP_I2SI2
> +                 <&adsp_audio26m 0>; //CLK_AUDIODSP_AUDIO26M
> +        clock-names = "clk26m",
> +                      "apll1_ck",
> +                      "apll2_ck",
> +                      "apll12_div0",
> +                      "apll12_div1",
> +                      "apll12_div2",
> +                      "apll12_div3",
> +                      "apll12_div9",
> +                      "a1sys_hp_sel",
> +                      "aud_intbus_sel",
> +                      "audio_h_sel",
> +                      "audio_local_bus_sel",
> +                      "dptx_m_sel",
> +                      "i2so1_m_sel",
> +                      "i2so2_m_sel",
> +                      "i2si1_m_sel",
> +                      "i2si2_m_sel",
> +                      "adsp_audio_26m";

It's good if the examples include optional properties so we at least 
have some validation the schema matches the DTS.

> +    };
> +
> +...
> -- 
> 2.18.0
> 
> 
