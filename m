Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2097260F972
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbiJ0Nme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbiJ0Nmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:42:31 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC371826D1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:42:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a5so879881qkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wM4Vw2+6axRvXSbyEhTxGQ1M8jgYDY7F1JmeCqi4DtA=;
        b=Qfmd16a8rPHB6gP9KngqB+MAJCh40aoEVl+VKG4LpOIsMyTMaJ6kekLbXfGHrYzmHh
         KP7sZEmrYaQ1YbQmwiphZcVbt41l5UarqZdInVDlS68bXkj5d7nhTshuUWSj+G6QG5mG
         KLIqEEExuoPrM6DYxSsdUosuaPcGKko102+WOCVQjFnND6Sdk+Bu1IFmYdCym3i8SBsq
         /UGu0KmViUYC68f1T1aFCvBIIIGsZKsGnny8W8IFbVCC59KDbKps8lzJafe8vieLSsBf
         GcELwM40nNCymCIr9DTqE8+EfP9CJavpm1s5zuq9IHWnL6+dzwXjAoogWOiblGBnUzJY
         bEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wM4Vw2+6axRvXSbyEhTxGQ1M8jgYDY7F1JmeCqi4DtA=;
        b=bbglFYUPI9UcU6EONBPWsQVkpS+3HeCzUpg9NI/qLEKq7w3194hANvwVyR8I+AIWMD
         WkFav4/8Q6DLuZ04aHUQ60Yv0gNDLB29XcE4fuyUOPt0yC6gPhE8Wq4Y9ZEmg7AcQqlc
         ZE1KSL6hRmCjcfBTypr80/O0YdHYdf0jQR3xaxXt7Xb3hx1XZKUJmgNhTXs4Q0Pqc+/a
         Zw8xyPyoLglstusBOIREjZFrxTaR1+zFakomfA4lqr7UF614yaCJy5VrVNCZ/RfJ+EIz
         Gu/QXbYRFvpOFPSp3rQ/1NgdD6gO/p3cOuizBbdKELi4K8GqKUawZh+CFg2x64J8EQ1N
         Petw==
X-Gm-Message-State: ACrzQf0eT6a2BZCHrZru9WwayQylDPNACggzMTejli/YPG7Bgx7kbgNc
        eifcGKC4vT/tg1upNWFg+qAYGw==
X-Google-Smtp-Source: AMsMyM44mwyfkNK9FKOzm1Oey82nDiu8X5Aw1J4Tb80n2Y//lc1hB0Auwc45uma1QaXmEIeuuzdP9A==
X-Received: by 2002:a37:98c2:0:b0:6f8:6a62:a195 with SMTP id a185-20020a3798c2000000b006f86a62a195mr8265251qke.245.1666878150053;
        Thu, 27 Oct 2022 06:42:30 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id q11-20020a37f70b000000b006ce0733caebsm995698qkj.14.2022.10.27.06.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:42:29 -0700 (PDT)
Message-ID: <9092152a-35c9-1f80-8674-ea4124a1bb36@linaro.org>
Date:   Thu, 27 Oct 2022 09:42:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 01/19] dt-bindings: ARM: MediaTek: Add new document
 bindings of MT8188 clock
Content-Language: en-US
To:     "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221024094254.29218-1-Garmin.Chang@mediatek.com>
 <20221024094254.29218-2-Garmin.Chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024094254.29218-2-Garmin.Chang@mediatek.com>
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

On 24/10/2022 05:42, Garmin.Chang wrote:
> Add the new binding documentation for system clock
> and functional clock on MediaTek MT8188.
> 
> Signed-off-by: Garmin.Chang <Garmin.Chang@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,mt8188-clock.yaml   |  70 ++
>  .../mediatek/mediatek,mt8188-sys-clock.yaml   |  55 ++
>  .../dt-bindings/clock/mediatek,mt8188-clk.h   | 733 ++++++++++++++++++
>  3 files changed, 858 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-sys-clock.yaml
>  create mode 100644 include/dt-bindings/clock/mediatek,mt8188-clk.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-clock.yaml
> new file mode 100644
> index 000000000000..49dc681e6601
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-clock.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8188-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Functional Clock Controller for MT8188
> +
> +maintainers:
> +  - Garmin Chang <garmin.chang@mediatek.com>
> +
> +description: |
> +  The clock architecture in MediaTek like below
> +  PLLs -->
> +          dividers -->
> +                      muxes
> +                           -->
> +                              clock gate
> +
> +  The devices provide clock gate control in different IP blocks.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8188-adsp_audio26m

No underscores in compatibles.

> +      - mediatek,mt8188-imp_iic_wrap_c
> +      - mediatek,mt8188-imp_iic_wrap_en
> +      - mediatek,mt8188-imp_iic_wrap_w
> +      - mediatek,mt8188-mfgcfg
> +      - mediatek,mt8188-vppsys0
> +      - mediatek,mt8188-wpesys
> +      - mediatek,mt8188-wpesys_vpp0
> +      - mediatek,mt8188-vppsys1
> +      - mediatek,mt8188-imgsys
> +      - mediatek,mt8188-imgsys_wpe1
> +      - mediatek,mt8188-imgsys_wpe2
> +      - mediatek,mt8188-imgsys_wpe3
> +      - mediatek,mt8188-imgsys1_dip_top
> +      - mediatek,mt8188-imgsys1_dip_nr
> +      - mediatek,mt8188-ipesys
> +      - mediatek,mt8188-camsys
> +      - mediatek,mt8188-camsys_rawa
> +      - mediatek,mt8188-camsys_yuva
> +      - mediatek,mt8188-camsys_rawb
> +      - mediatek,mt8188-camsys_yuvb
> +      - mediatek,mt8188-ccusys
> +      - mediatek,mt8188-vdecsys_soc
> +      - mediatek,mt8188-vdecsys
> +      - mediatek,mt8188-vencsys

Blank line here

> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    imp_iic_wrap_c: clock-controller@11283000 {

Drop the label, not used,

> +        compatible = "mediatek,mt8188-imp_iic_wrap_c";
> +        reg = <0x11283000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-sys-clock.yaml
> new file mode 100644
> index 000000000000..35962b3746e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-sys-clock.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8188-sys-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek System Clock Controller for MT8188
> +
> +maintainers:
> +  - Garmin Chang <garmin.chang@mediatek.com>
> +
> +description: |
> +  The clock architecture in MediaTek like below
> +  PLLs -->
> +          dividers -->
> +                      muxes
> +                           -->
> +                              clock gate
> +
> +  The apmixedsys provides most of PLLs which generated from SoC 26m.
> +  The topckgen provides dividers and muxes which provide the clock source to other IP blocks.
> +  The infracfg_ao provides clock gate in peripheral and infrastructure IP blocks.
> +  The mcusys provides mux control to select the clock source in AP MCU.
> +  The device nodes also provide the system control capacity for configuration.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8188-topckgen
> +          - mediatek,mt8188-infracfg_ao

Same comment.

> +          - mediatek,mt8188-apmixedsys
> +          - mediatek,mt8188-pericfg_ao
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    topckgen: syscon@10000000 {

Drop label.

> +        compatible = "mediatek,mt8188-topckgen", "syscon";
> +        reg = <0x10000000 0x1000>;
> +        #clock-cells = <1>;
Best regards,
Krzysztof

