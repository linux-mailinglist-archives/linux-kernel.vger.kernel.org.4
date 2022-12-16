Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88AD64EBFD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiLPNRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiLPNRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:17:08 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D2DEA;
        Fri, 16 Dec 2022 05:17:05 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id v2so1207352ioe.4;
        Fri, 16 Dec 2022 05:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NmDJSzYyWX63+orb904BOyH6AtsXRHC2Ka0GQssJRuM=;
        b=R51dYopwE4AxuIfxq3WR3nZ0bSooIKpqV3auaELU/nF4Q93wOCULQsAni2gneKPVua
         vok2DTUFbdMokCrtRvODrtwE0gZPaJ/88qjiqPgZB2dD1xd7uwCGSM8zddEsq6uBHaSD
         l3ZNRA2YZY8ojHOtEvvfcLgBrB9pIPBdMLtkhzxapIOcliY9siRGmOFnYszgqwR9aohM
         Ahu9MlxF8cqVVmg9Aa5oadFMh3pfWBasr+4Jr3i0zjV5dUin5ySN795clSmiMIm1tOnp
         U1PfTcRc/o8ymLa20a8EH5wtI8Qec2Rc2X4Pj/RyZ75IdDKCPtMvxAmzQ0YtjEDXi3eQ
         wuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmDJSzYyWX63+orb904BOyH6AtsXRHC2Ka0GQssJRuM=;
        b=ofKAugH/ZCkLb+IQOGVD2kKNGvtDsFhxDfDQZ6uvcHvHXWdXIAuuHIrt4rPbeB0mEp
         62DEIZ+2Jg4wXrqwS92ym7lZL50gw9uifApG3IhbvPqXxuTdP4TJF6lZ+XNOZXsytA/S
         6Cp6i2ruXRv5p7z1D80RDY08C1v5XfU76llfF0n0e6L30iZMzJ56j9KCu6i6LLpEY6oD
         CEk+An5XNtreAgHujaNrl54SgaXqFi/eh7jzyU/RfNflbG/GqOK+TnPf6xscckB5ow5a
         tiALQKeA/BmkXG3ZYgS1bvCHbkGoGYw/oSFPYICmUs8k1ot1f9sT5TDNz5qUPjiCJnTd
         50lA==
X-Gm-Message-State: ANoB5pmUvaFuaqehf4/ZuhzJe0JwAEmLAAQYMnXP3dg+JBlgd971payy
        Mx9/623VONiqiWkBl7AkEzxTx+uF3vO/TKJjLcw=
X-Google-Smtp-Source: AA0mqf5gbOcsHzbcplNw/i17s6VOmXaSLwAkOETs2bbwbUMTg/inWSDLQQ0LaL4cR1MGqP52mKzDrFC7nX4v4oRwWtw=
X-Received: by 2002:a5d:8515:0:b0:6e2:fe57:3d76 with SMTP id
 q21-20020a5d8515000000b006e2fe573d76mr2001899ion.41.1671196624708; Fri, 16
 Dec 2022 05:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20221215233719.404581-1-aford173@gmail.com> <20221215233719.404581-2-aford173@gmail.com>
 <df74eac8-1f9c-d0b8-f4fc-29f54d72c947@linaro.org>
In-Reply-To: <df74eac8-1f9c-d0b8-f4fc-29f54d72c947@linaro.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 16 Dec 2022 07:16:53 -0600
Message-ID: <CAHCN7x+ic9Pii82SRZqVxXZqKkb4iJiMCkPpxnOUFVajQL-t0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx: Introduce imx8mp-beacon-kit
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 5:37 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/12/2022 00:37, Adam Ford wrote:
> > Beacon Embedded has an i.MX8M Plus development kit which consists
> > of a SOM + baseboard.  The SOM includes Bluetooth, WiFi, QSPI, eMMC,
> > and one Ethernet PHY. The baseboard includes audio, HDMI, USB-C Dual
> > Role port, USB Hub with five ports, a PCIe slot, and a second Ethernet
> > PHY.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts

<snip>

>
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).

I totally forgot.  Thanks for the review.  I'll post a V2 tonight or
tomorrow after running the dt_binding_check.  Sorry to waste your
time.  I should have known better.

adam
>
> > +                     label = "btn0";
> > +                     linux,code = <BTN_0>;
> > +                     gpios = <&pca6416_1 12 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> > +                     wakeup-source;
> > +             };
> > +
> > +             btn1 {
> > +                     label = "btn1";
> > +                     linux,code = <BTN_1>;
> > +                     gpios = <&pca6416_1 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> > +                     wakeup-source;
> > +             };
> > +
> > +             btn2 {
> > +                     label = "btn2";
> > +                     linux,code = <BTN_2>;
> > +                     gpios = <&pca6416_1 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> > +                     wakeup-source;
> > +             };
> > +
> > +             btn3 {
> > +                     label = "btn3";
> > +                     linux,code = <BTN_3>;
> > +                     gpios = <&pca6416_1 15 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> > +                     wakeup-source;
> > +             };
> > +     };
> > +
> > +     leds {
> > +             compatible = "gpio-leds";
> > +
> > +             led0 {
>
> I think preferred is led-0
>
> > +                     label = "gen_led0";
> > +                     gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led1 {
>
> led-1
>
> > +                     label = "gen_led1";
> > +                     gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led2 {
> > +                     label = "gen_led2";
> > +                     gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led3 {
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&pinctrl_led3>;
> > +                     label = "heartbeat";
> > +                     gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
> > +                     linux,default-trigger = "heartbeat";
> > +             };
> > +     };
> > +
> > +     pcie0_refclk: pcie0-refclk {
> > +             compatible = "fixed-clock";
> > +                     #clock-cells = <0>;
> > +                     clock-frequency = <100000000>;
> > +     };
> > +
> > +     reg_usdhc2_vmmc: regulator-usdhc2 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "VSD_3V3";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +             startup-delay-us = <100>;
> > +             off-on-delay-us = <20000>;
> > +     };
> > +
> > +     reg_usb1_host_vbus: regulator-usb1-vbus {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "usb1_host_vbus";
> > +             regulator-max-microvolt = <5000000>;
> > +             regulator-min-microvolt = <5000000>;
> > +             gpio = <&pca6416_1 0 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +     };
> > +};
> > +
> > +&ecspi2 {
> > +     #address-cells = <1>;
> > +     #size-cells = <0>;
> > +     fsl,spi-num-chipselects = <1>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_ecspi2>;
> > +     cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > +     status = "okay";
> > +
> > +     tpm: tpm_tis@0 {
>
> Node names should be generic. No underscores in node name.
>
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_tpm>;
> > +             compatible = "infineon,slb9670";
> > +             reg = <0>;
>
> compatible is the first propert, reg is second.
>
> > +             reset-gpios = <&gpio4 0 GPIO_ACTIVE_LOW>;
> > +             spi-max-frequency = <18500000>;
> > +     };
> > +};
> > +
> > +&fec {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_fec>;
> > +     phy-mode = "rgmii-id";
> > +     phy-handle = <&ethphy1>;
> > +     phy-reset-gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
> > +     phy-reset-post-delay = <150>;
> > +     phy-reset-duration = <10>;
> > +     fsl,magic-packet;
> > +     status = "okay";
> > +
> > +     mdio {
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             ethphy1: ethernet1-phy@3 {
> > +                     compatible = "ethernet-phy-ieee802.3-c22";
> > +                     reg = <3>;
> > +             };
> > +     };
> > +};
> > +
> > +&flexcan1 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_flexcan1>;
> > +     status = "okay";
> > +};
> > +
> > +
> > +&i2c2 {
> > +     clock-frequency = <384000>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_i2c2>;
> > +     status = "okay";
> > +
> > +     pca6416_3: gpio-i2c2@20 {
>
> Node names should be generic, so i2c
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> > +             compatible = "nxp,pcal6416";
> > +             reg = <0x20>;
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +             interrupt-parent = <&gpio4>;
> > +             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +};
> > +
> > +&i2c3 {
> > +     /* Connected to USB Hub */
> > +     ptn5110: tcpc@52 {
>
> What is a tcpc?
>
> > +             compatible = "nxp,ptn5110";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_typec>;
> > +             reg = <0x52>;
>
> Order of your properties is quite random...
>
> > +             interrupt-parent = <&gpio4>;
> > +             interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             usb_con: connector {
> > +                     compatible = "usb-c-connector";
> > +                     label = "USB-C";
> > +                     power-role = "source";
> > +                     data-role = "host";
> > +                     source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> > +             };
> > +     };
> > +};
> > +
> > +&i2c4 {
> > +     clock-frequency = <384000>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_i2c4>;
> > +     status = "okay";
> > +
> > +     pca6416: gpio@20 {
> > +             compatible = "nxp,pcal6416";
> > +             reg = <0x20>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_pcal6414>;
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +             interrupt-parent = <&gpio4>;
> > +             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +     };
> > +
> > +     pca6416_1: gpio@21 {
> > +             compatible = "nxp,pcal6416";
> > +             reg = <0x21>;
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +             interrupt-parent = <&gpio4>;
> > +             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +
> > +             usb-reset {
> > +                     gpio-hog;
> > +                     gpios = <7 0>;
> > +                     output-low;
> > +                     line-name = "USB Hub Reset";
> > +             };
> > +     };
> > +
> > +     hd3ss3220@47 {
>
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_hd3ss3220>;
> > +             compatible = "ti,hd3ss3220";
> > +             reg = <0x47>;
>
> pinctrl is not the first property.
>
> > +             interrupt-parent = <&gpio4>;
> > +             interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             ports {
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     port@0 {
> > +                             reg = <0>;
> > +                             hd3ss3220_in_ep: endpoint {
> > +                                     remote-endpoint = <&ss_ep>;
> > +                             };
> > +                     };
> > +                             port@1 {
> > +                             reg = <1>;
>
> Wrong indentation.
>
> > +                             hd3ss3220_out_ep: endpoint {
> > +                                     remote-endpoint = <&usb3_role_switch>;
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&gpio2 {
> > +     usb-reset {
>
> Does it pass dtbs_check?
>
> > +             gpio-hog;
> > +             gpios = <20 0>;
> > +             output-low;
> > +             line-name = "USB-C Mux En";
> > +     };
> > +};
> > +
> > +&pcie {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_pcie>;
> > +     disable-gpio = <&gpio1 5 GPIO_ACTIVE_LOW>;
> > +     reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
> > +     clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
> > +              <&clk IMX8MP_CLK_PCIE_ROOT>,
> > +              <&clk IMX8MP_CLK_HSIO_AXI>;
> > +     clock-names = "pcie", "pcie_aux", "pcie_bus";
> > +     assigned-clocks = <&clk IMX8MP_CLK_PCIE_AUX>;
> > +     assigned-clock-rates = <10000000>;
> > +     assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_50M>;
> > +     status = "okay";
> > +};
>
> (...)
>
>
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
> > new file mode 100644
> > index 000000000000..c915116cfc4b
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
> > @@ -0,0 +1,500 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright LogicPD, Inc. dba Beacon EmbeddedWorks
> > + */
> > +
> > +/ {
> > +     aliases {
> > +             rtc0 = &rtc;
> > +             rtc1 = &snvs_rtc;
> > +     };
> > +
> > +     memory@40000000 {
> > +             device_type = "memory";
> > +             reg = <0x0 0x40000000 0 0xc0000000>,
> > +                   <0x1 0x00000000 0 0xc0000000>;
> > +     };
> > +
> > +     reg_wl_bt: regulator-wl-bt-pow-dwn {
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_reg_wl_bt>;
> > +             interrupt-parent = <&gpio1>;
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "wl-bt-pow-dwn";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             gpio = <&gpio2 6 GPIO_ACTIVE_LOW>;
> > +             startup-delay-us = <70000>;
> > +             regulator-always-on;
> > +     };
> > +};
> > +
> > +&A53_0 {
> > +     cpu-supply = <&buck2>;
> > +};
> > +
> > +&A53_1 {
> > +     cpu-supply = <&buck2>;
> > +};
> > +
> > +&A53_2 {
> > +     cpu-supply = <&buck2>;
> > +};
> > +
> > +&A53_3 {
> > +     cpu-supply = <&buck2>;
> > +};
> > +
> > +&dsp {
> > +     status = "okay";
> > +};
> > +
> > +&eqos {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_eqos>;
> > +     phy-mode = "rgmii-id";
> > +     phy-handle = <&ethphy0>;
> > +     snps,force_thresh_dma_mode;
> > +     snps,mtl-tx-config = <&mtl_tx_setup>;
> > +     snps,mtl-rx-config = <&mtl_rx_setup>;
> > +     status = "okay";
> > +
> > +     mdio {
> > +             compatible = "snps,dwmac-mdio";
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             ethphy0: ethernet-phy@3 {
> > +                     compatible = "ethernet-phy-ieee802.3-c22";
> > +                     interrupt-parent = <&gpio1>;
> > +                     interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
> > +                     reg = <3>;
> > +             };
> > +     };
> > +
> > +     mtl_tx_setup: tx-queues-config {
> > +             snps,tx-queues-to-use = <5>;
> > +             snps,tx-sched-sp;
> > +
> > +             queue0 {
> > +                     snps,dcb-algorithm;
> > +                     snps,priority = <0x1>;
> > +             };
> > +
> > +             queue1 {
> > +                     snps,dcb-algorithm;
> > +                     snps,priority = <0x2>;
> > +             };
> > +
> > +             queue2 {
> > +                     snps,dcb-algorithm;
> > +                     snps,priority = <0x4>;
> > +             };
> > +
> > +             queue3 {
> > +                     snps,dcb-algorithm;
> > +                     snps,priority = <0x8>;
> > +             };
> > +
> > +             queue4 {
> > +                     snps,dcb-algorithm;
> > +                     snps,priority = <0xf0>;
> > +             };
> > +     };
> > +
> > +     mtl_rx_setup: rx-queues-config {
> > +             snps,rx-queues-to-use = <5>;
> > +             snps,rx-sched-sp;
> > +
> > +             queue0 {
> > +                     snps,dcb-algorithm;
> > +                     snps,priority = <0x1>;
> > +                     snps,map-to-dma-channel = <0>;
> > +             };
> > +
> > +             queue1 {
> > +                     snps,dcb-algorithm;
> > +                     snps,priority = <0x2>;
> > +                     snps,map-to-dma-channel = <1>;
> > +             };
> > +
> > +             queue2 {
> > +                     snps,dcb-algorithm;
> > +                     snps,priority = <0x4>;
> > +                     snps,map-to-dma-channel = <2>;
> > +             };
> > +
> > +             queue3 {
> > +                     snps,dcb-algorithm;
> > +                     snps,priority = <0x8>;
> > +                     snps,map-to-dma-channel = <3>;
> > +             };
> > +
> > +             queue4 {
> > +                     snps,dcb-algorithm;
> > +                     snps,priority = <0xf0>;
> > +                     snps,map-to-dma-channel = <4>;
> > +             };
> > +     };
> > +};
> > +
> > +&flexspi {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_flexspi0>;
> > +     status = "okay";
> > +
> > +     flash0: mt25qu256aba@0 {
>
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> > +             reg = <0>;
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +             compatible = "jedec,spi-nor";
> > +             spi-max-frequency = <80000000>;
> > +             spi-tx-bus-width = <1>;
> > +             spi-rx-bus-width = <4>;
> > +     };
> > +};
> > +
> > +&i2c1 {
> > +     clock-frequency = <384000>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_i2c1>;
> > +     status = "okay";
> > +
> > +     pmic@25 {
> > +             compatible = "nxp,pca9450c";
> > +             reg = <0x25>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_pmic>;
> > +             interrupt-parent = <&gpio1>;
> > +             interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             regulators {
> > +                     buck1: BUCK1 {
> > +                             regulator-name = "BUCK1";
> > +                             regulator-min-microvolt = <600000>;
> > +                             regulator-max-microvolt = <2187500>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                             regulator-ramp-delay = <3125>;
> > +                     };
> > +
> > +                     buck2: BUCK2 {
> > +                             regulator-name = "BUCK2";
> > +                             regulator-min-microvolt = <600000>;
> > +                             regulator-max-microvolt = <2187500>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                             regulator-ramp-delay = <3125>;
> > +                             nxp,dvs-run-voltage = <950000>;
> > +                             nxp,dvs-standby-voltage = <850000>;
> > +                     };
> > +
> > +                     buck4: BUCK4 {
> > +                             regulator-name = "BUCK4";
> > +                             regulator-min-microvolt = <3300000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     buck5: BUCK5 {
> > +                             regulator-name = "BUCK5";
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <1800000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     buck6: BUCK6 {
> > +                             regulator-name = "BUCK6";
> > +                             regulator-min-microvolt = <600000>;
> > +                             regulator-max-microvolt = <3400000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     ldo1: LDO1 {
> > +                             regulator-name = "LDO1";
> > +                             regulator-min-microvolt = <1600000>;
> > +                             regulator-max-microvolt = <1800000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     ldo3: LDO3 {
> > +                             regulator-name = "LDO3";
> > +                             regulator-min-microvolt = <800000>;
> > +                             regulator-max-microvolt = <1800000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     ldo4: LDO4 {
> > +                             regulator-name = "LDO4";
> > +                             regulator-min-microvolt = <800000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     ldo5: LDO5 {
> > +                             regulator-name = "LDO5";
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&i2c3 {
> > +     clock-frequency = <384000>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_i2c3>;
> > +     status = "okay";
> > +
> > +     eeprom@50 {
> > +             compatible = "atmel,24c64";
> > +             pagesize = <32>;
> > +             read-only;      /* Manufacturing EEPROM programmed at factory */
> > +             reg = <0x50>;
>
> reg is second property
>
> > +     };
> > +
> > +     rtc: rtc@51 {
> > +             compatible = "nxp,pcf85263";
> > +             reg = <0x51>;
> > +             quartz-load-femtofarads = <12500>;
> > +     };
> > +};
> > +
> > +&snvs_pwrkey {
> > +     status = "okay";
> > +};
> > +
> > +&uart1 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_uart1>;
> > +     assigned-clocks = <&clk IMX8MP_CLK_UART1>;
> > +     assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
> > +     uart-has-rtscts;
> > +     status = "okay";
> > +};
> > +
> > +&usdhc1 {
> > +     vmmc-supply = <&reg_wl_bt>;
> > +     pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +     pinctrl-0 = <&pinctrl_usdhc1>;
> > +     pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> > +     pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> > +     bus-width = <4>;
> > +     max-frequency = <200000000>;
> > +     cap-sd-highspeed;
> > +     sd-uhs-sdr50;
> > +     sd-uhs-sdr104;
> > +     keep-power-in-suspend;
> > +     enable-sdio-wakeup;
> > +     cap-sdio-irq;
> > +     non-removable;
> > +     cap-power-off-card;
> > +     status = "okay";
>
> status is usually last
>
> > +     #address-cells = <1>;
> > +     #size-cells = <0>;
>
> Do you need these?
> > +
> > +     mwifiex: wifi@1 {
> > +             reg = <1>;
> > +             compatible = "marvell,sd8997";
>
> compatible, then reg
>
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_wlan>;
> > +             interrupt-parent = <&gpio2>;
> > +             interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
> > +     };
> > +};
>
> Best regards,
> Krzysztof
>
