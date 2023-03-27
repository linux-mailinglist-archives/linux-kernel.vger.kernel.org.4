Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD7A6C9EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjC0I4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjC0Izc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:55:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BAFA1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:51:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q16so10314959lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679907100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2+kRCNVOr2pBFfgdf+JplZo6qHGQlkF340GrkRwD8U=;
        b=qU7jolIbbSl5zD2tA8YK/ZxLY8rDToXZQ/ycWR5SP3WAnXtSHbuN/RVkwohZXclLu2
         /WCkMb4UHx8aTV29QRpBcpapGzzdFva81aErnk5Vp+bHjM+q4wObkrOxnZS7jNJ34umY
         GRPv0wr8sv3fH3KChaOsdndWdVSzn2/1CJLipV+rd6y/WrkNsQZTYiCqemyx0WL3716p
         Meleyv58Xv7bYQMccrIdNHxefc/t0HEluQcgyazXHFli9JoLU+YsoMtfojTkWayPcRWX
         DEISpVzkfzThO+WDy9+XRPCIlSjYezeTjjEV+e/vKBgQmLUVpv/ehO+c6Hq+IEfVwOlW
         p62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679907100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2+kRCNVOr2pBFfgdf+JplZo6qHGQlkF340GrkRwD8U=;
        b=C45r0e5BLCeXF4Al7bXI4/eH+XMSYoOxfx0epB94fsysGI/+e6Qg5tTye2dAB6X/Ns
         D3etVld3W4Eq9RIe/cxSVgqM9Yu8GvZyMKG+uxVBwj5S2BGN6CNQq3p48xtTKg2/0WMe
         dPZ4/meQrK39V/GMIRPoyFEEWdk7v0V73812iD3g+vvaRiStJgCUXaiougS5tDYUnNMN
         zpGEnln+XP1pBueno0crWbOsE9UmoY5WoIxoIaQJIrJ1c28YI+TbIRnIfhrcsNA3qL3p
         iEiR1MFJnMeIpursbpAqbzzWe+HaOjcB+eR2XWRtMz1z7IjyBnU6hDa3XyNrBXHTpcjj
         876A==
X-Gm-Message-State: AAQBX9cen6KKgle0L8KAkNRaCB1He4Oy905YhmIiu9IBCAQr3GS6QotY
        VDuh0QbJvYIsTQBLVfqWxNK6XQ==
X-Google-Smtp-Source: AKy350bFRvV8uD+FvgcuLNXlZq2os4xpuXLlzBvvYRq/oAQPOwFEwwRffDZ0bMYEGWGMOj2ISw+rPw==
X-Received: by 2002:ac2:5607:0:b0:4c0:91d0:e7ab with SMTP id v7-20020ac25607000000b004c091d0e7abmr2573477lfd.28.1679907100312;
        Mon, 27 Mar 2023 01:51:40 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id c18-20020ac25312000000b004eaec70c68esm2731000lfh.294.2023.03.27.01.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 01:51:39 -0700 (PDT)
Message-ID: <84bcb9a7-40f7-b692-0f06-4075b27b5b7e@linaro.org>
Date:   Mon, 27 Mar 2023 10:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 12/12] arm64: dts: qcom: sc8180x: Introduce Lenovo Flex
 5G
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-13-vkoul@kernel.org>
 <cf4feba0-de96-9e81-592b-e4b7520340a6@linaro.org> <ZCEs57ttv67KfOua@matsya>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZCEs57ttv67KfOua@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.03.2023 07:43, Vinod Koul wrote:
> On 25-03-23, 13:40, Konrad Dybcio wrote:
>>
>>
>> On 25.03.2023 13:24, Vinod Koul wrote:
>>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>
>>> Introduce support for the Lenovo Flex 5G laptop, built on the Qualcomm
>>> SC8180X platform. Supported peripherals includes keyboard, touchpad,
>>> UFS storage, external USB and WiFi.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>>  .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  | 590 ++++++++++++++++++
>>>  2 files changed, 591 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index fdce44a7a902..f096561f711e 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -141,6 +141,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-nvme-lte.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-lenovo-flex-5g.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-primus.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
>>> new file mode 100644
>>> index 000000000000..76dad608fb85
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
>>> @@ -0,0 +1,590 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2020-2023, Linaro Limited
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/gpio-keys.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>> +#include "sc8180x.dtsi"
>>> +#include "sc8180x-pmics.dtsi"
>>> +
>>> +/ {
>>> +	model = "Lenovo Flex 5G";
>>> +	compatible = "lenovo,flex-5g", "qcom,sc8180x";
>>> +
>>> +	aliases {
>>> +		serial0 = &uart13;
>>> +	};
>>> +
>>> +	backlight: backlight {
>>> +		compatible = "pwm-backlight";
>>> +		pwms = <&pmc8180c_lpg 4 1000000>;
>>> +		enable-gpios = <&pmc8180c_gpios 8 GPIO_ACTIVE_HIGH>;
>>> +
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&bl_pwm_default>;
>>> +	};
>>> +
>>> +	chosen {
>>> +	};
>> Unused, remove.
> 
> ok
> 
>>
>>> +
>>> +	gpio-keys {
>>> +		compatible = "gpio-keys";
>>> +
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&hall_int_active_state>;
>> property
>> property-names
> 
> ack here and everwhere else
> 
>>
>>> +
>>> +		lid {
>>> +			gpios = <&tlmm 121 GPIO_ACTIVE_LOW>;
>>> +			linux,input-type = <EV_SW>;
>>> +			linux,code = <SW_LID>;
>>> +			wakeup-source;
>>> +			wakeup-event-action = <EV_ACT_DEASSERTED>;
>>> +		};
>>> +	};
>>> +
>>> +	reserved-memory {
>>> +		rmtfs_mem: rmtfs-region@85500000 {
>>> +			compatible = "qcom,rmtfs-mem";
>>> +			reg = <0x0 0x85500000 0x0 0x200000>;
>> You're using 0 and 0x0 in a mixed fashion. Please stick with one,
>> preferably 0x0 everywhere.
> 
> yep
> 
>>
>>> +			no-map;
>>> +
>>> +			qcom,client-id = <1>;
>>> +			qcom,vmid = <15>;
>>> +		};
>>> +
>> [...]
>>
>>> +
>>> +&dispcc {
>>> +	status = "okay";
>> Any reason for disabling dispcc by default?
> 
> I think that is a good question. I would prefer disabling and enabling
> in places it is required, we might have a headless system or a dev board
> where we dont have display..?
It's a double-edged sword: on one side we could disable clocks that were
mistakenly enabled, but on the other hand we do keep some some clocks
always-on within that driver..

Perhaps leave it on by default and shut it off per-board if need be.

> 
>>
>>> +};
>>> +
>>> +&gpu {
>>> +	status = "okay";
>>> +
>>> +	zap-shader {
>>> +		memory-region = <&gpu_mem>;
>>> +		firmware-name = "qcom/sc8180x/qcdxkmsuc8180.mbn";
>>> +	};
>>> +};
>>> +
>>> +&i2c1 {
>>> +	clock-frequency = <100000>;
>>> +
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c1_active>, <&i2c1_hid_active>;
>> property
>> property-names
>>
>>> +
>>> +	status = "okay";
>>> +
>>> +	hid@10 {
>>> +		compatible = "hid-over-i2c";
>>> +		reg = <0x10>;
>>> +		hid-descr-addr = <0x1>;
>>> +
>>> +		interrupts-extended = <&tlmm 122 IRQ_TYPE_LEVEL_LOW>;
>>> +	};
>>> +};
>>> +
>>> +&i2c7 {
>>> +	clock-frequency = <100000>;
>>> +
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c7_active>, <&i2c7_hid_active>;
>>> +
>>> +	status = "okay";
>>> +
>>> +	hid@5 {
>>> +		compatible = "hid-over-i2c";
>>> +		reg = <0x5>;
>>> +		hid-descr-addr = <0x20>;
>>> +
>>> +		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_LOW>;
>>> +	};
>>> +
>>> +	hid@2c {
>>> +		compatible = "hid-over-i2c";
>>> +		reg = <0x2c>;
>>> +		hid-descr-addr = <0x20>;
>>> +
>>> +		interrupts-extended = <&tlmm 24 IRQ_TYPE_LEVEL_LOW>;
>>> +	};
>>> +};
>>> +
>>> +&mdss {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&mdss_edp {
>>> +	data-lanes = <0 1 2 3>;
>>> +
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&edp_hpd_active>;
>>> +
>>> +	status = "okay";
>>> +
>>> +	aux-bus {
>>> +		panel {
>>> +			compatible = "edp-panel";
>>> +			no-hpd;
>>> +
>>> +			backlight = <&backlight>;
>>> +
>>> +			ports {
>>> +				port {
>>> +					auo_b140han06_in: endpoint {
>>> +						remote-endpoint = <&mdss_edp_out>;
>>> +					};
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	ports {
>>> +		port@1 {
>>> +			reg = <1>;
>>> +			mdss_edp_out: endpoint {
>>> +				remote-endpoint = <&auo_b140han06_in>;
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&pcie3 {
>>> +	perst-gpio = <&tlmm 178 GPIO_ACTIVE_LOW>;
>>> +	wake-gpio = <&tlmm 180 GPIO_ACTIVE_HIGH>;
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&pcie3_default_state>;
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&pcie3_phy {
>>> +	vdda-phy-supply = <&vreg_l5e_0p88>;
>>> +	vdda-pll-supply = <&vreg_l3c_1p2>;
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&pmc8180c_lpg {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&qupv3_id_0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&qupv3_id_1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&qupv3_id_2 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&remoteproc_adsp {
>>> +	memory-region = <&adsp_mem>;
>>> +	firmware-name = "qcom/sc8180x/LENOVO/82AK/qcadsp8180.mbn";
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&remoteproc_cdsp {
>>> +	memory-region = <&cdsp_mem>;
>>> +	firmware-name = "qcom/sc8180x/LENOVO/82AK/qccdsp8180.mbn";
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&remoteproc_mpss {
>>> +	memory-region = <&mpss_mem>;
>>> +	firmware-name = "qcom/sc8180x/LENOVO/82AK/qcmpss8180_nm.mbn";
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&uart13 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&uart13_state>;
>>> +
>>> +	status = "okay";
>>> +
>>> +	bluetooth {
>>> +		compatible = "qcom,wcn3998-bt";
>>> +
>>> +		vddio-supply = <&vreg_s4a_1p8>;
>>> +		vddxo-supply = <&vreg_l7a_1p8>;
>>> +		vddrf-supply = <&vreg_l9a_1p3>;
>>> +		vddch0-supply = <&vreg_l11c_3p3>;
>>> +		max-speed = <3200000>;
>>> +	};
>>> +};
>>> +
>>> +&ufs_mem_hc {
>>> +	reset-gpios = <&tlmm 190 GPIO_ACTIVE_LOW>;
>>> +
>>> +	vcc-supply = <&vreg_l10e_2p9>;
>>> +	vcc-max-microamp = <155000>;
>>> +
>>> +	vccq2-supply = <&vreg_l7e_1p8>;
>>> +	vccq2-max-microamp = <425000>;
>> Missing regulator-allow-set-load for regulators that have current
>> ops assigned to them.
>>
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&ufs_mem_phy {
>>> +	vdda-phy-supply = <&vreg_l5e_0p88>;
>>> +	vdda-pll-supply = <&vreg_l3c_1p2>;
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_prim_hsphy {
>>> +	vdda-pll-supply = <&vreg_l5e_0p88>;
>>> +	vdda18-supply = <&vreg_l12a_1p8>;
>>> +	vdda33-supply = <&vreg_l16e_3p0>;
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_prim_qmpphy {
>>> +	vdda-phy-supply = <&vreg_l3c_1p2>;
>>> +	vdda-pll-supply = <&vreg_l5e_0p88>;
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_prim {
>> We mostly use usb_1 / usb_2 for this
> 
> Isnt this better from readablity pov? esp since this is board dts
Generally both sound pretty reasonable but I'm just saying that
all other trees name this differently..

Konrad
> 
>>
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_prim_dwc3 {
>>> +	dr_mode = "host";
>>> +};
>>> +
>>> +&usb_sec_hsphy {
>>> +	vdda-pll-supply = <&vreg_l5e_0p88>;
>>> +	vdda18-supply = <&vreg_l12a_1p8>;
>>> +	vdda33-supply = <&vreg_l16e_3p0>;
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_sec_qmpphy {
>>> +	vdda-phy-supply = <&vreg_l3c_1p2>;
>>> +	vdda-pll-supply = <&vreg_l5e_0p88>;
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_sec {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_sec_dwc3 {
>>> +	dr_mode = "host";
>> No roleswitching?
> 
> Laptop :-) Always in host mode
> 
>>
>>> +};
>>> +
>>> +&wifi {
>>> +	memory-region = <&wlan_mem>;
>> It comes from the common dt file, so this may as well stay there.
> 
> I can do that
> 
