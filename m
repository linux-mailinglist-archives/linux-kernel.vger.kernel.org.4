Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C4650473
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 20:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiLRTAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 14:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiLRTAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 14:00:36 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893418FDD;
        Sun, 18 Dec 2022 11:00:34 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id y3so3839926ilq.0;
        Sun, 18 Dec 2022 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1CFkge8Tpo0CVlieNupvmBkQr0LFgaRIv/5MuV2YmqI=;
        b=FyfMYvqy8dje4V+lI897svplxDiWpGnU1QIw2qfKlwEs0EcJ7BYkgvepT2wR9WEp5/
         xgtKXgyZLXSKO/D2iUqltxDeSJevy27lfIp7fTipQc2n7H/4NVugYojFu8bT4QL2nxH2
         qJcVZLji/BmLxQGR8hS7Xi/P9QC1ARaxnsLaa78v6ej1jgo0H7zdHqaySzitO3IgvQf+
         U4HvlJxrXZNhpGTTmCm8HrDKedHmYf2f511hEAaWZDROyQMT3SimWZVMiTYCt+pQSGm0
         qCxu3I6M4HRpU/H1zv7wA28FIBBNY+EQlzVnpmp1dc7aki4XTWAprQ4LdWJzXPm4/QWS
         kraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CFkge8Tpo0CVlieNupvmBkQr0LFgaRIv/5MuV2YmqI=;
        b=jiXGHuMR6LRrqvxq52in9/YUyAdXsJBqFFXt1vIsA9J1O9ghyjaWWiYtycd8DsTNBK
         igYdMrckPTTuohREGWmzBN/ICQY3OPEbeZYv3LEbpimKdz7RTXV9srZAFaziedck3oFm
         pzdQhVCweCSvn+z1x3gPcf3fWhoLRnWz362q4+Ej4RImzwRWRWtBwAU/TunGch2UJgOB
         9JmhAmLg03tL3ku0gWEARNgpkxryyzOqACppWHRYnezsfiPAhIIZ3LkjMjx7CWnDLS0x
         qbEmU/JDWegWbP05elwsjI72LAI18ilsGurl1CNnEHqgnZKDGk0Os5zymA6v2KKHIwJn
         KUfA==
X-Gm-Message-State: ANoB5pmyz3HOC2oXPWx7qtqoQFz6lJa6NI8bGyHpSdPpPZMNvtkezuMz
        dduhn6ymbMr9gbeFD5wzC0KAoy4+Z3VBNM3QL84=
X-Google-Smtp-Source: AA0mqf5xotTzs/mqu+9P0m9AUVf8TF02wnw0ph6wwrbUZcy7DSQdQ/zoUKffoP+HnlW20FZOqcBESQoXUpt2oMPAVGw=
X-Received: by 2002:a92:1912:0:b0:302:5c57:c19d with SMTP id
 18-20020a921912000000b003025c57c19dmr39193523ilz.226.1671390033718; Sun, 18
 Dec 2022 11:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20221217234340.819752-1-aford173@gmail.com> <20221217234340.819752-2-aford173@gmail.com>
 <c5b8c9d1-6391-fb76-c380-6f0fdb3cc878@linaro.org>
In-Reply-To: <c5b8c9d1-6391-fb76-c380-6f0fdb3cc878@linaro.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 18 Dec 2022 13:00:21 -0600
Message-ID: <CAHCN7xKHE-9VAysC4VLQNfT8c9j6AMZQFRsH+M2xE6-DSfbF7Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] arm64: dts: imx: Introduce imx8mp-beacon-kit
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

On Sun, Dec 18, 2022 at 12:42 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/12/2022 00:43, Adam Ford wrote:
> > Beacon Embedded has an i.MX8M Plus development kit which consists
> > of a SOM + baseboard.  The SOM includes Bluetooth, WiFi, QSPI, eMMC,
> > and one Ethernet PHY. The baseboard includes audio, HDMI, USB-C Dual
> > Role port, USB Hub with five ports, a PCIe slot, and a second Ethernet
> > PHY.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V2:  Fix whitespace, remove dead nodes, and fix some node and
> > parameter names to address errors in 'make dt_binding_check'
>
> You still cannot check/test/build this DTS without Makefile.

The lack of makefile was an honest mistake as I forgot to add it to my
patch.  I ran the make dt_binding_check and addressed many of the
errors, but some of them are not unique to my board, because they were
errors in the imx8mp.dtsi file. I addressed some of them by sending
patches to fix some types in imx8mp.dtsi.  I will make sure V3 has the
makefile updated.

>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> > new file mode 100644
> > index 000000000000..70399f2419cf
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> > @@ -0,0 +1,549 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2022 Logic PD, Inc dba Beacon EmbeddedWorks
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/usb/pd.h>
> > +#include <dt-bindings/phy/phy-imx8-pcie.h>
> > +#include "imx8mp.dtsi"
> > +#include "imx8mp-beacon-som.dtsi"
> > +
> > +/ {
> > +     model = "Beacon EmbeddedWorks i.MX8MPlus Development kit";
> > +     compatible = "beacon,imx8mp-beacon-kit", "fsl,imx8mp";
> > +
> > +     aliases {
> > +             ethernet0 = &eqos;
> > +             ethernet1 = &fec;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path = &uart2;
> > +     };
> > +
> > +     connector-1 {
> > +             compatible = "usb-c-connector";
> > +             label = "USB-C";
> > +             data-role = "dual";
> > +
> > +             ports {
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     port@0 {
> > +                             reg = <0>;
> > +                             hs_ep: endpoint {
> > +                                     remote-endpoint = <&usb3_hs_ep>;
> > +                             };
> > +                     };
> > +                     port@1 {
> > +                             reg = <1>;
> > +                             ss_ep: endpoint {
> > +                                     remote-endpoint = <&hd3ss3220_in_ep>;
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible = "gpio-keys";
> > +             autorepeat;
> > +
> > +             button-0 {
> > +                     label = "btn0";
> > +                     linux,code = <BTN_0>;
> > +                     gpios = <&pca6416_1 12 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> > +                     wakeup-source;
> > +             };
> > +
> > +             button-1 {
> > +                     label = "btn1";
> > +                     linux,code = <BTN_1>;
> > +                     gpios = <&pca6416_1 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> > +                     wakeup-source;
> > +             };
> > +
> > +             button-2 {
> > +                     label = "btn2";
> > +                     linux,code = <BTN_2>;
> > +                     gpios = <&pca6416_1 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> > +                     wakeup-source;
> > +             };
> > +
> > +             button-3 {
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
> No improvements here.
I forgot the git commit --amend so my patch was missing the changes,
but my machine has the fix.  Sorry about that.

>
> > +                     label = "gen_led0";
> > +                     gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
> > +                     default-state = "off";
> > +             };
> > +
> > +             led1 {
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
> > +             #clock-cells = <0>;
> > +             clock-frequency = <100000000>;
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
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_ecspi2>;
> > +     cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > +     status = "okay";
> > +
> > +     tpm: tpm@0 {
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_tpm>;
> > +             compatible = "infineon,slb9670";
> > +             reg = <0>;
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
> No improvements.

I am not sure what I am supposed to do here.  I already have one node
called "gpio@20" and as far as I know, I can't have duplicate nodes
with the same name.  I have the same GPIO expander with the same on a
different i2c bus.  Do you have a recommendation as to what name I
should use so the names are unique?

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
> > +     ptn5110: ptn5110@52 {
>
> No improvements ... I'll stop reviewing. No point if you do not intend
> to apply the comments.

I changed this node from tcpc to ptn5110 per your last comment, and it
matches other boards that use this and
Documentation/devicetree/bindings/connector/usb-connector.yaml example
uses ptn5110.
Documentation/devicetree/bindings/usb/typec-tcpci.txt just called it
"ptn5110@50" .

imx8mm-evk.dtsi calls it "ptn5110: tcpc@50" so that's the example I
followed.  I am guessing it fails the build test because there isn't a
yaml file for this driver.

I wasn't intentionally ignoring your comments, and I honestly tried to
catch them.

If you let me know how you want me to proceed, I will do a V3.

thank you,

adam
>
>
> Best regards,
> Krzysztof
>
