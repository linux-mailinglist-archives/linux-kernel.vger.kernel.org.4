Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A056CC9D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjC1R6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjC1R6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F54F1BC2;
        Tue, 28 Mar 2023 10:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC12618CF;
        Tue, 28 Mar 2023 17:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5AAC433EF;
        Tue, 28 Mar 2023 17:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680026280;
        bh=Ib0TeEbZ2cwg8aSfAANNAHICaPz76LsEnrLxN+yLCao=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JfsCV1Inw6I0q8kDdQwAjmxyrup3uT8e3KFYzTujUsokHWACrpONGwFUc7FjuRI0z
         OT6PayAgdUAohie/0UnE3to1UcP4A8Sg/Bby9mNdxRkXkMgyIx/Tv2oHI4d58isxAr
         cHkMLUBT0UeTneItUc0e8U5QZyHdWps6vvrAy9EQHfW8jQlN/cxmtjg5clbAF0/4Iu
         ARyk+x8+zXBOHwWvvE3kzEjRRBe7uabT000msJ4kkFUREakycpt63FL0zFCvfQRThL
         d43arIL5LGXhhiKEBGHq3KuoS48+BRJxVP/sFuerEX23dYM5WQYoLLVzMJjrTvxHpU
         xdSsaoKOpX4sQ==
Message-ID: <ab4e0bc8834b7e618e9a88ea6a1c30cc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230328021912.177301-9-ychuang570808@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com> <20230328021912.177301-9-ychuang570808@gmail.com>
Subject: Re: [PATCH v6 08/12] arm64: dts: nuvoton: Add initial ma35d1 device tree
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
To:     Jacky Huang <ychuang570808@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Date:   Tue, 28 Mar 2023 10:57:57 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacky Huang (2023-03-27 19:19:08)
> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dt=
s/nuvoton/ma35d1.dtsi
> new file mode 100644
> index 000000000000..0740b0b218a7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Shan-Chun Hung <schung@nuvoton.com>
> + *         Jacky huang <ychuang3@nuvoton.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +
> +/ {
> +       compatible =3D "nuvoton,ma35d1";
> +       interrupt-parent =3D <&gic>;
> +       #address-cells =3D <2>;
> +       #size-cells =3D <2>;
> +
> +       cpus {
> +               #address-cells =3D <2>;
> +               #size-cells =3D <0>;
> +
> +               cpu0: cpu@0 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "arm,cortex-a35";
> +                       reg =3D <0x0 0x0>;
> +                       enable-method =3D "psci";
> +                       next-level-cache =3D <&L2_0>;
> +               };
> +
> +               cpu1: cpu@1 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "arm,cortex-a35";
> +                       reg =3D <0x0 0x1>;
> +                       enable-method =3D "psci";
> +                       next-level-cache =3D <&L2_0>;
> +               };
> +
> +               L2_0: l2-cache0 {

Just l2-cache for the node name. Doesn't it go under the cpu0 node as
well?

> +                       compatible =3D "cache";
> +                       cache-level =3D <2>;
> +               };
> +       };
> +
> +       psci {
> +               compatible =3D "arm,psci-0.2";
> +               method =3D "smc";
> +       };
> +
> +       timer {
> +               compatible =3D "arm,armv8-timer";
> +               interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> +                             IRQ_TYPE_LEVEL_LOW)>, /* Physical Secure */
> +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> +                             IRQ_TYPE_LEVEL_LOW)>, /* Physical Non-Secur=
e */
> +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
> +                             IRQ_TYPE_LEVEL_LOW)>, /* Virtual */
> +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
> +                             IRQ_TYPE_LEVEL_LOW)>; /* Hypervisor */
> +               clock-frequency =3D <12000000>;

Remove this property. The frequency should be read by the driver.

> +               interrupt-parent =3D <&gic>;
> +       };

Please create an 'soc' node for the SoC to hold all the nodes that have
a reg property.

> +
> +       sys: system-management@40460000 {
> +               compatible =3D "nuvoton,ma35d1-sys", "syscon", "simple-mf=
d";
> +               reg =3D <0x0 0x40460000 0x0 0x200>;
> +
> +               reset: reset-controller {
> +                       compatible =3D "nuvoton,ma35d1-reset";
> +                       #reset-cells =3D <1>;
> +               };
> +       };
> +
> +       clk: clock-controller@40460200 {
> +               compatible =3D "nuvoton,ma35d1-clk", "syscon";
> +               reg =3D <0x00000000 0x40460200 0x0 0x100>;
> +               #clock-cells =3D <1>;
> +               clocks =3D <&clk_hxt>;
> +               nuvoton,sys =3D <&sys>;
> +       };

It looks like the device at 40460000 is a reset and clock controller.
Just make it one node and register the clk or reset device as an
auxiliary device.

> +
> +       gic: interrupt-controller@50801000 {
> +               compatible =3D "arm,gic-400";
> +               reg =3D   <0x0 0x50801000 0 0x1000>, /* GICD */
> +                       <0x0 0x50802000 0 0x2000>, /* GICC */
> +                       <0x0 0x50804000 0 0x2000>, /* GICH */
> +                       <0x0 0x50806000 0 0x2000>; /* GICV */
> +               #interrupt-cells =3D <3>;
> +               interrupt-parent =3D <&gic>;
> +               interrupt-controller;
> +               interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
> +                             IRQ_TYPE_LEVEL_HIGH)>;
> +       };
> +
> +       uart0:serial@40700000 {

Add a space after :

> +               compatible =3D "nuvoton,ma35d1-uart";
> +               reg =3D <0x0 0x40700000 0x0 0x100>;
> +               interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks =3D <&clk UART0_GATE>;
> +               status =3D "disabled";
> +       };
