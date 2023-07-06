Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769907494D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjGFFHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGFFHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:07:03 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2968DB2;
        Wed,  5 Jul 2023 22:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1688620021; x=1720156021;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=6Ht0rAFs+rZnK+7UtbasxXqvhje9rztLxAQxVYA9THI=;
  b=NhLCotSkQODXDc6Kj963R9tQI779FclnLgQCD9AC9UExSoxtQ03eCn5F
   63v/6xe04GVC7Pcr9baFaG2Ls6KNX7hGnJEeuiXQxUNCsZMEkjB7L6dA4
   aOKsq3tbaAsriwDdUfPBxLaud641IjpW4+xuhmuVOvM6aMTjYqX9z26tI
   m7oP0pf1LPjpWAG3g9DvStE+zh7uvWxdIWgAiUrgzhXbP5vsF+r3k6Nms
   8N5DOaJh58hOz8c4u34OVGso7Q5EQPyhPxaIgaF5KueyA+aO8VIxW6SH0
   edcIcW0tvD+etEHjcAfKEEm29Cp1PNIGkLnnNBwTdK5bSZp35eQiOvddV
   g==;
X-IronPort-AV: E=Sophos;i="6.01,184,1684792800"; 
   d="scan'208";a="31780937"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Jul 2023 07:06:59 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id BD365280084;
        Thu,  6 Jul 2023 07:06:58 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: remove arm, primecell-periphid at etm nodes
Date:   Thu, 06 Jul 2023 07:06:58 +0200
Message-ID: <9405224.NyiUUSuA9g@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230705205954.4159781-1-Frank.Li@nxp.com>
References: <20230705205954.4159781-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Am Mittwoch, 5. Juli 2023, 22:59:53 CEST schrieb Frank Li:
> The reg size of etm nodes is incorrectly set to 64k instead of 4k. This
> leads to a crash when calling amba_read_periphid().  After corrected reg
> size, amba_read_periphid() retrieve the correct periphid.
> arm,primecell-periphid were removed from the etm nodes.

So this means the reference manual is wrong here? It clearly states the siz=
e=20
is 64kiB. Reference Manual i.MX8MP Rev 1. 06/2021
On a side note: Is imx8mq affected by this as well? The DAP memory table li=
sts=20
similar sizes in the RM .

Best regards,
Alexander

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
> cc406bb338fe..e0ca82ff6f15 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -306,8 +306,7 @@ soc: soc@0 {
>=20
>  		etm0: etm@28440000 {
>  			compatible =3D "arm,coresight-etm4x",=20
"arm,primecell";
> -			reg =3D <0x28440000 0x10000>;
> -			arm,primecell-periphid =3D <0xbb95d>;
> +			reg =3D <0x28440000 0x1000>;
>  			cpu =3D <&A53_0>;
>  			clocks =3D <&clk IMX8MP_CLK_MAIN_AXI>;
>  			clock-names =3D "apb_pclk";
> @@ -323,8 +322,7 @@ etm0_out_port: endpoint {
>=20
>  		etm1: etm@28540000 {
>  			compatible =3D "arm,coresight-etm4x",=20
"arm,primecell";
> -			reg =3D <0x28540000 0x10000>;
> -			arm,primecell-periphid =3D <0xbb95d>;
> +			reg =3D <0x28540000 0x1000>;
>  			cpu =3D <&A53_1>;
>  			clocks =3D <&clk IMX8MP_CLK_MAIN_AXI>;
>  			clock-names =3D "apb_pclk";
> @@ -340,8 +338,7 @@ etm1_out_port: endpoint {
>=20
>  		etm2: etm@28640000 {
>  			compatible =3D "arm,coresight-etm4x",=20
"arm,primecell";
> -			reg =3D <0x28640000 0x10000>;
> -			arm,primecell-periphid =3D <0xbb95d>;
> +			reg =3D <0x28640000 0x1000>;
>  			cpu =3D <&A53_2>;
>  			clocks =3D <&clk IMX8MP_CLK_MAIN_AXI>;
>  			clock-names =3D "apb_pclk";
> @@ -357,8 +354,7 @@ etm2_out_port: endpoint {
>=20
>  		etm3: etm@28740000 {
>  			compatible =3D "arm,coresight-etm4x",=20
"arm,primecell";
> -			reg =3D <0x28740000 0x10000>;
> -			arm,primecell-periphid =3D <0xbb95d>;
> +			reg =3D <0x28740000 0x1000>;
>  			cpu =3D <&A53_3>;
>  			clocks =3D <&clk IMX8MP_CLK_MAIN_AXI>;
>  			clock-names =3D "apb_pclk";


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


