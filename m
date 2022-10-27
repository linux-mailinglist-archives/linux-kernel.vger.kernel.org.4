Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A8E610274
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiJ0UOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiJ0UOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:14:21 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B92D1DC;
        Thu, 27 Oct 2022 13:14:19 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oo9GT-000329-74; Thu, 27 Oct 2022 22:14:09 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     kever.yang@rock-chips.com, Johan Jonker <jbx6244@gmail.com>
Cc:     sjg@chromium.org, philipp.tomsich@vrull.eu,
        zhangqing@rock-chips.com, hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1 2/4] dt-bindings: timer: rockchip: add rockchip,rk3128-timer
Date:   Thu, 27 Oct 2022 22:14:08 +0200
Message-ID: <4123966.kQq0lBPeGt@diego>
In-Reply-To: <939d9e2c-4431-5408-5884-12d328b6a4f2@gmail.com>
References: <da1252eb-85e9-bdb8-0542-207173523523@gmail.com> <939d9e2c-4431-5408-5884-12d328b6a4f2@gmail.com>
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

Am Donnerstag, 27. Oktober 2022, 02:52:35 CEST schrieb Johan Jonker:
> Add rockchip,rk3128-timer compatible string.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
> index dc3bc1e62..b61ed1a43 100644
> --- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
> +++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
> @@ -18,6 +18,7 @@ properties:
>            - enum:
>                - rockchip,rv1108-timer
>                - rockchip,rk3036-timer
> +              - rockchip,rk3128-timer
>                - rockchip,rk3188-timer
>                - rockchip,rk3228-timer
>                - rockchip,rk3229-timer
> --
> 2.20.1
> 
> 




