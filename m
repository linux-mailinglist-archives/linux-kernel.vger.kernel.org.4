Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDC76480C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLIKPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLIKPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:15:43 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4841631F85
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:15:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p8so6268904lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 02:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlvfkF2ZFYuFQpxBnIpN0aFK4kWr5DwTIlUFg1Sxm10=;
        b=iB4EZnlRNYR9XsnIqBEIPTBPZ2s9ORP0ZU5q5t8qP0qfsE1V1SD5UJIlwcXU5e4BFm
         hjg7dt4F/HGMUh1zYORVDvLvPrIp/6gj8VRMgbyztp9Az9iX1Ai5mGFp2w0jGh3YGAJO
         F8Pxd+pYMnHp6HwgbBk50hJtPrL0eMR6xW9Sz3tun7+qq7RXyM5F3z1Py3XYMwUC/s+F
         cSn2n099UHSkGl9tfbf81M/Kde3wmliN5v1T8ZtIhVfoYl5Zmu0VZmd7tI5vllaz/xPF
         AcF4lNgNIeUKyfuNLO8SiBLRDSFz0bjaGezpNvxlk0M8xzw2u4pp012hc0iPN/6r5bi3
         rPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlvfkF2ZFYuFQpxBnIpN0aFK4kWr5DwTIlUFg1Sxm10=;
        b=a8gj+kW5lDy6O1UiZqLdMFKE/i3GJHbHUgtP9vxmG8XHqHkcWCOOxyJPqc6ptRszD8
         B8im4ewQuPA5KS1qUddGNSCRi1qGaVj3K3QvY8SXOKwHS1x0R/weoi4BPdhzNdIWApCW
         dMWsR0AHXeiuw4js2u16gjwV/Amxuh8XLJGG0/fLZ6RTyHkyW/0PjMoS496NTG1ibdf4
         Crcndm3Q6399DuO+zn3joPgdLF794xUn4f3Rems6gZ4QkFfCNyxg7Wp3hIjEwKhKYq7B
         uWKZcOo62BGQjkN5UfNFQ+NX+mvyktMoZdb5njYumQxhyXIZb76Yyx2HFLCfgFrLvuGf
         1SMw==
X-Gm-Message-State: ANoB5pnC5oerubGbiIv10NwXB1OnCeTKyUwIr0k03K+EV7OUO2eax9E4
        uGs5uUqwXEwuT4gYecUCl9QMtg==
X-Google-Smtp-Source: AA0mqf4PV54SFqHCdc0zs8HGqB2QDXjAeslsLxGBJT/SW25dK9NlvFl04szs2leJ2cSdPYldgZKSqg==
X-Received: by 2002:a05:6512:10c3:b0:4b5:34c4:78a4 with SMTP id k3-20020a05651210c300b004b534c478a4mr1695393lfg.30.1670580939515;
        Fri, 09 Dec 2022 02:15:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25053000000b004b5789ecdd7sm191371lfm.274.2022.12.09.02.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 02:15:39 -0800 (PST)
Message-ID: <d7d9f3c7-b3e3-1e13-a80f-c7bf7b38a5b1@linaro.org>
Date:   Fri, 9 Dec 2022 11:15:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221208033148.21866-1-trevor.wu@mediatek.com>
 <20221208033148.21866-11-trevor.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221208033148.21866-11-trevor.wu@mediatek.com>
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

On 08/12/2022 04:31, Trevor Wu wrote:
> Add mt8188 audio afe document.

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../devicetree/bindings/sound/mt8188-afe.yaml | 196 ++++++++++++++++++
>  1 file changed, 196 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8188-afe.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8188-afe.yaml b/Documentation/devicetree/bindings/sound/mt8188-afe.yaml
> new file mode 100644
> index 000000000000..6ab26494d924
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8188-afe.yaml


This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Comment was about filename matching compatible, so with vendor prefix.

> @@ -0,0 +1,196 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt8188-afe.yaml#
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
> +    minItems: 1
> +    maxItems: 16
> +    description:
> +      By default, all data received from ETDM pins will be outputed to
> +      memory. etdm in supports disable_out in direct mode(w/o interconn).
> +      User can specify the channel ID which they hope dropping and then
> +      the specified channel won't be seen on memory.

So we know what are the IDs but it's a mystery what are the values.
Especially with unique values - how any of these should case that
channel "won't be seen in memory"?

> +    uniqueItems: true
> +    items:
> +      minimum: 0
> +      maximum: 15
> +
> +  "^mediatek,etdm-in[1-2]-mclk-always-on-rate-hz$":
> +    description: Specify etdm in mclk output rate for always on case.

How is it different than assigned-clock-rates?

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
> +    description:
> +      etdm modules can share the same external clock pin. Specify
> +      which etdm clock source is required by this etdm in moudule.

typo: module

> +    enum:
> +      - 0 # etdm1_in
> +      - 1 # etdm2_in
> +      - 2 # etdm1_out

I don't get. This suggests that etdm1_out can be clock source of
etdm-in1. Or etdm1_in can be clock source of etdm-in1... It does not
make sense...

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
Best regards,
Krzysztof

