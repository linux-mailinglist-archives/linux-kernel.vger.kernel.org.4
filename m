Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961976F0365
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243337AbjD0J2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbjD0J2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:28:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A92212D;
        Thu, 27 Apr 2023 02:28:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f178da21afso55333465e9.1;
        Thu, 27 Apr 2023 02:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682587695; x=1685179695;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gRyv9/c3hiQ7r5QJojLuvI4Uzi5JVoUb74Y2iMoY+Y=;
        b=oewTNZabFK2Yqd114dg9u/afFL6NUGghYQtxENi4k3ZewcX+4in5J9Pqwy0xUt2I/+
         I93f4pDsiTVklaCqOoZunN2RUOPSbAeiShQq9NHzBGMKR1ejDjdE47CvyjxC5vhwIDeG
         jex9eV7R1aoVmJBZxuYkacJy6OEUSFgvqfyVakIrrgSBlGbtfzHTfdk9xsvy175jTLHq
         IpupsZopztl9zZNy3Xh331rtYJV4kujP+nZKJU7/Nt4TOPE+xP01FwlpDVL8Rca1xd2K
         QL++E/00cnmQ7x9+DpvnDxPwaLcEPfneghoqlYS3oCtpZuCkkxlRz/kZ6Nm9IT/mOZxL
         qFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682587695; x=1685179695;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gRyv9/c3hiQ7r5QJojLuvI4Uzi5JVoUb74Y2iMoY+Y=;
        b=fNMidikSL6foVvKrr3xPMYvmyjwMN//WOrGXumTCiGUwMllWw3tJWNCL8CqDs0B4UL
         N/6m9Y/Bx4p6imHkzJNos89l3zlQ1BQvL/hdl1AR5WSTTnAS6S/39xBF9/rbZBSVhxlH
         j92gNBzqs1McUXx7NMv5tpXsKx8cuT4XVWiW1ZP62s5JmQpTyHREU2sONXY4K3qnUKj+
         nQWATmc2vCKhJ6i4lFrawZcyADEgW3qAaxY8F/45gB9thFha17goE6HKOTdbZNlW0Dkd
         0eLMcDCERhdoLHCi5szmRr/m8y+ItKJMFmGvHnNh40GLGSFV4mXCFveeT0VKehB5ZYQs
         /g/w==
X-Gm-Message-State: AC+VfDzeWPvUp9o7hBRJkzyTZIoTrFJDpkGLE0czQ4/DmsxJ0TqyDvmI
        pBqz2lb0raNxDYi+gjalk7kzCLID+p0=
X-Google-Smtp-Source: ACHHUZ65pFzJpzljmfjsh3vnqlyNuO+P+qMyYfCpjWhtjLe/uJ8pKsdXDuff/McAilSu3ppiZPeL3g==
X-Received: by 2002:a05:600c:b49:b0:3f1:82d8:8fde with SMTP id k9-20020a05600c0b4900b003f182d88fdemr1052490wmr.24.1682587695334;
        Thu, 27 Apr 2023 02:28:15 -0700 (PDT)
Received: from smtpclient.apple ([94.57.164.107])
        by smtp.gmail.com with ESMTPSA id p10-20020a1c544a000000b003f03d483966sm23976695wmi.44.2023.04.27.02.28.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Apr 2023 02:28:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH V2] arm64: dts: add support for C3 based Amlogic AW409
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20230427085859.793802-1-xianwei.zhao@amlogic.com>
Date:   Thu, 27 Apr 2023 10:28:06 +0100
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
Message-Id: <1C87B1C1-122F-491C-9D3A-1FE1EF6F2B87@gmail.com>
References: <20230427085859.793802-1-xianwei.zhao@amlogic.com>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
>         Modify node name, and delete superfluous blank lines.
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

