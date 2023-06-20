Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A585736DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjFTNtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjFTNtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:49:14 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1E419A2;
        Tue, 20 Jun 2023 06:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=MbhnEmhZxIHf1fmMfV+bQAd3pFabyEe6Z/SMW51uWPM=;
        b=1Vp9XkkohvW4nSYivy9P2WPhdL5SiHovDrprm9s2nbFcbHpoOfLfKRQmLmXotQdBBkZNDdqGpN4
        Qxwm4LNFDMoNKMuWLfMPRURRv9cmDrNhI47GZVz3x7YuJGRunf/9MZr6C1fX0FbRTn7/lE1SnKfzB
        TD3DEO2d0UC4d1fTlF8XseTeAGjZZAEBMgmYadaX14PfNqiCAMuGC2RB3tThVH+QFAg5Ljlr/mTWA
        1kQsaIEecIR8VakHExxK3hexrfthFvX2KChS6L3yffJnJnNgMmzhp45F8inq3b/89Lzoo/c3BBoKC
        QYEaye6IHsYzkWLs4vFbs7IHv6jlDeN6A8GA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qBbiu-000EjF-8h; Tue, 20 Jun 2023 15:48:44 +0200
Received: from [2a06:4004:10df:0:41df:3def:a404:e612] (helo=smtpclient.apple)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qBbit-000Hxh-NW; Tue, 20 Jun 2023 15:48:43 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH 4/5] ARM: dts: stm32: Add Octavo STM32MP15x SiP
From:   Sean Nyekjaer <sean@geanix.com>
In-Reply-To: <20230620114138.959812-4-sean@geanix.com>
Date:   Tue, 20 Jun 2023 15:48:32 +0200
Cc:     dantuguf14105@gmail.com,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A92AE452-7E4D-4CB5-87AA-02E0A5F8A2EE@geanix.com>
References: <20230620114138.959812-1-sean@geanix.com>
 <20230620114138.959812-4-sean@geanix.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26945/Tue Jun 20 09:30:24 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 20 Jun 2023, at 13.41, Sean Nyekjaer <sean@geanix.com> wrote:
>=20
> Octavo STM32MP15x is a System-in-Package based on STM32MP15xx SoC from =
ST.
>=20
> This SiP module integrates the SoC, DDR Memory, PMIC, EEPROM etc.
>=20
> https://octavosystems.com/octavo_products/osd32mp15x/
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---

Hi,

I just saw the stm32mp15xx-osd32.dtsi :/

I will merge these changes into that one.

/Sean

> arch/arm/boot/dts/stm32mp15xx-osd32mp1.dtsi | 308 ++++++++++++++++++++
> 1 file changed, 308 insertions(+)
> create mode 100644 arch/arm/boot/dts/stm32mp15xx-osd32mp1.dtsi
>=20
> diff --git a/arch/arm/boot/dts/stm32mp15xx-osd32mp1.dtsi =
b/arch/arm/boot/dts/stm32mp15xx-osd32mp1.dtsi
> new file mode 100644
> index 000000000000..b89e0e42d296
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp15xx-osd32mp1.dtsi
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) Geanix ApS 2023 - All Rights Reserved
> + * Author: Sean Nyekjaer <sean@geanix.com>
> + */
> +
> +#include "stm32mp15-pinctrl.dtsi"
> +#include "stm32mp15xxac-pinctrl.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/mfd/st,stpmic1.h>
> +#include <dt-bindings/pinctrl/stm32-pinfunc.h>
> +
> +/ {
> + reserved-memory {
> + #address-cells =3D <1>;
> + #size-cells =3D <1>;
> + ranges;
> +
> + mcuram2: mcuram2@10000000 {
> + compatible =3D "shared-dma-pool";
> + reg =3D <0x10000000 0x40000>;
> + no-map;
> + };
> +
> + vdev0vring0: vdev0vring0@10040000 {
> + compatible =3D "shared-dma-pool";
> + reg =3D <0x10040000 0x1000>;
> + no-map;
> + };
> +
> + vdev0vring1: vdev0vring1@10041000 {
> + compatible =3D "shared-dma-pool";
> + reg =3D <0x10041000 0x1000>;
> + no-map;
> + };
> +
> + vdev0buffer: vdev0buffer@10042000 {
> + compatible =3D "shared-dma-pool";
> + reg =3D <0x10042000 0x4000>;
> + no-map;
> + };
> +
> + mcuram: mcuram@30000000 {
> + compatible =3D "shared-dma-pool";
> + reg =3D <0x30000000 0x40000>;
> + no-map;
> + };
> +
> + retram: retram@38000000 {
> + compatible =3D "shared-dma-pool";
> + reg =3D <0x38000000 0x10000>;
> + no-map;
> + };
> +
> + gpu_reserved: gpu@d4000000 {
> + reg =3D <0xd4000000 0x4000000>;
> + no-map;
> + };
> + };
> +
> + vin: vin {
> + compatible =3D "regulator-fixed";
> + regulator-name =3D "vin";
> + regulator-min-microvolt =3D <5000000>;
> + regulator-max-microvolt =3D <5000000>;
> + regulator-always-on;
> + };
> +};
> +
> +&m4_rproc {
> + memory-region =3D <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
> + <&vdev0vring1>, <&vdev0buffer>;
> + mboxes =3D <&ipcc 0>, <&ipcc 1>, <&ipcc 2>, <&ipcc 3>;
> + mbox-names =3D "vq0", "vq1", "shutdown", "detach";
> + interrupt-parent =3D <&exti>;
> + interrupts =3D <68 1>;
> + status =3D "okay";
> +};
> +
> +&gpu {
> + contiguous-area =3D <&gpu_reserved>;
> +};
> +
> +&hash1 {
> + status =3D "okay";
> +};
> +
> +&cryp1 {
> + status =3D "okay";
> +};
> +
> +&i2c4 {
> + pinctrl-names =3D "default", "sleep";
> + pinctrl-0 =3D <&i2c4_pins_a>;
> + pinctrl-1 =3D <&i2c4_sleep_pins_a>;
> + status =3D "okay";
> + i2c-scl-rising-time-ns =3D <185>;
> + i2c-scl-falling-time-ns =3D <20>;
> + clock-frequency =3D <400000>;
> + /delete-property/ dmas;
> + /delete-property/ dma-names;
> +
> + pmic: stpmic@33 {
> + compatible =3D "st,stpmic1";
> + reg =3D <0x33>;
> + interrupts-extended =3D <&gpioa 0 IRQ_TYPE_EDGE_FALLING>;
> + interrupt-controller;
> + #interrupt-cells =3D <2>;
> + status =3D "okay";
> +
> + regulators {
> + compatible =3D "st,stpmic1-regulators";
> + buck1-supply =3D <&vin>;
> + buck2-supply =3D <&vin>;
> + buck3-supply =3D <&vin>;
> + buck4-supply =3D <&vin>;
> + ldo1-supply =3D <&v3v3>;
> + ldo2-supply =3D <&vin>;
> + ldo3-supply =3D <&vdd_ddr>;
> + ldo4-supply =3D <&vin>;
> + ldo5-supply =3D <&vin>;
> + ldo6-supply =3D <&v3v3>;
> + vref_ddr-supply =3D <&vin>;
> + boost-supply =3D <&vin>;
> + pwr_sw1-supply =3D <&bst_out>;
> + pwr_sw2-supply =3D <&bst_out>;
> +
> + vddcore: buck1 {
> + regulator-name =3D "vddcore";
> + regulator-min-microvolt =3D <1200000>;
> + regulator-max-microvolt =3D <1350000>;
> + regulator-always-on;
> + regulator-initial-mode =3D <0>;
> + regulator-over-current-protection;
> + };
> +
> + vdd_ddr: buck2 {
> + regulator-name =3D "vdd_ddr";
> + regulator-min-microvolt =3D <1350000>;
> + regulator-max-microvolt =3D <1350000>;
> + regulator-always-on;
> + regulator-initial-mode =3D <0>;
> + regulator-over-current-protection;
> + };
> +
> + vdd: buck3 {
> + regulator-name =3D "vdd";
> + regulator-min-microvolt =3D <3300000>;
> + regulator-max-microvolt =3D <3300000>;
> + regulator-always-on;
> + st,mask-reset;
> + regulator-initial-mode =3D <0>;
> + regulator-over-current-protection;
> + };
> +
> + v3v3: buck4 {
> + regulator-name =3D "v3v3";
> + regulator-min-microvolt =3D <3300000>;
> + regulator-max-microvolt =3D <3300000>;
> + regulator-always-on;
> + regulator-over-current-protection;
> + regulator-initial-mode =3D <0>;
> + };
> +
> + ldo1: ldo1 {
> + regulator-name =3D "v1v8_audio";
> + regulator-min-microvolt =3D <1800000>;
> + regulator-max-microvolt =3D <1800000>;
> + interrupts =3D <IT_CURLIM_LDO1 0>;
> + };
> +
> + v2v8: ldo2 {
> + regulator-name =3D "v2v8";
> + regulator-min-microvolt =3D <2800000>;
> + regulator-max-microvolt =3D <2800000>;
> + interrupts =3D <IT_CURLIM_LDO2 0>;
> + };
> +
> + vtt_ddr: ldo3 {
> + regulator-name =3D "vtt_ddr";
> + regulator-min-microvolt =3D <500000>;
> + regulator-max-microvolt =3D <750000>;
> + regulator-always-on;
> + regulator-over-current-protection;
> + };
> +
> + vdd_usb: ldo4 {
> + regulator-name =3D "vdd_usb";
> + interrupts =3D <IT_CURLIM_LDO4 0>;
> + };
> +
> + vdda: ldo5 {
> + regulator-name =3D "vdda";
> + regulator-min-microvolt =3D <3300000>;
> + regulator-max-microvolt =3D <3300000>;
> + interrupts =3D <IT_CURLIM_LDO5 0>;
> + };
> +
> + v1v8: ldo6 {
> + regulator-name =3D "v1v8";
> + regulator-min-microvolt =3D <1800000>;
> + regulator-max-microvolt =3D <1800000>;
> + interrupts =3D <IT_CURLIM_LDO6 0>;
> + };
> +
> + vref_ddr: vref_ddr {
> + regulator-name =3D "vref_ddr";
> + regulator-always-on;
> + };
> +
> + bst_out: boost {
> + regulator-name =3D "bst_out";
> + interrupts =3D <IT_OCP_BOOST 0>;
> + };
> +
> + vbus_otg: pwr_sw1 {
> + regulator-name =3D "vbus_otg";
> + interrupts =3D <IT_OCP_OTG 0>;
> + };
> +
> + vbus_sw: pwr_sw2 {
> + regulator-name =3D "vbus_sw";
> + interrupts =3D <IT_OCP_SWOUT 0>;
> + regulator-active-discharge =3D <1>;
> + };
> + };
> +
> + onkey {
> + compatible =3D "st,stpmic1-onkey";
> + interrupts =3D <IT_PONKEY_F 0>, <IT_PONKEY_R 0>;
> + interrupt-names =3D "onkey-falling", "onkey-rising";
> + power-off-time-sec =3D <10>;
> + status =3D "okay";
> + };
> +
> + watchdog {
> + compatible =3D "st,stpmic1-wdt";
> + status =3D "disabled";
> + };
> + };
> +
> + eeprom@50 {
> + compatible =3D "atmel,24c02";
> + reg =3D <0x50>;
> + pagesize =3D <16>;
> + };
> +};
> +
> +&cpu0 {
> + cpu-supply =3D <&vddcore>;
> +};
> +
> +&cpu1 {
> + cpu-supply =3D <&vddcore>;
> +};
> +
> +&ipcc {
> + status =3D "okay";
> +};
> +
> +&pwr_regulators {
> + vdd-supply =3D <&vdd>;
> + vdd_3v3_usbfs-supply =3D <&vdd_usb>;
> +};
> +
> +&rng1 {
> + status =3D "okay";
> +};
> +
> +&rtc {
> + status =3D "okay";
> +};
> +
> +&crc1 {
> + status =3D "okay";
> +};
> +
> +&dts {
> + status =3D "okay";
> +};
> +
> +&usbh_ehci {
> + phys =3D <&usbphyc_port0>;
> + phy-names =3D "usb";
> + status =3D "okay";
> +};
> +
> +&usbh_ohci {
> + phys =3D <&usbphyc_port0>;
> + phy-names =3D "usb";
> + status =3D "okay";
> +};
> +
> +&usbotg_hs {
> + vbus-supply =3D <&vbus_otg>;
> +};
> +
> +&usbphyc {
> + status =3D "okay";
> +};
> +
> +&usbphyc_port0 {
> + phy-supply =3D <&vdd_usb>;
> +};
> +
> +&usbphyc_port1 {
> + phy-supply =3D <&vdd_usb>;
> +};
> --=20
> 2.40.0
>=20


