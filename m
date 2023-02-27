Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969776A43A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjB0OEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjB0OD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:03:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D7A65BF;
        Mon, 27 Feb 2023 06:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677506638; x=1709042638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lhINFStdkUVW6diIibKLb9nd7HYBVPWekTlInXGunlM=;
  b=x+bRhmtBZx2nx6R+5HhztNXI3ptTCcbN0mW6qwlzhTiOmhGUJflpU5EY
   L3GiUbHCzI4r1j3q2qEUTZTSqMKHsd+eXnU1klZ7y4OJ7FvtfsRn/FSqu
   0T2DvBZJi8IGUm288xeUNVUZ8WWO7y5j7oC/QlPuq3y4Dlumh3zJIskQ4
   pxf4uFog+BUfeqQ6rnlC6UXJ+rv2GQRc/tk63jlAyhbfToFVYuIZOm+hB
   gNGQSR9c5YTRye0f6NnBUCyNs2PEjKg2sTSJJp1Eo7XztY/YYgKSrdZul
   4A03PTKNiW94MD2Kj3A/KkoDZr5QCQii/s+m6YfxlF84EaWMNgMax5Wpc
   A==;
X-IronPort-AV: E=Sophos;i="5.98,332,1673938800"; 
   d="asc'?scan'208";a="139247079"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2023 07:03:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 07:03:55 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 27 Feb 2023 07:03:53 -0700
Date:   Mon, 27 Feb 2023 14:03:26 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] hwmon: (sfctemp) Add StarFive JH71x0 temperature
 sensor
Message-ID: <Y/y4LunvriV2RYwu@wendy>
References: <20230227134125.120638-1-hal.feng@starfivetech.com>
 <20230227134125.120638-3-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NBI72SkxZsmpX/ON"
Content-Disposition: inline
In-Reply-To: <20230227134125.120638-3-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--NBI72SkxZsmpX/ON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 09:41:25PM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Add driver for the StarFive JH71x0 temperature sensor. You
> can enable/disable it and read temperature in milli Celcius
> through sysfs.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Samin Guo <samin.guo@starfivetech.com>
> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

> +config SENSORS_SFCTEMP
> +	tristate "Starfive JH71x0 temperature sensor"
> +	depends on SOC_STARFIVE || COMPILE_TEST

We (or I?) am trying to homogenise RISC-V with the rest of the kernel by
using ARCH_FOO rather than SOC_FOO. We've currently got a mix of both,
due to companies that started out with RISC-V having SOC_ symbols &
those with history in other archs having ARCH_ ones.
The ARCH_ definitions landed in mainline this week, so if you end up
resubmitting this driver, it'd save me a conversion if you were to use
the ARCH_ variant.

Thanks,
Conor.

> +	help
> +	  If you say yes here you get support for temperature sensor
> +	  on the Starfive JH71x0 SoCs.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called sfctemp.

--NBI72SkxZsmpX/ON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/y4LgAKCRB4tDGHoIJi
0mJ0AP4vNo5Ie/2kHWAmJFUKGr8YQL9x84VEY3Xn9vgF9A6izgD/QJzmlpXfLT0E
wuAiKkJkRPP9FP1Z+dqqrB2FAZrw3QY=
=DO8S
-----END PGP SIGNATURE-----

--NBI72SkxZsmpX/ON--
