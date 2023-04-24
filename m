Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497BE6ED219
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjDXQIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjDXQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:08:17 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050707DA1;
        Mon, 24 Apr 2023 09:08:17 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1879fc89f5eso1884821fac.0;
        Mon, 24 Apr 2023 09:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682352496; x=1684944496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6smFu5JD2lNei+Q07P9yUaeXn3pY+Qnrxg8SLiUIomA=;
        b=V0DcHFkCNISiWzAEl8SwBTQfggmUnwEkpfYsWt9e2GKNWy3Ot72EqGt2AwRPXyX51M
         v09v9yB0vtmbZAa6lRDwoaNGV9d13ypzyrOg7SSa8PUBNlGutPxN4rpNVM+8jrWa8mSb
         z2Fa3So+QlLbKwzNLIEOsdba4bcs2h0IpQ+aR+xDe1hGlRvyJot5xA51rVZaiie4E7d8
         3L2oWz295dWmS9ntX1am+oDv4YLFjyiWAFCQFpmvurWSkZ2K0tLUGVi59xPdXVR2rBwk
         t5FWxCIgsgbWvIVp1oJ0LPHTdT+VeU/MZw8q+Ere4lFsKqia/gB8d+JdI4iTRwbC7+If
         Qi3Q==
X-Gm-Message-State: AAQBX9cRZv1l7yIEBpcRfpXD9P7FQeKuUX9TKK7b3gFgpfS3uCL3gy37
        oncE4hjneAMF4bhJ9asfaSX5MFjjLA==
X-Google-Smtp-Source: AKy350aONDWvf0fxkXysYAbO1714d7kyNsGXyTrOBCTCVrw4BldLaehiZv/LU9Hsj06Mp+RWY9EdLg==
X-Received: by 2002:a05:6870:3412:b0:184:433c:a175 with SMTP id g18-20020a056870341200b00184433ca175mr9036307oah.22.1682352496169;
        Mon, 24 Apr 2023 09:08:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s14-20020a4aad4e000000b0051ffe0fe11bsm4956749oon.6.2023.04.24.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:08:15 -0700 (PDT)
Received: (nullmailer pid 2755671 invoked by uid 1000);
        Mon, 24 Apr 2023 16:08:15 -0000
Date:   Mon, 24 Apr 2023 11:08:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/43] dt-bindings: spi: Add DT bindings ep93xx spi
Message-ID: <20230424160815.GD2701399-robh@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-17-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-17-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 03:34:32PM +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../devicetree/bindings/spi/spi-ep93xx.yaml   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-ep93xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-ep93xx.yaml b/Documentation/devicetree/bindings/spi/spi-ep93xx.yaml
> new file mode 100644
> index 000000000000..e09ab50629fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-ep93xx.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-ep93xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: EP93xx SoC SPI controller
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"

Drop quotes.

> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  compatible:
> +    items:
> +      - const: cirrus,ep9301-spi
> +
> +  reg:
> +    items:
> +      - description: SPI registers region
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: SPI Controller reference clock source
> +
> +  clock-names:
> +    items:
> +      - const: ep93xx-spi.0

Does not sound like a clock name... Just drop unless you expect to add 
more clocks.

> +
> +  cs-gpios: true
> +
> +  use_dma:

Don't use '_' in property names. Custom properties need a vendor prefix.

However, this looks like a driver setting rather than h/w config. Why 
not always use DMA or transfers above X size. IOW, let the driver figure 
it out.

> +    type: boolean
> +    items:

'items' is for an array, but this is a boolean.

> +      - description: Flag indicating that the SPI should use dma
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +    spi0: spi@808a0000 {
> +        compatible = "cirrus,ep9301-spi";
> +        reg = <0x808a0000 0x18>;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <21>;
> +        clocks = <&syscon EP93XX_CLK_SPI>;
> +        clock-names = "ep93xx-spi.0";
> +        cs-gpios = <&gpio5 2 0>;
> +        use_dma;
> +    };
> +
> +...
> -- 
> 2.39.2
> 
