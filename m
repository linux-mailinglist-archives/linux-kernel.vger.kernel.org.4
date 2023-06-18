Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E91734754
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 19:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjFRRmG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 18 Jun 2023 13:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRRmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 13:42:03 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB6E1B5;
        Sun, 18 Jun 2023 10:42:01 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-76255e34663so58099385a.0;
        Sun, 18 Jun 2023 10:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687110120; x=1689702120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rs7djGRDMu1aZXDhugX14SPLxQVWX7l11QLi7OKMns=;
        b=Zr9XUwh5ZLaYPOQIxMbhqIC9uIK8DYoXV+B9u/fCGz4pYK5mQQNcWx9cmxYPjVOfOa
         f6epM9kuqxXKXFPxd5MVJwTXPTJ6QFcoeOiLqHcxOsmF83P3aLMQgZawM2F6lvOxaTbx
         GYRB/gAhtbzluJjUIsJw0BUOejGpgaz8hDJxPjfI+MdOw0pDfVeUvgoFFW5NXyA0Xl8l
         BICV/Wd5bY1H4NkA32SL6n2A46V6q4XIUyXSJ1OLNn90YKXt/+2A0ldzul/6XLs+afSM
         i/ZGFUXIjts6xe6cfeiGShXhDjnBOYEBtfDMI5u6pmM3iI4mfEgWv4Amucrpq6EqyyuN
         vkSQ==
X-Gm-Message-State: AC+VfDw1uIwO88eG/DvgnWFYpgWuEOUWlhLeR09DDykkM1ecyCq9Jwfp
        XMV+NO15bHdqtDkCFyzNpQ1yeWnyfZIZm/iTDM8=
X-Google-Smtp-Source: ACHHUZ6iaFLF22nJx00USsTKYgpvIK9MDJSjfPRKxE507vsKGxcMB1KMAW4OmXJ/1oj3NsL4TW/2GA==
X-Received: by 2002:a05:620a:a1b:b0:762:5aff:2386 with SMTP id i27-20020a05620a0a1b00b007625aff2386mr1734414qka.3.1687110119983;
        Sun, 18 Jun 2023 10:41:59 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id h2-20020a37c442000000b007623a6ec960sm2502093qkm.124.2023.06.18.10.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 10:41:59 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7623e09e7aaso134185085a.2;
        Sun, 18 Jun 2023 10:41:59 -0700 (PDT)
X-Received: by 2002:a05:6214:f29:b0:623:883a:3137 with SMTP id
 iw9-20020a0562140f2900b00623883a3137mr9867954qvb.51.1687110118841; Sun, 18
 Jun 2023 10:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230615182938.18487-1-tanure@linux.com> <20230615182938.18487-7-tanure@linux.com>
 <ZIumTthAmBLBxpXn@ofant>
In-Reply-To: <ZIumTthAmBLBxpXn@ofant>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Sun, 18 Jun 2023 18:41:47 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+14r0knLHLg0=G_kA=JhVvhZD1VRK=xuKkvTzwg820coA@mail.gmail.com>
Message-ID: <CAJX_Q+14r0knLHLg0=G_kA=JhVvhZD1VRK=xuKkvTzwg820coA@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: meson-t7-a311d2-khadas-vim4: add initial device-tree
To:     Yixun Lan <dlan@gentoo.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 1:01 AM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Lucas:
>
> On 19:29 Thu 15 Jun     , Lucas Tanure wrote:
> > The Khadas VIM4 uses the Amlogic A311D2 SoC, based on the Amlogic T7 SoC
> > family, on a board with the same form factor as the VIM3 models.
> I'd like to see little bit more verbose messages here, like
> which functionality/driver added here - cpu, gic, timer, uart?
Ok, I add this information in the next version.
Its adding CPU, GIC, and UART.

>
> so, it's capable of booting into a serial console?
yes

>
> >
> > - 8GB LPDDR4X 2016MHz
> > - 32GB eMMC 5.1 storage
> > - 32MB SPI flash
> > - 10/100/1000 Base-T Ethernet
> > - AP6275S Wireless (802.11 a/b/g/n/ac/ax, BT5.1)
> > - HDMI 2.1 video
> > - HDMI Input
> > - 1x USB 2.0 + 1x USB 3.0 ports
> > - 1x USB-C (power) with USB 2.0 OTG
> > - 3x LED's (1x red, 1x blue, 1x white)
> > - 3x buttons (power, function, reset)
> > - M2 socket with PCIe, USB, ADC & I2C
> > - 40pin GPIO Header
> > - 1x micro SD card slot
> >
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
> >  .../amlogic/meson-t7-a311d2-khadas-vim4.dts   | 112 ++++++++++
> >  arch/arm64/boot/dts/amlogic/meson-t7.dtsi     | 202 ++++++++++++++++++
> >  3 files changed, 315 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
> >  create mode 100644 arch/arm64/boot/dts/amlogic/meson-t7.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> > index cd1c5b04890a..1c5846bd1ca0 100644
> > --- a/arch/arm64/boot/dts/amlogic/Makefile
> > +++ b/arch/arm64/boot/dts/amlogic/Makefile
> > @@ -74,3 +74,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
> > +dtb-$(CONFIG_ARCH_MESON) += meson-t7-a311d2-khadas-vim4.dtb
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
> > new file mode 100644
> > index 000000000000..46e175536edf
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2022 Wesion, Inc. All rights reserved.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "meson-t7.dtsi"
> > +
> > +/ {
> > +     model = "Khadas VIM4";
> > +
> > +     aliases {
> > +             serial0 = &uart_A;
> > +     };
> > +
> > +     reserved-memory {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             /* 3 MiB reserved for ARM Trusted Firmware (BL31) */
> > +             secmon_reserved: secmon@5000000 {
> > +                     reg = <0x0 0x05000000 0x0 0x300000>;
> > +                     no-map;
> > +             };
> > +
> > +             /* 32 MiB reserved for ARM Trusted Firmware (BL32) */
> > +             secmon_reserved_bl32: secmon@5300000 {
> > +                     reg = <0x0 0x05300000 0x0 0x2000000>;
> > +                     no-map;
> > +             };
> > +     };
> > +
> > +     xtal: xtal-clk {
> > +             compatible = "fixed-clock";
> > +             clock-frequency = <24000000>;
> > +             clock-output-names = "xtal";
> > +             #clock-cells = <0>;
> > +     };
> > +
> > +     vddcpu_a: regulator-vddcpu-a {
> > +             /*
> > +              * MP8756GD Regulator.
> > +              */
> > +             compatible = "pwm-regulator";
> > +
> > +             regulator-name = "VDDCPU_A";
> > +             regulator-min-microvolt = <689000>;
> > +             regulator-max-microvolt = <1049000>;
> > +
> > +             regulator-boot-on;
> > +             regulator-always-on;
> > +     };
> > +
> > +     vddcpu_b: regulator-vddcpu-a {
> > +             /*
> > +              * MP8756GD Regulator.
> > +              */
> > +             compatible = "pwm-regulator";
> > +
> > +             regulator-name = "VDDCPU_B";
> > +             regulator-min-microvolt = <689000>;
> > +             regulator-max-microvolt = <1049000>;
> > +
> > +             regulator-boot-on;
> > +             regulator-always-on;
> > +     };
> > +};
> > +
> > +&clkc{
> > +     clocks = <&xtal>;
> > +     clock-names = "xtal";
> > +     status = "okay";
> > +};
> > +
> > +&uart_A {
> > +     status = "okay";
> > +};
> > +
> > +&cpu0 {
> > +     cpu-supply = <&vddcpu_a>;
> > +};
> > +
> > +&cpu1 {
> > +     cpu-supply = <&vddcpu_a>;
> > +};
> > +
> > +&cpu2 {
> > +     cpu-supply = <&vddcpu_a>;
> > +};
> > +
> > +&cpu3 {
> > +     cpu-supply = <&vddcpu_a>;
> > +};
> > +
> > +&cpu100 {
> > +     cpu-supply = <&vddcpu_b>;
> > +};
> > +
> > +&cpu101 {
> > +     cpu-supply = <&vddcpu_b>;
> > +};
> > +
> > +&cpu102 {
> > +     cpu-supply = <&vddcpu_b>;
> > +};
> > +
> > +&cpu103 {
> > +     cpu-supply = <&vddcpu_b>;
> > +};
> > +
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-t7.dtsi b/arch/arm64/boot/dts/amlogic/meson-t7.dtsi
> > new file mode 100644
> > index 000000000000..453b3d9cb9d8
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/amlogic/meson-t7.dtsi
> > @@ -0,0 +1,202 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> > + */
> > +
> > +#include <dt-bindings/clock/mesont7-clkc.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +     compatible = "amlogic,t7";
> > +     interrupt-parent = <&gic>;
> > +     #address-cells = <2>;
> > +     #size-cells = <2>;
> > +
> > +     cpus {
> > +             #address-cells = <0x2>;
> > +             #size-cells = <0x0>;
> > +
> > +             cpu-map {
> > +                     cluster0 {
> > +                             core0 {
> > +                                     cpu = <&cpu100>;
> > +                             };
> > +                             core1 {
> > +                                     cpu = <&cpu101>;
> > +                             };
> > +                             core2 {
> > +                                     cpu = <&cpu102>;
> > +                             };
> > +                             core3 {
> > +                                     cpu = <&cpu103>;
> > +                             };
> > +                     };
> > +
> > +                     cluster1 {
> > +                             core0 {
> > +                                     cpu = <&cpu0>;
> > +                             };
> > +                             core1 {
> > +                                     cpu = <&cpu1>;
> > +                             };
> > +                             core2 {
> > +                                     cpu = <&cpu2>;
> > +                             };
> > +                             core3 {
> > +                                     cpu = <&cpu3>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             cpu100: cpu@100 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a53";
> > +                     reg = <0x0 0x100>;
> > +                     enable-method = "psci";
> > +                     capacity-dmips-mhz = <632>;
> > +                     dynamic-power-coefficient = <110>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +
> > +             cpu101: cpu@101{
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a53";
> > +                     reg = <0x0 0x101>;
> > +                     enable-method = "psci";
> > +                     capacity-dmips-mhz = <632>;
> > +                     dynamic-power-coefficient = <110>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +
> > +             cpu102: cpu@102 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a53";
> > +                     reg = <0x0 0x102>;
> > +                     enable-method = "psci";
> > +                     capacity-dmips-mhz = <632>;
> > +                     dynamic-power-coefficient = <110>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +
> > +             cpu103: cpu@103 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a53";
> > +                     reg = <0x0 0x103>;
> > +                     enable-method = "psci";
> > +                     capacity-dmips-mhz = <632>;
> > +                     dynamic-power-coefficient = <110>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +
> > +             cpu0: cpu@0 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a73";
> > +                     reg = <0x0 0x0>;
> > +                     enable-method = "psci";
> > +                     capacity-dmips-mhz = <1024>;
> > +                     dynamic-power-coefficient = <550>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +
> > +             cpu1: cpu@1 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a73";
> > +                     reg = <0x0 0x1>;
> > +                     enable-method = "psci";
> > +                     capacity-dmips-mhz = <1024>;
> > +                     dynamic-power-coefficient = <550>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +
> > +             cpu2: cpu@2 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a73";
> > +                     reg = <0x0 0x2>;
> > +                     enable-method = "psci";
> > +                     capacity-dmips-mhz = <1024>;
> > +                     dynamic-power-coefficient = <550>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +
> > +             cpu3: cpu@3 {
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a73";
> > +                     reg = <0x0 0x3>;
> > +                     enable-method = "psci";
> > +                     capacity-dmips-mhz = <1024>;
> > +                     dynamic-power-coefficient = <550>;
> > +                     #cooling-cells = <2>;
> > +             };
> > +     };
> > +
> > +     timer {
> > +             compatible = "arm,armv8-timer";
> > +             interrupts = <GIC_PPI 13 0xff08>,
> > +                          <GIC_PPI 14 0xff08>,
> > +                          <GIC_PPI 11 0xff08>,
> > +                          <GIC_PPI 10 0xff08>;
> > +     };
> > +
> > +     gic: interrupt-controller@fff01000 {
> > +             compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> > +             #interrupt-cells = <3>;
> > +             #address-cells = <0>;
> > +             interrupt-controller;
> > +             reg = <0x0 0xfff01000 0 0x1000>,
> > +                   <0x0 0xfff02000 0 0x0100>;
> > +             interrupts = <GIC_PPI 9 0xf04>;
> > +     };
> > +
> > +     psci {
> > +             compatible = "arm,psci-0.2";
> can you double check if it is actual version 0.2?
> most recent Amlogic SoC should support psci-1.0
>
> > +             method = "smc";
> > +     };
> > +
> > +     sm: secure-monitor {
> > +             compatible = "amlogic,meson-gxbb-sm";
> > +     };
> > +
> > +     soc {
> > +             compatible = "simple-bus";
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             apb4: apb4@fe000000 {
> > +                     compatible = "simple-bus";
> > +                     reg = <0x0 0xfe000000 0x0 0x480000>;
> > +                     #address-cells = <2>;
> > +                     #size-cells = <2>;
> > +                     ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> > +
> > +                     clkc: clock-controller {
> > +                             compatible = "amlogic,t7-clkc";
> > +                             #clock-cells = <1>;
> > +                             reg = <0x0 0x0 0x0 0x49c>,
> > +                                   <0x0 0x8000 0x0 0x320>,
> > +                                   <0x0 0xe040 0x0 0xbc>;
> > +                             reg-names = "basic",
> > +                                         "pll",
> > +                                         "cpu_clk";
> > +                     };
> > +
> > +                     ao-secure@140 {
> > +                             compatible = "amlogic,meson-gx-ao-secure", "syscon";
> > +                             reg=<0x0 0x10220 0x0 0x140>;
> > +                             amlogic,has-chip-id;
> > +                     };
> > +             };
> > +
> > +             uart_A: serial@fe078000 {
> > +                     compatible = "amlogic,meson-t7-uart";
> > +                     reg = <0x0 0xfe078000 0x0 0x18>;
> > +                     interrupts = <0 168 1>;
> > +                     status = "disabled";
> > +                     clocks = <&xtal>, <&clkc CLKID_UART_A>, <&xtal>;
> > +                     clock-names = "xtal", "pclk", "baud";
> > +                     fifo-size = < 64 >;
> > +                     pinctrl-names = "default";
> > +             };
> I believe there are more uart ports, it's worth the effort to add them all in one run,
> which sounds more consistent to me, anyway you could also choose to add them
> in later patch series, no problem..

Yeah, I prefer to add those uarts later, when I can propper test them.

>
> > +     };
> > +};
> > +
> > --
> > 2.41.0
> >
> >
> > _______________________________________________
> > linux-amlogic mailing list
> > linux-amlogic@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-amlogic
>
> --
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55
