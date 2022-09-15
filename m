Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E279A5B9A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiIOMJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiIOMI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:08:59 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1EB86FD4;
        Thu, 15 Sep 2022 05:08:47 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id n83so1935681oif.11;
        Thu, 15 Sep 2022 05:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CWexIgbA3IRIwyMqeKFp2DYo/QKwW457pkqopssZBso=;
        b=8QGKCc7l4aWtoyszUTSZ3pQH33poc76OsyYsBgf3wd0woQi4/w5ecb7j8j0Hzghx59
         u0Iqzz+Bd6frKur3fB0o1IXpoatgZaezyOcmj1wZUmlqhTdLtG1E+DOgaIBaS/ippRvS
         YQS3YX6mh2kWJ3t/TFMGIPLt4mGflC+raB+gpTqV0qIXHmYXF0WEd2MYlShX6m7m37xh
         zO0onefH6EgZLVvKRhcvO5BIFI64TK1wnMBLBgqZrnX8dpIwK4bUKVmgwZDKfbWaTLw7
         nkefoRrKf33N9gKx+Svkziw0LXPIck7cjaxt8MsztFFHzATApViSp6P91n+TiQqdioGw
         6awQ==
X-Gm-Message-State: ACgBeo0xIvGgb2mP3iC6fF8c2eVWpEN1ltlM5xhDFgjxWL1dT5TEToXH
        TlIal8g4X7K0E8VdDfV5j3rD5YmXWA==
X-Google-Smtp-Source: AA6agR5dB/lKeEMCwtyIAsd5I1+hpRgDUrSLNVqzCErkZDE/p7to/702NAT8rsqbA8ikleCipXFM2A==
X-Received: by 2002:a05:6808:1a98:b0:34f:8b40:6263 with SMTP id bm24-20020a0568081a9800b0034f8b406263mr4073595oib.265.1663243725872;
        Thu, 15 Sep 2022 05:08:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id en8-20020a056870078800b0012c52bd4369sm602362oab.19.2022.09.15.05.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:08:45 -0700 (PDT)
Received: (nullmailer pid 1008120 invoked by uid 1000);
        Thu, 15 Sep 2022 12:08:44 -0000
Date:   Thu, 15 Sep 2022 07:08:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alex Helms <alexander.helms.jy@renesas.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, geert+renesas@glider.be
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Message-ID: <20220915120844.GA996386-robh@kernel.org>
References: <20220914211809.22500-1-alexander.helms.jy@renesas.com>
 <20220914211809.22500-2-alexander.helms.jy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914211809.22500-2-alexander.helms.jy@renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 02:18:08PM -0700, Alex Helms wrote:
> Add dt bindings for the Renesas ProXO oscillator.
> 
> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
> ---
>  .../bindings/clock/renesas,proxo.yaml         | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,proxo.yaml b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> new file mode 100644
> index 000000000..2ae131431
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/renesas,versaclock7.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas ProXO Oscillator Device Tree Bindings
> +
> +maintainers:
> +  - Alex Helms <alexander.helms.jy@renesas.com>
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  Renesas ProXO is a family of programmable ultra-low phase noise 
> +  quartz-based oscillators.

Are they all the same from a s/w standpoint. If not you need specific 
compatibles for the differences. 

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
> +  renesas,xtal:
> +    description: Internal crystal frequency, default is 50000000 (50MHz)
> +    $ref: /schemas/types.yaml#/definitions/uint32

Use 'clock-frequency'.

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
> +    i2c@0 {

i2c {

> +      reg = <0x0 0x100>;

Drop

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      proxo: proxo@55 {

clock-controller@55

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
