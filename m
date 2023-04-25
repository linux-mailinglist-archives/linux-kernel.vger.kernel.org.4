Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D0E6EE75D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjDYSKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjDYSKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:10:36 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D371619B;
        Tue, 25 Apr 2023 11:10:34 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-18ecdb1f2aaso6354496fac.1;
        Tue, 25 Apr 2023 11:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682446234; x=1685038234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rng6PHPZ/aCPXB606CKpC6fkVi0wxWyPWt9a80TUNyM=;
        b=IbQVqQEAVwRH8vE0bwdLudQJ2bfX1P0S9Zpni06YFzq2NNUHki3qD1ob5C9EaW7Pgc
         OvYLBRAzkCjuNQnrc1BWJLAL+PXMFAM3x5/f4YbxFx0jSnakOlTod8fYoiiQv9Si5Fv8
         S09ekSHK1kZJvOtRT+Vyk08q8FqQf21EUhVTR0iPQrkIC9ZbXr0vSbwWfzllr8FbY6j3
         8VDMseMQsBr3/rK5a6xbs4q6Exn6y4+Etvenan4HU7atCKFT1AzfkCIHZxadiV15eYQW
         kGpMJRa7H9sujGtMMj3eg5LmNlsx4Oe3cc9y3Ck46DzwXoYKUJ7uE7WboaZrtHx322+z
         XtJw==
X-Gm-Message-State: AAQBX9fxBvN6jZchkI9DvIry9Jm2syYN9gzSDHm22Si1MImA9qZgBBF3
        VR99Z8pfuOmV+bfbn74mrkxR8Brtpg==
X-Google-Smtp-Source: AKy350YaySHgNcVyVhpFn4mmI6SA/6Cofrcf+eQkTiMBlatn2FJ2k339LhvrpscsGqDNCP4IYrNBog==
X-Received: by 2002:a05:6870:a686:b0:177:864d:7a7e with SMTP id i6-20020a056870a68600b00177864d7a7emr9885349oam.18.1682446234059;
        Tue, 25 Apr 2023 11:10:34 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dx46-20020a05687076ae00b00183ff6b45a2sm5771218oab.10.2023.04.25.11.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:10:33 -0700 (PDT)
Received: (nullmailer pid 2031051 invoked by uid 1000);
        Tue, 25 Apr 2023 18:10:32 -0000
Date:   Tue, 25 Apr 2023 13:10:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/7] dt-bindings: display: panel: Add synaptics r63353
 panel controller
Message-ID: <20230425181032.GA2028047-robh@kernel.org>
References: <20230421154308.527128-1-dario.binacchi@amarulasolutions.com>
 <20230421154308.527128-2-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421154308.527128-2-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 05:43:02PM +0200, Dario Binacchi wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> Add documentation for "synaptics,r63353" panel.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  .../display/panel/synaptics,r63353.yaml       | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
> new file mode 100644
> index 000000000000..13e6ed39e124
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/synaptics,r63353.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synaptics R63353 based MIPI-DSI panels
> +
> +maintainers:
> +  - Michael Trimarchi <michael@amarulasolutions.com>
> +

You need a $ref to panel-common.yaml.

> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - sharp,ls068b3sx02
> +      - const: synaptics,r63353
> +
> +  avdd-supply: true
> +  dvdd-supply: true
> +  port: true
> +  reg: true
> +  reset-gpios: true
> +  backlight: true

And then drop port, reset-gpios, and backlight.

> +
> +required:
> +  - compatible
> +  - avdd-supply
> +  - dvdd-supply
> +  - reg
> +  - reset-gpios
> +
> +additionalProperties: false

And then 'unevaluatedProperties: false' here instead.

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
> +            compatible = "sharp,ls068b3sx02", "synaptics,r63353";
> +            reg = <0>;
> +            avdd-supply = <&avdd_display>;
> +            dvdd-supply = <&dvdd_display>;
> +            reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
> +
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint = <&mipi_dsi_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.32.0
> 
