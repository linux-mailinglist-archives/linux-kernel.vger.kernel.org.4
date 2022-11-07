Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8240761EFE4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiKGKDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiKGKDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:03:04 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11BE186D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:03:02 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u11so15401129ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RM9kb3J3wnBPlGqqjFbWWIP1RllNoZN+0SAF5Yq6Zr4=;
        b=zMGUtZu0IWNgDwJWBtEWy+3qUj/xZTiJLH3eT3yNKcOiC0kvdCoCfBnbH1cJLBnnjl
         78/SC5P1u0YdAdrVaJTsU1Ycn8In4GnViWJn/G/x7qA2x2GhGO7S3pfdg3MuxGB+ttQG
         EsZ9Ry4krL/6ZuqYd9u2jpHP+gADgE1CWK7uzdTM2MNs0Hp7hSAYGx55rldPnMl39vOo
         AZsoNaHN2Ualx8AYYKKHE7XOeTVDZLlI3jSLcVavcUL/QW1AavkAELbHnGQKEz5gFIZ2
         IKC0P8DkF9tWPQx7i6uRDGNa9bMHsEMOYpi8pYcU0/ZfmGGAhd6Mm5tGhAr37xRagpdj
         r/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RM9kb3J3wnBPlGqqjFbWWIP1RllNoZN+0SAF5Yq6Zr4=;
        b=nQgry6QNGaEzcGpYbsfRRonyy2KECiMSROMU6dRhw0e5Clh+FHXcuimxrbguw+Hhbv
         /kX3B/HlBuHVDYVS6El6RRf61mGhfcPtwQG4GkD06TMECSn0mym8yT/jEs5gdWCdnI0M
         pltNnrPS118FQr8x4KTzpTmRbDc1dzJj0VO4FSPLgx4Cllqtarjy5h1L4djY+/R9Y3WF
         7o5COo9X6BUMUUVFY/5SGaDg40st9Gy9de3Yby6NYcPIcm5XVS3+wqV03tB44Z6FXAS6
         q1vg+/3NifuTrZrutOfb2UyzEroyo0LXmnGv0lSTDuYknlYMmVtLMdj1GVvDXF+5Rjgy
         AZkw==
X-Gm-Message-State: ACrzQf2Npx82WsfYU6MLauCLUXsrxuM7c6e7oicfyHlN5Bca+h+c78QV
        DrcZP2YJAZLcFXNu9X0boM06qg==
X-Google-Smtp-Source: AMsMyM45Nd4u9vh1fgVyjMywXV/syU6IzBqqpec13oIq/b2S10en3aGDNpC5XgVj+PXwKcO/NWFW4A==
X-Received: by 2002:a2e:80c4:0:b0:277:fa0:d500 with SMTP id r4-20020a2e80c4000000b002770fa0d500mr5209054ljg.51.1667815381318;
        Mon, 07 Nov 2022 02:03:01 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id t3-20020a19ad03000000b004a459799bc3sm1150870lfc.283.2022.11.07.02.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 02:03:00 -0800 (PST)
Message-ID: <ab8528cc-fa5d-35da-0c6e-cdebc694f646@linaro.org>
Date:   Mon, 7 Nov 2022 11:02:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 02/12] dt-bindings: display: mediatek: add MT8195 hdmi
 bindings
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, stuart.lee@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        mac.shen@mediatek.com, linux-phy@lists.infradead.org
References: <20220919-v3-0-a803f2660127@baylibre.com>
 <20220919-v3-2-a803f2660127@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919-v3-2-a803f2660127@baylibre.com>
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

On 04/11/2022 15:09, Guillaume Ranquet wrote:
> Add mt8195 SoC bindings for hdmi and hdmi-ddc
> 
> On mt8195 the ddc i2c controller is part of the hdmi IP block and thus has no
> specific register range, power domain or interrupt, making it simpler
> than its the legacy "mediatek,hdmi-ddc" binding.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  .../bindings/display/mediatek/mediatek,hdmi.yaml   | 61 ++++++++++++++++++----
>  .../display/mediatek/mediatek,mt8195-hdmi-ddc.yaml | 51 ++++++++++++++++++
>  2 files changed, 101 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
> index bdaf0b51e68c..9710b7b6e9bf 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
> @@ -21,6 +21,7 @@ properties:
>        - mediatek,mt7623-hdmi
>        - mediatek,mt8167-hdmi
>        - mediatek,mt8173-hdmi
> +      - mediatek,mt8195-hdmi
>  
>    reg:
>      maxItems: 1
> @@ -29,18 +30,12 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    items:
> -      - description: Pixel Clock
> -      - description: HDMI PLL
> -      - description: Bit Clock
> -      - description: S/PDIF Clock
> +    minItems: 4

Drop minItems, it's not needed when equal to maxItems.

> +    maxItems: 4
>  
>    clock-names:
> -    items:
> -      - const: pixel
> -      - const: pll
> -      - const: bclk
> -      - const: spdif
> +    minItems: 4

Drop minItems, it's not needed when equal to maxItems.


> +    maxItems: 4
>  
>    phys:
>      maxItems: 1
> @@ -58,6 +53,9 @@ properties:
>      description: |
>        phandle link and register offset to the system configuration registers.
>  
> +  power-domains:
> +    maxItems: 1
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>  
> @@ -86,9 +84,50 @@ required:
>    - clock-names
>    - phys
>    - phy-names
> -  - mediatek,syscon-hdmi
>    - ports
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8195-hdmi
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: APB
> +            - description: HDCP
> +            - description: HDCP 24M
> +            - description: Split HDMI
> +        clock-names:
> +          items:
> +            - const: hdmi_apb_sel
> +            - const: hdcp_sel
> +            - const: hdcp24_sel
> +            - const: split_hdmi
> +
> +      required:
> +        - power-domains
> +    else:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Pixel Clock
> +            - description: HDMI PLL
> +            - description: Bit Clock
> +            - description: S/PDIF Clock
> +
> +        clock-names:
> +          items:
> +            - const: pixel
> +            - const: pll
> +            - const: bclk
> +            - const: spdif
> +
> +      required:
> +        - mediatek,syscon-hdmi
> +
>  additionalProperties: false
>  
>  examples:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
> new file mode 100644
> index 000000000000..2dc273689584
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek HDMI DDC for mt8195
> +
> +maintainers:
> +  - CK Hu <ck.hu@mediatek.com>
> +  - Jitao shi <jitao.shi@mediatek.com>
> +
> +description: |
> +  The HDMI DDC i2c controller is used to interface with the HDMI DDC pins.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8195-hdmi-ddc
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ddc

Unless you expect it to grow, I propose to drop clock-names. It's not
useful when the name is the same as name of hardware.

Best regards,
Krzysztof

