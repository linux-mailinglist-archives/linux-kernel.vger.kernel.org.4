Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8161E6B10EF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCHSVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCHSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:21:16 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB94CF9AF;
        Wed,  8 Mar 2023 10:21:13 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id t22so12819720oiw.12;
        Wed, 08 Mar 2023 10:21:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678299672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K9M/WGoEfXxcoKbYphxqAy7GDsCNUya755BhLVY2l0=;
        b=RvS8y/iuLGaYfZkFX05j2rjtwCxz93KHBoTI6W7FJqY+1emMhGKNrc6k9QgwF6/Hkm
         qRUm4uJ5dykyEoHRLgS5EwuaVd9huuVUEpU1BHl7gDtP23uZc0N5hTnIiiJZVpVq8p5G
         NmCxIrMyKjdtBpMGQYoprcXuai4Ha0T/zyQJv/j77QR1xCUEkEjc/QtmifTy9PTUJJ7V
         YzyhVq83quDFSvJFxoje20wAoia3kpyCDq1nOEINCNsCE32Ovhy/bGgBkBtVG5n7nOfR
         RnE5Mfw4+qkJeufPl+TNnsQyTAvmN67XazDclm3s8u+kWKjCqpvAphUirtOrL8AHIT9L
         gTkA==
X-Gm-Message-State: AO0yUKWlH5E4g68y8T9nwP7t+rbIQz8yBZp1emxSZE9akUaX540c3l9k
        zoIKpql9puoJYdBmjUOLGQ==
X-Google-Smtp-Source: AK7set96SwfHtjO5POTOqFp+IXOvf8KHwTGt8xR4WiBhJ3lblZG49hQldEdmfsp3/f768W93V0f2Pw==
X-Received: by 2002:a05:6808:21aa:b0:37b:8dde:4a98 with SMTP id be42-20020a05680821aa00b0037b8dde4a98mr1523367oib.0.1678299672366;
        Wed, 08 Mar 2023 10:21:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g5-20020a05687085c500b001724d631f92sm6505603oal.30.2023.03.08.10.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:21:11 -0800 (PST)
Received: (nullmailer pid 3539159 invoked by uid 1000);
        Wed, 08 Mar 2023 18:21:11 -0000
Date:   Wed, 8 Mar 2023 12:21:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Jean Delvare <jdelvare@suse.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Ldd-Mlp <ldd-mlp@list.ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: media: i2c: add lm3560 binding
Message-ID: <20230308182111.GA3533712-robh@kernel.org>
References: <20230308095209.14700-1-clamor95@gmail.com>
 <20230308095209.14700-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308095209.14700-2-clamor95@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:52:08AM +0200, Svyatoslav Ryhel wrote:
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/media/i2c/ti,lm3560.yaml         | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ti,lm3560.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ti,lm3560.yaml b/Documentation/devicetree/bindings/media/i2c/ti,lm3560.yaml
> new file mode 100644
> index 000000000000..b3c2ccb83a30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ti,lm3560.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ti,lm3560.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LM3560 Synchronous Boost Flash Driver
> +
> +maintainers:
> +  - Daniel Jeong <gshark.jeong@gmail.com>
> +  - Ldd-Mlp <ldd-mlp@list.ti.com>
> +
> +description: |
> +  The LM3560 is a 2-MHz fixed frequency synchronous boost
> +  converter with two 1000-mA constant current drivers for
> +  high-current white LEDs. The dual highside current sources
> +  allow for grounded cathode LED operation and can be tied
> +  together for providing flash currents at up to 2 A through
> +  a single LED. An adaptive regulation method ensures the
> +  current for each LED remains in regulation and maximizes
> +  efficiency.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ti,lm3559
> +          - ti,lm3560
> +
> +  reg:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    maxItems: 1
> +
> +  ti,peak-current:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 0x20, 0x40, 0x60]
> +    default: 0x60
> +    description: |
> +      Peak current can be set to 4 values 1.6A (0x00),
> +      2.3A (0x20), 3.0A (0x40) and 3.6A (0x60).

Pretty sure we have common properties for this.

> +
> +  ti,max-flash-timeout:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 32
> +    maximum: 1024
> +    default: 1024
> +    description: |
> +      Maximum flash timeout in ms with step 32ms.

And this too.

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +patternProperties:
> +  "^led@[01]$":
> +    type: object
> +    description: |
> +      Properties for a connected LEDs.
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 1
> +
> +      ti,max-flash-current:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 62500
> +        maximum: 1000000
> +        default: 1000000
> +        description: |
> +          Maximum current in flash mode in uA with step 62500uA.

Or maybe it's these per LED settings that are common.

BTW, anything with units, should have a standard unit suffix.

> +
> +      ti,max-torch-current:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 31250
> +        maximum: 250000
> +        default: 250000
> +        description: |
> +          Maximum current in tourch mode in uA with step 31250uA.
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash-led@53 {

led-controller@53

> +            compatible = "ti,lm3559";
> +            reg = <0x53>;
> +
> +            enable-gpios = <&gpio 219 GPIO_ACTIVE_HIGH>;
> +
> +            ti,peak-current = <0>;
> +            ti,max-flash-timeout = <1024>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            led@0 {
> +                reg = <0>;
> +
> +                ti,max-flash-current = <562500>;
> +                ti,max-torch-current = <156250>;
> +            };
> +
> +            led@1 {
> +                reg = <1>;
> +
> +                ti,max-flash-current = <562500>;
> +                ti,max-torch-current = <156250>;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.37.2
> 
