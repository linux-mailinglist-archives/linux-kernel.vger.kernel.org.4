Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF06D3E5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjDCHsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCHsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:48:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA6C1FF5;
        Mon,  3 Apr 2023 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680508076; x=1712044076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zGqIFvsIBpWbq/uZw0Ixb3JhhlFXJPObQzt1HnJSOpc=;
  b=Y0f3ldBp0OyrL74hEPh0T7eYh3iISzcg+FiP9czbESDeGAFd1Vpabnki
   sXa9499GpThQDnat8a+ovFGGUN4eH8zgyEEDwQE9JKBriN2OK5yfGT8Kp
   tn05RtUTM0V2VmjSHEqi7IEgE/deOnNIAsVZH6IB+tyIuV07lnii6VYU7
   r+NUbqeHkUqS99+0bg37aOMneSCeRB9hj+QDeb29MXu1oUrS3RabRuAgw
   FSHXIxy1QsYAJytwiPKezNWL31I7Fk6nM4oTeCcvcPpXsPB556EPxuLSr
   BPvoYjGuIZz4sbaCwiINOt0i2HczoocNX2fnKykgH9jlscox6GNiHlDyx
   w==;
X-IronPort-AV: E=Sophos;i="5.98,314,1673938800"; 
   d="asc'?scan'208";a="145174505"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Apr 2023 00:47:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 00:47:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Apr 2023 00:47:50 -0700
Date:   Mon, 3 Apr 2023 08:47:35 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/22] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <1eda304a-a8e0-4f19-bfe4-8793052f73a9@spud>
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
 <acb36897-8085-4f41-9b68-b243467ffc6f@spud>
 <ce4ee037-c53c-5bd4-8968-437ee21c9c51@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QEXRWawa+Yd/Oc16"
Content-Disposition: inline
In-Reply-To: <ce4ee037-c53c-5bd4-8968-437ee21c9c51@starfivetech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--QEXRWawa+Yd/Oc16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 03:30:32PM +0800, Hal Feng wrote:
> On Sun, 2 Apr 2023 20:19:41 +0100, Conor Dooley wrote:
> > On Sat, Apr 01, 2023 at 07:19:12PM +0800, Hal Feng wrote:

> > And the rest as riscv-jh7110_clk_reset:
> > MAINTAINERS: generalise StarFive clk/reset entries
>=20
> For this patch, I find something to improve.
> 1. Could you please help me sort the StarFive entries in MAINTAINERS?
> "STARFIVE JH71X0 CLOCK DRIVERS" should be added after
> "STARFIVE JH7110 MMC/SD/SDIO DRIVER".
>=20
> 2. A "S" should be added at the end of
> "STARFIVE JH7100 RESET CONTROLLER DRIVER".
>=20
> I have tested your branch and have no comments on the other patches.

Done:
diff --git a/MAINTAINERS b/MAINTAINERS
index f405114bf096..0a701632b0b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19907,6 +19907,12 @@ M:     Emil Renner Berthing <kernel@esmil.dk>
 S:     Maintained
 F:     arch/riscv/boot/dts/starfive/
=20
+STARFIVE JH7110 MMC/SD/SDIO DRIVER
+M:     William Qiu <william.qiu@starfivetech.com>
+S:     Supported
+F:     Documentation/devicetree/bindings/mmc/starfive*
+F:     drivers/mmc/host/dw_mmc-starfive.c
+
 STARFIVE JH71X0 CLOCK DRIVERS
 M:     Emil Renner Berthing <kernel@esmil.dk>
 M:     Hal Feng <hal.feng@starfivetech.com>
@@ -19915,12 +19921,6 @@ F:     Documentation/devicetree/bindings/clock/sta=
rfive,jh71*.yaml
 F:     drivers/clk/starfive/clk-starfive-jh71*
 F:     include/dt-bindings/clock/starfive?jh71*.h
=20
-STARFIVE JH7110 MMC/SD/SDIO DRIVER
-M:     William Qiu <william.qiu@starfivetech.com>
-S:     Supported
-F:     Documentation/devicetree/bindings/mmc/starfive*
-F:     drivers/mmc/host/dw_mmc-starfive.c
-
 STARFIVE JH71X0 PINCTRL DRIVERS
 M:     Emil Renner Berthing <kernel@esmil.dk>
 M:     Jianlong Huang <jianlong.huang@starfivetech.com>
@@ -19931,7 +19931,7 @@ F:      drivers/pinctrl/starfive/pinctrl-starfive-j=
h71*
 F:     include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
 F:     include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
=20
-STARFIVE JH71X0 RESET CONTROLLER DRIVER
+STARFIVE JH71X0 RESET CONTROLLER DRIVERS
 M:     Emil Renner Berthing <kernel@esmil.dk>
 M:     Hal Feng <hal.feng@starfivetech.com>
 S:     Maintained

 Cheers,
 Conor.

--QEXRWawa+Yd/Oc16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCqElwAKCRB4tDGHoIJi
0sqbAQCMsACpQzkzhLoKfCAGm331fVF+ABaBHJYSyLnVCVgBVAEAmAp9CCOzimm4
keaJvJy+j9w82evuGi+U1ktFrXhXDQs=
=7zTB
-----END PGP SIGNATURE-----

--QEXRWawa+Yd/Oc16--
