Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C195264DE69
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLOQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLOQSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:18:41 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507D32EF5E;
        Thu, 15 Dec 2022 08:18:37 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id q186so5687074oia.9;
        Thu, 15 Dec 2022 08:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkEZhSsU4mzNAr18IB/D8QJ1S3PK2BFZlhgNiiT5eFM=;
        b=IX+SW/nGQJRpUL6ywIEuFAs8jiY36WlAp8+UKiePooVcX1juYnS9lcejzRtXsB1fei
         AYjw/v75qzbukjkuBoGyK99iGk7hC8Dex9iSgkgfr/agz4ifd1kQtwO2d3C+qmMh97En
         1qoWInlBZ/vwCSwKL4+PS2DjwzSqQHBe2G6QK21O6N2fpmmX9j0MmbbhjWw88l2OCHfi
         TuK9iOiDuR6+bKrffmQ7YWw4AsPS5igFWtJM029xuggVct4gxIrSpdfPuIXbPCnKs6l4
         k+/ixJtxqZfNSkgeHnrMjlHZMY05VKx+ogNYqrMG03L1epztszkUmTrcufQim9iZa+X8
         MgJg==
X-Gm-Message-State: ANoB5pnoE6BV66R6bF0avRHOOUTLcZbgReUTKTetgCFR1p+k1oJHFd1F
        6q6GBzBYJ0RMgT+/b1KnCkyC8ClCDA==
X-Google-Smtp-Source: AA0mqf6spoTnVRTvj5p5ecPZ3cY28cZEsAev95PjmvjtRC2u0TwcpnqcegbCj1AJALyDCDAY2rrJ5g==
X-Received: by 2002:a05:6808:23d5:b0:35b:bfb4:6d64 with SMTP id bq21-20020a05680823d500b0035bbfb46d64mr16738782oib.14.1671121116363;
        Thu, 15 Dec 2022 08:18:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f37-20020a9d2c28000000b006731ecc5bedsm1262911otb.14.2022.12.15.08.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 08:18:36 -0800 (PST)
Received: (nullmailer pid 140820 invoked by uid 1000);
        Thu, 15 Dec 2022 16:18:35 -0000
Date:   Thu, 15 Dec 2022 10:18:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ep93xx: Add cirrus,ep9301-adc
 description
Message-ID: <20221215161835.GA138650-robh@kernel.org>
References: <20221214222024.951984-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214222024.951984-1-alexander.sverdlin@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:20:23PM +0100, Alexander Sverdlin wrote:
> Add device tree bindings for Cirrus Logic EP9301/EP9302 internal SoCs' ADC
> block.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  .../bindings/iio/adc/cirrus,ep9301-adc.yaml   | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml b/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
> new file mode 100644
> index 000000000000..d0fd24d1be04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/cirrus,ep9301-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP930x internal ADC
> +
> +description: |
> +  Cirrus Logic EP9301/EP9302 SoCs' internal ADC block.
> +
> +  User's manual:
> +  https://cdn.embeddedts.com/resource-attachments/ts-7000_ep9301-ug.pdf
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: cirrus,ep9301-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ep93xx-adc

Weird name for a clock. Generally is signal name or what it 
controls (e.g. bus, core, etc.). Perhaps just drop it.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        adc: adc@80900000 {
> +            compatible = "cirrus,ep9301-adc";
> +            reg = <0x80900000 0x28>;
> +            clocks = <&syscon EP93XX_CLK_ADC>;
> +            clock-names = "ep93xx-adc";
> +            interrupt-parent = <&vic1>;
> +            interrupts = <30>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 69565ac0c224..4a914d5bc2e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2027,8 +2027,10 @@ M:	Hartley Sweeten <hsweeten@visionengravers.com>
>  M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
>  F:	arch/arm/mach-ep93xx/
>  F:	arch/arm/mach-ep93xx/include/mach/
> +F:	drivers/iio/adc/ep93xx_adc.c
>  
>  ARM/CLKDEV SUPPORT
>  M:	Russell King <linux@armlinux.org.uk>
> -- 
> 2.37.3
> 
> 
