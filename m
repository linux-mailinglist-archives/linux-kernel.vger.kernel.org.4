Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6737420C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjF2HKv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 03:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjF2HKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:10:48 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CA02110;
        Thu, 29 Jun 2023 00:10:46 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so353251276.2;
        Thu, 29 Jun 2023 00:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688022645; x=1690614645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tn9NNmjuel7XZ5JFuKy8oA1aMH0qpUgNaaolh4a54YM=;
        b=UN3/VbrmzgPIUWLsqQsWMKZrnVsD4s4V8ad3AcNTTsgNXzYAxVBAtEgltV5sxClOqd
         +3RpkXAYdkI26Xy+oUi7QpYunA1zLPGMXI40BmnpZSCDHKrJjR6C0vUv0D8fKzG0O4d/
         4TEU9iwfA/JxrVSPW0mfsyJKgWCKfqpLOhq1hELj5augeIxecKx/WS3/9uyV5eBqeBUS
         HRyoePib3Abr7Bv37aD0Us52CO4X1hWc7dLYA3cfalWirGX2Uy9ydI6wQ0h7hqCYkRmo
         IAXMlHt/4CTLsfuFStyagzi8Kc02cq7X4L9YY88JHWRSP5RmdknaGt0aiUFCTDn2FoKe
         J8TA==
X-Gm-Message-State: AC+VfDxSyP5+XgTZXtALFzGLdLAJ/4ECPM7FQdpfITNmhyIkGrsQHQ4D
        zlWOxifMT0i/eoglCmwuD0r2kr5eMp1xQQ==
X-Google-Smtp-Source: ACHHUZ4JoxtBfXTWL9qbf98s3fVi/5gTFO5VGfST86n8sZVx5cHKfu8/7Avsji6uDVVarB5aj8nCcA==
X-Received: by 2002:a25:a287:0:b0:c1a:eb92:73d with SMTP id c7-20020a25a287000000b00c1aeb92073dmr11922620ybi.65.1688022645505;
        Thu, 29 Jun 2023 00:10:45 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id x68-20020a25ce47000000b00b8f6ec5a955sm2422276ybe.49.2023.06.29.00.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 00:10:45 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-57026f4bccaso3520787b3.2;
        Thu, 29 Jun 2023 00:10:44 -0700 (PDT)
X-Received: by 2002:a81:4fce:0:b0:565:e48d:32cf with SMTP id
 d197-20020a814fce000000b00565e48d32cfmr40124407ywb.7.1688022644631; Thu, 29
 Jun 2023 00:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230627091007.190958-1-tanure@linux.com> <20230627091007.190958-5-tanure@linux.com>
 <fd7e60d1-b99a-a425-42c9-db85236ba71e@amlogic.com>
In-Reply-To: <fd7e60d1-b99a-a425-42c9-db85236ba71e@amlogic.com>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Thu, 29 Jun 2023 08:10:33 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+1q1nbE3HxA_xG5f6vwRBfvzcfBnXiFnEfsU7KuBkTHWA@mail.gmail.com>
Message-ID: <CAJX_Q+1q1nbE3HxA_xG5f6vwRBfvzcfBnXiFnEfsU7KuBkTHWA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] arm64: dts: amlogic-t7-a311d2-khadas-vim4: add
 initial device-tree
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
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

On Tue, Jun 27, 2023 at 10:21 AM Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>
>
>
> On 2023/6/27 17:10, Lucas Tanure wrote:
> > [ EXTERNAL EMAIL ]
> >
> > The Khadas VIM4 uses the Amlogic A311D2 SoC, based on the Amlogic T7 SoC
> > family, on a board with the same form factor as the VIM3 models.
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
> >   arch/arm64/boot/dts/amlogic/Makefile          |   1 +
> >   .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts |  52 ++++++
> >   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 158 ++++++++++++++++++
> >   3 files changed, 211 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> >   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> > index cd1c5b04890a..166fec1e4229 100644
> > --- a/arch/arm64/boot/dts/amlogic/Makefile
> > +++ b/arch/arm64/boot/dts/amlogic/Makefile
> > @@ -1,4 +1,5 @@
> >   # SPDX-License-Identifier: GPL-2.0
> > +dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
> >   dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
> >   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
> >   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j110-rev-2.dtb
> > diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> > new file mode 100644
> > index 000000000000..5d7fb86a9738
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> > @@ -0,0 +1,52 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2022 Wesion, Inc. All rights reserved.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "amlogic-t7.dtsi"
> > +
> > +/ {
> > +       model = "Khadas vim4";
> > +       compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
> > +
> > +       aliases {
> > +               serial0 = &uart_A;
> > +       };
> > +
> > +       memory@0 {
> > +               device_type = "memory";
> > +               reg = <0x0 0x0 0x2 0x0>; /* 8 GB */
> > +       };
> > +
> > +       reserved-memory {
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> > +
> > +               /* 3 MiB reserved for ARM Trusted Firmware (BL31) */
> > +               secmon_reserved: secmon@5000000 {
> > +                       reg = <0x0 0x05000000 0x0 0x300000>;
> > +                       no-map;
> > +               };
> > +
> > +               /* 32 MiB reserved for ARM Trusted Firmware (BL32) */
> > +               secmon_reserved_bl32: secmon@5300000 {
> > +                       reg = <0x0 0x05300000 0x0 0x2000000>;
> > +                       no-map;
> > +               };
> > +       };
> > +
> > +       xtal: xtal-clk {
> > +               compatible = "fixed-clock";
> > +               clock-frequency = <24000000>;
> > +               clock-output-names = "xtal";
> > +               #clock-cells = <0>;
> > +       };
> > +
> > +};
> > +
> > +&uart_A {
> > +       status = "okay";
> > +};
> > diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> > new file mode 100644
> > index 000000000000..6f3971b4df99
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> > @@ -0,0 +1,158 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +       interrupt-parent = <&gic>;
> > +       #address-cells = <2>;
> > +       #size-cells = <2>;
> > +
> > +       cpus {
> > +               #address-cells = <0x2>;
> > +               #size-cells = <0x0>;
> > +
> > +               cpu-map {
> > +                       cluster0 {
> > +                               core0 {
> > +                                       cpu = <&cpu100>;
> > +                               };
> > +                               core1 {
> > +                                       cpu = <&cpu101>;
> > +                               };
> > +                               core2 {
> > +                                       cpu = <&cpu102>;
> > +                               };
> > +                               core3 {
> > +                                       cpu = <&cpu103>;
> > +                               };
> > +                       };
> > +
> > +                       cluster1 {
> > +                               core0 {
> > +                                       cpu = <&cpu0>;
> > +                               };
> > +                               core1 {
> > +                                       cpu = <&cpu1>;
> > +                               };
> > +                               core2 {
> > +                                       cpu = <&cpu2>;
> > +                               };
> > +                               core3 {
> > +                                       cpu = <&cpu3>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               cpu100: cpu@100 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x0 0x100>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu101: cpu@101{
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x0 0x101>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu102: cpu@102 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x0 0x102>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu103: cpu@103 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x0 0x103>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu0: cpu@0 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a73";
> > +                       reg = <0x0 0x0>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu1: cpu@1 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a73";
> > +                       reg = <0x0 0x1>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu2: cpu@2 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a73";
> > +                       reg = <0x0 0x2>;
> > +                       enable-method = "psci";
> > +               };
> > +
> > +               cpu3: cpu@3 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a73";
> > +                       reg = <0x0 0x3>;
> > +                       enable-method = "psci";
> > +               };
> > +       };
> > +
> > +       timer {
> > +               compatible = "arm,armv8-timer";
> > +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> > +       };
> cpu number is 8, not 4, need use GIC_CPU_MASK_SIMPLE(8)
> > +
> > +       psci {
> > +               compatible = "arm,psci-1.0";
> > +               method = "smc";
> > +       };
> > +
> > +       sm: secure-monitor {
> > +               compatible = "amlogic,meson-gxbb-sm";
> > +       };
> > +
> > +       soc {
> > +               compatible = "simple-bus";
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> > +
> > +               gic: interrupt-controller@fff01000 {
> > +                       compatible = "arm,gic-400";
> > +                       #interrupt-cells = <3>;
> > +                       #address-cells = <0>;
> > +                       interrupt-controller;
> > +                       reg = <0x0 0xfff01000 0 0x1000>,
> > +                             <0x0 0xfff02000 0 0x0100>;
> > +                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> cpu number is 8, not 4, need use GIC_CPU_MASK_SIMPLE(8)
OK

> > +               };
> > +
> > +               apb4: bus@fe000000 {
> > +                       compatible = "simple-bus";
> > +                       reg = <0x0 0xfe000000 0x0 0x480000>;
> > +                       #address-cells = <2>;
> > +                       #size-cells = <2>;
> > +                       ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> > +
> > +                       uart_A: serial@78000 {
> use lowercase, "uart_a"

OK
> > +                               compatible = "amlogic,t7-uart",
> > +                                            "amlogic,meson-s4-uart";
> > +                               reg = <0x0 0x78000 0x0 0x18>;
> > +                               interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> > +                               status = "disabled";
> > +                               clocks = <&xtal>, <&xtal>, <&xtal>
> "xtal" why defined in  amlogic-t7-a311d2-khadas-vim4.dts files

The 24MHz clock is a crystal in VIm4 schematic, so its something the
board did to provide that clock.
Other boards using a311d2 could provide that clock in a different way.
Or are you saying that this clock is mandatory at boot time, and all
boards using this chip will have the same crystal?

> > +                               clock-names = "xtal", "pclk", "baud";
> > +                       };
> > +               };
> > +
> > +       };
> > +};
> > --
> > 2.41.0
> >
