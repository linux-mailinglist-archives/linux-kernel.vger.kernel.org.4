Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81345EB50E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiIZXEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIZXEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:04:43 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC722B27;
        Mon, 26 Sep 2022 16:04:40 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id m130so10075152oif.6;
        Mon, 26 Sep 2022 16:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=s/U+J/VqHjqU5tkNQcNIG/8Dz7n7mcUbdGFIysM2eco=;
        b=sB+/jYIYSWvwbkt2RzGJe37jYRnhyE6vuD+9UlOVIxTSQKToKEgzJimixvq1+pGi9O
         Bkk6MZDfunmEWxTF0j38A1urFK4NCWKh9xsB26M+Lo3pzzBkgyCnx3ENdWrpT/Dj2QKZ
         PmC1NR/iBvOt/FhhHUbsB8l7vnztJPIf/u3i4qq9L08EimMFSUvyxJbVljuVzB1SQf+H
         YkMAhx7wLKiiY0mGh84Begzm49Kn5RjP3Ojvypr8q8DoWT0QJslq+0aaTT9WSjIsErEC
         AtJq5AnlVGrc7rfw2VhxG7l7LjqnSem0zcEc6/u00hPaZLco2w62DeYogHFgxVLJB50o
         NQ6w==
X-Gm-Message-State: ACrzQf1BLwASgbGx2i6+5S5IKJkmvJkNoBIitqcvmqkQrgV36m4UhKac
        UaiTZ8qW0slNaI/6KSHLFNbeqSk4rA==
X-Google-Smtp-Source: AMsMyM769LYZrCueL24Ix6kcxcAjb9myULNY8414CmypzDcwRECYzz6a4K5mqZSrx/H6aFYdlIF0+g==
X-Received: by 2002:a05:6808:1cb:b0:350:39f1:84ca with SMTP id x11-20020a05680801cb00b0035039f184camr554335oic.278.1664233479869;
        Mon, 26 Sep 2022 16:04:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m23-20020a056870a11700b0010830c24aaasm9902447oae.56.2022.09.26.16.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:04:39 -0700 (PDT)
Received: (nullmailer pid 3132557 invoked by uid 1000);
        Mon, 26 Sep 2022 23:04:38 -0000
Date:   Mon, 26 Sep 2022 18:04:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alex Helms <alexander.helms.jy@renesas.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, geert+renesas@glider.be
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Message-ID: <20220926230438.GA3128861-robh@kernel.org>
References: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
 <20220923205251.1387-2-alexander.helms.jy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923205251.1387-2-alexander.helms.jy@renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 01:52:50PM -0700, Alex Helms wrote:
> Add dt bindings for the Renesas ProXO oscillator.
> 
> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
> ---
>  .../bindings/clock/renesas,proxo.yaml         | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,proxo.yaml b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> new file mode 100644
> index 000000000..79d62f399
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/renesas,proxo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas ProXO Oscillator Device Tree Bindings
> +
> +maintainers:
> +  - Alex Helms <alexander.helms.jy@renesas.com>
> +
> +description:
> +  Renesas ProXO is a family of programmable ultra-low phase noise
> +  quartz-based oscillators.
> +
> +properties:
> +  '#clock-cells':
> +    const: 0
> +
> +  compatible:
> +    enum:
> +      - renesas,proxo-xp
> +
> +  reg:
> +    maxItems: 1
> +
> +  renesas,crystal-frequency:
> +    description: Internal crystal frequency, default is 50000000 (50MHz)
> +    $ref: /schemas/types.yaml#/definitions/uint32

'clock-frequency' doesn't work here?

Anything else needs '-hz' suffix.

> +
> +required:
> +  - '#clock-cells'
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      proxo: clock-controller@55 {
> +        compatible = "renesas,proxo-xp";
> +        reg = <0x55>;
> +        #clock-cells = <0>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 350102355..d52a8a5d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16080,6 +16080,11 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
>  F:	drivers/iio/adc/rzg2l_adc.c
>  
> +RENESAS PROXO CLOCK DRIVER
> +M:	Alex Helms <alexander.helms.jy@renesas.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> +
>  RESET CONTROLLER FRAMEWORK
>  M:	Philipp Zabel <p.zabel@pengutronix.de>
>  S:	Maintained
> -- 
> 2.30.2
> 
> 
