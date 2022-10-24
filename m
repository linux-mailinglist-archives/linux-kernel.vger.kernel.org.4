Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDD860B5B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJXShi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiJXShB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:37:01 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A1C2A94A;
        Mon, 24 Oct 2022 10:19:03 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1322d768ba7so12615720fac.5;
        Mon, 24 Oct 2022 10:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq07o9wuJNbHrKGzjon5pt7apzh/WdzpNrzbg1YpjS4=;
        b=wZk6ZxKg36+QQ/BW/8Dhgrb6mfb/EfzXwP/1x82TFIdiX4Gen5HkZgkB2gmB+56WFX
         c7B/Yu3XwyO5Mq3givB3QVGQi6Aw83d3RdYBo4/gtehcnJTkCYugIaDm1ZcVDfXUVaQW
         KvbPK6XTPNDe7SnbCpxznZDwvB6SjDLhseQZDtPsShvuZvZS+vZ+wLy48EuvGy6jjSGw
         G+jnnbLhZctrcCslcadUFmdnHwzYmfPglulA23gs4G6QmR1pc0V/XDKevFwVscU8NtG8
         cy/W66uCF+CCdNnaLfFbZ3YLCkmJN/i3+7cSPJ/ZY6L9ZMFPsaZrG7Y1a5B7bw73Yc/d
         KY9g==
X-Gm-Message-State: ACrzQf3Xi3Dq27Wb1n0IowiDc8xm5RPBPYhTUFYXYYfQ/ou3HZrWkpLw
        54jgpOLb+W/38GOEIdNkB35xrzb8HA==
X-Google-Smtp-Source: AMsMyM6DHnB5RVEx0H9gu8efBVp7KAoVrKdz8YGCQy4wIdNRQnB1jn4NzXCzMJWeQrB9ov3HW1w3hA==
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id er8-20020a056870c88800b0012c7f3bd67dmr21854729oab.229.1666629770315;
        Mon, 24 Oct 2022 09:42:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ce5-20020a056830628500b006619dd066fbsm4579560otb.5.2022.10.24.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:42:49 -0700 (PDT)
Received: (nullmailer pid 1896101 invoked by uid 1000);
        Mon, 24 Oct 2022 16:42:51 -0000
Date:   Mon, 24 Oct 2022 11:42:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT6190 regulator
Message-ID: <20221024164251.GA1890861-robh@kernel.org>
References: <1666320059-17544-1-git-send-email-u0084500@gmail.com>
 <1666320059-17544-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666320059-17544-2-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 10:40:58AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add devicetree binding for Richtek RT6190 4-Switch buckboost controller.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v2:
> - Rename binding filename to 'richtek,rt6190.yaml'
> 
> ---
>  .../bindings/regulator/richtek,rt6190.yaml         | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml
> new file mode 100644
> index 00000000..dced404
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rt6190.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT6190 4-Switch BuckBoost controller
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  The RT6190 is 4-Switch BuckBoost controller designed for converting input
> +  voltage to output voltage that can be equal to, higher or lower than input
> +  voltage. It operates with wide input voltage range from 4.5V to 36V, and
> +  the output voltage can be set from 3V to 36V by external FB pin. It's commonly
> +  used for the application like as BuckBoost bus upply, docking station and USB

typo: upply

> +  power delivery product.
> +
> +  Datasheet is available at
> +  https://www.richtek.com/assets/product_file/RT6190/DS6190-02.pdf
> +
> +allOf:
> +  - $ref: regulator.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rt6190
> +
> +  reg:
> +    maxItems: 1
> +
> +  enable-gpios: true

       maxItems: 1

> +
> +  wakeup-source: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  regulator-allowed-modes:
> +    description: |
> +      buck allowed operating mode
> +        0: PSM mode (light load Power Saving Mode)
> +        1: FCCM mode (Forced-CCM mode)

       maxItems: 2

> +    items:
> +      enum: [0, 1]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      regulator@2c {
> +        compatible = "richtek,rt6190";
> +        reg = <0x2c>;
> +        wakeup-source;
> +        interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
> +        enable-gpios = <&gpio26 1 GPIO_ACTIVE_HIGH>;
> +        regulator-name = "richtek,rt6190-buckboost";
> +        regulator-min-microvolt = <3000000>;
> +        regulator-max-microvolt = <32000000>;
> +        regulator-min-microamp = <306000>;
> +        regulator-max-microamp = <12114000>;
> +        regulator-allowed-modes = <0 1>;
> +      };
> +    };
> -- 
> 2.7.4
> 
> 
