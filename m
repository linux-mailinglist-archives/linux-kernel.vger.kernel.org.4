Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5AF6F9C8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 00:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjEGWlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 18:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjEGWlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 18:41:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2765100D9;
        Sun,  7 May 2023 15:41:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84FA44B3;
        Sun,  7 May 2023 15:41:53 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D0203F663;
        Sun,  7 May 2023 15:41:05 -0700 (PDT)
Date:   Sun, 7 May 2023 23:40:49 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/5] dt-bindings: spi: sun6i: add DT bindings for
 Allwinner R329/D1/R528/T113s SPI
Message-ID: <20230507234049.3f285450@slackpad.lan>
In-Reply-To: <20230507150345.1971083-2-bigunclemax@gmail.com>
References: <20230507150345.1971083-1-bigunclemax@gmail.com>
        <20230507150345.1971083-2-bigunclemax@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 May 2023 18:03:33 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

Hi,

> Listed above Allwinner SoCs has two SPI controllers. First is the regular
> SPI controller and the second one has additional functionality for
> MIPI-DBI Type C.
> 
> Add compatible strings for these controllers
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml   | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> index de36c6a34a0f..ab2d8a03011e 100644
> --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> @@ -19,6 +19,7 @@ properties:
>  
>    compatible:
>      oneOf:
> +      - const: allwinner,sun50i-r329-spi
>        - const: allwinner,sun6i-a31-spi
>        - const: allwinner,sun8i-h3-spi
>        - items:
> @@ -28,6 +29,12 @@ properties:
>                - allwinner,sun50i-h616-spi
>                - allwinner,suniv-f1c100s-spi
>            - const: allwinner,sun8i-h3-spi
> +      - items:
> +          - enum:
> +              - allwinner,sun20i-d1-spi
> +              - allwinner,sun20i-d1-spi-dbi
> +              - allwinner,sun50i-r329-spi-dbi
> +          - const: allwinner,sun50i-r329-spi

So this is still not right: It allows:
"allwinner,sun20i-d1-spi-dbi", "allwinner,sun50i-r329-spi"
which it shouldn't, but more importantly disallows the three string
version that is introduced in patch 5/5, which makes dtbs_check fail.
So we need to fix this. I think the simplest is probably:

+      - items:
+          - enum:
+              - allwinner,sun20i-d1-spi
+              - allwinner,sun50i-r329-spi-dbi
+          - const: allwinner,sun50i-r329-spi
+      - items:
+          - const: allwinner,sun20i-d1-spi-dbi
+          - const: allwinner,sun50i-r329-spi-dbi
+          - const: allwinner,sun50i-r329-spi

Maybe there is a shorter sequence.
This assumes we go with the three-string combo, of course.

Cheers,
Andre


>  
>    reg:
>      maxItems: 1

