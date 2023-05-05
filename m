Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5D76F8AAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjEEVXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjEEVXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:23:44 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B980A3;
        Fri,  5 May 2023 14:23:43 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6a5ec0d8d8aso1445206a34.2;
        Fri, 05 May 2023 14:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683321822; x=1685913822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwdhZdKqyhuaiAmSNIpDtAl7IfbJSYB+daUBPaVksik=;
        b=Nur8IoEtyk1cPVgkS2VkZbhFlJ3JLwjf+J6+ePhisi0lrioVX3+mtOf6gKjGIQTk0W
         9iosGnbdIsj538QfScDq6WTAAdRKmF0T1XxpbylZ/Im8gvAjfIJ7SWQVij+JzUv0iJ7A
         3vBDyKateDck3Na3VKd/TOeyDkhddK7qjON5y1oc1/dGLgsVUorYVRvivpz9qSq7QrgI
         ZPh8XBDoKSeAOz8fkC6vE8cJcedj8k/MmvoaqfPTtpjBPZBWaiEAarn+Y/ZcXxq2jBxn
         4GsWDz+x9DoA7LdJACaZVN5vuFlEsV+humMkLt237naLtz2J5d+af0JH7Lus9O0pLMN9
         jgJA==
X-Gm-Message-State: AC+VfDwzt0nRSI3tlqDZq7lz4vXoc/4uFnC/ApjkadYjZlZ6akh6NUzv
        p3w+HC1juHXBhrBzVb7SBg==
X-Google-Smtp-Source: ACHHUZ5aScoYRGug8/b0YvTj0vwFXK6C0WhOO7mcg4F0Md4vayUd4T69DoSmGy8fggvRw39K2vP6pg==
X-Received: by 2002:a05:6808:46:b0:38d:f03f:935b with SMTP id v6-20020a056808004600b0038df03f935bmr1325252oic.24.1683321822415;
        Fri, 05 May 2023 14:23:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id es10-20020a056808278a00b0038edc69490bsm3185925oib.10.2023.05.05.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:23:41 -0700 (PDT)
Received: (nullmailer pid 3587437 invoked by uid 1000);
        Fri, 05 May 2023 21:23:40 -0000
Date:   Fri, 5 May 2023 16:23:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 1/3] dt-bindings: display: panel: Add Samsung S6D7AA0
 LCD panel controller
Message-ID: <20230505212340.GA3585766-robh@kernel.org>
References: <20230501185103.25939-1-aweber.kernel@gmail.com>
 <20230501185103.25939-2-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501185103.25939-2-aweber.kernel@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 08:51:01PM +0200, Artur Weber wrote:
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
> Changed in v3:
>  - Correctly applied suggestions
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

Dual license please.

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
> +      # 1024x768 LSL080AL03 panel
> +      - samsung,s6d7aa0-lsl080al03
> +      # 1024x768 LTL101AT01 panel
> +      - samsung,s6d7aa0-ltl101at01
> +
> +  reg: true
> +
> +  backlight:
> +    description: |
> +      Backlight to use for the panel. If this property is set on panels
> +      that have DSI-based backlight control (LSL080AL03 and LTL101AT01),
> +      it overrides the DSI-based backlight.
> +
> +  reset-gpios:
> +    description: Reset GPIO pin, usually GPIO_ACTIVE_LOW.
> +
> +  power-supply:
> +    description: |
> +      Main power supply for the panel; the exact voltage differs between
> +      panels, and is usually somewhere around 3.3-5v.
> +
> +  vmipi-supply:
> +    description: VMIPI supply, usually 1.8v.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "samsung,s6d7aa0-lsl080al02";
> +            reg = <0>;
> +            power-supply = <&display_3v3_supply>;
> +            reset-gpios = <&gpf0 4 GPIO_ACTIVE_LOW>;
> +            backlight = <&backlight>;
> +        };
> +    };
> +
> +...
> -- 
> 2.40.1
> 
