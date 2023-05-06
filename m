Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE336F8D2D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjEFAhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEFAha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:37:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A504C19;
        Fri,  5 May 2023 17:37:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaea3909d1so22108715ad.2;
        Fri, 05 May 2023 17:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683333449; x=1685925449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lksvsdy5ZBGz5N+QewT9TIbE/aUyvQ4IEKQ9nU6eAT4=;
        b=ZsTAe8yYgYPZkeBQ6jCuPIh7HAbrjZXPTPTwxPQHhJWwbyJs3VqikzIgIAXsklozz7
         ogCXZC71rWThF8C3b57hqJce2yovmE/7HGpic98964RxoWIdINg+wSN1iZMnREXELfVD
         mE1J4I6nXAOAXSlQI6ryMjYaYRdHTDr2K5ctlDJu2ITi1RHWVwl9Ny2XwnOCQceEGNxJ
         3sDE820K7EVBWM3llYfYZGcG+X3xUuWPe27f13FIxh0PCOaZHphwewUvRcDnpX81t0jX
         riYdDncDClW/lmvdzm/Z8KvTYvypolz5QQeImR3RENbkWPSBWHhJfaQR4pFhEFe7EPZ7
         oHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683333449; x=1685925449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lksvsdy5ZBGz5N+QewT9TIbE/aUyvQ4IEKQ9nU6eAT4=;
        b=PASn2RN8geo67UT1b1ch15/TyIeTG4TvkWXFojkfU4ziziwlFD6oXKbG+mVLKNXewh
         mDQRCS+I0eHXG4Q6w17n0AipuT2LPTGQGwBMwFwoTiCLnzne2AJq2BN1dZRMGhH3He0k
         VC2rKJpnPxjLGs1/MH61O0GMtDhdqOUFwJdA8lklk2Srg1vbes7vyQWd/dp2Ekj2mB0k
         Cg7XDyfrvWnwX2CU8kNfFFeWFWHggNonpUiUL2oLIoOpvG00dtvl99DQzFHakOjJ6O/o
         TZjSyawKhVJAzbwIcywFfU9XeiJyHOayEhu2ZnQcvzKCl72o6gUrHbG3O96r3jgRiXZJ
         4fSg==
X-Gm-Message-State: AC+VfDxmF0cEJWceN7nzrAxebmP3Pf82MKbCF7Pmmrflu5jsiN1HFO4D
        asYpWZ0yzYchSxI6+S+1vvoxFKeOzAjzeOEtCjQ=
X-Google-Smtp-Source: ACHHUZ6L+OdKMWK4KYhldGKKBjgPUe9JHsTqL/XXyO5DO4jQas2oQY/plfyzWaUic4tDX0AkQEYTN4ITTebEFYifFuo=
X-Received: by 2002:a17:90b:1d0d:b0:24d:ea7f:9ea2 with SMTP id
 on13-20020a17090b1d0d00b0024dea7f9ea2mr3355514pjb.15.1683333448544; Fri, 05
 May 2023 17:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230423123513.1346323-1-aford173@gmail.com>
In-Reply-To: <20230423123513.1346323-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 5 May 2023 19:37:17 -0500
Message-ID: <CAHCN7xLJ8D3dkbdEtUFd5RSvt=V0Xjmus2MxSKyRPhGRMrH+LA@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: dts: imx8mn: Fix video clock parents
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 7:35=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> There are a few clocks whose parents are set in mipi_dsi
> and mxsfb nodes, but these clocks are used by the disp_blk_ctrl
> power domain which may cause an issue when re-parenting, resuling
> in a disp_pixel clock having the wrong parent and wrong rate.
>
> Fix this by moving the assigned-clock-parents as associate clock
> assignments to the power-domain node to setup these clocks before
> they are enabled.
>
> Fixes: d825fb6455d5 ("arm64: dts: imx8mn: Add display pipeline components=
")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Shawn,

Any chance this can get applied?  Without it, the 8MN video doesn't
have correct parents and therefore the wrong clock rates too.

adam
> ---
> V2:  Split this into a separate patch away from a series of DSIM changes.
>      No actual changes made to the patch.
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mn.dtsi
> index bd84db550053..8be8f090e8b8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -1069,13 +1069,6 @@ lcdif: lcdif@32e00000 {
>                                          <&clk IMX8MN_CLK_DISP_APB_ROOT>,
>                                          <&clk IMX8MN_CLK_DISP_AXI_ROOT>;
>                                 clock-names =3D "pix", "axi", "disp_axi";
> -                               assigned-clocks =3D <&clk IMX8MN_CLK_DISP=
_PIXEL_ROOT>,
> -                                                 <&clk IMX8MN_CLK_DISP_A=
XI>,
> -                                                 <&clk IMX8MN_CLK_DISP_A=
PB>;
> -                               assigned-clock-parents =3D <&clk IMX8MN_C=
LK_DISP_PIXEL>,
> -                                                        <&clk IMX8MN_SYS=
_PLL2_1000M>,
> -                                                        <&clk IMX8MN_SYS=
_PLL1_800M>;
> -                               assigned-clock-rates =3D <594000000>, <50=
0000000>, <200000000>;
>                                 interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_=
HIGH>;
>                                 power-domains =3D <&disp_blk_ctrl IMX8MN_=
DISPBLK_PD_LCDIF>;
>                                 status =3D "disabled";
> @@ -1093,12 +1086,6 @@ mipi_dsi: dsi@32e10000 {
>                                 clocks =3D <&clk IMX8MN_CLK_DSI_CORE>,
>                                          <&clk IMX8MN_CLK_DSI_PHY_REF>;
>                                 clock-names =3D "bus_clk", "sclk_mipi";
> -                               assigned-clocks =3D <&clk IMX8MN_CLK_DSI_=
CORE>,
> -                                                 <&clk IMX8MN_CLK_DSI_PH=
Y_REF>;
> -                               assigned-clock-parents =3D <&clk IMX8MN_S=
YS_PLL1_266M>,
> -                                                        <&clk IMX8MN_CLK=
_24M>;
> -                               assigned-clock-rates =3D <266000000>, <24=
000000>;
> -                               samsung,pll-clock-frequency =3D <24000000=
>;
>                                 interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL=
_HIGH>;
>                                 power-domains =3D <&disp_blk_ctrl IMX8MN_=
DISPBLK_PD_MIPI_DSI>;
>                                 status =3D "disabled";
> @@ -1142,6 +1129,21 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
>                                               "lcdif-axi", "lcdif-apb", "=
lcdif-pix",
>                                               "dsi-pclk", "dsi-ref",
>                                               "csi-aclk", "csi-pclk";
> +                               assigned-clocks =3D <&clk IMX8MN_CLK_DSI_=
CORE>,
> +                                                 <&clk IMX8MN_CLK_DSI_PH=
Y_REF>,
> +                                                 <&clk IMX8MN_CLK_DISP_P=
IXEL>,
> +                                                 <&clk IMX8MN_CLK_DISP_A=
XI>,
> +                                                 <&clk IMX8MN_CLK_DISP_A=
PB>;
> +                               assigned-clock-parents =3D <&clk IMX8MN_S=
YS_PLL1_266M>,
> +                                                        <&clk IMX8MN_CLK=
_24M>,
> +                                                        <&clk IMX8MN_VID=
EO_PLL1_OUT>,
> +                                                        <&clk IMX8MN_SYS=
_PLL2_1000M>,
> +                                                        <&clk IMX8MN_SYS=
_PLL1_800M>;
> +                               assigned-clock-rates =3D <266000000>,
> +                                                      <24000000>,
> +                                                      <594000000>,
> +                                                      <500000000>,
> +                                                      <200000000>;
>                                 #power-domain-cells =3D <1>;
>                         };
>
> --
> 2.39.2
>
