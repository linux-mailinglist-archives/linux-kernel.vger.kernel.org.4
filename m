Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6566DD660
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDKJNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDKJNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:13:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A91B1BD;
        Tue, 11 Apr 2023 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681204424; x=1712740424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jqwQxom5IR5Ep7ajLiRjlvWzVlD1fmsVr0UZ+TZ7eTA=;
  b=Q27RM5WmrrxDmgpSX+SkDKaoGm5TTycSfMW40CDosRBkUQP2eZdIy4rn
   hnsTAlRrBMYredYJvSFnhbNxNQ75UFjmTuaMnCbdinr7DnsNYj/2rxdm5
   KTjmHRYDt6rDk0l/WTWUWog1Nz8HEUAlhFzlKTOwnM62BD+bRBWw7zIVS
   M6IuYa+woGbOqZ9AEES+FB9ULR7/IYjJd0lhegRRleorCnHDpwAtCOand
   LuwIg9gstwCLJerzsAPK7PmA7m1vaXApOflzo2L5b2x+jjKN+/qJsl0JJ
   zW3EHwDrYwKeAfyPVzsqhMGSHW1Im56ya5z8z42JNc+jif/Rrc7Q2TPJI
   A==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673938800"; 
   d="asc'?scan'208";a="146440571"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2023 02:13:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Apr 2023 02:13:42 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Apr 2023 02:13:40 -0700
Date:   Tue, 11 Apr 2023 10:13:24 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mason Huo <mason.huo@starfivetech.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v1 1/3] riscv: dts: starfive: Enable axp15060 pmic for
 cpufreq
Message-ID: <20230411-chimp-unvarying-142394732ff5@wendy>
References: <20230411083257.16155-1-mason.huo@starfivetech.com>
 <20230411083257.16155-2-mason.huo@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4LuYI8HlWhg/F6SG"
Content-Disposition: inline
In-Reply-To: <20230411083257.16155-2-mason.huo@starfivetech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--4LuYI8HlWhg/F6SG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 04:32:55PM +0800, Mason Huo wrote:
> The VisionFive 2 board has an embedded pmic axp15060,
> which supports the cpu DVFS through the dcdc2 regulator.
> This patch enables axp15060 pmic and configs the dcdc2.
>=20
> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  .../starfive/jh7110-starfive-visionfive-2.dtsi    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 2a6d81609284..df582bddae4b 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -114,6 +114,21 @@ &i2c5 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&i2c5_pins>;
>  	status =3D "okay";
> +
> +	pmic: axp15060_reg@36 {

No underscores in node names please & "pmic" is the generic node name
for pmics.

Cheers,
Conor.

> +		compatible =3D "x-powers,axp15060";
> +		reg =3D <0x36>;
> +
> +		regulators {
> +			reg_dcdc2: dcdc2 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <500000>;
> +				regulator-max-microvolt =3D <1540000>;
> +				regulator-name =3D "vdd-cpu";
> +			};
> +		};
> +	};
>  };
> =20
>  &i2c6 {
> --=20
> 2.39.2
>=20

--4LuYI8HlWhg/F6SG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDUktAAKCRB4tDGHoIJi
0ptHAQCDKGI3XyRxsVsoA9ciou5bbpoELojUFMtGujWP5aLzMgD/fvEH3XsXgs4X
IK9tDzpwxqp7DnaE/yiMSrJHFzcauw0=
=QUPe
-----END PGP SIGNATURE-----

--4LuYI8HlWhg/F6SG--
