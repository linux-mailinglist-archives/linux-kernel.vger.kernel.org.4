Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3562C62F3DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbiKRLiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241626AbiKRLhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:37:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861D227C;
        Fri, 18 Nov 2022 03:37:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00AF36245B;
        Fri, 18 Nov 2022 11:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EE9C433D6;
        Fri, 18 Nov 2022 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668771470;
        bh=5fnUH/20FcSJcxT1WGsEq266c8E14n+LjI+HE0ek2ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJijciL9ADRGHAsfttqDczSUiqVFYXRnh5NdUWla3VTiyR3eThLcOTEEThFH6b7F7
         SXiFfN2Nuao9PbQHsMVJQ0gVdIdBhq2Gy489hXP3JFNNdSw+J3ZydkDwRytVmb+aKG
         Mp7+8LNuHPc18Gn3FV0XhY7XqdYrpP+EEOctHrPMtTdL6G9l2COQDDmoQyJd3UeI6k
         Z1QLdvJoa2+/Mi38nRkESZO7Y3oOBz1Hsn923yhHTTr8tjGvpWRsjWnHShWwO6OUPJ
         uY6bC8eAn/3Qn5JZwNPctdmhiqzBo4bVvvXZk+JLUtQHJSH83at9dmvfVhrwnXtJff
         7QRVxbM+Sq/Ow==
Date:   Fri, 18 Nov 2022 11:37:44 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: sifive,ccache0: Support StarFive
 JH7110 SoC
Message-ID: <Y3duiJguYE6VrVLP@spud>
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-5-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118011714.70877-5-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 09:17:10AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> This cache controller is also used on the StarFive JH7110 SoC.

"... and configured identically to that of the FU740"?
Anyways,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../devicetree/bindings/riscv/sifive,ccache0.yaml          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml b/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
> index bf3f07421f7e..262d1d49ce25 100644
> --- a/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
> @@ -25,6 +25,7 @@ select:
>            - sifive,ccache0
>            - sifive,fu540-c000-ccache
>            - sifive,fu740-c000-ccache
> +          - starfive,jh7110-ccache
>  
>    required:
>      - compatible
> @@ -37,6 +38,7 @@ properties:
>                - sifive,ccache0
>                - sifive,fu540-c000-ccache
>                - sifive,fu740-c000-ccache
> +              - starfive,jh7110-ccache
>            - const: cache
>        - items:
>            - const: microchip,mpfs-ccache
> @@ -86,6 +88,7 @@ allOf:
>              enum:
>                - sifive,fu740-c000-ccache
>                - microchip,mpfs-ccache
> +              - starfive,jh7110-ccache
>  
>      then:
>        properties:
> @@ -105,7 +108,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: sifive,fu740-c000-ccache
> +            enum:
> +              - sifive,fu740-c000-ccache
> +              - starfive,jh7110-ccache
>  
>      then:
>        properties:
> -- 
> 2.38.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
