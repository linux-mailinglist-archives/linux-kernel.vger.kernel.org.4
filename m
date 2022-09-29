Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2AC5EF928
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiI2PgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiI2PeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:34:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25F01C00DD;
        Thu, 29 Sep 2022 08:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90A7C61227;
        Thu, 29 Sep 2022 15:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665A5C433C1;
        Thu, 29 Sep 2022 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465623;
        bh=+81bAoJyqC0ALTsR9tloD4BNLwube6I1s0Bczot21Xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hq1NG+ARl0FcweRYLLtiF+pfBV56zxl92+e8Jox7KnYupArV9QTRLdTUAEo6Biyp2
         Dsd0cqplyrzh72f33CMTb8897MZ3CI2BaHj3lStC8CQEZQh10IOrCMHjLfLGuhj+ZR
         UhxQbnRj3matK9cJbNK93AB7UgQjPOi6+lVfGsJhpHl+jKFAUFSI0vD7MS0vlH70O6
         tUZ5cbTv990KaRXWXYrYcc6WHaH+pVw6T8ZmYFUykcSlot6bwKYiJuhrW8YKf0YLVG
         qsaSIMXcDY6vJTGqGQl/cdNG9pZPn8oxDv+K71DJqQlxdh3peuH4TbSXUJYbKHgsP/
         jIZTsKGUKPU0w==
Date:   Thu, 29 Sep 2022 16:33:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v1 04/30] dt-bindings: sifive-l2-cache: Support StarFive
 JH71x0 SoCs
Message-ID: <YzW60PDwnJ7GeLYK@spud>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929143225.17907-5-hal.feng@linux.starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929143225.17907-5-hal.feng@linux.starfivetech.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:31:59PM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> This cache controller is also used on the StarFive JH7100 and JH7110
> SoCs.

Ditto this patch, hopefully [0] will have landed as 6.1 material
before you get around to an actual v2.

Thanks,
Conor

0 - https://lore.kernel.org/linux-riscv/20220913061817.22564-1-zong.li@sifive.com/

> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> index ca3b9be58058..ba29ecfd3a92 100644
> --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> @@ -24,6 +24,8 @@ select:
>          enum:
>            - sifive,fu540-c000-ccache
>            - sifive,fu740-c000-ccache
> +          - starfive,jh7100-ccache
> +          - starfive,jh7110-ccache
>  
>    required:
>      - compatible
> @@ -35,6 +37,8 @@ properties:
>            - enum:
>                - sifive,fu540-c000-ccache
>                - sifive,fu740-c000-ccache
> +              - starfive,jh7100-ccache
> +              - starfive,jh7110-ccache
>            - const: cache
>        - items:
>            - const: microchip,mpfs-ccache
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
