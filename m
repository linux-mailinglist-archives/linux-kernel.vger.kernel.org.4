Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87F4650979
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiLSJoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSJoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:44:01 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB87D2E8;
        Mon, 19 Dec 2022 01:43:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1671443006; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=LOCrxKOXLVaY82NfhflD3Vz6Bx9kbBbItxvm4Swsr2NOLq+0X/J7UVpUBeT3FaEHur5WLhLK+k40djFLsQw6HNXcnVTv1eb3nznf9s2MmYIO2D/X26ZSv9wL3cVO56KhRTVmGTP3fixzJy6slIGzr9OmwDgXmx8wKSCQPu/oxkc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1671443006; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=FZkrG/PJzkAi8Kwx1oMn1iqTbZ/7Tzjos6YQM1WqJFY=; 
        b=XUwegxb8R2YJVYR4e8+ARCHktnvMNiLAigUm0dvPZoQFNlzRHXCen8Z/IqtSm1cN0tT+HE2OC5D5d/2nncmOeHlJwkvenPNNzPMWi2rQviLmrvzV/wbMHTib4RqRyhBXdMyGcV5RGIWJixzauwGWVIN4bylKJ6CJncpRNTsKE1k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1671443006;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=FZkrG/PJzkAi8Kwx1oMn1iqTbZ/7Tzjos6YQM1WqJFY=;
        b=Axk3H0JdXqb85gV9+L+mdWtRvkRwZjJcpkjQvmgFJ6TbOLIb03Jf4yDjY21HdRPj
        b+OP0792RQ8fVFlp559Fua+JJuB4d+6EulQPlS23n518y7w7mrhWnlw7nfNPMQAtiuS
        /6b23pXET43pyipobTxpKtFle3ux0Ezj/bf8+pV4=
Received: from edelgard.fodlan.icenowy.me (120.85.99.51 [120.85.99.51]) by mx.zohomail.com
        with SMTPS id 1671443003083956.9203910325415; Mon, 19 Dec 2022 01:43:23 -0800 (PST)
Message-ID: <e9428f30cf0c6a239af01c0c2db9c511f3561a8c.camel@icenowy.me>
Subject: Re: [PATCH v3 00/12] riscv: Allwinner D1/D1s platform support
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel@sholland.org>
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
Date:   Mon, 19 Dec 2022 17:43:17 +0800
In-Reply-To: <Y53/ruLoggBDXozF@spud>
References: <20221208090237.20572-1-samuel@sholland.org>
         <Y53/ruLoggBDXozF@spud>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-12-17=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 17:43 +0000=EF=BC=
=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Dec 08, 2022 at 03:02:25AM -0600, Samuel Holland wrote:
> > This series adds the Kconfig/defconfig plumbing and devicetrees for
> > a
> > range of Allwinner D1 and D1s-based boards. Many features are
> > already
> > enabled, including USB, Ethernet, and WiFi.
> >=20
> > The devicetrees use bindings from the following series which have
> > not
> > yet been merged to linux-next:
> > =C2=A0- In-package LDO regulators:
> > =C2=A0=C2=A0
> > https://lore.kernel.org/lkml/20221208084127.17443-1-samuel@sholland.org=
/
> > =C2=A0- Ethernet MAC binding fix (not a new issue with D1):
> > =C2=A0=C2=A0
> > https://lore.kernel.org/lkml/20221208061616.7806-1-samuel@sholland.org/
> > =C2=A0- TI ADC101C ADC (accepted, not yet in linux-next):
> > =C2=A0=C2=A0
> > https://lore.kernel.org/lkml/20221125220903.8632-1-samuel@sholland.org/
> >=20
> > The only remaining DT validation issue is that gpio-fan is missing
> > a
> > YAML conversion, although one is on the list here:
> > https://lore.kernel.org/lkml/20220126200350.3633576-1-clabbe@baylibre.c=
om/
>=20
> With the above 4 in next:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Corentin's patch looked like it needed only minor changes. I shall go
> ping it :)

In addition I think Corentin's patch shouldn't be a blocking issue.
This patchset does not depend on DT binding being converted to YAML,
TXT binding is enough as dependency.

>=20
> >=20
> > $ make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-musl- dtbs_check
> > =C2=A0 SYNC=C2=A0=C2=A0=C2=A0 include/config/auto.conf.cmd
> > =C2=A0 LINT=C2=A0=C2=A0=C2=A0 Documentation/devicetree/bindings
> > =C2=A0 CHKDT=C2=A0=C2=A0 Documentation/devicetree/bindings/processed-sc=
hema.json
> > =C2=A0 SCHEMA=C2=A0 Documentation/devicetree/bindings/processed-schema.=
json
> > =C2=A0 DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-
> > v3.14.dtb
> > =C2=A0 DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dt=
b
> > =C2=A0 DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-
> > stu.dtb
> > =C2=A0 DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-
> > panel-480p.dtb
> > =C2=A0 DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-
> > panel-720p.dtb
> > =C2=A0 DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-
> > dock.dtb
> > =C2=A0 DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dtb
> > =C2=A0 DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-
> > pro.dtb
> > =C2=A0 DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dtb
> > =C2=A0 DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dtb
> > arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dtb:0:0:
> > /fan: failed to match any schema with compatible: ['gpio-fan']
> >=20
> > Note that validation requires dt-schema v2022.12 or newer.
> >=20
> > I tested this series (DMIC, Ethernet, LEDs, MMC, PMIC, touch, and
> > USB,
> > all where available) on the following boards:
> > =C2=A0- sun20i-d1-devterm-v3.14
> > =C2=A0- sun20i-d1-dongshan-nezha-stu
> > =C2=A0- sun20i-d1-lichee-rv-86-panel-480p
> > =C2=A0- sun20i-d1-mangopi-mq-pro
> > =C2=A0- sun20i-d1-nezha
> > =C2=A0- sun20i-d1s-mangopi-mq
> >=20
> > Changes in v3:
> > =C2=A0- Drop dummy DCXO clock-frequency property
> > =C2=A0- Decrease the PLIC's riscv,ndev property to 175
> > =C2=A0- Fix `make W=3D1 dtbs` warnings (unnecessary #address/#size-cell=
s)
> > =C2=A0- Drop mmc aliases
> > =C2=A0- Change LED_FUNCTION_BACKLIGHT to LED_FUNCTION_STATUS (the
> > backlight
> > =C2=A0=C2=A0 regulator is disconnected by default, so this is a standal=
one
> > LED)
> > =C2=A0- Fix `make W=3D1 dtbs` warnings (missing reg properties)
> > =C2=A0- ARCH_SUNXI depends on MMU && !XIP_KERNEL
> >=20
> > Changes in v2:
> > =C2=A0- Add MangoPi MQ (non-Pro) board
> > =C2=A0- Split into separate files for sharing with D1s/R528/T113
> > =C2=A0- Use SOC_PERIPHERAL_IRQ macro for interrupts
> > =C2=A0- Rename osc24M to dcxo and move the frequency to the board DTs
> > =C2=A0- Drop analog LDOs due to the missing binding
> > =C2=A0- Correct tcon_top DSI clock reference
> > =C2=A0- Add DMIC, DSI controller, and DPHY (bindings are in linux-next)
> > =C2=A0- Add CPU OPP table
> > =C2=A0- Common regulators moved to MangoPi MQ patch, removed analog LDO=
s
> > =C2=A0- Removed LRADC (depends on analog LDOs)
> > =C2=A0- Added XR829 host-wake interrupt
> > =C2=A0- Added DMIC sound card to Lichee RV dock and Lichee RV 86 Panel
> > =C2=A0- Removed LRADC (depends on analog LDOs)
> > =C2=A0- Added LED (GPIO shared between onboard LED and backlight
> > regulator)
> > =C2=A0- Added PMIC GPIO controller node (binding merged for 6.2)
> > =C2=A0- Sort Kconfig as if we had done s/SOC_/ARCH_/ for future-proofin=
g
> >=20
> > Samuel Holland (12):
> > =C2=A0 MAINTAINERS: Match the sun20i family of Allwinner SoCs
> > =C2=A0 dt-bindings: vendor-prefixes: Add Allwinner D1/D1s board vendors
> > =C2=A0 dt-bindings: riscv: Add Allwinner D1/D1s board compatibles
> > =C2=A0 riscv: dts: allwinner: Add the D1/D1s SoC devicetree
> > =C2=A0 riscv: dts: allwinner: Add MangoPi MQ devicetree
> > =C2=A0 riscv: dts: allwinner: Add Allwinner D1 Nezha devicetree
> > =C2=A0 riscv: dts: allwinner: Add Sipeed Lichee RV devicetrees
> > =C2=A0 riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
> > =C2=A0 riscv: dts: allwinner: Add Dongshan Nezha STU devicetree
> > =C2=A0 riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees
> > =C2=A0 riscv: Add the Allwinner SoC family Kconfig option
> > =C2=A0 riscv: defconfig: Enable the Allwinner D1 platform and drivers
> >=20
> > =C2=A0.../devicetree/bindings/riscv/sunxi.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 69 ++
> > =C2=A0.../devicetree/bindings/vendor-prefixes.yaml=C2=A0 |=C2=A0=C2=A0 =
4 +
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 2 +-
> > =C2=A0arch/riscv/Kconfig.socs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 10 +
> > =C2=A0arch/riscv/boot/dts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
> > =C2=A0arch/riscv/boot/dts/allwinner/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 11 +
> > =C2=A0.../allwinner/sun20i-common-regulators.dtsi=C2=A0=C2=A0 |=C2=A0 3=
5 +
> > =C2=A0.../allwinner/sun20i-d1-clockworkpi-v3.14.dts | 252 ++++++
> > =C2=A0.../dts/allwinner/sun20i-d1-devterm-v3.14.dts |=C2=A0 36 +
> > =C2=A0.../sun20i-d1-dongshan-nezha-stu.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 117 +++
> > =C2=A0.../sun20i-d1-lichee-rv-86-panel-480p.dts=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 29 +
> > =C2=A0.../sun20i-d1-lichee-rv-86-panel-720p.dts=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 10 +
> > =C2=A0.../sun20i-d1-lichee-rv-86-panel.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 119 +++
> > =C2=A0.../allwinner/sun20i-d1-lichee-rv-dock.dts=C2=A0=C2=A0=C2=A0 |=C2=
=A0 97 ++
> > =C2=A0.../dts/allwinner/sun20i-d1-lichee-rv.dts=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 87 ++
> > =C2=A0.../allwinner/sun20i-d1-mangopi-mq-pro.dts=C2=A0=C2=A0=C2=A0 | 14=
2 +++
> > =C2=A0.../boot/dts/allwinner/sun20i-d1-nezha.dts=C2=A0=C2=A0=C2=A0 | 16=
6 ++++
> > =C2=A0arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi=C2=A0 |=C2=A0 66 ++
> > =C2=A0.../dts/allwinner/sun20i-d1s-mangopi-mq.dts=C2=A0=C2=A0 | 134 +++
> > =C2=A0arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |=C2=A0 76 ++
> > =C2=A0.../boot/dts/allwinner/sunxi-d1-t113.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 15 +
> > =C2=A0.../boot/dts/allwinner/sunxi-d1s-t113.dtsi=C2=A0=C2=A0=C2=A0 | 83=
7
> > ++++++++++++++++++
> > =C2=A0arch/riscv/configs/defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
22 +-
> > =C2=A023 files changed, 2335 insertions(+), 2 deletions(-)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/riscv/sunxi.yaml
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-common-
> > regulators.dtsi
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-
> > clockworkpi-v3.14.dts
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-
> > devterm-v3.14.dts
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-
> > dongshan-nezha-stu.dts
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee=
-
> > rv-86-panel-480p.dts
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee=
-
> > rv-86-panel-720p.dts
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee=
-
> > rv-86-panel.dtsi
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee=
-
> > rv-dock.dts
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee=
-
> > rv.dts
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-
> > mangopi-mq-pro.dts
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-
> > nezha.dts
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s-
> > mangopi-mq.dts
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sunxi-d1-
> > t113.dtsi
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sunxi-d1s-
> > t113.dtsi
> >=20
> > --=20
> > 2.37.4
> >=20
> >=20

