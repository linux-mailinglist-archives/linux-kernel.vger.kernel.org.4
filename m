Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B8C5BAC42
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiIPLXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiIPLXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:23:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1DC7859D;
        Fri, 16 Sep 2022 04:23:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l14so48724620eja.7;
        Fri, 16 Sep 2022 04:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DU5KF0Ljto1qqKaaYep+gSPj1bvw9HckQSDSnz55RRQ=;
        b=UGAvmqpx6gdqMSAr0/ahrhiyIeHbl/GU2JEWzNQophHjbTExwEBIkmGmcPZFoS6d0V
         EXjzMGsnw3sfwW5IP7i62O7Q5bHSeUGkVKaN8U5gY5ZAw6xpWJE73KhmDshOOGezbZc5
         IlXpUu4szSBWK3lETDE5zGrrIeAn9YW1EBa2nQVzpz2aSbnKjVDAPZW9QIZjoK6hglJp
         r4iC9yJ3Qv/Pf+7lYUYROHV5+xuQCHo65m8jqLtaopEeksRdwRewfPWp0tu+Fgy4eM5h
         wCBJXcDs+zbEQQHtOp+JHEZWzLh/O9J+vQfSxkLQ4sDMkrvVjmmLkQXOtZ54TUxX9ocR
         wdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DU5KF0Ljto1qqKaaYep+gSPj1bvw9HckQSDSnz55RRQ=;
        b=8CJ/cvPym3PB1Wd+qEWurgoG56HxO4kJOpQs56Ue0LUQPthcHBb47LeqijR1Fk8csX
         mzEugMXkbRfbVgD10we40BXNuqlEiHFIHiRddY806avYM0RY8uReZQDn9Y5STLZ5Twfn
         hlGGS814dxdfcVF6XDZDg36z7U/tpAmsfy24diE4/virVGdYhBn6DnaJSbYMvCOaIiCj
         roC992Hyf5CRuk35NgFeME8zETRuPqMzIiI9220lSF59vXtzgvAFdYanhVBI5mWyf6Q2
         /3trXcizYHkm6HmS9l8v2LoMMZqQ795QrPJ0zmrwHhxxncoxerNYjDsaJi3IRzUpO2vc
         FeNA==
X-Gm-Message-State: ACrzQf1MqhwXPZeCRQ+T8IeN/Mup0uUFMMvaiaRBnwZNII5LAAab0xyD
        y3Xl+Zjou+CYPDvnoj9nalI=
X-Google-Smtp-Source: AMsMyM7A42U9OhgxYi+DBc3R1EShECp5+w1553csnq/jqH05bw3yyNynycc9pAcJzQ1WfLXjMiUXyQ==
X-Received: by 2002:a17:906:5d0a:b0:780:3c42:990f with SMTP id g10-20020a1709065d0a00b007803c42990fmr3254128ejt.9.1663327383181;
        Fri, 16 Sep 2022 04:23:03 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.gmail.com with ESMTPSA id c19-20020a056402121300b0044f0f51f813sm13193643edw.83.2022.09.16.04.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 04:23:02 -0700 (PDT)
Date:   Fri, 16 Sep 2022 11:18:15 +0000
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Changes phy configuration to expose sata in place of
 usb3 on quartz64-a board
Message-ID: <YyRbd0vaAwu0DI7n@lab.hqhome163.com>
References: <YyIyo42QWvgJTBjL@lab.hqhome163.com>
 <c46fd424-3517-9f66-dc8c-ed10ca3ef622@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c46fd424-3517-9f66-dc8c-ed10ca3ef622@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm reviewing the notes you made me on the review.
To tell all the truth, I derived the DTS from an existing one by modifying a small portion of it. 
In the end, your notes are for the already existing DTS.
To address the notes in your message and spare future work, I decided to refactor the rk3566-quartz64-a DTS.
I will post another patch briefly with the new version. 
For the moment, thank you for the review.
Regards
Alessandro

On Thu, Sep 15, 2022 at 04:07:54PM +0100, Krzysztof Kozlowski wrote:
> On 14/09/2022 20:59, Alessandro Carminati wrote:
> > The Quartz64 board is built upon Rockchip RK3566.
> > Rockchip RK3566 has two combo phys.
> > The first connects USB3 and SATA ctrl1, and the second PCIe lane and SATA
> > ctrl2.
> > The second combo phy is hardwired to the PCIe slot, where for the first,
> > the hardware on the board provides both the USB3 connector and the SATA
> > connector.
> > This DT allows the users to switch the combo phy to the SATA connector.
> > 
> > Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> > ---
> >  .../dts/rockchip/rk3566-quartz64-a.sata.dts   | 839 ++++++++++++++++++
> >  1 file changed, 839 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
> > new file mode 100644
> > index 000000000000..6ac21b729be7
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
> > @@ -0,0 +1,839 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include <dt-bindings/soc/rockchip,vop2.h>
> > +#include "rk3566.dtsi"
> > +
> > +/ {
> > +	model = "Pine64 RK3566 Quartz64-A Board";
> > +	compatible = "pine64,quartz64-a", "rockchip,rk3566";
> > +
> > +	aliases {
> > +		ethernet0 = &gmac1;
> > +		mmc0 = &sdmmc0;
> > +		mmc1 = &sdhci;
> > +	};
> > +
> > +	chosen: chosen {
> > +		stdout-path = "serial2:1500000n8";
> > +	};
> > +
> > +	gmac1_clkin: external-gmac1-clock {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <125000000>;
> > +		clock-output-names = "gmac1_clkin";
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	fan: gpio_fan {
> 
> No underscores in node names. Node name just "fan"
> 
> > +		compatible = "gpio-fan";
> > +		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
> > +		gpio-fan,speed-map = <0    0
> > +				      4500 1>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&fan_en_h>;
> > +		#cooling-cells = <2>;
> > +	};
> > +
> > +	hdmi-con {
> 
> Node name: connector
> 
> > +		compatible = "hdmi-connector";
> > +		type = "a";
> > +
> > +		port {
> > +			hdmi_con_in: endpoint {
> > +				remote-endpoint = <&hdmi_out_con>;
> > +			};
> > +		};
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> > +		led-work {
> > +			label = "work-led";
> > +			default-state = "off";
> > +			gpios = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&work_led_enable_h>;
> > +			retain-state-suspended;
> > +		};
> > +
> > +		led-diy {
> > +			label = "diy-led";
> > +			default-state = "on";
> > +			gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "heartbeat";
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&diy_led_enable_h>;
> > +			retain-state-suspended;
> > +		};
> > +	};
> > +
> > +	rk817-sound {
> > +		compatible = "simple-audio-card";
> > +		simple-audio-card,format = "i2s";
> > +		simple-audio-card,name = "Analog RK817";
> > +		simple-audio-card,mclk-fs = <256>;
> > +
> > +		simple-audio-card,cpu {
> > +			sound-dai = <&i2s1_8ch>;
> > +		};
> > +
> > +		simple-audio-card,codec {
> > +			sound-dai = <&rk817>;
> > +		};
> > +	};
> > +
> > +	sdio_pwrseq: sdio-pwrseq {
> > +		compatible = "mmc-pwrseq-simple";
> > +		clocks = <&rk817 1>;
> > +		clock-names = "ext_clock";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&wifi_enable_h>;
> > +		post-power-on-delay-ms = <100>;
> > +		power-off-delay-us = <5000000>;
> > +		reset-gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_LOW>;
> > +	};
> > +
> > +	spdif_dit: spdif-dit {
> > +		compatible = "linux,spdif-dit";
> > +		#sound-dai-cells = <0>;
> > +	};
> > +
> > +	spdif_sound: spdif-sound {
> > +		compatible = "simple-audio-card";
> > +		simple-audio-card,name = "SPDIF";
> > +
> > +		simple-audio-card,cpu {
> > +			sound-dai = <&spdif>;
> > +		};
> > +
> > +		simple-audio-card,codec {
> > +			sound-dai = <&spdif_dit>;
> > +		};
> > +	};
> > +
> > +	vcc12v_dcin: vcc12v_dcin {
> 
> No underscores in node names, generic node name, so at least with
> regulator prefix or suffix.
> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc12v_dcin";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <12000000>;
> > +		regulator-max-microvolt = <12000000>;
> > +	};
> > +
> > +	/* vbus feeds the rk817 usb input.
> > +	 * With no battery attached, also feeds vcc_bat+
> > +	 * via ON/OFF_BAT jumper
> > +	 */
> > +	vbus: vbus {
> 
> Ditto
> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vbus";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		vin-supply = <&vcc12v_dcin>;
> > +	};
> > +
> > +	vcc3v3_pcie_p: vcc3v3-pcie-p-regulator {
> 
> And here you have suffix...
> 
> > +		compatible = "regulator-fixed";
> > +		enable-active-high;
> > +		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pcie_enable_h>;
> > +		regulator-name = "vcc3v3_pcie_p";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		vin-supply = <&vcc_3v3>;
> > +	};
> > +
> > +	vcc5v0_usb: vcc5v0_usb {
> 
> Ditto
> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc5v0_usb";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		vin-supply = <&vcc12v_dcin>;
> > +	};
> > +
> > +	/* all four ports are controlled by one gpio
> > +	 * the host ports are sourced from vcc5v0_usb
> > +	 * the otg port is sourced from vcc5v0_midu
> > +	 */
> > +	vcc5v0_usb20_host: vcc5v0_usb20_host {
> 
> and in other places as well
> 
> 
> 
> > +		compatible = "regulator-fixed";
> > +		enable-active-high;
> > +		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&vcc5v0_usb20_host_en>;
> > +		regulator-name = "vcc5v0_usb20_host";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		vin-supply = <&vcc5v0_usb>;
> > +	};
> > +
> > +	vcc5v0_usb20_otg: vcc5v0_usb20_otg {
> > +		compatible = "regulator-fixed";
> > +		enable-active-high;
> > +		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
> > +		regulator-name = "vcc5v0_usb20_otg";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		vin-supply = <&dcdc_boost>;
> > +	};
> > +
> > +	vcc3v3_sd: vcc3v3_sd {
> > +		compatible = "regulator-fixed";
> > +		enable-active-low;
> > +		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&vcc_sd_h>;
> > +		regulator-boot-on;
> > +		regulator-name = "vcc3v3_sd";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		vin-supply = <&vcc_3v3>;
> > +	};
> > +
> > +	/* sourced from vbus and vcc_bat+ via rk817 sw5 */
> > +	vcc_sys: vcc_sys {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc_sys";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <4400000>;
> > +		regulator-max-microvolt = <4400000>;
> > +		vin-supply = <&vbus>;
> > +	};
> > +
> > +	/* sourced from vcc_sys, sdio module operates internally at 3.3v */
> > +	vcc_wl: vcc_wl {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc_wl";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		vin-supply = <&vcc_sys>;
> > +	};
> > +};
> > +
> > +&combphy1 {
> > +	status = "okay";
> > +};
> > +
> > +&combphy2 {
> > +	status = "okay";
> > +};
> > +
> > +&cpu0 {
> > +	cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu1 {
> > +	cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu2 {
> > +	cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu3 {
> > +	cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu_thermal {
> > +	trips {
> > +		cpu_hot: cpu_hot {
> 
> No underscores in node names. Are you sure bindings/schema do not expect
> some specific name?
> 
> > +			temperature = <55000>;
> > +			hysteresis = <2000>;
> > +			type = "active";
> > +		};
> > +	};
> 
> 
> Best regards,
> Krzysztof
