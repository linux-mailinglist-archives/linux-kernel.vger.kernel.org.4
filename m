Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64613713A56
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjE1PMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 11:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE1PMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 11:12:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BDDA7;
        Sun, 28 May 2023 08:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA10A60D2E;
        Sun, 28 May 2023 15:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAE9C433EF;
        Sun, 28 May 2023 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685286719;
        bh=ARvEO23dasH18+5jDJHBo7KTOvsMfUCav6bqynj3MxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qd2gPvwOncZlWRSsTAihexqmUAaBRd4Fr+aDYrucvyakAr9S88rLgH4czuFrGk421
         ikl5iyFfKrv1JNNrdtyDgCCr691/7PoMWQm3ryDK3eGWYWvxZXow93Hacy7wrScnz2
         7TR5w7ZJFUnjAQrKfD/lP4Zt8+dXyAEJ0c7pGgbaj09VhoIBDKJLaKJ8AERjX0TwRM
         32/YraaCelspQHyF/iBDCi+NYoo5p29Kwyg6LOcukYv7KXHVSj76ePAa0aoqqoa/4o
         CoQsEgCMCXR1TMuvHRbOP2NENPf/Boj4uxXpGAW/raUZQy9Gerb3qouMGyDjo3xi4c
         VSwfC4CtVhu7g==
Date:   Sun, 28 May 2023 16:28:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andre Przywara <andre.przywara@arm.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v1 2/4] dt-bindings: iio: adc: Add Allwinner
 D1/T113s/R329 SoCs GPADC
Message-ID: <20230528162813.6a7263e5@jic23-huawei>
In-Reply-To: <20230524082744.3215427-3-bigunclemax@gmail.com>
References: <20230524082744.3215427-1-bigunclemax@gmail.com>
        <20230524082744.3215427-3-bigunclemax@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 11:27:31 +0300
Maxim Kiselev <bigunclemax@gmail.com> wrote:

> Allwinner's D1, T113s and R329 SoCs have a new general purpose ADC.
> This ADC is the same for all of this SoCs. The only difference is
> the number of available channels.
> 
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> ---
>  .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> new file mode 100644
> index 000000000000..a79b874750dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/allwinner,sun20i-d1-gpadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner D1 General Purpose ADC
> +
> +properties:
> +  "#io-channel-cells":
> +    const: 0

That's odd for a device with more than one channel.  How do you reference
which channel you want to consume?

> +
> +  clocks:
> +    maxItems: 1
> +
> +  compatible:
> +    enum:
> +      - allwinner,sun20i-d1-gpadc
> +      - allwinner,sun8i-t113-gpadc
> +      - allwinner,sun50i-r329-gpadc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - "#io-channel-cells"
> +  - clocks
> +  - compatible
> +  - interrupts
> +  - reg
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpadc: adc@2009000 {
> +        compatible = "allwinner,sun20i-d1-gpadc";
> +        reg = <0x2009000 0x1000>;
> +        clocks = <&ccu CLK_BUS_GPADC>;
> +        resets = <&ccu RST_BUS_GPADC>;
> +        interrupts = <SOC_PERIPHERAL_IRQ(57) IRQ_TYPE_LEVEL_HIGH>;

I guess the bot probably got this, but to use these macros you need some includes.

> +        #io-channel-cells = <0>;
> +    };
> +
> +...

