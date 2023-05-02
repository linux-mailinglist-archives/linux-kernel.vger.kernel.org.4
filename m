Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECE6F3E48
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjEBHPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBHPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:15:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5759A119
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:15:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-959a3e2dd27so673930066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 00:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683011728; x=1685603728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dtp1yaPEC+fRXRQf1GiiaizhZwEuiFdW7LGcT1sySog=;
        b=RdNB5sItGdZjMb3ymixPktS4fHSCxz1uwhzsP+8XITmMM1SrTlSipHywAIdBzh3EOA
         MiffZH4l7NU9LOoucBcOSTDiF1hWJOzh+oBCkdqER4v9Y2NeIRRpPvnl86FAs9XYwO6b
         dCv3iL+f/wY4Vu+HYt3u9YISRfHOJOTQQPz5H/W/+VQ9gjT+N8X4QIY8GcKfeCaUMZSG
         /uIQo0HZ0rK6SIPUahUDfKxmGCVTcPORmhmLo6xHdr2rvMQEFZKPKJqVT3Wpks9DTN4g
         Ksx10GyzlL7WCFvw70iCtPQfKKgfXYPudWbyRLYUYIGSue7Z2EVjIvtsvqVhWBOHPn3P
         DSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683011728; x=1685603728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dtp1yaPEC+fRXRQf1GiiaizhZwEuiFdW7LGcT1sySog=;
        b=hdB4QyYgClrnH65SFw/wuq5z+Hw/tazP3iuNdgpeo3jh7NCA+pBzy90ASgJokOObme
         crQ8TCJsCrRyukB5UCrxi06HEY/HfjgW1/w2qVG/7q4BOQ/web63tNw4QkpwRih+rGmp
         RhG8RZePILtZHSkkJ3wyxdCnlrXToHm9OdjHMSkXdVpMV94tm/QrL3B1idCjhlXPlG3R
         bITn5vjXUxZtSCN9sqgE4/fRE8HTM5VIcJl0454qHHsX2jCsLNdjHPB0BNRwAxae/7Hd
         pqWV+WIzaCZYchFNN9Pw9JwvP29KRgplgAYy4PolUlLjU2DHaVGHDih+dqF2TLmz/a7H
         zrrw==
X-Gm-Message-State: AC+VfDy3xD586dU1u+cvuVUSbyQU1PUPF1BT7YAq3MKVXxDQmkT++m2L
        Ukm46V5RqIvDbcphzJfojP7r8A==
X-Google-Smtp-Source: ACHHUZ4f4BV375Lqs3dUy6tpZtsKlhKa36DK6PF4+nx/fJp1fDYdxz99rUNDj1w6kFQkzu8qb667Lw==
X-Received: by 2002:a17:907:9806:b0:958:4387:5772 with SMTP id ji6-20020a170907980600b0095843875772mr14229767ejc.41.1683011727850;
        Tue, 02 May 2023 00:15:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id fp31-20020a1709069e1f00b0095251a3d66fsm15595581ejc.119.2023.05.02.00.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 00:15:27 -0700 (PDT)
Message-ID: <a7d07acf-d79e-3f67-dd48-2a5c3e840d7c@linaro.org>
Date:   Tue, 2 May 2023 09:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 1/3] dt-bindings: display: panel: Add Samsung S6D7AA0
 LCD panel controller
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230501185103.25939-1-aweber.kernel@gmail.com>
 <20230501185103.25939-2-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230501185103.25939-2-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 20:51, Artur Weber wrote:
> Add bindings for the S6D7AA0 LCD panel controller, including the
> S6D7AA0-LSL080AL02 panel used in the Samsung Galaxy Tab 3 8.0 family
> of tablets, and the S6D7AA0-LSL080AL03 and S6D7AA0-LTL101AT01 panels
> used in the Samsung Galaxy Tab A 8.0 and 9.7 2015.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changed in v2:
>  - Updated commit message
>  - Applied suggestions from Krzysztof Kozlowski

What have changed?

> Changed in v3:
>  - Correctly applied suggestions

What have changed?

> Changed in v4:
>  - Added LSL080AL03, LTL101AT01 compatibles
>  - Added description to reset-gpios
>  - Added vmipi-supply, renamed enable-supply to power-supply
> ---
>  .../display/panel/samsung,s6d7aa0.yaml        | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> new file mode 100644
> index 000000000000..918f62a78ecd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/samsung,s6d7aa0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S6D7AA0 MIPI-DSI LCD panel controller
> +
> +maintainers:
> +  - Artur Weber <aweber.kernel@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      # 1280x800 LSL080AL02 panel
> +      - samsung,s6d7aa0-lsl080al02

lsl080al02 is model number also coming from Samsung? I am afraid this
concatenated two compatibles into one...

> +      # 1024x768 LSL080AL03 panel
> +      - samsung,s6d7aa0-lsl080al03
> +      # 1024x768 LTL101AT01 panel
> +      - samsung,s6d7aa0-ltl101at01
> +
> +  reg: true
> +
> +  backlight:> +    description: |

If there is going to be new version:
Do not need '|' unless you need to preserve formatting.

> +      Backlight to use for the panel. If this property is set on panels
> +      that have DSI-based backlight control (LSL080AL03 and LTL101AT01),
> +      it overrides the DSI-based backlight.
> +
> +  reset-gpios:
> +    description: Reset GPIO pin, usually GPIO_ACTIVE_LOW.
> +
> +  power-supply:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Main power supply for the panel; the exact voltage differs between
> +      panels, a


Best regards,
Krzysztof

