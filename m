Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B8673796
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjASL4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjASL4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:56:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D6A75A21;
        Thu, 19 Jan 2023 03:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674129357; x=1705665357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a/yQNfHAxcljG2Q5aMUQijjlsJyFUg3zCw6doKyi/Ds=;
  b=0TesP34J6uxZDAKp5ST7ITvGBRXI15QgIYLNAguFlUP8eGYYfVsbcnha
   MCDxwtSpN7V4TDbff5zfsRKn3tbEjShKMWkDtI4LFITdvgHmUh3mt/W6x
   QFus89WAStFy4WSDAJMcn4A5wivL1kMbkB2IEUtWBeaYibazTbQdpuFJ8
   qbg8f5G09U+IG3tTjqHzBvju4u6GGP7rSUtRuSh0IBeN/MlR6c88sysBG
   ntIObmK5cO4oLrhzO8CfbkWPu3jtK1YlfZcl1dgv0Nz4KS/0v/DQXYsXn
   JNPERKqvol16FmumSULTyTVnNpbt6OuTXauogevv4uCWkuiRMphyNjowC
   w==;
X-IronPort-AV: E=Sophos;i="5.97,229,1669100400"; 
   d="asc'?scan'208";a="196514152"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jan 2023 04:55:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 04:55:55 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 19 Jan 2023 04:55:53 -0700
Date:   Thu, 19 Jan 2023 11:55:12 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Walker Chen <walker.chen@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: power: Add starfive,jh7110-pmu
Message-ID: <Y8kvoBY61p7ZX1UP@wendy>
References: <20230119094447.21939-1-walker.chen@starfivetech.com>
 <20230119094447.21939-2-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KtqlIoRlabMqvssE"
Content-Disposition: inline
In-Reply-To: <20230119094447.21939-2-walker.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--KtqlIoRlabMqvssE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Walker,

On Thu, Jan 19, 2023 at 05:44:46PM +0800, Walker Chen wrote:
> Add bindings for the Power Management Unit on the StarFive JH7110 SoC.
>=20
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Just FYI, an R-b given against the cover letter can usually be applied
to all patches in the series, unless otherwise stated.
So here's mine from v3:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Whenever you re-submit the dts patch, you can send that with my R-b
already applied there too.
I'll give this a day or two for the build bots to look at it before
applying it.

Thanks,
Conor.

> ---
>  .../bindings/power/starfive,jh7110-pmu.yaml   | 45 +++++++++++++++++++
>  .../dt-bindings/power/starfive,jh7110-pmu.h   | 17 +++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/starfive,jh71=
10-pmu.yaml
>  create mode 100644 include/dt-bindings/power/starfive,jh7110-pmu.h
>=20
> diff --git a/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.=
yaml b/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> new file mode 100644
> index 000000000000..98eb8b4110e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/starfive,jh7110-pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 Power Management Unit
> +
> +maintainers:
> +  - Walker Chen <walker.chen@starfivetech.com>
> +
> +description: |
> +  StarFive JH7110 SoC includes support for multiple power domains which =
can be
> +  powered on/off by software based on different application scenes to sa=
ve power.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - starfive,jh7110-pmu
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#power-domain-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwrc: power-controller@17030000 {
> +        compatible =3D "starfive,jh7110-pmu";
> +        reg =3D <0x17030000 0x10000>;
> +        interrupts =3D <111>;
> +        #power-domain-cells =3D <1>;
> +    };
> diff --git a/include/dt-bindings/power/starfive,jh7110-pmu.h b/include/dt=
-bindings/power/starfive,jh7110-pmu.h
> new file mode 100644
> index 000000000000..132bfe401fc8
> --- /dev/null
> +++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Author: Walker Chen <walker.chen@starfivetech.com>
> + */
> +#ifndef __DT_BINDINGS_POWER_JH7110_POWER_H__
> +#define __DT_BINDINGS_POWER_JH7110_POWER_H__
> +
> +#define JH7110_PD_SYSTOP	0
> +#define JH7110_PD_CPU		1
> +#define JH7110_PD_GPUA		2
> +#define JH7110_PD_VDEC		3
> +#define JH7110_PD_VOUT		4
> +#define JH7110_PD_ISP		5
> +#define JH7110_PD_VENC		6
> +
> +#endif
> --=20
> 2.17.1
>=20
>=20

--KtqlIoRlabMqvssE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8kvoAAKCRB4tDGHoIJi
0v8aAQD5NmwXm053OEW5Y+vl6nJVhbEcYexgIv681j8R3EHB4gEA6Gz2eE/sUgsd
nSoL8cY+awMny85fIl0xH64nT8kloAs=
=K8tD
-----END PGP SIGNATURE-----

--KtqlIoRlabMqvssE--
