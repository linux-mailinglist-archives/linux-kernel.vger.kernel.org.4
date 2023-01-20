Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B20B67511F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjATJa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjATJaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:30:11 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1294C97;
        Fri, 20 Jan 2023 01:29:36 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pInhK-0002aV-GZ; Fri, 20 Jan 2023 10:28:34 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: Re: [PATCH RESEND 1/2] media: dt-bindings: media: rockchip-rga: add
 rockchip,rk3568-rga
Date:   Fri, 20 Jan 2023 10:28:33 +0100
Message-ID: <1938419.usQuhbGJ8B@diego>
In-Reply-To: <20230119-rk3568-rga-v1-1-43d4d14365e6@pengutronix.de>
References: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
 <20230119-rk3568-rga-v1-1-43d4d14365e6@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 20. Januar 2023, 10:14:21 CET schrieb Michael Tretter:
> Add a new compatible for the rk3568 Rockchip SoC, which also features an
> RGA, which is called RGA2 in the TRM Part2. It is the same core as used
> on the rk3288, which documents the same RGA2.
> 
> Specify a new compatible for the rk3568 to be able to handle unknown
> SoC-specific differences in the driver.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

@media people: I'd guess this should go through the media-tree, while I
would pick the devicetree patch.

I can also apply this binding patch, but would need an Ack from the
media-side for it.

Thanks
Heiko

> ---
>  Documentation/devicetree/bindings/media/rockchip-rga.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip-rga.yaml b/Documentation/devicetree/bindings/media/rockchip-rga.yaml
> index dd645ddccb07..ea2342222408 100644
> --- a/Documentation/devicetree/bindings/media/rockchip-rga.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip-rga.yaml
> @@ -21,7 +21,9 @@ properties:
>        - const: rockchip,rk3288-rga
>        - const: rockchip,rk3399-rga
>        - items:
> -          - const: rockchip,rk3228-rga
> +          - enum:
> +              - rockchip,rk3228-rga
> +              - rockchip,rk3568-rga
>            - const: rockchip,rk3288-rga
>  
>    reg:
> 
> 




