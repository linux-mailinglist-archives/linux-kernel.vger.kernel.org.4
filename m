Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB7869618E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjBNK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBNK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:58:15 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6051C9ED8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:58:14 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bk16so15165078wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gx40Fv/hr96gRU+c/9uu5X2ZcDhXizr9d7Ess0reKt0=;
        b=koNK4VCvQvRc2CjyayjNk6lDJ+hKgxHPWE3G8ao18g5rTt5qjABVk0RAAtOTNbm4D4
         X+pvM4v3S4flbb63FkXX90tgE7VP3qq6IqO5/aI8Bdr5IrHj4aCImbkI/wE3pD3JCUV1
         B6LKtlYlnFEXVtB0d8XMq7gvMt/MSnP1EYib2H/lV8wIL7XxumfqhXz9AneJvCdI2Zq1
         +MjLTMMKAaK0gxdWLgEP/YiuC0g4sEss7phI+UsxNoNQMiPabyerKWfX/lMpPZgx5p1O
         rEZz1WWtNNZo4YtTuCLYx3hZtGn8pmfqcT9U8IoYB5Mse2wfHrSEzd6Bpx2UDGKtJFGR
         oj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gx40Fv/hr96gRU+c/9uu5X2ZcDhXizr9d7Ess0reKt0=;
        b=ecIZyVWhhlby6eYxQDn2/de/Lcodhp9Lin5BJbu2GDgH49TTUwnesrWDHLRW2Ff2L3
         rcBk5nPMEzujz4JskFbccFIXNQG7oFzGl/CJlFWA1225VD1e4hCu0Yj5UX454j5iUJcT
         0fo6gEfdihi/MzeMiFpdhNs+nk6NRLAD3tFj6RjPM024AWjBPWSEGrlnbj+W8YnKCI1C
         4WVoQJGoKXhEyUkqvuPXZ4z1G4MjOgvEqQGJ6hGpQ+4oxG8UtQn/KszU8y31ibrN+5dz
         GkGfMqKen7jpCOz4L2Ezmb+DA1+Zt3N7WcoUWPjLBFLdgYuJiWi/yfdgtEStCij9JpuZ
         WBcA==
X-Gm-Message-State: AO0yUKWvNhZ3suqr6vI4N5NtnR785Y7hW1r3NS5cFx5Z+tTAviAd4L40
        wo+F1jwmm4XF+Blhs9uWgPJpUg==
X-Google-Smtp-Source: AK7set/wETknM6nyMS91eRgNnkHhD4f9C7g93FAnMO+buvH0MuMDeL1A34df/ZNdhAy2Ajz7xf2A7Q==
X-Received: by 2002:adf:dd45:0:b0:2c3:db98:3e87 with SMTP id u5-20020adfdd45000000b002c3db983e87mr1784868wrm.20.1676372292992;
        Tue, 14 Feb 2023 02:58:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bg1-20020a05600c3c8100b003e118684d56sm18172368wmb.45.2023.02.14.02.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 02:58:12 -0800 (PST)
Message-ID: <46d5b6af-23e1-4178-83bc-b4a435b1426e@linaro.org>
Date:   Tue, 14 Feb 2023 11:58:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: sound: ep93xx: Add I2S and AC'97
 descriptions
Content-Language: en-US
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 00:21, Alexander Sverdlin wrote:
> Add device tree bindings for Cirrus Logic EP93xx internal SoCs' I2S and
> AC'97 controllers.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  .../bindings/sound/cirrus,ep9301-ac97.yaml    | 47 ++++++++++++++
>  .../bindings/sound/cirrus,ep9301-i2s.yaml     | 63 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,ep9301-ac97.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-ac97.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-ac97.yaml
> new file mode 100644
> index 000000000000..bfa5d392f525
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-ac97.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/cirrus,ep9301-ac97.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus EP93xx AC'97 Controller
> +
> +description: |
> +  The AC’97 Controller includes a 5-pin serial interface to an external audio
> +  codec.
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +

missing ref to dai-common.yaml

> +properties:
> +  compatible:
> +    const: cirrus,ep9301-ac97
> +
(...)

> diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
> new file mode 100644
> index 000000000000..b47d28dc8389
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/cirrus,ep9301-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus EP93xx I2S Controller
> +
> +description: |
> +  The I2S controller is used to stream serial audio data between the external
> +  I2S CODECs’, ADCs/DACs, and the ARM Core. The controller supports I2S, Left-
> +  and Right-Justified DSP formats.
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +

ref to dai-common

> +properties:
> +  compatible:
> +    const: cirrus,ep9301-i2s
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3

maxItems instead

> +
> +  clock-names:
> +    items:
> +      - const: mclk
> +      - const: sclk
> +      - const: lrclk


The clk suffixes are quite redundant. Don't these inputs have some
meaningful name?

> +
> +required:
> +  - compatible
> +  - '#sound-dai-cells'
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2s: i2s@80820000 {
> +        compatible = "cirrus,ep9301-i2s";
> +        #sound-dai-cells = <0>;
> +        reg = <0x80820000 0x100>;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <28>;
> +        clocks = <&syscon 29
> +                  &syscon 30
> +                  &syscon 31>;

That's one phandle, but you want three, so <>, <>, <>.


Best regards,
Krzysztof

