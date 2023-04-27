Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212CB6F036D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbjD0JdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243188AbjD0JdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:33:06 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Apr 2023 02:33:04 PDT
Received: from m239-7.eu.mailgun.net (m239-7.eu.mailgun.net [185.250.239.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4BD2D69
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:33:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hewittfamily.org.uk;
 q=dns/txt; s=s1; t=1682587982; x=1682595182; h=To: To: References:
 Message-Id: Content-Transfer-Encoding: Cc: Date: In-Reply-To: From: From:
 Subject: Subject: Mime-Version: Content-Type: Sender: Sender;
 bh=WKlhktvkNCXudJUIlMvUHYKEozR+HdTU1JB7gKtNB7E=;
 b=PvEsJ+Anx+SM2aJP2Bh5/2xq4wmeHtdarl/dA/AyiS6uJQN6skV2/DMNMLdvN/8AfBumMb06ltg9LLaGbhiBKA44cQJed3m4qHDdPK4bt8EclOk8f2xvI0hd28sHGaCbgrX6HANWQtXLyHQcpGdzAb6T0NTdzgiFmcgxuffycz+gdAf74m1qY9KDamiqyMUB0kpNB470QAUFAv5H5thz5RgdBYaxHmdAtDWWSdkVbGaypYRoSf2dt/qBK2GcsXy6Ru9LR7ozSbU6F/SHS9aCb7AWRaVLJVfWSloZ1+LNBsEF4mVPPfyiuHsM8XoCJ+ZPLRn8yLatri9iUA/78xK2RQ==
X-Mailgun-Sending-Ip: 185.250.239.7
X-Mailgun-Sid: WyIyNWUwNSIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCJlMzcyMCJd
Received: from mail.hewittfamily.org.uk (<unknown> [87.200.95.144]) by fe978277b15e with
 SMTP id 644a401f90677e019261cb9e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Apr 2023 09:27:59 GMT
Sender: christian@hewittfamily.org.uk
Received: from smtpclient.apple (unknown [94.57.164.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.hewittfamily.org.uk (Postfix) with ESMTPSA id 990768CBB78;
        Thu, 27 Apr 2023 13:27:54 +0400 (+04)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH V2] arm64: dts: add support for C3 based Amlogic AW409
From:   Christian Hewitt <christian@hewittfamily.org.uk>
In-Reply-To: <20230427085859.793802-1-xianwei.zhao@amlogic.com>
Date:   Thu, 27 Apr 2023 10:26:47 +0100
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C020F0D-315C-4281-BA0E-1E5CFAC97C39@hewittfamily.org.uk>
References: <20230427085859.793802-1-xianwei.zhao@amlogic.com>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-Synology-Spam-Status: score=0.399, required 5, MID_RHS_MATCH_FROM 0, FROM_HAS_DN 0, TO_DN_SOME 0, MV_CASE 0.5, TO_MATCH_ENVRCPT_ALL 0, MIME_GOOD -0.1, __THREADED 0, RCPT_COUNT_SEVEN 0, RCVD_COUNT_ZERO 0, FROM_EQ_ENVFROM 0, MIME_TRACE 0, __NOT_SPOOFED 0, __BODY_URI_ONLY 0, __HDRS_LCASE_KNOWN 0, NO_RECEIVED -0.001
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 27 Apr 2023, at 9:58 am, Xianwei Zhao <xianwei.zhao@amlogic.com> =
wrote:
>=20
> Amlogic C3 is an advanced edge AI processor designed for smart IP =
camera
> applications.
>=20
> Add basic support for the C3 based Amlogic AW409 board, which =
describes
> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
> booting up into the serial console.
>=20
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>=20
> ---
> V1 -> V2: Remove new arch, and use ARCH_MESON;
>          Modify node name, and delete superfluous blank lines.
> ---
> arch/arm64/boot/dts/amlogic/Makefile          |  1 +
> .../amlogic/amlogic-c3-c302x-aw409-256m.dts   | 29 +++++++
> arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 86 +++++++++++++++++++
> 3 files changed, 116 insertions(+)
> create mode 100644 =
arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
> create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile =
b/arch/arm64/boot/dts/amlogic/Makefile
> index cd1c5b04890a..bcec872c2444 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -74,3 +74,4 @@ dtb-$(CONFIG_ARCH_MESON) +=3D =
meson-sm1-odroid-hc4.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-sei610.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-x96-air-gbit.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-x96-air.dtb
> +dtb-$(CONFIG_ARCH_MESON) +=3D amlogic-c3-c302x-aw409-256m.dtb

^ please keep the list alpha-sorted, and 256m is described in the dts
so there is no need to include it in the board filename. I would also
expect meson-c3* to align with existing filenames, but I=E2=80=99ll let =
others
comment on naming rules.

Christian

> diff --git =
a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts =
b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
> new file mode 100644
> index 000000000000..edce8850b338
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "amlogic-c3.dtsi"
> +
> +/ {
> +	model =3D "Amlogic C302 aw409 Development Board";
> +	compatible =3D "amlogic,aw409", "amlogic,c3";
> +	interrupt-parent =3D <&gic>;
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +
> +	aliases {
> +		serial0 =3D &uart_b;
> +	};
> +
> +	memory@0 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x0 0x0 0x10000000>;
> +	};
> +};
> +
> +&uart_b {
> +	status =3D "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi =
b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> new file mode 100644
> index 000000000000..93b335aef605
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	cpus {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type =3D "cpu";
> +			compatible =3D "arm,cortex-a35";
> +			reg =3D <0x0 0x0>;
> +			enable-method =3D "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type =3D "cpu";
> +			compatible =3D "arm,cortex-a35";
> +			reg =3D <0x0 0x1>;
> +			enable-method =3D "psci";
> +		};
> +	};
> +
> +	timer {
> +		compatible =3D "arm,armv8-timer";
> +		interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | =
IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | =
IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | =
IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | =
IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	psci {
> +		compatible =3D "arm,psci-1.0";
> +		method =3D "smc";
> +	};
> +
> +	xtal: xtal-clk {
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <24000000>;
> +		clock-output-names =3D "xtal";
> +		#clock-cells =3D <0>;
> +	};
> +
> +	soc {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		gic: interrupt-controller@fff01000 {
> +			compatible =3D "arm,gic-400";
> +			#interrupt-cells =3D <3>;
> +			#address-cells =3D <0>;
> +			interrupt-controller;
> +			reg =3D <0x0 0xfff01000 0 0x1000>,
> +			      <0x0 0xfff02000 0 0x2000>,
> +			      <0x0 0xfff04000 0 0x2000>,
> +			      <0x0 0xfff06000 0 0x2000>;
> +			interrupts =3D <GIC_PPI 9 =
(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
> +		apb4: bus@fe000000 {
> +			compatible =3D "simple-bus";
> +			reg =3D <0x0 0xfe000000 0x0 0x480000>;
> +			#address-cells =3D <2>;
> +			#size-cells =3D <2>;
> +			ranges =3D <0x0 0x0 0x0 0xfe000000 0x0 =
0x480000>;
> +
> +			uart_b: serial@7a000 {
> +				compatible =3D =
"amlogic,meson-g12a-uart";
> +				reg =3D <0x0 0x7a000 0x0 0x18>;
> +				interrupts =3D <GIC_SPI 169 =
IRQ_TYPE_EDGE_RISING>;
> +				status =3D "disabled";
> +				clocks =3D <&xtal>, <&xtal>, <&xtal>;
> +				clock-names =3D "xtal", "pclk", "baud";
> +			};
> +
> +		};
> +	};
> +};
>=20
> base-commit: ae68fb187b59bc8645974320808ab2d7c41b1833
> --=20
> 2.37.1
>=20
>=20
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

