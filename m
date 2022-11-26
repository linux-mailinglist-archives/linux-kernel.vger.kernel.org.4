Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D6A6392AE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiKZAWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKZAWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:22:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A0B537D6;
        Fri, 25 Nov 2022 16:21:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9346D6118A;
        Sat, 26 Nov 2022 00:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26C7C433D7;
        Sat, 26 Nov 2022 00:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669422119;
        bh=EvnPbzsbEw7zAyBO+z4cuktpDw5KqBq4/XvJ8AzDkIA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N233vt2R0fGUYWTUsF5BcxdXFNpWCZFTJVfJrX6MJeFBM4YlwwIBZDoLj2QsJ1XYX
         +I/KaXRb9TW9NS5ICBefBP5TM9XFffcCyKD3gAHy/g2vc7NkNRIUcD8u8B49ypVJ+g
         tYEqfoG+HdNCIS+Sd3DOyYSfzdZhylg84yra+VhRN6bBxoo0s2Q01FsFJr0FeScGDv
         lCybSTB5hLgalXNHKV4KZt2sdGoVFFbAJvW4YTEdy3wSPJqcFaj3DVa82tUjc3M1f8
         GN/7vUpo2Xq/Tyde1XA/9hQKPRhlgLwg8lq5uLNtX0RZfRW+WprkBh7G2/NBXPgGc3
         NdpapzbYwHnwQ==
Received: by mail-ed1-f49.google.com with SMTP id l11so8290625edb.4;
        Fri, 25 Nov 2022 16:21:58 -0800 (PST)
X-Gm-Message-State: ANoB5plmRRunkaMguAd4Dk2ihifeWa+WP/3ynFnIiSu3a7lh6P7rtVEN
        Dx+FNuwXVcXX4OkeQZH83lmgn5z/9Ne5EhrSp2w=
X-Google-Smtp-Source: AA0mqf4rpPgIDYF954AE+7uEMaTsXRORj4s3HeCwXHNWfBJPsc6JyRWc1pt5YAUkgdoX4Fdg95xFWPPmoz72uc9rb/o=
X-Received: by 2002:a05:6402:399a:b0:468:fdf2:477f with SMTP id
 fk26-20020a056402399a00b00468fdf2477fmr10389831edb.329.1669422117198; Fri, 25
 Nov 2022 16:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-7-samuel@sholland.org>
In-Reply-To: <20221125234656.47306-7-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 26 Nov 2022 08:21:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS0h8BG-q3VJNUxwziMh823HX8mn9XU72OCJ76ZHXvmLg@mail.gmail.com>
Message-ID: <CAJF2gTS0h8BG-q3VJNUxwziMh823HX8mn9XU72OCJ76ZHXvmLg@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] riscv: dts: allwinner: Add Allwinner D1 Nezha devicetree
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Sat, Nov 26, 2022 at 7:47 AM Samuel Holland <samuel@sholland.org> wrote:
>
> "D1 Nezha" is Allwinner's first-party development board for the D1 SoC.
> It was shipped with 512M, 1G, or 2G of DDR3. It supports onboard audio,
> HDMI, gigabit Ethernet, WiFi and Bluetooth, USB 2.0 host and OTG ports,
> plus low-speed I/O from the SoC and a GPIO expander chip.
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> Changes in v2:
>  - Common regulators moved to MangoPi MQ patch, removed analog LDOs
>  - Removed LRADC (depends on analog LDOs)
>  - Added XR829 host-wake interrupt
>
>  arch/riscv/boot/dts/allwinner/Makefile        |   1 +
>  .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 167 ++++++++++++++++++
>  2 files changed, 168 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
>
> diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts/allwinner/Makefile
> index 2f2792594f7d..277e59d1c907 100644
> --- a/arch/riscv/boot/dts/allwinner/Makefile
> +++ b/arch/riscv/boot/dts/allwinner/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-nezha.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1s-mangopi-mq.dtb
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
> new file mode 100644
> index 000000000000..9ea3648e64ea
> --- /dev/null
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/dts-v1/;
> +
> +#include "sun20i-d1.dtsi"
> +#include "sun20i-common-regulators.dtsi"
> +
> +/ {
> +       model = "Allwinner D1 Nezha";
> +       compatible = "allwinner,d1-nezha", "allwinner,sun20i-d1";
> +
> +       aliases {
> +               ethernet0 = &emac;
> +               ethernet1 = &xr829;
> +               mmc0 = &mmc0;
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       reg_usbvbus: usbvbus {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usbvbus";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
> +               enable-active-high;
> +               vin-supply = <&reg_vcc>;
> +       };
> +
> +       /*
> +        * This regulator is PWM-controlled, but the PWM controller is not
> +        * yet supported, so fix the regulator to its default voltage.
> +        */
> +       reg_vdd_cpu: vdd-cpu {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vdd-cpu";
> +               regulator-min-microvolt = <1100000>;
> +               regulator-max-microvolt = <1100000>;
> +               vin-supply = <&reg_vcc>;
> +       };
> +
> +       wifi_pwrseq: wifi-pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               reset-gpios = <&pio 6 12 GPIO_ACTIVE_LOW>; /* PG12 */
> +       };
> +};
> +
> +&cpu0 {
> +       cpu-supply = <&reg_vdd_cpu>;
> +};
> +
> +&dcxo {
> +       clock-frequency = <24000000>;
> +};
> +
> +&ehci0 {
> +       status = "okay";
> +};
> +
> +&ehci1 {
> +       status = "okay";
> +};
> +
> +&emac {
> +       pinctrl-0 = <&rgmii_pe_pins>;
> +       pinctrl-names = "default";
> +       phy-handle = <&ext_rgmii_phy>;
> +       phy-mode = "rgmii-id";
> +       phy-supply = <&reg_vcc_3v3>;
> +       status = "okay";
> +};
> +
> +&i2c2 {
> +       pinctrl-0 = <&i2c2_pb0_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +
> +       pcf8574a: gpio@38 {
> +               compatible = "nxp,pcf8574a";
> +               reg = <0x38>;
> +               interrupt-parent = <&pio>;
> +               interrupts = <1 2 IRQ_TYPE_LEVEL_LOW>; /* PB2 */
> +               interrupt-controller;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               #interrupt-cells = <2>;
> +       };
> +};
> +
> +&mdio {
> +       ext_rgmii_phy: ethernet-phy@1 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <1>;
> +       };
> +};
> +
> +&mmc0 {
> +       bus-width = <4>;
> +       cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
> +       disable-wp;
> +       vmmc-supply = <&reg_vcc_3v3>;
> +       vqmmc-supply = <&reg_vcc_3v3>;
> +       pinctrl-0 = <&mmc0_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +};
> +
> +&mmc1 {
> +       bus-width = <4>;
> +       mmc-pwrseq = <&wifi_pwrseq>;
> +       non-removable;
> +       vmmc-supply = <&reg_vcc_3v3>;
> +       vqmmc-supply = <&reg_vcc_3v3>;
> +       pinctrl-0 = <&mmc1_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +
> +       xr829: wifi@1 {
> +               reg = <1>;
> +               interrupt-parent = <&pio>;
> +               interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 */
> +               interrupt-names = "host-wake";
> +       };
> +};
> +
> +&ohci0 {
> +       status = "okay";
> +};
> +
> +&ohci1 {
> +       status = "okay";
> +};
> +
> +&uart0 {
> +       pinctrl-0 = <&uart0_pb8_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +};
> +
> +&uart1 {
> +       uart-has-rtscts;
> +       pinctrl-0 = <&uart1_pg6_pins>, <&uart1_pg8_rts_cts_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +
> +       /* XR829 bluetooth is connected here */
> +};
> +
> +&usb_otg {
> +       dr_mode = "otg";
> +       status = "okay";
> +};
> +
> +&usbphy {
> +       usb0_id_det-gpios = <&pio 3 21 GPIO_ACTIVE_HIGH>; /* PD21 */
> +       usb0_vbus_det-gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
> +       usb0_vbus-supply = <&reg_usbvbus>;
> +       usb1_vbus-supply = <&reg_vcc>;
> +       status = "okay";
> +};
> --
> 2.37.4
>


-- 
Best Regards
 Guo Ren
