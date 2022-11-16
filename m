Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B462B500
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiKPIUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiKPIU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:20:26 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0735521BE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:20:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id r12so28335952lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20QIWTDhxs5zpxfjzQDwrXucngPgVQ+JOvZAayYi6hk=;
        b=ddqPFfDM59WUbI9URyKo7Wu9Vum3BpFnaox+hRouL9QzJqOse+muzQwkNGtVMlZ5Zs
         wxElcJ87TL+rGlJ73eCySG5L4L9VBc9asBWfuy/rfOgkkHWrPqbRH/BESzcX51Mj1xoG
         BclxmopYl0NXcYviJ9ogHWuvf80+psdHS8TUSzN6d+dDX/sKSrcDpp9rjzl1gWQ0yF2Q
         bnRxatjHV7HgjKNp3lhDacF8O9SNnoyyEke2jZeDhcOtRMuTwR6xyKtR7/lmDwoqBNJp
         E42sIi/PYUnzUulpPUoVshXgVheNlYOClOs6YSF+l/ndAZE5Ilq6VP9kEj33+/VK9ngm
         Zy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20QIWTDhxs5zpxfjzQDwrXucngPgVQ+JOvZAayYi6hk=;
        b=n9X2ZpX6lQyjLPEH/rnRgx9USLUZ7c7tSoliQxd+Yihcz3iFV1QUoZj8qihNWcE1jS
         +UIVpj8MLKrgIl/Sj1mTDc6cm+y/yeyvxlgY07GWr6aFq0QCGMc3rsdmyqFnmWlG36eE
         U1y4Hq22t9eam7D+YnVidO+NeVTLhPq/v8McqvkJ99d7vN3lku9jFyPe3IJBiIwIn6ej
         B85AvdVVKopnF8yjqUNFCORVI3ZzGb1LTTP2KAtKQNGH+HR2Ntu43PflGGD8qmppIJCZ
         KOwO513oq9buTlOTckG27R080HmHH2ekQvEbhKgsifE9GMHbuLujHX8dWvj8luHstUwH
         w2bA==
X-Gm-Message-State: ANoB5pl8wkmJwwVR5qRd4qqFEv6JLOwa+KLOQvlxMAwXhXy1I/YeZK4X
        uZvf0daV4G4JP7E2CmdmQSepgA==
X-Google-Smtp-Source: AA0mqf6Z7C14uz2nU+dWtpSFYMdf+a93HGeoSotCFIFvFrqMsbC8WgrVJY+5FdIxsakJ8XPLIIzwQQ==
X-Received: by 2002:ac2:4ac9:0:b0:4ac:102e:5c93 with SMTP id m9-20020ac24ac9000000b004ac102e5c93mr7889381lfp.352.1668586823210;
        Wed, 16 Nov 2022 00:20:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g16-20020a19e050000000b00494a11c5f52sm2503698lfj.256.2022.11.16.00.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:20:22 -0800 (PST)
Message-ID: <e9fd112f-0fd2-e833-8687-9a256c307842@linaro.org>
Date:   Wed, 16 Nov 2022 09:20:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dtbindings: clock: Add bindings for Renesas PhiClock
Content-Language: en-US
To:     Alex Helms <alexander.helms.jy@renesas.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, geert+renesas@glider.be
References: <20221115192625.9410-1-alexander.helms.jy@renesas.com>
 <20221115192625.9410-2-alexander.helms.jy@renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115192625.9410-2-alexander.helms.jy@renesas.com>
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

On 15/11/2022 20:26, Alex Helms wrote:
> Add dt bindings for the Renesas PhiClock clock generator.
> 

Subject: drop second, redundant "bindings"

> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
> ---
>  .../bindings/clock/renesas,phiclock.yaml      | 81 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml b/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
> new file mode 100644
> index 000000000..2b36534d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml

Filename based on compatible.

> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/renesas,phiclock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas PhiClock Clock Generator Device Tree Bindings

Drop "Device Tree Bindings"

> +
> +maintainers:
> +  - Alex Helms <alexander.helms.jy@renesas.com>
> +
> +description: |
> +  The Renesas PhiClock is a programmable I2C clock generator that provides
> +  1 reference output and 2 clock outputs.
> +
> +  The driver supports spread spectrum but only if all configurations use the

Driver as in Linux driver? Drop entire paragraph. Bindings are about
hardware, not driver.

> +  same spread spectrum parameters. If your configuration uses spread spectrum,
> +  you must include renesas,ss-amount-percent, renesas,ss-modulation-hz, and
> +  renesas,ss-direction in the device tree.
> +
> +properties:

compatible goes always first. Start your schema from example-schema.yaml.

> +  '#clock-cells':
> +    const: 1
> +
> +  clock-names:
> +    items:
> +      - const: xin-clkin

Just "xin" or entirely drop.

> +
> +  clocks:
> +    const: 1
> +
> +  compatible:
> +    enum:
> +      - renesas,9fgv1006
> +
> +  reg:
> +    maxItems: 1
> +
> +  renesas,ss-amount-percent:
> +    description: Spread spectrum absolute amount as hundredths of a percent, e.g. 150 is 1.50%.

What? If this is percent then it cannot be hundreds of percent. Percent
is percent. Use appropriate units.
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> +    minimum: 0
> +    maximum: 500
> +
> +  renesas,ss-modulation-hz:
> +    description: Spread spectrum modulation rate in Hz
> +    minimum: 30000
> +    maximum: 63000
> +
> +  renesas,ss-direction:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Spread spectrum direction
> +    enum: [ down, center ]
> +
> +required:
> +  - clock-names
> +  - '#clock-cells'
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ref25: ref25m {
> +      compatible = "fixed-clock";
> +      #clock-cells = <0>;
> +      clock-frequency = <25000000>;
> +    };

Drop, it's obvious, isn't it?

> +

Best regards,
Krzysztof

