Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2F5EFD53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiI2Sot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbiI2SoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:44:18 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9C11E05CB;
        Thu, 29 Sep 2022 11:43:51 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-12803ac8113so2851224fac.8;
        Thu, 29 Sep 2022 11:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Q4kEonMB6d7v5hHIJWkTHsGtsa94Xy9dbaqRdwzR/jk=;
        b=Yqx8cFhwaktXXI7UXVnilucgH0yF3+nzesFdvoeZI7Ohe6PAIyjVDXx/OcD8dBUTrd
         M/86HWaZ071o1DKPzFJhOPb5dP03yIgQ+9JEtKgAYpXayJLJSHT/Wu6OUZfpLLo9+7KG
         6wx/DmoX5FGd0lHnC59+KPc4KPvHRk8ZRCRS53NEsj7PKKmFVSDCouOT5T9VhAzgACUB
         2Fq3mEno/m5xWq2R1vL08z50QkGGIINHn2ftMAGRUUnoTAjX6rpwCRwVa1G5up41qF0B
         i9Ui3HDz5S0at3hT6LYgBB8mOIdtEKBzwIx4OQL6cz8TOWpVYkr2DBuMqDbTae/cD/dK
         85zA==
X-Gm-Message-State: ACrzQf2TQ1BVakWOaTGdKcteAa753G5Qdhpm7mjn8zeO6ivex12ytIrr
        5Q9gJhaeKfr7JJyMGkue+Q==
X-Google-Smtp-Source: AMsMyM5S3sep/kgC/lRMc+k20QdnFLy7atFiQAWFIW3HBrS8fou5vE8LlVATDpsRqUmmHdmf37CKvg==
X-Received: by 2002:a05:6870:3389:b0:131:94ab:fb63 with SMTP id w9-20020a056870338900b0013194abfb63mr2623611oae.41.1664477030662;
        Thu, 29 Sep 2022 11:43:50 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t16-20020a0568301e3000b00655bc7c4522sm95402otr.81.2022.09.29.11.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:43:50 -0700 (PDT)
Received: (nullmailer pid 2554700 invoked by uid 1000);
        Thu, 29 Sep 2022 18:43:49 -0000
Date:   Thu, 29 Sep 2022 13:43:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/30] dt-bindings: reset: Add starfive,jh7110-reset
 bindings
Message-ID: <20220929184349.GA2551443-robh@kernel.org>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929175147.19749-1-hal.feng@linux.starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929175147.19749-1-hal.feng@linux.starfivetech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 01:51:47AM +0800, Hal Feng wrote:
> Add bindings for the reset controller on the JH7110 RISC-V
> SoC by StarFive Technology Ltd.
> 
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  .../bindings/reset/starfive,jh7110-reset.yaml | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml b/Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml
> new file mode 100644
> index 000000000000..bb0010c200f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/starfive,jh7110-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 SoC Reset Controller Device Tree Bindings
> +
> +maintainers:
> +  - Emil Renner Berthing <kernel@esmil.dk>
> +  - Hal Feng <hal.feng@linux.starfivetech.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - starfive,jh7110-reset

'reg' needed? Is this a sub-block of something else?

> +
> +  "#reset-cells":
> +    const: 1
> +
> +  starfive,assert-offset:
> +    description: Offset of the first ASSERT register
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  starfive,status-offset:
> +    description: Offset of the first STATUS register
> +    $ref: /schemas/types.yaml#/definitions/uint32

These can't be implied from the compatible string?

> +
> +  starfive,nr-resets:
> +    description: Number of reset signals
> +    $ref: /schemas/types.yaml#/definitions/uint32

Why do you need this? Most bindings don't. If just to validate 'resets' 
args, then don't.


> +
> +required:
> +  - compatible
> +  - "#reset-cells"
> +  - starfive,assert-offset
> +  - starfive,status-offset
> +  - starfive,nr-resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/starfive-jh7110.h>
> +
> +    syscrg_rst: reset-controller@13020000 {
> +        compatible = "starfive,jh7110-reset";
> +        #reset-cells = <1>;
> +        starfive,assert-offset = <0x2F8>;
> +        starfive,status-offset= <0x308>;
> +        starfive,nr-resets = <JH7110_SYSRST_END>;
> +    };
> +
> +...
> -- 
> 2.17.1
> 
> 
