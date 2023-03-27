Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB8E6C9B05
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjC0FnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjC0FnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:43:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D400D3C03;
        Sun, 26 Mar 2023 22:43:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 681C6B80DAC;
        Mon, 27 Mar 2023 05:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F75DC433EF;
        Mon, 27 Mar 2023 05:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679895788;
        bh=bVoKqlEKcb4Utbw/q4YYQWsU3JeRXa7XO93nRHgQgkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MWVnIZZADuvKR00+OZ+oyfpjZyEaShUcdXdF6PU6flgnts7YeE7xGUMZh5G0RYF/d
         ttR9uC1JKv+DqcVq/G8RaSOZW6qWaThBUxbtOcRRvP/kM7vqbBXPjBdM/cfJvZmdjL
         Bkxcng9a5iZQWdR4L6bsUmG7Tw3eK5dHzjRB6Zb6XVOdKlXUf/jaq48IQLnxqovGGl
         L4/VBCIry+G8rUSOda0Wc/pVcl3lXyimU3dNLNpOiJ1afneE/MOEEwGcKds/EFf6Ws
         YTQi0bXWkm9pR19GzX2mGoy2CesvIE+htCRcYxAwNz8O1audJJSP23cGKGrBw6aY4V
         XCJ0mpZb/u8CA==
Date:   Mon, 27 Mar 2023 11:13:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] arm64: dts: qcom: sc8180x: Introduce Lenovo
 Flex 5G
Message-ID: <ZCEs57ttv67KfOua@matsya>
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-13-vkoul@kernel.org>
 <cf4feba0-de96-9e81-592b-e4b7520340a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf4feba0-de96-9e81-592b-e4b7520340a6@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-23, 13:40, Konrad Dybcio wrote:
> 
> 
> On 25.03.2023 13:24, Vinod Koul wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Introduce support for the Lenovo Flex 5G laptop, built on the Qualcomm
> > SC8180X platform. Supported peripherals includes keyboard, touchpad,
> > UFS storage, external USB and WiFi.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >  .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  | 590 ++++++++++++++++++
> >  2 files changed, 591 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index fdce44a7a902..f096561f711e 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -141,6 +141,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-nvme-lte.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-lenovo-flex-5g.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-primus.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> > new file mode 100644
> > index 000000000000..76dad608fb85
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> > @@ -0,0 +1,590 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2020-2023, Linaro Limited
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/gpio-keys.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > +#include "sc8180x.dtsi"
> > +#include "sc8180x-pmics.dtsi"
> > +
> > +/ {
> > +	model = "Lenovo Flex 5G";
> > +	compatible = "lenovo,flex-5g", "qcom,sc8180x";
> > +
> > +	aliases {
> > +		serial0 = &uart13;
> > +	};
> > +
> > +	backlight: backlight {
> > +		compatible = "pwm-backlight";
> > +		pwms = <&pmc8180c_lpg 4 1000000>;
> > +		enable-gpios = <&pmc8180c_gpios 8 GPIO_ACTIVE_HIGH>;
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&bl_pwm_default>;
> > +	};
> > +
> > +	chosen {
> > +	};
> Unused, remove.

ok

> 
> > +
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&hall_int_active_state>;
> property
> property-names

ack here and everwhere else

> 
> > +
> > +		lid {
> > +			gpios = <&tlmm 121 GPIO_ACTIVE_LOW>;
> > +			linux,input-type = <EV_SW>;
> > +			linux,code = <SW_LID>;
> > +			wakeup-source;
> > +			wakeup-event-action = <EV_ACT_DEASSERTED>;
> > +		};
> > +	};
> > +
> > +	reserved-memory {
> > +		rmtfs_mem: rmtfs-region@85500000 {
> > +			compatible = "qcom,rmtfs-mem";
> > +			reg = <0x0 0x85500000 0x0 0x200000>;
> You're using 0 and 0x0 in a mixed fashion. Please stick with one,
> preferably 0x0 everywhere.

yep

> 
> > +			no-map;
> > +
> > +			qcom,client-id = <1>;
> > +			qcom,vmid = <15>;
> > +		};
> > +
> [...]
> 
> > +
> > +&dispcc {
> > +	status = "okay";
> Any reason for disabling dispcc by default?

I think that is a good question. I would prefer disabling and enabling
in places it is required, we might have a headless system or a dev board
where we dont have display..?

> 
> > +};
> > +
> > +&gpu {
> > +	status = "okay";
> > +
> > +	zap-shader {
> > +		memory-region = <&gpu_mem>;
> > +		firmware-name = "qcom/sc8180x/qcdxkmsuc8180.mbn";
> > +	};
> > +};
> > +
> > +&i2c1 {
> > +	clock-frequency = <100000>;
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c1_active>, <&i2c1_hid_active>;
> property
> property-names
> 
> > +
> > +	status = "okay";
> > +
> > +	hid@10 {
> > +		compatible = "hid-over-i2c";
> > +		reg = <0x10>;
> > +		hid-descr-addr = <0x1>;
> > +
> > +		interrupts-extended = <&tlmm 122 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +};
> > +
> > +&i2c7 {
> > +	clock-frequency = <100000>;
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c7_active>, <&i2c7_hid_active>;
> > +
> > +	status = "okay";
> > +
> > +	hid@5 {
> > +		compatible = "hid-over-i2c";
> > +		reg = <0x5>;
> > +		hid-descr-addr = <0x20>;
> > +
> > +		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +
> > +	hid@2c {
> > +		compatible = "hid-over-i2c";
> > +		reg = <0x2c>;
> > +		hid-descr-addr = <0x20>;
> > +
> > +		interrupts-extended = <&tlmm 24 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +};
> > +
> > +&mdss {
> > +	status = "okay";
> > +};
> > +
> > +&mdss_edp {
> > +	data-lanes = <0 1 2 3>;
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&edp_hpd_active>;
> > +
> > +	status = "okay";
> > +
> > +	aux-bus {
> > +		panel {
> > +			compatible = "edp-panel";
> > +			no-hpd;
> > +
> > +			backlight = <&backlight>;
> > +
> > +			ports {
> > +				port {
> > +					auo_b140han06_in: endpoint {
> > +						remote-endpoint = <&mdss_edp_out>;
> > +					};
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	ports {
> > +		port@1 {
> > +			reg = <1>;
> > +			mdss_edp_out: endpoint {
> > +				remote-endpoint = <&auo_b140han06_in>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&pcie3 {
> > +	perst-gpio = <&tlmm 178 GPIO_ACTIVE_LOW>;
> > +	wake-gpio = <&tlmm 180 GPIO_ACTIVE_HIGH>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pcie3_default_state>;
> > +
> > +	status = "okay";
> > +};
> > +
> > +&pcie3_phy {
> > +	vdda-phy-supply = <&vreg_l5e_0p88>;
> > +	vdda-pll-supply = <&vreg_l3c_1p2>;
> > +
> > +	status = "okay";
> > +};
> > +
> > +&pmc8180c_lpg {
> > +	status = "okay";
> > +};
> > +
> > +&qupv3_id_0 {
> > +	status = "okay";
> > +};
> > +
> > +&qupv3_id_1 {
> > +	status = "okay";
> > +};
> > +
> > +&qupv3_id_2 {
> > +	status = "okay";
> > +};
> > +
> > +&remoteproc_adsp {
> > +	memory-region = <&adsp_mem>;
> > +	firmware-name = "qcom/sc8180x/LENOVO/82AK/qcadsp8180.mbn";
> > +
> > +	status = "okay";
> > +};
> > +
> > +&remoteproc_cdsp {
> > +	memory-region = <&cdsp_mem>;
> > +	firmware-name = "qcom/sc8180x/LENOVO/82AK/qccdsp8180.mbn";
> > +
> > +	status = "okay";
> > +};
> > +
> > +&remoteproc_mpss {
> > +	memory-region = <&mpss_mem>;
> > +	firmware-name = "qcom/sc8180x/LENOVO/82AK/qcmpss8180_nm.mbn";
> > +
> > +	status = "okay";
> > +};
> > +
> > +&uart13 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart13_state>;
> > +
> > +	status = "okay";
> > +
> > +	bluetooth {
> > +		compatible = "qcom,wcn3998-bt";
> > +
> > +		vddio-supply = <&vreg_s4a_1p8>;
> > +		vddxo-supply = <&vreg_l7a_1p8>;
> > +		vddrf-supply = <&vreg_l9a_1p3>;
> > +		vddch0-supply = <&vreg_l11c_3p3>;
> > +		max-speed = <3200000>;
> > +	};
> > +};
> > +
> > +&ufs_mem_hc {
> > +	reset-gpios = <&tlmm 190 GPIO_ACTIVE_LOW>;
> > +
> > +	vcc-supply = <&vreg_l10e_2p9>;
> > +	vcc-max-microamp = <155000>;
> > +
> > +	vccq2-supply = <&vreg_l7e_1p8>;
> > +	vccq2-max-microamp = <425000>;
> Missing regulator-allow-set-load for regulators that have current
> ops assigned to them.
> 
> > +
> > +	status = "okay";
> > +};
> > +
> > +&ufs_mem_phy {
> > +	vdda-phy-supply = <&vreg_l5e_0p88>;
> > +	vdda-pll-supply = <&vreg_l3c_1p2>;
> > +
> > +	status = "okay";
> > +};
> > +
> > +&usb_prim_hsphy {
> > +	vdda-pll-supply = <&vreg_l5e_0p88>;
> > +	vdda18-supply = <&vreg_l12a_1p8>;
> > +	vdda33-supply = <&vreg_l16e_3p0>;
> > +
> > +	status = "okay";
> > +};
> > +
> > +&usb_prim_qmpphy {
> > +	vdda-phy-supply = <&vreg_l3c_1p2>;
> > +	vdda-pll-supply = <&vreg_l5e_0p88>;
> > +
> > +	status = "okay";
> > +};
> > +
> > +&usb_prim {
> We mostly use usb_1 / usb_2 for this

Isnt this better from readablity pov? esp since this is board dts

> 
> > +	status = "okay";
> > +};
> > +
> > +&usb_prim_dwc3 {
> > +	dr_mode = "host";
> > +};
> > +
> > +&usb_sec_hsphy {
> > +	vdda-pll-supply = <&vreg_l5e_0p88>;
> > +	vdda18-supply = <&vreg_l12a_1p8>;
> > +	vdda33-supply = <&vreg_l16e_3p0>;
> > +
> > +	status = "okay";
> > +};
> > +
> > +&usb_sec_qmpphy {
> > +	vdda-phy-supply = <&vreg_l3c_1p2>;
> > +	vdda-pll-supply = <&vreg_l5e_0p88>;
> > +
> > +	status = "okay";
> > +};
> > +
> > +&usb_sec {
> > +	status = "okay";
> > +};
> > +
> > +&usb_sec_dwc3 {
> > +	dr_mode = "host";
> No roleswitching?

Laptop :-) Always in host mode

> 
> > +};
> > +
> > +&wifi {
> > +	memory-region = <&wlan_mem>;
> It comes from the common dt file, so this may as well stay there.

I can do that

-- 
~Vinod
