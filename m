Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6370B62CDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiKPWat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiKPWaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:30:46 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7F25656E;
        Wed, 16 Nov 2022 14:30:45 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id v81so20208651oie.5;
        Wed, 16 Nov 2022 14:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbpACnaXmrPREOrzmgwFDvqtUVn/DHRnFRgcTOhyLb8=;
        b=Ia0Claf+K+ZMOHC6Gv+4kGq19jjgDXHzMLXaNSzalUIMMJ7taQ32jJFPWVE0347Dm1
         f2KOGOQqk2NNfRJwhDeA1aceDHX4rLrXl7m838HuUbk+gAuNQ2YvS1YWpLMCZ5HxQaz6
         FYnmIyxr4MpG2yPdUaHRR/4vFagpDAJ0CcTUrxkzDKI/KVeFiVdrBnapy4NAc8eg52kg
         FWB3XMFDuqziPfQGKtJgM/KxzfCz1o/VZOtq/JIs535xydhs5f7jJUJZwAzhcWDbJhls
         lMk1bj7fyCsKN7IasM96Unm2DYH4i5o9+p7KeiQvDZBv3YBc1FYd3W9z2p96M0I64L6b
         O4/A==
X-Gm-Message-State: ANoB5plRxL70LXj9A/MuHKIt4Om9LzS+NAL5dN3L3gFynWBlWBaRuuNo
        DeAV44dnotPjf+c376If5Q==
X-Google-Smtp-Source: AA0mqf697XFyAspx8GJWNLHGqzqrI1rGojs7MliM5qrGwGc7c97ydk3ctzaQesak540j/eDZCFheTw==
X-Received: by 2002:a05:6808:17a6:b0:35b:13ca:23a0 with SMTP id bg38-20020a05680817a600b0035b13ca23a0mr2844923oib.12.1668637844468;
        Wed, 16 Nov 2022 14:30:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c25-20020a9d6c99000000b0066c73061d4bsm7074041otr.54.2022.11.16.14.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:30:43 -0800 (PST)
Received: (nullmailer pid 1144141 invoked by uid 1000);
        Wed, 16 Nov 2022 22:30:45 -0000
Date:   Wed, 16 Nov 2022 16:30:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     krzysztof.kozlowski@linaro.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com, broonie@kernel.org,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        fancer.lancer@gmail.com, gerg@linux-m68k.org, gsomlo@gmail.com,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        p.yadav@ti.com, p.zabel@pengutronix.de, piotrs@cadence.com,
        rdunlap@infradead.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH v8 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Message-ID: <20221116223045.GA1130586-robh@kernel.org>
References: <e9d8c14d-38b3-0401-7bfc-b2bd7ab36c52@linaro.org>
 <20221116193940.67445-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116193940.67445-1-blarson@amd.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:39:40AM -0800, Brad Larson wrote:
> Add support for the AMD Pensando Elba SoC System Resource chip
> using the SPI interface.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> v8:
>  - Apply review request changes and picked the two unique examples
>    for the 4 chip-selects as one has the reset control support and
>    the other an interrupt.  Missed the --in-reply-to in git
>    send-email for v7, included in this update.

No, you haven't. By default in git, you don't have to do anything. See 
--thread and --no-chain-reply-to options. If you are messing with 
--in-reply-to, you are doing it wrong.

Please resend the whole series properly threaded.

> 
> v7:
>  - Use system-controller for the device with four chip-selects
>    connected over spi.
>  - Delete child by moving reset-controller into the parent.
>  - Updated and used dtschema-2022.11 and yamllint-1.28.0
> 
> v6:
>  - Expand description, rename nodes and change compatible usage
> 
> v5:
>  - Change to AMD Pensando instead of Pensando
> 
> v4:
>  - Change Maintained to Supported
> 
>  .../bindings/mfd/amd,pensando-elbasr.yaml     | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> new file mode 100644
> index 000000000000..622c93402a86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/amd,pensando-elbasr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Pensando Elba SoC Resource Controller
> +
> +description: |
> +  AMD Pensando Elba SoC Resource Controller functions are
> +  accessed with four chip-selects.  Reset control is on CS0.

One device with 4 chip-selects? Then I'd expect 'reg = <0 1 2 3>;'

Hard to say more because I don't have the whole thread nor remember what 
exactly we discussed before. That was 100s of bindings ago...

> +
> +maintainers:
> +  - Brad Larson <blarson@amd.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amd,pensando-elbasr
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        num-cs = <4>;
> +
> +        system-controller@0 {
> +            compatible = "amd,pensando-elbasr";
> +            reg = <0>;
> +            spi-max-frequency = <12000000>;
> +            #reset-cells = <1>;
> +        };
> +
> +        system-controller@2 {
> +            compatible = "amd,pensando-elbasr";
> +            reg = <2>;
> +            spi-max-frequency = <12000000>;
> +            interrupt-parent = <&porta>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> -- 
> 2.17.1
> 
> 
