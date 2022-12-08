Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0607646A62
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLHIXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLHIXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:23:19 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41986FD3D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:23:18 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s8so909860lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPuBgj1yabvOJ7+IGzwNtRsPpYRu7YfyBOxzUD3UuBw=;
        b=Q1FNM2pSCaZYh3ABN/8xmcVo1qkp440IkUqCxf4aOJ6X9OdMSffMh2DKy1kXWgHrOw
         +Ls+9UsiUTXgAHBUEnD/hAEXz9cGyI7eA2QJ0jouZJdAoIDIap4BqU4TWJ8B/SRMtjEs
         AmqO5RL96AHElBCfNvrWELZuIqDnaQ0nh2ta/vLttgDdvZIMpWFAb8cdOGEWlXMgbqhB
         MlkspRoABTOJ5OoXWdqtejntFaDye+085sWwduV8edXs2MZALEMjav5GR01izJKYsjcs
         5r31ZscJJBAEso6G96lgpLJPXR2LywTSBuz2TaprZOcaq8tevZlf09fuEHKTWYmTLxkT
         op9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPuBgj1yabvOJ7+IGzwNtRsPpYRu7YfyBOxzUD3UuBw=;
        b=JhKsCiO3m2UreSZbcdQvtzO+KauXmSxGJtty9AvSpicpS3U38cQvBcQCAoscX0xRP6
         DbftRJ28MfLjLCbDQ2G7mbOG9CGD7o9kMZko3IBLt/IIOriijw8JuMRKAoGrIxRV1QjE
         pqNng0RR72rZyMjCyKBolVDbFNYtkLf5zt9LCEKdCEp4URTsAqLWuFK7hVcUI/Qf/HyC
         UfxR3njZEb17uK/1A9nw5lqDko6ZoLpcXE1eBm1suCmlR/f3GZJV7qCg58pdO0wWvRP5
         xoD2S5CGteJ+vihH4uuGsvoEssBhL7FSx03KRd2CePDvePPSCzFDB4+nn/fzQn9UhGuT
         o73Q==
X-Gm-Message-State: ANoB5pkPNow5oLI641KE2dG+tdz2to9P4homZ7nLETKoL2o6R+LkZWkt
        GgYn8GtJa+ol68zn+OmYtOY7kQ==
X-Google-Smtp-Source: AA0mqf7bIu8b4cGA9tgzIXjo+isdrK+OBdu95kGpnZSbwyBHjIhCA1SpnULiT6DdGmrgF65HSi4pOg==
X-Received: by 2002:a05:6512:3e13:b0:4b5:3f5f:da27 with SMTP id i19-20020a0565123e1300b004b53f5fda27mr9942065lfv.666.1670487796636;
        Thu, 08 Dec 2022 00:23:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi35-20020a0565120ea300b004ac6a444b26sm3227727lfb.141.2022.12.08.00.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:23:16 -0800 (PST)
Message-ID: <1ceecc45-43bd-49bd-68f5-57294093d731@linaro.org>
Date:   Thu, 8 Dec 2022 09:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 15/16] dt-bindings: soc: socionext: Add UniPhier DWC3
 USB glue layer
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-16-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207055405.30940-16-hayashi.kunihiko@socionext.com>
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

On 07/12/2022 06:54, Kunihiko Hayashi wrote:
> Add DT binding schema for components belonging to the platform-specific
> DWC3 USB glue layer implemented in UniPhier SoCs.
> 
> This USB glue layer works as a sideband logic for the host controller,
> including core reset, vbus control, PHYs, and some signals to the
> controller.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-dwc3-glue.yaml         | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
> new file mode 100644
> index 000000000000..1b5585a5a3a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-dwc3-glue.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier SoC DWC3 USB3.0 glue layer
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +description: |+
> +  DWC3 USB3.0 glue layer implemented on Socionext UniPhier SoCs is
> +  a sideband logic handling signals to DWC3 host controller inside
> +  USB3.0 component.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - socionext,uniphier-pro4-dwc3-glue
> +          - socionext,uniphier-pro5-dwc3-glue
> +          - socionext,uniphier-pxs2-dwc3-glue
> +          - socionext,uniphier-ld20-dwc3-glue
> +          - socionext,uniphier-pxs3-dwc3-glue
> +          - socionext,uniphier-nx1-dwc3-glue
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':

Use consistent quotes - either ' or "

> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^reset-controller@[0-9a-f]+$":
> +    $ref: /schemas/reset/socionext,uniphier-glue-reset.yaml#
> +
> +  "^regulator@[0-9a-f]+$":
> +    $ref: /schemas/regulator/socionext,uniphier-regulator.yaml#
> +
> +  "^phy@[0-9a-f]+$":
> +    oneOf:
> +      - $ref: /schemas/phy/socionext,uniphier-usb3hs-phy.yaml#
> +      - $ref: /schemas/phy/socionext,uniphier-usb3ss-phy.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +

You need to fix
Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
example. I propose to drop usb-glue@65b00000 from that file. It's not
relevant to that example.

Best regards,
Krzysztof

