Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2466A6A9163
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCCHCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCCHCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:02:20 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB3515E5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:02:17 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ay14so2826933edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677826936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOiRqJKH+u7RHpRAZZEt+RhmyvTscqB3usql//Z6EaQ=;
        b=SOuP5U2qg7ezacgxwmPVZ/Nkxacu35evW1dbY6QbcUqnlQHmWIonCW1jbVfpiVF4Ng
         LCjAR23NBfjbu8hvRlusSpRKaAbm4xD9sop4Ar2jzWSCR9yZ791Shhq0V1Iusagz8Ugi
         4wdGxtKmBA6MDK0fRAYI1TJaydT+lXFahijKwUiekUe2j5K0yJv5YWc5dKbWwXW/4A9R
         L15UV45oac2WMcqqzCmocidVDiSJBBveHdbtO1QtMvM5bDO6R3YEvnnJ/GkFZR1TG971
         iW5DZQ3ckD0R3nfLLU3JfSsfsQ/YKvSVcWAWcMjiFOdH4Gy5xeb6Hmi9AAq2q51aHDrY
         tymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677826936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOiRqJKH+u7RHpRAZZEt+RhmyvTscqB3usql//Z6EaQ=;
        b=TB6izDJW9wEyTl6cge+t3vb6GfqmulG/ecyr10eil//9HwqCc9g6G5rgTXxzh3nCV5
         EA8/gAbo+v3B/xbSuNDjrG2xn7qblndp/5HnV3T8YAwFQeiu43xD9y+yP2GTibtE/wRK
         QZTqzZaco7XMoP9ghR5C7qeGCoLPnMPbS9v5+CMRshjydiWwfoEITaC5paeEU4WVM5wd
         GzY8LM3HJJSQlgq9dJ/jt0XubTGt3mfxcGGHeOgsEj2Iqqjf8UulqGc0ep32RxgW11tJ
         Rwhm3uLRt3XGTa/arz3K/gSe5T22Kv4QcgGxmf+CybqiTK7vaqP3hYsCnC58+grbzkMp
         ob8A==
X-Gm-Message-State: AO0yUKWBoXe8ZfkMkSr46olXGZtQKTGoUBASCjQQimx4QyT/qqKhGHPS
        qgW7MJVxeYVsG5HZF7Q9O9xbcA==
X-Google-Smtp-Source: AK7set/oepS0Udiek/PopmdocMi22RvcsESQF//zaYC2tp6J25O87kOQtBvrcofyFGvJvcpeaUhI0g==
X-Received: by 2002:a17:907:7212:b0:8b1:75c4:abd with SMTP id dr18-20020a170907721200b008b175c40abdmr661485ejc.15.1677826936286;
        Thu, 02 Mar 2023 23:02:16 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c14-20020a50f60e000000b004af720b855fsm773411edn.82.2023.03.02.23.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:02:15 -0800 (PST)
Message-ID: <0081a671-9d0e-5db3-fca4-8d1a45588680@linaro.org>
Date:   Fri, 3 Mar 2023 08:02:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/7] ARM: dts: nuvoton: Add Quanta GIS BMC Device Tree
To:     David Wang <tomato1220@gmail.com>, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        fran.hsu@quantatw.com, David Wang <davidwang@quantatw.com>
References: <20230303063435.803097-1-davidwang@quantatw.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230303063435.803097-1-davidwang@quantatw.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 07:34, David Wang wrote:
> Add the device tree for the Quanta GIS BMC and it's
> based on NPCM730 SoC
> 


> +};
> diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gis.dts b/arch/arm/boot/dts/nuvoton-npcm730-gis.dts
> new file mode 100644
> index 000000000000..1422b2aadebf
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton-npcm730-gis.dts
> @@ -0,0 +1,1076 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2020 Quanta Computer Inc. Fran.Hsu@quantatw.com
> +
> +/dts-v1/;
> +#include "nuvoton-npcm730.dtsi"
> +#include "nuvoton-npcm730-gis-pincfg.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Quanta GIS Board (Device Tree v01.17)";
> +	compatible = "nuvoton,npcm750";

That's not a correct compatible for the board. Add new, correct
compatible (with vendor prefix) and document it in the bindings.

> +
> +	aliases {
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +		serial2 = &serial2;
> +		serial3 = &serial3;
> +		udc5 = &udc5;
> +		udc6 = &udc6;
> +		udc7 = &udc7;
> +		udc8 = &udc8;
> +		udc9 = &udc9;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c8 = &i2c8;
> +		i2c11 = &i2c11;
> +		i2c14 = &i2c14;
> +		i2c15 = &i2c15;
> +		i2c16 = &i2c_cpu0_dimmA;
> +		i2c17 = &i2c_cpu0_dimmE;
> +		i2c18 = &i2c_cpu1_dimmA;
> +		i2c19 = &i2c_cpu1_dimmE;
> +		i2c20 = &i2c_clock_gen_0;
> +		i2c21 = &i2c_clock_gen_1;
> +		i2c22 = &i2c_clock_gen_2;
> +		i2c23 = &i2c_clock_gen_3;
> +		i2c24 = &i2c_slot0;
> +		i2c25 = &i2c_slot1;
> +		i2c26 = &i2c_slot2;
> +		i2c27 = &i2c_slot3;
> +		i2c28 = &i2c_slot4;
> +		i2c29 = &i2c_slot5;
> +		i2c30 = &i2c_slot6;
> +		i2c31 = &i2c_slot7;
> +		i2c32 = &i2c_power_0;
> +		i2c33 = &i2c_power_1;
> +		i2c34 = &i2c_power_2;
> +		i2c35 = &i2c_power_3;
> +		i2c36 = &i2c_isl_0;
> +		i2c37 = &i2c_isl_1;
> +		i2c38 = &i2c_isl_2;
> +		i2c39 = &i2c_isl_3;
> +		i2c40 = &i2c_isl_4;
> +		i2c41 = &i2c_isl_5;
> +		i2c42 = &i2c_isl_6;
> +		i2c43 = &i2c_isl_7;
> +		i2c44 = &i2c_hostswap;
> +		i2c45 = &i2c_tmp;
> +		i2c46 = &i2c_fan_controller_1;
> +		i2c47 = &i2c_fan_controller_2;
> +		i2c48 = &i2c_seq;
> +		i2c49 = &i2c_fru_1;
> +		i2c50 = &i2c_fru_2;
> +		i2c51 = &i2c_i2cool_1;
> +		i2c52 = &i2c_i2cool_2;
> +		i2c53 = &i2c_i2cool_3;
> +		i2c54 = &i2c_i2cool_4;
> +		i2c55 = &i2c_cpu_pirom;
> +		fiu0 = &fiu0;
> +		fiu1 = &fiu3;
> +	};
> +
> +	chosen {
> +		stdout-path = &serial3;
> +	};
> +
> +	memory {
> +		reg = <0 0x40000000>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		sas-cable0 {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +			label = "sas-cable0";
> +			gpios = <&gpio6 19 GPIO_ACTIVE_LOW>;
> +			linux,code = <211>;
> +		};
> +
> +		sas-cable1 {
> +			label = "sas-cable1";
> +			gpios = <&gpio6 20 GPIO_ACTIVE_LOW>;
> +			linux,code = <212>;
> +		};
> +
> +		power-failure {
> +			label = "power-failure";
> +			gpios = <&gpio6 21 GPIO_ACTIVE_LOW>;
> +			linux,code = <213>;
> +		};
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 1>, <&adc 2>, <&adc 3>,
> +			<&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>;
> +	};
> +
> +	iio-hwmon-battery {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 0>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-bmc-live {
> +			gpios = <&gpio4 25 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		LED_SYS_ERROR {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

Only lowercase, no underscores in node names.

> +			gpios = <&gpio5 12 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";

Missing properties like color and function (or label).

> +		};
> +
> +		LED_BMC_FAULT {
> +			gpios = <&gpio6 25 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		LED_SYS_ATTN {
> +			gpios = <&gpio6 28 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		LED_SYS_STATE {
> +			gpios = <&gpio6 29 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	seven-seg-disp {
> +		compatible = "seven-seg-gpio-dev";
> +		refresh-interval-ms = /bits/ 16 <600>;
> +		clock-gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
> +		data-gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
> +		clear-gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	pcie-slot {

What's this? Which bindings do you implement?

> +		pcie0: pcie-slot@0 {
> +			label = "PE0";
> +		};
> +
> +		pcie1: pcie-slot@1 {
> +			label = "PE1";
> +		};
> +
> +		pcie2: pcie-slot@2 {
> +			label = "PE2";
> +		};
> +
> +		pcie3: pcie-slot@3 {
> +			label = "PE3";
> +		};
> +
> +		pcie4: pcie-slot@4 {
> +			label = "PE4";
> +		};
> +
> +		pcie5: pcie-slot@5 {
> +			label = "PE5";
> +		};
> +
> +		pcie6: pcie-slot@6 {
> +			label = "PE6";
> +		};
> +
> +		pcie7: pcie-slot@7 {
> +			label = "PE7";
> +		};
> +	};
> +};
> +

> +&gcr {
> +	serial_port_mux: mux-controller {
> +		compatible = "mmio-mux";
> +		#mux-control-cells = <1>;
> +		mux-reg-masks = <0x38 0x07>;
> +		idle-states = <2>; /* Serial port mode 3 (takeover) */
> +	};
> +};
> +
> +&gmac0 {
> +	phy-mode = "rgmii-id";
> +	snps,eee-force-disable;
> +	status = "okay";
> +};
> +
> +&emc0 {
> +	status = "okay";
> +	fixed-link {
> +		speed = <100>;
> +		full-duplex;
> +	};
> +};
> +
> +&mc {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&aes {
> +	status = "okay";
> +};
> +
> +&sha {
> +	status = "okay";
> +};
> +
> +&udc5 {
> +	status = "okay";
> +};
> +
> +&udc6 {
> +	status = "okay";
> +};
> +
> +&udc7 {
> +	status = "okay";
> +};
> +
> +&udc8 {
> +	status = "okay";
> +};
> +
> +&udc9 {
> +	status = "okay";
> +};
> +
> +&pcimbox {
> +	status = "okay";
> +};
> +
> +&fiu0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0cs1_pins>;
> +	status = "okay";
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;

Are you sure you tested the DTS with dtbs_check?

> +		reg = <0>;
> +		spi-max-frequency = <19000000>;
> +		spi-rx-bus-width = <2>;
> +		label = "bmc";
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			u-boot@0 {
> +				label = "u-boot";
> +				reg = <0x0000000 0xf0000>;
> +			};
> +			image-descriptor@f0000 {
> +				label = "image-descriptor";
> +				reg = <0xf0000 0x10000>;
> +			};
> +			hoth-update@100000 {
> +				label = "hoth-update";
> +				reg = <0x100000 0x100000>;
> +			};
> +			kernel@200000 {
> +				label = "kernel";
> +				reg = <0x200000 0x500000>;
> +			};
> +			rofs@700000 {
> +				label = "rofs";
> +				reg = <0x700000 0x35f0000>;
> +			};
> +			rwfs@3cf0000 {
> +				label = "rwfs";
> +				reg = <0x3cf0000 0x300000>;
> +			};
> +			hoth-mailbox@3ff0000 {
> +				label = "hoth-mailbox";
> +				reg = <0x3ff0000 0x10000>;
> +			};
> +		};
> +	};
> +};
> +
> +&fiu3 {
> +	pinctrl-0 = <&spi3_pins>, <&spi3cs1_pins>;
> +	status = "okay";
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0>;
> +		spi-max-frequency = <20000000>;
> +		spi-rx-bus-width = <2>;
> +		label="bios";
> +	};
> +	flash@1 {
> +		compatible = "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;

Same problem.

> +		reg = <1>;
> +		spi-max-frequency = <20000000>;
> +		spi-rx-bus-width = <2>;
> +		label = "bios-secondary";
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			bios-secondary-zero@0 {
> +				label = "bios-secondary-0";
> +				reg = <0x0000000 0x4000000>;
> +			};
> +			bios-secondary-one@4000000 {
> +				label = "bios-secondary-1";
> +				reg = <0x4000000 0x4000000>;
> +			};
> +		};
> +	};
> +};
> +
> +&watchdog1 {
> +	status = "okay";
> +};
> +
> +&rng {
> +	status = "okay";
> +};
> +
> +&serial0 {
> +	status = "okay";
> +};
> +
> +&serial1 {
> +	status = "okay";
> +};
> +
> +&serial2 {
> +	status = "okay";
> +};
> +
> +&serial3 {
> +	status = "okay";
> +};
> +
> +&adc {
> +	#io-channel-cells = <1>;
> +	status = "okay";
> +};
> +
> +&otp {
> +	status = "okay";
> +};
> +
> +&lpc_kcs {
> +	kcs1: kcs1@0 {
> +		status = "okay";
> +	};
> +
> +	kcs2: kcs2@0 {
> +		status = "okay";
> +	};
> +
> +	kcs3: kcs3@0 {
> +		status = "okay";
> +	};
> +};
> +
> +&lpc_host {
> +	lpc_bpc: lpc_bpc@40 {
> +		monitor-ports = <0x80>;
> +		status = "okay";
> +	};
> +};
> +
> +&i2c0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	status = "disabled";

Why?

> +	i2c-switch@73 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x73>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +		reset-gpios = <&pca9538 0 GPIO_ACTIVE_LOW>;
> +
> +		i2c_cpu0_dimmA: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +
> +		i2c_cpu0_dimmE: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +		i2c_cpu1_dimmA: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +
> +		i2c_cpu1_dimmE: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +	i2c-switch@74 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x74>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +		reset-gpios = <&pca9538 1 GPIO_ACTIVE_LOW>;
> +
> +		i2c_clock_gen_0: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +
> +		i2c_clock_gen_1: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +		i2c_clock_gen_2: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +
> +		i2c_clock_gen_3: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +	};
> +
> +	i2c-switch@75 {
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x75>;
> +		i2c-mux-idle-disconnect;
> +		reset-gpios = <&pca9538 4 GPIO_ACTIVE_LOW>;
> +
> +		i2c_slot0: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +			pcie-slot = &pcie0;
> +		};
> +
> +		i2c_slot1: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +			pcie-slot = &pcie1;
> +		};
> +
> +		i2c_slot2: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +			pcie-slot = &pcie2;
> +			lm90@4a {
> +				compatible = "national,lm90";
> +				reg = <0x4a>;
> +			};
> +		};
> +
> +		i2c_slot3: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +			pcie-slot = &pcie3;
> +		};
> +
> +		i2c_slot4: i2c@4 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <4>;
> +			pcie-slot = &pcie4;
> +		};
> +
> +		i2c_slot5: i2c@5 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <5>;
> +			pcie-slot = &pcie5;
> +		};
> +
> +		i2c_slot6: i2c@6 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <6>;
> +			pcie-slot = &pcie6;
> +		};
> +
> +		i2c_slot7: i2c@7 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <7>;
> +			pcie-slot = &pcie7;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	i2c-switch@75 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x75>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +		reset-gpios = <&pca9538 2 GPIO_ACTIVE_LOW>;
> +
> +		i2c_power_0: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +			zl8802@5b {
> +				compatible = "isil,zl8802";
> +				reg = <0x5b>;
> +			};
> +		};
> +
> +		i2c_power_1: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +			max16600@60 {
> +				compatible = "max16600";
> +				reg = <0x60>;
> +			};
> +		};
> +
> +		i2c_power_2: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +			max16600@60 {
> +				compatible = "max16600";
> +				reg = <0x60>;
> +			};
> +		};
> +
> +		i2c_power_3: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +			stb_12v@68 {
> +				compatible = "pm6764tr";
> +				reg = <0x68>;
> +			};
> +		};
> +	};
> +
> +	i2c-switch@77 {
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x77>;
> +		i2c-mux-idle-disconnect;
> +		reset-gpios = <&pca9538 5 GPIO_ACTIVE_LOW>;
> +
> +		i2c_isl_0: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +			vrm@46 {
> +				compatible = "isil,isl69222";
> +				reg = <0x46>;
> +			};
> +		};
> +
> +		i2c_isl_1: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +			vrm@46 {
> +				compatible = "isil,isl69222";
> +				reg = <0x46>;
> +			};
> +		};
> +
> +		i2c_isl_2: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +			vrm@46 {
> +				compatible = "isil,isl69222";
> +				reg = <0x46>;
> +			};
> +		};
> +
> +		i2c_isl_3: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +			vrm@46 {
> +				compatible = "isil,isl69222";
> +				reg = <0x46>;
> +			};
> +		};
> +
> +		i2c_isl_4: i2c@4 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <4>;
> +			vrm@46 {
> +				compatible = "isil,isl69228";
> +				reg = <0x46>;
> +			};
> +		};
> +
> +		i2c_isl_5: i2c@5 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <5>;
> +			vrm@46 {
> +				compatible = "isil,isl69228";
> +				reg = <0x46>;
> +			};
> +		};
> +
> +		i2c_isl_6: i2c@6 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <6>;
> +			vrm@46 {
> +				compatible = "isil,isl69228";
> +				reg = <0x46>;
> +			};
> +		};
> +
> +		i2c_isl_7: i2c@7 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <7>;
> +			vrm@46 {
> +				compatible = "isil,isl69228";
> +				reg = <0x46>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	pca9538: pca9538@72 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "nxp,pca9538";
> +		reg = <0x72>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		U3009_P0 {


No underscores in node names, only lowercase characters.

> +			gpio-hog;
> +			gpios = <0 0>;
> +			output-low;
> +			line-name = "RST_SMB_MUX_TCA9545_N";
> +		};
> +	};
> +
> +	i2c-switch@75 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x75>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +		reset-gpios = <&pca9538 3 GPIO_ACTIVE_LOW>;
> +
> +		i2c_hostswap: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			adm1272@1f {
> +				compatible = "adi,adm1272";
> +				reg = <0x1f>;
> +				shunt-resistor-micro-ohms = <330>;
> +			};
> +		};
> +		i2c_tmp: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +		i2c_fan_controller_1: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +			fan_controller@2c {
> +				compatible = "maxim,max31790";
> +				reg = <0x2c>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +		i2c_fan_controller_2: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +			fan_controller@2c {
> +				compatible = "maxim,max31790";
> +				reg = <0x2c>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +	};
> +
> +	i2c-switch@77 {
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x77>;
> +		i2c-mux-idle-disconnect;
> +		reset-gpios = <&pca9538 6 GPIO_ACTIVE_LOW>;
> +
> +		i2c_seq: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +			Sequencer@59 {
> +				compatible = "maxim,max34451";
> +				reg = <0x59>;
> +			};
> +		};
> +
> +		i2c_fru_1: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +			mobo_fru@55 {
> +				compatible = "atmel,24c64";
> +				reg = <0x55>;
> +			};
> +		};
> +
> +		i2c_fru_2: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +			eeprom@50 {
> +				compatible = "atmel,24c2048";
> +				reg = <0x50>;
> +			};
> +		};
> +
> +		i2c_i2cool_1: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +			lm75@5c {
> +				compatible = "maxim,max31725";
> +				reg = <0x5c>;
> +				status = "okay";
> +			};
> +		};
> +
> +		i2c_i2cool_2: i2c@4 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <4>;
> +			lm75@5c {
> +				compatible = "maxim,max31725";
> +				reg = <0x5c>;
> +				status = "okay";
> +			};
> +		};
> +
> +		i2c_i2cool_3: i2c@5 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <5>;
> +			lm75@5c {
> +				compatible = "maxim,max31725";
> +				reg = <0x5c>;
> +				status = "okay";
> +			};
> +		};
> +
> +		i2c_i2cool_4: i2c@6 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <6>;
> +			lm75@5c {
> +				compatible = "maxim,max31725";
> +				reg = <0x5c>;
> +				status = "okay";
> +			};
> +		};
> +
> +		i2c_cpu_pirom: i2c@7 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <7>;
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +	slave_mqueue: i2c-slave-mqueue@40000010 {
> +		compatible = "i2c-slave-mqueue";
> +		reg = <0x40000010>;
> +		status = "okay";

Why do you need status here?

> +	};
> +};
> +
> +&i2c8 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c11 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +};
> +
> +&i2c14 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +	Sequencer@59 {

No underscores in node names, only lowercase characters.

> +		compatible = "maxim,max34451";
> +		reg = <0x59>;
> +	};
> +
> +	bmc_fru@55 {

Ehh... this is poor.. I'll stop review.



Best regards,
Krzysztof

