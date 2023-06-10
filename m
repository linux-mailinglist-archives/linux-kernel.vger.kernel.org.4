Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B9772AB91
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjFJM5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFJM5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:57:16 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBAAAB;
        Sat, 10 Jun 2023 05:57:13 -0700 (PDT)
Received: from i53875b22.versanet.de ([83.135.91.34] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q7y9L-0005N2-CT; Sat, 10 Jun 2023 14:56:59 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        sebastian.reichel@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: Re: [PATCH] dt-bindings: iio: rockchip: Fix 'oneOf' condition failed warning
Date:   Sat, 10 Jun 2023 14:56:58 +0200
Message-ID: <2621715.Lt9SDvczpP@diego>
In-Reply-To: <20230610122200.161741-1-shreeya.patel@collabora.com>
References: <20230610122200.161741-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 10. Juni 2023, 14:22:00 CEST schrieb Shreeya Patel:
> Fix the dtbs_check warning for 'oneOf' condition failure.
> 
> DTC_CHK arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb
> /home/shreeya/linux/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb:
> 	saradc@fec10000: compatible: 'oneOf' conditional failed,
> 	one must be fixed:
> 	['rockchip,rk3588-saradc'] is too short
> 	'rockchip,saradc' was expected
> 	'rockchip,rk3066-tsadc' was expected
> 	'rockchip,rk3399-saradc' was expected
> 

Nit: the commit message could explain that the rk3588 in fact isn't
compatible with the rk3399-saradc variant.

Otherwise I checked the implementation, so
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> Fixes: 2daf2ae9793d ("dt-bindings: iio: adc: Add rockchip,rk3588-saradc string")
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> index 11c27ea451c8..aa24b841393c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> @@ -15,13 +15,13 @@ properties:
>        - const: rockchip,saradc
>        - const: rockchip,rk3066-tsadc
>        - const: rockchip,rk3399-saradc
> +      - const: rockchip,rk3588-saradc
>        - items:
>            - enum:
>                - rockchip,px30-saradc
>                - rockchip,rk3308-saradc
>                - rockchip,rk3328-saradc
>                - rockchip,rk3568-saradc
> -              - rockchip,rk3588-saradc
>                - rockchip,rv1108-saradc
>                - rockchip,rv1126-saradc
>            - const: rockchip,rk3399-saradc
> 




