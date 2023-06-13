Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24ED72F000
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjFMXcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFMXcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:32:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A005D2;
        Tue, 13 Jun 2023 16:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 665D863C1C;
        Tue, 13 Jun 2023 23:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACB1C433C0;
        Tue, 13 Jun 2023 23:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699116;
        bh=aNJH35WRMNqV0lqZl8N98lkQSouazvy9Y1MphL/3tYg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P5QlrbcFWh7WO7qIzYatE9h4nh2LMtoJoqbmvlUhmG+xX3L4nMF8JSkYNj3dGSRsH
         62UsqX5srRIENLVAAARr2cn6i+6N5fqi6aU7RbjgLfCIysgIagLzVuUwg2wNhp10m+
         K53Rmys1aL/uJqB/WyXJcfeBBEcYboH2agtTgcPfSeFaQ4lR4g3pKQFR9up1aIm3UV
         e1G5RGhchegpQvIM98stlnHyW6cu/xyLZSxQ6QS4naV58YhdTTWFdxp1YqFOKGVBd2
         skrpqTQ39P2WOY/qfxOkLNsh9TFbmGJ3byv0cwh1MSwo6lQGNu2LW7EN0e7TINNwqW
         8aeTjELvZe/JA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b1a3fa2cd2so876431fa.1;
        Tue, 13 Jun 2023 16:31:56 -0700 (PDT)
X-Gm-Message-State: AC+VfDw8sruz3SbsVOpPRExwyUkszScADI/EI9DMnNS6OhfKOOaSIKCV
        S5VavenT3cQeyJO8NZfob+YjhUEzy4dT1dWzUA==
X-Google-Smtp-Source: ACHHUZ4iBNHpRqCMQM3h4+6Wob2LPbB25k7cHf6W6lan03IqY+Tgwf1MVZ9lZskiFqgCTd3mlLVMfhsrEJSJ9Y2ozVs=
X-Received: by 2002:a2e:91d7:0:b0:2b3:46ec:8014 with SMTP id
 u23-20020a2e91d7000000b002b346ec8014mr376176ljg.47.1686699114810; Tue, 13 Jun
 2023 16:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230515150149.2790189-1-Frank.Li@nxp.com>
In-Reply-To: <20230515150149.2790189-1-Frank.Li@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Jun 2023 17:31:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMtf__1Q+5MiaoXXx1LO=49XG490HZxOxcD7yDveioiQ@mail.gmail.com>
Message-ID: <CAL_JsqLMtf__1Q+5MiaoXXx1LO=49XG490HZxOxcD7yDveioiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: imx8mp: Add coresight trace components
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 9:02=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> Add coresight trace components (ETM, ETF, ETB and Funnel).
>
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90
> =E2=94=82 CPU0  =E2=94=9C=E2=94=80=E2=96=BA=E2=94=82 ETM0  =E2=94=9C=E2=
=94=80=E2=96=BA=E2=94=82       =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=98  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98  =E2=94=82       =E2=94=82
>                       =E2=94=82       =E2=94=82
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90  =E2=94=82  ATP  =E2=94=82
> =E2=94=82 CPU1  =E2=94=9C=E2=94=80=E2=96=BA=E2=94=82 ETM1  =E2=94=9C=E2=
=94=80=E2=96=BA=E2=94=82       =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=98  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98  =E2=94=82       =E2=94=82
>                       =E2=94=82 FUNNEL=E2=94=82
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90  =E2=94=82       =E2=94=82
> =E2=94=82 CPU2  =E2=94=9C=E2=94=80=E2=96=BA=E2=94=82 ETM2  =E2=94=9C=E2=
=94=80=E2=96=BA=E2=94=82       =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=98  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98  =E2=94=82       =E2=94=82   =E2=94=8C=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=90  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90
>                       =E2=94=82       =E2=94=82   =E2=94=82     =E2=94=82=
  =E2=94=82     =E2=94=82
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90  =E2=94=82       =E2=94=82   =E2=94=82 M7  =E2=94=82  =
=E2=94=82 DSP =E2=94=82
> =E2=94=82 CPU3  =E2=94=9C=E2=94=80=E2=96=BA=E2=94=82 ETM3  =E2=94=9C=E2=
=94=80=E2=96=BA=E2=94=82       =E2=94=82   =E2=94=82     =E2=94=82  =E2=94=
=82     =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=98  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98   =E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=
=E2=94=80=E2=94=98  =E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=
=E2=94=98               AXI
>                           =E2=94=82          =E2=94=82        =E2=94=82  =
                 =E2=96=B2
>                           =E2=96=BC          =E2=96=BC        =E2=96=BC  =
                 =E2=94=82
>                       =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90   =E2=94=8C=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90   =E2=94=8C=E2=94=80=E2=
=94=B4=E2=94=80=E2=94=80=E2=94=90
>                       =E2=94=82          ATP FUNNEL       =E2=94=9C=E2=94=
=80=E2=94=80=E2=96=BA=E2=94=82ETF  =E2=94=9C=E2=94=80=E2=96=BA =E2=94=82ETR=
 =E2=94=82
>                       =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98   =E2=94=94=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98   =E2=94=94=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - add new line between nodes
> - add new line between properties and child node
>
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 204 ++++++++++++++++++++++
>  1 file changed, 204 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index a19224fe1a6a..1a25710c3a90 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -304,6 +304,210 @@ soc: soc@0 {
>                 nvmem-cells =3D <&imx8mp_uid>;
>                 nvmem-cell-names =3D "soc_unique_id";
>
> +               etm0: etm@28440000 {
> +                       compatible =3D "arm,coresight-etm4x", "arm,primec=
ell";
> +                       reg =3D <0x28440000 0x10000>;
> +                       arm,primecell-periphid =3D <0xbb95d>;
> +                       cpu =3D <&A53_0>;
> +                       clocks =3D <&clk IMX8MP_CLK_MAIN_AXI>;
> +                       clock-names =3D "apb_pclk";
> +
> +                       out-ports {
> +                               port {
> +                                       etm0_out_port: endpoint {
> +                                               remote-endpoint =3D <&ca_=
funnel_in_port0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm1: etm@28540000 {
> +                       compatible =3D "arm,coresight-etm4x", "arm,primec=
ell";
> +                       reg =3D <0x28540000 0x10000>;
> +                       arm,primecell-periphid =3D <0xbb95d>;
> +                       cpu =3D <&A53_1>;
> +                       clocks =3D <&clk IMX8MP_CLK_MAIN_AXI>;
> +                       clock-names =3D "apb_pclk";
> +
> +                       out-ports {
> +                               port {
> +                                       etm1_out_port: endpoint {
> +                                               remote-endpoint =3D <&ca_=
funnel_in_port1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm2: etm@28640000 {
> +                       compatible =3D "arm,coresight-etm4x", "arm,primec=
ell";
> +                       reg =3D <0x28640000 0x10000>;
> +                       arm,primecell-periphid =3D <0xbb95d>;
> +                       cpu =3D <&A53_2>;
> +                       clocks =3D <&clk IMX8MP_CLK_MAIN_AXI>;
> +                       clock-names =3D "apb_pclk";
> +
> +                       out-ports {
> +                               port {
> +                                       etm2_out_port: endpoint {
> +                                               remote-endpoint =3D <&ca_=
funnel_in_port2>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               etm3: etm@28740000 {
> +                       compatible =3D "arm,coresight-etm4x", "arm,primec=
ell";
> +                       reg =3D <0x28740000 0x10000>;
> +                       arm,primecell-periphid =3D <0xbb95d>;
> +                       cpu =3D <&A53_3>;
> +                       clocks =3D <&clk IMX8MP_CLK_MAIN_AXI>;
> +                       clock-names =3D "apb_pclk";
> +
> +                       out-ports {
> +                               port {
> +                                       etm3_out_port: endpoint {
> +                                               remote-endpoint =3D <&ca_=
funnel_in_port3>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel {
> +                       /*
> +                        * non-configurable funnel don't show up on the A=
MBA
> +                        * bus.  As such no need to add "arm,primecell".
> +                        */
> +                       compatible =3D "arm,coresight-static-funnel";

This device has no registers so it should not be under the bus node.

This is pointed out by the dtschema checks. Please don't add new ones.

Rob
