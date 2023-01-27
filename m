Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EA567E6D1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjA0NeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjA0NeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:34:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688A037542;
        Fri, 27 Jan 2023 05:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674826453; x=1706362453;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=bVvYCzsGc4JR01gXRMvltOhjxrUCv00fjKBqc05/dGA=;
  b=MJr3Bf5sh3sxCqvJIxi3FX5TCvNm+BSD8SeoTYC6z36N58xOmNLqGHee
   tHJb3hyJNr8kPJbUVYg4JkiiMfYAzDu2sjO14DWGiFj+irVsxFmDO+5Yv
   ImGk3YTs5i53UwTMiPLWmFUNIJsAicT+COSXwo5gAIE7EToE4Q5wGMbAU
   caXj/XPTKH2S8H+ZnQR0xCHjomT62JoqTNLrEmqUYT893q5MW6kv7jFy7
   L0iZUfX8bUFYhwVSYqRgqQnG7HdYoMXSHJ3THIHzm4rySht2Pyh3A7NC3
   b4qR36kDB4FFblfm5Bg9Vi8zzzNLOcj2IQtOm9lYbqDq1fcoppxF/8YEO
   A==;
X-IronPort-AV: E=Sophos;i="5.97,251,1669100400"; 
   d="scan'208";a="194151084"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jan 2023 06:12:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 06:12:15 -0700
Received: from den-dk-m31857.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 06:12:13 -0700
Message-ID: <13801ebac011ed24792f809643b84d7595f0d15b.camel@microchip.com>
Subject: Re: [PATCH] arm64: dts: microchip: use "okay" for status
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 27 Jan 2023 14:12:12 +0100
In-Reply-To: <20230127101824.93684-1-krzysztof.kozlowski@linaro.org>
References: <20230127101824.93684-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

This looks "okay" to me.

BR
Steen

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

On Fri, 2023-01-27 at 11:18 +0100, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> "okay" over "ok" is preferred for status property.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> =C2=A0arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi | 2 +-
> =C2=A0arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi | 6 +++---
> =C2=A02 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
> b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
> index bf12be5e8d84..ed94a80bf05f 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
> @@ -538,7 +538,7 @@ i2c_sfp20: i2c_sfp20 {
> =C2=A0};
>=20
> =C2=A0&mdio3 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "ok";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy64: ethernet-phy@64 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reg =3D <28>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
> b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
> index ec90bda7ed6a..0760cf2e48bc 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
> @@ -208,7 +208,7 @@ sfp_eth63: sfp-eth63 {
> =C2=A0};
>=20
> =C2=A0&mdio0 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "ok";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy0: ethernet-phy@0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> @@ -284,7 +284,7 @@ phy23: ethernet-phy@23 {
> =C2=A0};
>=20
> =C2=A0&mdio1 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "ok";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy24: ethernet-phy@24 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> @@ -360,7 +360,7 @@ phy47: ethernet-phy@47 {
> =C2=A0};
>=20
> =C2=A0&mdio3 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "ok";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy64: ethernet-phy@64 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reg =3D <28>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> --
> 2.34.1
>=20

