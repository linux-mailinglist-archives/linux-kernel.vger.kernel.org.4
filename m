Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F230B69E1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjBUOAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjBUOAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:00:03 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6F44EE7;
        Tue, 21 Feb 2023 06:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676988000; x=1708524000;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/wNjMjxc0o/2+PBxlOBUobOxFoARZPT6afJbQz6rMjg=;
  b=pYFUbDX4GcnF/5NbhB9rcVYp0USktwDSTdE9xk8+i33DgfFkZqWrgfb5
   owbaqaU3GXdzrV6ydUAWQjE1p8IXNzZXzOXQMhNvv/NmuazCM+ldN2ZoC
   y0RUD2iNHVJ+97Mhcd4Erlrwt0xQ8g+qxi5X8bjH5ll9RT+vmcECi6k1c
   NEj+dS+YkCddyA4piBaV9zGFkVFbFMrHnB/brNVZg6Q5UGqyP5elQDZU2
   1EWlHXfXtrhBQKq55gc3HMb1mljq+sfSGbA9M2Pb2KLZF9mRiv+UET223
   44CY3OfQ3DvPKyBDXZ1FSmzZW756eAuwWa1MnW4OcyM8j91Buwq5bwX4g
   g==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669100400"; 
   d="scan'208";a="201632418"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2023 06:59:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 06:59:59 -0700
Received: from den-dk-m31857.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 06:59:57 -0700
Message-ID: <b90c582b8ddf0429058361ff42dc63ad1337bf43.camel@microchip.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: microchip: sparx5: do not use PSCI
 on reference boards
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Robert Marko <robert.marko@sartura.hr>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars.povlsen@microchip.com>,
        <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <arnd@arndb.de>, <alexandre.belloni@bootlin.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <luka.perkov@sartura.hr>
Date:   Tue, 21 Feb 2023 14:59:56 +0100
In-Reply-To: <20230221105039.316819-1-robert.marko@sartura.hr>
References: <20230221105039.316819-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
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

Hi Robert,

I find this very useful since the Sparx5 SoC does not support TFA and there=
fore
cannot provide PSCI on its own, as you also state below.

Acked-by: Steen Hegelund <Steen.Hegelund@microchip.com>

On Tue, 2023-02-21 at 11:50 +0100, Robert Marko wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> PSCI is not implemented on SparX-5 at all, there is no ATF and U-boot tha=
t
> is shipped does not implement it as well.
>=20
> I have tried flashing the latest BSP 2022.12 U-boot which did not work.
> After contacting Microchip, they confirmed that there is no ATF for the
> SoC nor PSCI implementation which is unfortunate in 2023.
>=20
> So, disable PSCI as otherwise kernel crashes as soon as it tries probing
> PSCI with, and the crash is only visible if earlycon is used.
>=20
> Since PSCI is not implemented, switch core bringup to use spin-tables
> which are implemented in the vendor U-boot and actually work.
>=20
> Tested on PCB134 with eMMC (VSC5640EV).
>=20
> Fixes: 6694aee00a4b ("arm64: dts: sparx5: Add basic cpu support")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v2:
> * As suggested by Arnd, disable PSCI only on reference boards
> ---
> =C2=A0arch/arm64/boot/dts/microchip/sparx5.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi | 12 +++++++++=
+++
> =C2=A02 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> index 0367a00a269b3..5eae6e7fd248e 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> @@ -61,7 +61,7 @@ arm-pmu {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 interrupt-affinity =3D <&cpu0>, <&cpu1>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psci {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psci: psci {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 compatible =3D "arm,psci-0.2";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 method =3D "smc";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
> b/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
> index 9d1a082de3e29..32bb76b3202a0 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
> @@ -6,6 +6,18 @@
> =C2=A0/dts-v1/;
> =C2=A0#include "sparx5.dtsi"
>=20
> +&psci {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "disabled";
> +};
> +
> +&cpu0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable-method =3D "spin-table";
> +};
> +
> +&cpu1 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable-method =3D "spin-table";
> +};
> +
> =C2=A0&uart0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> =C2=A0};
> --
> 2.39.2
>=20


BR
Steen
