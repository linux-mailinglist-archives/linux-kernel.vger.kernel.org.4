Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC564FB5E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 18:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLQRnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 12:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 12:43:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2524610B4C;
        Sat, 17 Dec 2022 09:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8640760AE3;
        Sat, 17 Dec 2022 17:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ED4C433D2;
        Sat, 17 Dec 2022 17:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671298995;
        bh=3dvtU5hDggdzKmnVB1aFnHkevchFFQETM7wW4bi+xIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3ouT1S5WMJeX+6redHw5SqeOkbJBo3pQx4X4iiDvnHEn0VJKHo83x/qXM4njiMIT
         S3ki2paLukIlpd+DbEYbFN4bJTkwXPbcM6LZPBCSBb4qqDuBJDYl+pZMr0t2XgVEL1
         CZDNcQ4bMm2ZXbFe2aEQIhlzCP8gSDdgylAy8hXZCwJIUyWi3LkRdnBbX8PBo2y3Mx
         uItRSEb51WvQ3jBHZ106eywU5GZo75Sp635GsYRBdrZ4mc4EXMHpb9P77xw7xK1lEc
         ucLscm+zUWh/WA+HND61TvYNrCY1Cp8kTrDmjz6ij+lYFM69qnC9AITJnNvQcGQBpl
         6ZA6yPD56uGGQ==
Date:   Sat, 17 Dec 2022 17:43:10 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v3 00/12] riscv: Allwinner D1/D1s platform support
Message-ID: <Y53/ruLoggBDXozF@spud>
References: <20221208090237.20572-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0qcFoswq9ICCBoIQ"
Content-Disposition: inline
In-Reply-To: <20221208090237.20572-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0qcFoswq9ICCBoIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2022 at 03:02:25AM -0600, Samuel Holland wrote:
> This series adds the Kconfig/defconfig plumbing and devicetrees for a
> range of Allwinner D1 and D1s-based boards. Many features are already
> enabled, including USB, Ethernet, and WiFi.
>=20
> The devicetrees use bindings from the following series which have not
> yet been merged to linux-next:
>  - In-package LDO regulators:
>    https://lore.kernel.org/lkml/20221208084127.17443-1-samuel@sholland.or=
g/
>  - Ethernet MAC binding fix (not a new issue with D1):
>    https://lore.kernel.org/lkml/20221208061616.7806-1-samuel@sholland.org/
>  - TI ADC101C ADC (accepted, not yet in linux-next):
>    https://lore.kernel.org/lkml/20221125220903.8632-1-samuel@sholland.org/
>=20
> The only remaining DT validation issue is that gpio-fan is missing a
> YAML conversion, although one is on the list here:
> https://lore.kernel.org/lkml/20220126200350.3633576-1-clabbe@baylibre.com/

With the above 4 in next:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Corentin's patch looked like it needed only minor changes. I shall go
ping it :)

>=20
> $ make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-musl- dtbs_check
>   SYNC    include/config/auto.conf.cmd
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p=
=2Edtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p=
=2Edtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dtb
> arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dtb:0:0: /fan: fail=
ed to match any schema with compatible: ['gpio-fan']
>=20
> Note that validation requires dt-schema v2022.12 or newer.
>=20
> I tested this series (DMIC, Ethernet, LEDs, MMC, PMIC, touch, and USB,
> all where available) on the following boards:
>  - sun20i-d1-devterm-v3.14
>  - sun20i-d1-dongshan-nezha-stu
>  - sun20i-d1-lichee-rv-86-panel-480p
>  - sun20i-d1-mangopi-mq-pro
>  - sun20i-d1-nezha
>  - sun20i-d1s-mangopi-mq
>=20
> Changes in v3:
>  - Drop dummy DCXO clock-frequency property
>  - Decrease the PLIC's riscv,ndev property to 175
>  - Fix `make W=3D1 dtbs` warnings (unnecessary #address/#size-cells)
>  - Drop mmc aliases
>  - Change LED_FUNCTION_BACKLIGHT to LED_FUNCTION_STATUS (the backlight
>    regulator is disconnected by default, so this is a standalone LED)
>  - Fix `make W=3D1 dtbs` warnings (missing reg properties)
>  - ARCH_SUNXI depends on MMU && !XIP_KERNEL
>=20
> Changes in v2:
>  - Add MangoPi MQ (non-Pro) board
>  - Split into separate files for sharing with D1s/R528/T113
>  - Use SOC_PERIPHERAL_IRQ macro for interrupts
>  - Rename osc24M to dcxo and move the frequency to the board DTs
>  - Drop analog LDOs due to the missing binding
>  - Correct tcon_top DSI clock reference
>  - Add DMIC, DSI controller, and DPHY (bindings are in linux-next)
>  - Add CPU OPP table
>  - Common regulators moved to MangoPi MQ patch, removed analog LDOs
>  - Removed LRADC (depends on analog LDOs)
>  - Added XR829 host-wake interrupt
>  - Added DMIC sound card to Lichee RV dock and Lichee RV 86 Panel
>  - Removed LRADC (depends on analog LDOs)
>  - Added LED (GPIO shared between onboard LED and backlight regulator)
>  - Added PMIC GPIO controller node (binding merged for 6.2)
>  - Sort Kconfig as if we had done s/SOC_/ARCH_/ for future-proofing
>=20
> Samuel Holland (12):
>   MAINTAINERS: Match the sun20i family of Allwinner SoCs
>   dt-bindings: vendor-prefixes: Add Allwinner D1/D1s board vendors
>   dt-bindings: riscv: Add Allwinner D1/D1s board compatibles
>   riscv: dts: allwinner: Add the D1/D1s SoC devicetree
>   riscv: dts: allwinner: Add MangoPi MQ devicetree
>   riscv: dts: allwinner: Add Allwinner D1 Nezha devicetree
>   riscv: dts: allwinner: Add Sipeed Lichee RV devicetrees
>   riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
>   riscv: dts: allwinner: Add Dongshan Nezha STU devicetree
>   riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees
>   riscv: Add the Allwinner SoC family Kconfig option
>   riscv: defconfig: Enable the Allwinner D1 platform and drivers
>=20
>  .../devicetree/bindings/riscv/sunxi.yaml      |  69 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
>  MAINTAINERS                                   |   2 +-
>  arch/riscv/Kconfig.socs                       |  10 +
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/allwinner/Makefile        |  11 +
>  .../allwinner/sun20i-common-regulators.dtsi   |  35 +
>  .../allwinner/sun20i-d1-clockworkpi-v3.14.dts | 252 ++++++
>  .../dts/allwinner/sun20i-d1-devterm-v3.14.dts |  36 +
>  .../sun20i-d1-dongshan-nezha-stu.dts          | 117 +++
>  .../sun20i-d1-lichee-rv-86-panel-480p.dts     |  29 +
>  .../sun20i-d1-lichee-rv-86-panel-720p.dts     |  10 +
>  .../sun20i-d1-lichee-rv-86-panel.dtsi         | 119 +++
>  .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  97 ++
>  .../dts/allwinner/sun20i-d1-lichee-rv.dts     |  87 ++
>  .../allwinner/sun20i-d1-mangopi-mq-pro.dts    | 142 +++
>  .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 166 ++++
>  arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |  66 ++
>  .../dts/allwinner/sun20i-d1s-mangopi-mq.dts   | 134 +++
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |  76 ++
>  .../boot/dts/allwinner/sunxi-d1-t113.dtsi     |  15 +
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 837 ++++++++++++++++++
>  arch/riscv/configs/defconfig                  |  22 +-
>  23 files changed, 2335 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sunxi.yaml
>  create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-common-regulator=
s.dtsi
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v=
3.14.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14=
=2Edts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezh=
a-stu.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-=
panel-480p.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-=
panel-720p.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-=
panel.dtsi
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-doc=
k.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pr=
o.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.d=
ts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
>  create mode 100644 arch/riscv/boot/dts/allwinner/sunxi-d1-t113.dtsi
>  create mode 100644 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
>=20
> --=20
> 2.37.4
>=20
>=20

--0qcFoswq9ICCBoIQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY53/qAAKCRB4tDGHoIJi
0rVAAQCPdM7dV5zPoOPBEKW39F8dp1eq2DwP/UuJPAVYL/00XgD+OwoVc8w7dKdn
z8qICUZckN76/7Kxl5jMDRCtM+wYbQ4=
=W/99
-----END PGP SIGNATURE-----

--0qcFoswq9ICCBoIQ--
