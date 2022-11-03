Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497E4617381
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 01:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiKCAxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 20:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKCAxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:53:51 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805C460ED;
        Wed,  2 Nov 2022 17:53:48 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 11so243294iou.0;
        Wed, 02 Nov 2022 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A25f1UNYpoi2rUIaTnlzfc1AYDlGiJ6dYNVWdbpVTGU=;
        b=lhZT+cA65h2ZlGPYQsW1KrCupo5wjVax0gidCRHawOq3LjlOWH0xWZ5WIk0ifMRSJt
         r2IPnRK44SpHygSvFvsYUMlRd+hx/lN/6vdbqaph4Gx3GK6inqoh65XT76cSPoB+XSJ5
         zwNv18UkPNR58FZ8Fh3MQef7yeJRtrc8cXileYQEkDdj1LEPSbIvRoAl+Ctfa55Rzax2
         Lveh2Kd4ZeuUZSMNBhqoF3qcscQViGnvbcpJcIlR37FU7AigBgC14HbDRiucodgVALi/
         U0OoYX6T0WnTaiP4JvZdnKm1AFZid/SLcW4ApyiQQ596115lL4G9O7tMwtxoTgmnOo1g
         wN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A25f1UNYpoi2rUIaTnlzfc1AYDlGiJ6dYNVWdbpVTGU=;
        b=qntRdordUQLfAvul194jQ5GwXx4hv0W0c9i5Ti01kCUueuU6jKo0zBoOfe1gYthi+d
         kzbu2GLGEs+6MJcq54BaHmHn4zLpAMys0QMoZkRpg2kMJ4xw+lO2WtUdgORqAquMM4jH
         M4eqoo8vGlH+CdPV6hW5fuqk3g8cYLcMZr9OTba0gimz4MonFp719eYO+aCjHKzAO02Q
         u+dnrQNR3giyXbvf06VD+mfwmcb1qS+/m2GwRKR/YpkYbhZQltpSB8DkYTSPKvoYYQEt
         x9vRLO8VE0sbKi8bDmFdw4hpsbd8KS2Y0nlR00FPgxaHOrBgq+Cg8uiMixOtoJLmqJvo
         qQ0A==
X-Gm-Message-State: ACrzQf011y7VENmkt/VIc1bW2M4iO0PUjXXBenxZAiDOFcVNeX4XAAHO
        BWE3LuEcV99TbRx+t5R+PG0=
X-Google-Smtp-Source: AMsMyM6UfhMs5UAH5hthQ36+3Ezu0Aqcp5Qy7fzBIEA7SZyPgiNCk0e4yXF9cklMqu35MxgVcmRljg==
X-Received: by 2002:a02:2b02:0:b0:375:29b5:b896 with SMTP id h2-20020a022b02000000b0037529b5b896mr17815595jaa.258.1667436827494;
        Wed, 02 Nov 2022 17:53:47 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id a18-20020a056602149200b006a102cb4900sm5682742iow.39.2022.11.02.17.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 17:53:46 -0700 (PDT)
Date:   Wed, 2 Nov 2022 20:53:44 -0400
From:   Richard Acayan <mailingradian@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: add sdm670 and pixel 3a device
 trees
Message-ID: <Y2MRGJIY9ZdVGnDs@mailingradian>
References: <20221101235722.53955-1-mailingradian@gmail.com>
 <20221101235722.53955-5-mailingradian@gmail.com>
 <bebf005c-3666-1442-47f7-dd000375af5d@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bebf005c-3666-1442-47f7-dd000375af5d@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:26:13PM +0100, Konrad Dybcio wrote:
> On 02/11/2022 00:57, Richard Acayan wrote:
>> The Qualcomm Snapdragon 670 has been out for a while. Add a device tree
>> for it and the Google Pixel 3a as the first device.
>>
>> The Pixel 3a has the same bootloader issue as the Pixel 3 and will not work
>> on Android 10 bootloaders or later until it gets fixed for the Pixel 3.
>>
>> SoC Initial Features:
>>   - power management
>>   - clocks
>>   - pinctrl
>>   - eMMC
>>   - USB 2.0
>>   - GENI I2C
>>   - IOMMU
>>   - RPMh
>>   - interrupts
>>
>> Device-Specific Initial Features:
>>   - side buttons (keys)
>>   - regulators
>>   - touchscreen
>>
>> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile             |    1 +
>>   .../boot/dts/qcom/sdm670-google-sargo.dts     |  519 +++++++
>>   arch/arm64/boot/dts/qcom/sdm670.dtsi          | 1216 +++++++++++++++++
>>   3 files changed, 1736 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/sdm670.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index b0558d3389e5..4eb5d8829efb 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -124,6 +124,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-voyager.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm670-google-sargo.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
>> new file mode 100644
>> index 000000000000..fa3dee78e442
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
>> @@ -0,0 +1,519 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device tree for Google Pixel 3a, adapted from google-blueline device tree,
>> + * xiaomi-lavender device tree, and oneplus-common device tree.
>> + *
>> + * Copyright (c) 2022, Richard Acayan. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>> +#include <dt-bindings/power/qcom-rpmpd.h>
>> +#include "sdm670.dtsi"
>> +#include "pm660.dtsi"
>> +#include "pm660l.dtsi"
>> +
>> +/delete-node/ &mpss_region;
>> +/delete-node/ &venus_mem;
>> +/delete-node/ &wlan_msa_mem;
>> +/delete-node/ &cdsp_mem;
>> +/delete-node/ &mba_region;
>> +/delete-node/ &adsp_mem;
>> +/delete-node/ &ipa_fw_mem;
>> +/delete-node/ &ipa_gsi_mem;
>> +/delete-node/ &gpu_mem;
>> +
>> +/ {
>> +	model = "Google Pixel 3a";
>> +	compatible = "google,sargo", "qcom,sdm670";
>> +	qcom,board-id = <0x00041e05 0>;
>> +	qcom,msm-id = <321 0x20001>;
>> +
>> +	aliases { };
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		framebuffer@9c000000 {
>> +			compatible = "simple-framebuffer";
>> +			reg = <0x0 0x9c000000 0x0 (1080 * 2220 * 4)>;
>> +			width = <1080>;
>> +			height = <2220>;
>> +			stride = <(1080 * 4)>;
>> +			format = "a8r8g8b8";
>> +		};
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +
>> +		mpss_region: mpss@8b000000 {
>
> Please call the nodes memory@

Ignoring.

>
>
>> +			reg = <0 0x8b000000 0 0x9800000>;
>> +			no-map;
>> +		};
>> +
>> +		venus_mem: venus@94800000 {
>> +			reg = <0 0x94800000 0 0x500000>;
>> +			no-map;
>> +		};
>> +
>> +		wlan_msa_mem: wlan-msa@94d00000 {
>> +			reg = <0 0x94d00000 0 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		cdsp_mem: cdsp@94e00000 {
>> +			reg = <0 0x94e00000 0 0x800000>;
>> +			no-map;
>> +		};
>> +
>> +		mba_region: mba@95600000 {
>> +			reg = <0 0x95600000 0 0x200000>;
>> +			no-map;
>> +		};
>> +
>> +		adsp_mem: adsp@95800000 {
>> +			reg = <0 0x95800000 0 0x2200000>;
>> +			no-map;
>> +		};
>> +
>> +		ipa_fw_mem: ipa-fw@97a00000 {
>> +			reg = <0 0x97a00000 0 0x10000>;
>> +			no-map;
>> +		};
>> +
>> +		ipa_gsi_mem: ipa-gsi@97a10000 {
>> +			reg = <0 0x97a10000 0 0x5000>;
>> +			no-map;
>> +		};
>> +
>> +		gpu_mem: gpu@97a15000 {
>> +			reg = <0 0x97a15000 0 0x2000>;
>> +			no-map;
>> +		};
>> +
>> +		framebuffer-region@9c000000 {
>> +			reg = <0 0x9c000000 0 0x2400000>;
>> +			no-map;
>> +		};
>> +
>> +		/* Also includes ramoops regions */
>
> Isn't that counter-intuitive? Linux won't see it as ramoops then.

Well, if it doesn't work, I don't want to pretend that it does.

The last time I tested ramoops time I tested ramoops was when there was
no simplefb, usb, or mmc. I could only test ramoops with an Android
recovery, and it didn't seem to function. I'll test the ramoops region
again before the next version and add it if it works.

>
>
>> +		debug_info_mem: debug-info@a1800000 {
>> +			reg = <0 0xa1800000 0 0x411000>;
>> +			no-map;
>> +		};
>> +	};
>> +
>> +	/*
>> +	 * Supply map from xiaomi-lavender specifies this as the supply for
>> +	 * ldob1, ldob9, ldob10, ldoa2, and ldoa3, while downstream specifies
>> +	 * this as a power domain. Set this as a fixed regulator with the same
>> +	 * voltage as lavender until display is needed to avoid unneccessarily
>> +	 * using a deprecated binding (regulator-fixed-domain).
>> +	 */
>> +	vreg_s2b_1p05: vreg-s2b-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vreg_s2b";
>> +		regulator-min-microvolt = <1050000>;
>> +		regulator-max-microvolt = <1050000>;
>> +	};
>> +
>> +	vph_pwr: vph-pwr-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vph_pwr";
>> +		regulator-min-microvolt = <3312000>;
>> +		regulator-max-microvolt = <3312000>;
>> +
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +		autorepeat;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vol_up_pin>;
>> +
>> +		key-vol-up {
>> +			label = "Volume Up";
>> +			linux,code = <KEY_VOLUMEUP>;
>> +			gpios = <&pm660l_gpios 7 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +
>> +	/*
>> +	 * The touchscreen regulator seems to be controlled somehow by a gpio.
>> +	 * Model it as a fixed regulator and keep it on. Without schematics we
>> +	 * don't know how this is actually wired up...
>> +	 */
>> +	ts_1p8_supply: ts-1p8-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "ts_1p8_supply";
>> +
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +
>> +		gpio = <&pm660_gpios 12 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +	};
>> +};
>> +
>> +&apps_rsc {
>> +	pm660l-regulators {
>
> New bindings changes dictate use of regulator-0 regulator-1 etc
>
> node names. Also, is there any particular reason PMIC_B goes before
>
> PMIC_A?

Renamed for v2.

If I remember correctly, the reason was that bob supplies other
regulators. You couldn't probe a regulator when I was putting this
together. Something must have changed on next, but these can be in their
proper order now.

>
>
>> +		compatible = "qcom,pm660l-rpmh-regulators";
>> +		qcom,pmic-id = "b";
>> +
>> +		vdd-s1-supply = <&vph_pwr>;
>> +		vdd-s2-supply = <&vph_pwr>;
>> +		vdd-s3-s4-supply = <&vph_pwr>;
>> +		vdd-s5-supply = <&vph_pwr>;
>> +
>> +		vdd-l1-l9-l10-supply = <&vreg_s2b_1p05>;
>> +		vdd-l2-supply = <&vreg_bob>;
>> +		vdd-l3-l5-l7-l8-supply = <&vreg_bob>;
>> +		vdd-l4-l6-supply = <&vreg_bob>;
>> +		vdd-bob-supply = <&vph_pwr>;
>> +
>> +		/* LDOs */
>> +		vreg_l1b_0p89: ldo1 {
>> +			regulator-min-microvolt = <880000>;
>> +			regulator-max-microvolt = <900000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l2b_2p38: ldo2 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <2960000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l3b_2p93: ldo3 {
>> +			regulator-min-microvolt = <2850000>;
>> +			regulator-max-microvolt = <3008000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l4b_2p96: ldo4 {
>> +			regulator-min-microvolt = <2960000>;
>> +			regulator-max-microvolt = <2960000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l5b_2p96: ldo5 {
>> +			regulator-min-microvolt = <2960000>;
>> +			regulator-max-microvolt = <2960000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l6b_3p15: ldo6 {
>> +			regulator-min-microvolt = <3008000>;
>> +			regulator-max-microvolt = <3300000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l7b_3p1: ldo7 {
>> +			regulator-min-microvolt = <3088000>;
>> +			regulator-max-microvolt = <3100000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l8b_3p3: ldo8 {
>> +			regulator-min-microvolt = <3300000>;
>> +			regulator-max-microvolt = <3312000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		/*
>> +		 * Downstream specifies a fixed voltage of 3.312 V, but the
>> +		 * PMIC4 BOB ranges don't support that. Widen the range a
>> +		 * little to avoid adding a new BOB regulator type.
>
> Maybe the upstream driver is wrong then. Could somebody with docs recheck
> that?

I'm not sure if this is relevant, but the RPM regulator driver doesn't
support 3.312 V either.

>
> And also pm8350 & pm8350c ranges while at it, pretty please?
>
>
>> +		 */
>> +		vreg_bob: bob {
>> +			regulator-min-microvolt = <3296000>;
>> +			regulator-max-microvolt = <3328000>;
>> +			regulator-enable-ramp-delay = <500>;
>> +		};
>> +	};
>> +
>> +	pm660-regulators {
>> +		compatible = "qcom,pm660-rpmh-regulators";
>> +		qcom,pmic-id = "a";
>> +
>> +		vdd-s1-supply = <&vph_pwr>;
>> +		vdd-s2-supply = <&vph_pwr>;
>> +		vdd-s3-supply = <&vph_pwr>;
>> +		vdd-s4-supply = <&vph_pwr>;
>> +		vdd-s5-supply = <&vph_pwr>;
>> +		vdd-s6-supply = <&vph_pwr>;
>> +
>> +		vdd-l1-l6-l7-supply = <&vreg_s6a_1p29>;
>> +		vdd-l2-l3-supply = <&vreg_s2b_1p05>;
>> +		vdd-l5-supply = <&vreg_s2b_1p05>;
>> +		vdd-l8-l9-l10-l11-l12-l13-l14-supply = <&vreg_s4a_1p92>;
>> +		vdd-l15-l16-l17-l18-l19-supply = <&vreg_bob>;
>> +
>> +		/*
>> +		 * S1A (FTAPC0), S2A (FTAPC1), S3A (HFAPC1) are managed
>> +		 * by the Core Power Reduction hardened (CPRh) and the
>> +		 * Operating State Manager (OSM) HW automatically.
>> +		 */
>> +
>> +		vreg_s4a_1p92: smps4 {
>> +			regulator-min-microvolt = <1808000>;
>> +			regulator-max-microvolt = <2040000>;
>> +			regulator-enable-ramp-delay = <200>;
>> +		};
>> +
>> +		vreg_s6a_1p29: smps6 {
>> +			regulator-min-microvolt = <1224000>;
>> +			regulator-max-microvolt = <1352000>;
>> +			regulator-enable-ramp-delay = <150>;
>> +		};
>> +
>> +		/* LDOs */
>> +		vreg_l1a_1p225: ldo1 {
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1250000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l2a_1p0: ldo2 {
>> +			regulator-min-microvolt = <1000000>;
>> +			regulator-max-microvolt = <1000000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l3a_1p0: ldo3 {
>> +			regulator-min-microvolt = <1000000>;
>> +			regulator-max-microvolt = <1000000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l5a_0p8: ldo5 {
>> +			regulator-min-microvolt = <800000>;
>> +			regulator-max-microvolt = <800000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l6a_1p28: ldo6 {
>> +			regulator-min-microvolt = <1248000>;
>> +			regulator-max-microvolt = <1304000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l7a_1p2: ldo7 {
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1200000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l8a_1p8: ldo8 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l9a_1p8: ldo9 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l10a_1p8: ldo10 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l11a_1p8: ldo11 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l12a_1p8: ldo12 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l13a_1p8: ldo13 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l14a_1p8: ldo14 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l15a_2p38: ldo15 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <2950000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l16a_2p7: ldo16 {
>> +			regulator-min-microvolt = <2696000>;
>> +			regulator-max-microvolt = <2696000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l17a_2p38: ldo17 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <2950000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +
>> +		vreg_l19a_3p3: ldo19 {
>> +			regulator-min-microvolt = <3000000>;
>> +			regulator-max-microvolt = <3312000>;
>> +			regulator-enable-ramp-delay = <250>;
>> +		};
>> +	};
>> +};
>> +
>> +&gpi_dma1 {
>> +	status = "okay";
>> +};
>> +
>> +&qupv3_id_1 {
>> +	status = "okay";
>> +};
>
> Please sort the & references alphabetically.

Sorted for v2.

>
>
>> +
>> +&i2c9 {
>> +	status = "okay";
>
> status should be the last property (still before subnodes - otherwise you'll
> get a DTC error).
>
> This applies to all occurences.

Moved.

>
>
>> +	clock-frequency = <100000>;
>> +
>> +	synaptics-rmi4-i2c@20 {
>> +		compatible = "syna,rmi4-i2c";
>> +		reg = <0x20>;
>> +		#address-cells = <0x1>;
>> +		#size-cells = <0x0>;
>> +		interrupts-extended = <&tlmm 125 IRQ_TYPE_EDGE_FALLING>;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&touchscreen_default>;
>> +
>> +		/* VDD supply isn't specified, bind it to power */
>
> I don't think it would explode if you just removed it then?

Confirmed and removed for v2.

>
>
>> +		vdd-supply = <&vph_pwr>;
>> +		vio-supply = <&ts_1p8_supply>;
>> +
>> +		syna,reset-delay-ms = <200>;
>> +		syna,startup-delay-ms = <200>;
>> +
>> +		rmi4-f01@1 {
>> +			reg = <0x01>;
>> +			syna,nosleep-mode = <1>;
>> +		};
>> +
>> +		rmi4-f12@12 {
>> +			reg = <0x12>;
>> +			touchscreen-x-mm = <62>;
>> +			touchscreen-y-mm = <127>;
>> +			syna,sensor-type = <1>;
>> +		};
>> +	};
>> +};
>> +
>> +&gcc {
>> +	protected-clocks = <GCC_QSPI_CORE_CLK>,
>> +			   <GCC_QSPI_CORE_CLK_SRC>,
>> +			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
>> +};
>> +
>> +&pm660l_gpios {
>> +	vol_up_pin: vol-up-state {
>> +		pins = "gpio7";
>> +		function = "normal";
>> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
>> +		input-enable;
>> +		bias-pull-up;
>> +	};
>> +};
>> +
>> +&pon_pwrkey {
>> +	status = "okay";
>> +};
>> +
>> +&pon_resin {
>> +	status = "okay";
>> +	linux,code = <KEY_VOLUMEDOWN>;
>> +};
>> +
>> +&sdhc_1 {
>> +	status = "okay";
>> +	supports-cqe;
>> +	mmc-hs200-1_8v;
>> +	mmc-hs400-1_8v;
>> +	mmc-ddr-1_8v;
>> +
>> +	qcom,ddr-config = <0xc3040873>;
>> +
>> +	vmmc-supply = <&vreg_l4b_2p96>;
>> +	vqmmc-supply = <&vreg_l8a_1p8>;
>> +};
>> +
>> +&tlmm {
>> +	gpio-reserved-ranges = <0 4>, <81 4>;
>> +
>> +	touchscreen_default: ts-default-state {
>> +		ts-reset-pins {
>> +			pins = "gpio99";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-pull-up;
>> +			output-high;
>> +		};
>> +
>> +		ts-irq-pins {
>> +			pins = "gpio125";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +
>> +		ts-switch-pins {
>> +			pins = "gpio135";
>> +			function = "gpio";
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +			output-low;
>> +		};
>> +	};
>> +};
>> +
>> +&usb_1_hsphy {
>> +	status = "okay";
>> +
>> +	vdd-supply = <&vreg_l1b_0p89>;
>> +	vdda-pll-supply = <&vreg_l10a_1p8>;
>> +	vdda-phy-dpdm-supply = <&vreg_l7b_3p1>;
>> +};
>> +
>> +&usb_1 {
>> +	status = "okay";
>> +
>> +	qcom,select-utmi-as-pipe-clk;
>> +};
>> +
>> +&usb_1_dwc3 {
>> +	/* Only peripheral works for now */
>> +	dr_mode = "peripheral";
>> +
>> +	/* Do not assume that sdm670.dtsi will never support USB 3.0 */
>> +	phys = <&usb_1_hsphy>;
>> +	phy-names = "usb2-phy";
>> +	maximum-speed = "high-speed";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
>> new file mode 100644
>> index 000000000000..4450ece839a0
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
>> @@ -0,0 +1,1216 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * SDM670 SoC device tree source, adapted from SDM845 SoC device tree
>> + *
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022, Richard Acayan. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/clock/qcom,gcc-sdm845.h>
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/dma/qcom-gpi.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/phy/phy-qcom-qusb2.h>
>> +#include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +
>> +/ {
>> +	interrupt-parent = <&intc>;
>> +
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	aliases { };
>> +
>> +	chosen { };
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		/* We expect the bootloader to fill in the size */
>> +		reg = <0 0x80000000 0 0>;
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		hyp_mem: hyp-mem@85700000 {
>> +			reg = <0 0x85700000 0 0x600000>;
>> +			no-map;
>> +		};
>> +
>> +		xbl_mem: xbl-mem@85e00000 {
>> +			reg = <0 0x85e00000 0 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		aop_mem: aop-mem@85fc0000 {
>> +			reg = <0 0x85fc0000 0 0x20000>;
>> +			no-map;
>> +		};
>> +
>> +		aop_cmd_db_mem: aop-cmd-db-mem@85fe0000 {
>> +			compatible = "qcom,cmd-db";
>> +			reg = <0x0 0x85fe0000 0 0x20000>;
>> +			no-map;
>> +		};
>> +
>> +		camera_mem: camera-mem@8ab00000 {
>> +			reg = <0 0x8ab00000 0 0x500000>;
>> +			no-map;
>> +		};
>> +
>> +		mpss_region: mpss@8b000000 {
>> +			reg = <0 0x8b000000 0 0x7e00000>;
>> +			no-map;
>> +		};
>> +
>> +		venus_mem: venus@92e00000 {
>> +			reg = <0 0x92e00000 0 0x500000>;
>> +			no-map;
>> +		};
>> +
>> +		wlan_msa_mem: wlan-msa@93300000 {
>> +			reg = <0 0x93300000 0 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		cdsp_mem: cdsp@93400000 {
>> +			reg = <0 0x93400000 0 0x800000>;
>> +			no-map;
>> +		};
>> +
>> +		mba_region: mba@93c00000 {
>> +			reg = <0 0x93c00000 0 0x200000>;
>> +			no-map;
>> +		};
>> +
>> +		adsp_mem: adsp@93e00000 {
>> +			reg = <0 0x93e00000 0 0x1e00000>;
>> +			no-map;
>> +		};
>> +
>> +		ipa_fw_mem: ipa-fw@95c00000 {
>> +			reg = <0 0x95c00000 0 0x10000>;
>> +			no-map;
>> +		};
>> +
>> +		ipa_gsi_mem: ipa-gsi@95c10000 {
>> +			reg = <0 0x95c10000 0 0x5000>;
>> +			no-map;
>> +		};
>> +
>> +		gpu_mem: gpu@95c15000 {
>> +			reg = <0 0x95c15000 0 0x2000>;
>> +			no-map;
>> +		};
>> +
>> +		spss_mem: spss@97b00000 {
>> +			reg = <0 0x97b00000 0 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		qseecom_mem: qseecom@9e400000 {
>> +			reg = <0 0x9e400000 0 0x1400000>;
>> +			no-map;
>> +		};
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		CPU0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo360";
>> +			reg = <0x0 0x0>;
>> +			enable-method = "psci";
>> +			power-domains = <&CPU_PD0>;
>> +			power-domain-names = "psci";
>> +			next-level-cache = <&L2_0>;
>> +			L2_0: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +				L3_0: l3-cache {
>> +				      compatible = "cache";
>> +				};
>> +			};
>> +		};
>> +
>> +		CPU1: cpu@100 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo360";
>> +			reg = <0x0 0x100>;
>> +			enable-method = "psci";
>> +			power-domains = <&CPU_PD1>;
>> +			power-domain-names = "psci";
>> +			next-level-cache = <&L2_100>;
>> +			L2_100: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU2: cpu@200 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo360";
>> +			reg = <0x0 0x200>;
>> +			enable-method = "psci";
>> +			power-domains = <&CPU_PD2>;
>> +			power-domain-names = "psci";
>> +			next-level-cache = <&L2_200>;
>> +			L2_200: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU3: cpu@300 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo360";
>> +			reg = <0x0 0x300>;
>> +			enable-method = "psci";
>> +			power-domains = <&CPU_PD3>;
>> +			power-domain-names = "psci";
>> +			next-level-cache = <&L2_300>;
>> +			L2_300: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU4: cpu@400 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo360";
>> +			reg = <0x0 0x400>;
>> +			enable-method = "psci";
>> +			power-domains = <&CPU_PD4>;
>> +			power-domain-names = "psci";
>> +			next-level-cache = <&L2_400>;
>> +			L2_400: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU5: cpu@500 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo360";
>> +			reg = <0x0 0x500>;
>> +			enable-method = "psci";
>> +			power-domains = <&CPU_PD5>;
>> +			power-domain-names = "psci";
>> +			next-level-cache = <&L2_500>;
>> +			L2_500: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU6: cpu@600 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo360";
>> +			reg = <0x0 0x600>;
>> +			enable-method = "psci";
>> +			power-domains = <&CPU_PD6>;
>> +			power-domain-names = "psci";
>> +			next-level-cache = <&L2_600>;
>> +			L2_600: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU7: cpu@700 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo360";
>> +			reg = <0x0 0x700>;
>> +			enable-method = "psci";
>> +			power-domains = <&CPU_PD7>;
>> +			power-domain-names = "psci";
>> +			next-level-cache = <&L2_700>;
>> +			L2_700: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		cpu-map {
>> +			cluster0 {
>> +				core0 {
>> +					cpu = <&CPU0>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&CPU1>;
>> +				};
>> +
>> +				core2 {
>> +					cpu = <&CPU2>;
>> +				};
>> +
>> +				core3 {
>> +					cpu = <&CPU3>;
>> +				};
>> +
>> +				core4 {
>> +					cpu = <&CPU4>;
>> +				};
>> +
>> +				core5 {
>> +					cpu = <&CPU5>;
>> +				};
>> +
>> +				core6 {
>> +					cpu = <&CPU6>;
>> +				};
>> +
>> +				core7 {
>> +					cpu = <&CPU7>;
>> +				};
>> +			};
>> +		};
>> +
>> +		idle-states {
>> +			entry-method = "psci";
>> +
>> +			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
>> +				compatible = "arm,idle-state";
>> +				idle-state-name = "little-rail-power-collapse";
>> +				arm,psci-suspend-param = <0x40000004>;
>> +				entry-latency-us = <702>;
>> +				exit-latency-us = <915>;
>> +				min-residency-us = <1617>;
>> +				local-timer-stop;
>> +			};
>> +
>> +			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
>> +				compatible = "arm,idle-state";
>> +				idle-state-name = "big-rail-power-collapse";
>> +				arm,psci-suspend-param = <0x40000004>;
>> +				entry-latency-us = <526>;
>> +				exit-latency-us = <1854>;
>> +				min-residency-us = <2380>;
>> +				local-timer-stop;
>> +			};
>> +		};
>> +
>> +		domain-idle-states {
>> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x4100c244>;
>> +				entry-latency-us = <3263>;
>> +				exit-latency-us = <6562>;
>> +				min-residency-us = <9825>;
>> +			};
>> +		};
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +
>> +	clocks {
>
> Please sort nodes alphabetically.

Sorted for next version.

>
>
>> +		xo_board: xo-board {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <38400000>;
>
> clock-frequency should be moved to the board DTS to indicate it's not
>
> a part of the SoC itself, but rather it sits on the board.

I don't know if you got this, because it wasn't sent to you directly,
but this thread suggests that the entire clocks should perhaps move:

https://lore.kernel.org/linux-arm-msm/bb2e92c8-8e19-8840-c1ec-8c7ef667fdbf@quicinc.com/

Full context:
https://lore.kernel.org/linux-arm-msm/Y1GCs6uCz5o9az+v@gerhold.net/

Should I move the entire clocks node?

>
>
>> +			clock-output-names = "xo_board";
>
> This should actually not be necessary, if you pass "xo" to rpmcc..

Confirmed, it is not.

>
>
>
>> +		};
>> +
>> +		sleep_clk: sleep-clk {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <32764>;
>> +		};
>> +	};
>> +
>> +	firmware {
>> +		scm {
>> +			compatible = "qcom,scm-sdm670", "qcom,scm";
>> +		};
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0";
>> +		method = "smc";
>> +
>> +		CPU_PD0: power-domain-cpu0 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD1: power-domain-cpu1 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD2: power-domain-cpu2 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD3: power-domain-cpu3 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD4: power-domain-cpu4 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD5: power-domain-cpu5 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD6: power-domain-cpu6 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD7: power-domain-cpu7 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
>> +		};
>> +
>> +		CLUSTER_PD: power-domain-cluster {
>> +			#power-domain-cells = <0>;
>> +			domain-idle-states = <&CLUSTER_SLEEP_0>;
>> +		};
>> +	};
>> +
>> +	soc: soc@0 {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges = <0 0 0 0 0x10 0>;
>> +		dma-ranges = <0 0 0 0 0x10 0>;
>> +		compatible = "simple-bus";
>> +
>> +		gcc: clock-controller@100000 {
>> +			compatible = "qcom,gcc-sdm670";
>> +			reg = <0 0x00100000 0 0x1f0000>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +				 <&rpmhcc RPMH_CXO_CLK_A>,
>> +				 <&sleep_clk>;
>> +			clock-names = "bi_tcxo",
>> +				      "bi_tcxo_ao",
>> +				      "sleep_clk";
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +		};
>> +
>> +		sdhc_1: mmc@7c4000 {
>> +			compatible = "qcom,sdm670-sdhci", "qcom,sdhci-msm-v5";
>> +			reg = <0 0x007c4000 0 0x1000>,
>> +			      <0 0x007c5000 0 0x1000>,
>> +			      <0 0x007c8000 0 0x8000>;
>> +			reg-names = "hc", "cqhci", "ice";
>> +
>> +			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +
>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>> +				 <&gcc GCC_SDCC1_APPS_CLK>,
>> +				 <&rpmhcc RPMH_CXO_CLK>,
>> +				 <&gcc GCC_SDCC1_ICE_CORE_CLK>,
>> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>;
>> +			clock-names = "iface", "core", "xo", "ice", "bus";
>> +
>> +			iommus = <&apps_smmu 0x140 0xf>;
>> +
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&sdc1_state_on>;
>> +			pinctrl-1 = <&sdc1_state_off>;
>> +			power-domains = <&rpmhpd SDM670_CX>;
>> +
>> +			bus-width = <8>;
>> +			non-removable;
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		gpi_dma0: dma-controller@800000 {
>> +			#dma-cells = <3>;
>> +			compatible = "qcom,sdm670-gpi-dma", "qcom,sdm845-gpi-dma";
>> +			reg = <0 0x00800000 0 0x60000>;
>> +			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
>> +			dma-channels = <13>;
>> +			dma-channel-mask = <0xfa>;
>> +			iommus = <&apps_smmu 0x0016 0x0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		qupv3_id_0: geniqup@8c0000 {
>> +			compatible = "qcom,geni-se-qup";
>> +			reg = <0 0x008c0000 0 0x6000>;
>> +			clock-names = "m-ahb", "s-ahb";
>> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
>> +			iommus = <&apps_smmu 0x3 0x0>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>;
>> +			interconnect-names = "qup-core";
>> +			status = "disabled";
>> +
>> +			i2c0: i2c@880000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00880000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c0_default>;
>> +				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
>> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>> +				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
>> +				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c1: i2c@884000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00884000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c1_default>;
>> +				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
>> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>> +				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
>> +				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c2: i2c@888000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00888000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c2_default>;
>> +				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
>> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>> +				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
>> +				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c3: i2c@88c000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x0088c000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c3_default>;
>> +				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
>> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>> +				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
>> +				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c4: i2c@890000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00890000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c4_default>;
>> +				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
>> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>> +				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
>> +				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c5: i2c@894000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00894000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c5_default>;
>> +				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
>> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>> +				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
>> +				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c6: i2c@898000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00898000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c6_default>;
>> +				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
>> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>> +				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
>> +				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c7: i2c@89c000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x0089c000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c7_default>;
>> +				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
>> +						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
>> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>> +				dmas = <&gpi_dma0 0 7 QCOM_GPI_I2C>,
>> +				       <&gpi_dma0 1 7 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gpi_dma1: dma-controller@a00000 {
>> +			#dma-cells = <3>;
>> +			compatible = "qcom,sdm670-gpi-dma", "qcom,sdm845-gpi-dma";
>> +			reg = <0 0x00a00000 0 0x60000>;
>> +			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
>> +			dma-channels = <13>;
>> +			dma-channel-mask = <0xfa>;
>> +			iommus = <&apps_smmu 0x06d6 0x0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		qupv3_id_1: geniqup@ac0000 {
>> +			compatible = "qcom,geni-se-qup";
>> +			reg = <0 0x00ac0000 0 0x6000>;
>> +			clock-names = "m-ahb", "s-ahb";
>> +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
>> +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
>> +			iommus = <&apps_smmu 0x6c3 0x0>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			status = "disabled";
>> +
>> +			i2c8: i2c@a80000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00a80000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c8_default>;
>> +				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
>> +				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c9: i2c@a84000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00a84000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c9_default>;
>> +				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
>> +				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c10: i2c@a88000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00a88000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c10_default>;
>> +				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
>> +				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c11: i2c@a8c000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00a8c000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c11_default>;
>> +				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
>> +				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c12: i2c@a90000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00a90000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c12_default>;
>> +				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
>> +				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c13: i2c@a94000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00a94000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c13_default>;
>> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				dmas = <&gpi_dma1 0 5 QCOM_GPI_I2C>,
>> +				       <&gpi_dma1 1 5 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c14: i2c@a98000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00a98000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c14_default>;
>> +				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				dmas = <&gpi_dma1 0 6 QCOM_GPI_I2C>,
>> +				       <&gpi_dma1 1 6 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c15: i2c@a9c000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00a9c000 0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c15_default>;
>> +				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				power-domains = <&rpmhpd SDM670_CX>;
>> +				dmas = <&gpi_dma1 0 7 QCOM_GPI_I2C>,
>> +				       <&gpi_dma1 1 7 QCOM_GPI_I2C>;
>> +				dma-names = "tx", "rx";
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		tlmm: pinctrl@3400000 {
>> +			compatible = "qcom,sdm670-tlmm";
>> +			reg = <0 0x03400000 0 0xc00000>;
>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +			gpio-ranges = <&tlmm 0 0 151>;
>> +
>> +			qup_i2c0_default: qup-i2c0-default-state {
>> +				pins = "gpio0", "gpio1";
>> +				function = "qup0";
>> +			};
>> +
>> +			qup_i2c1_default: qup-i2c1-default-state {
>> +				pins = "gpio17", "gpio18";
>> +				function = "qup1";
>> +			};
>> +
>> +			qup_i2c2_default: qup-i2c2-default-state {
>> +				pins = "gpio27", "gpio28";
>> +				function = "qup2";
>> +			};
>> +
>> +			qup_i2c3_default: qup-i2c3-default-state {
>> +				pins = "gpio41", "gpio42";
>> +				function = "qup3";
>> +			};
>> +
>> +			qup_i2c4_default: qup-i2c4-default-state {
>> +				pins = "gpio89", "gpio90";
>> +				function = "qup4";
>> +			};
>> +
>> +			qup_i2c5_default: qup-i2c5-default-state {
>> +				pins = "gpio85", "gpio86";
>> +				function = "qup5";
>> +			};
>> +
>> +			qup_i2c6_default: qup-i2c6-default-state {
>> +				pins = "gpio45", "gpio46";
>> +				function = "qup6";
>> +			};
>> +
>> +			qup_i2c7_default: qup-i2c7-default-state {
>> +				pins = "gpio93", "gpio94";
>> +				function = "qup7";
>> +			};
>> +
>> +			qup_i2c8_default: qup-i2c8-default-state {
>> +				pins = "gpio65", "gpio66";
>> +				function = "qup8";
>> +			};
>> +
>> +			qup_i2c9_default: qup-i2c9-default-state {
>> +				pins = "gpio6", "gpio7";
>> +				function = "qup9";
>> +			};
>> +
>> +			qup_i2c10_default: qup-i2c10-default-state {
>> +				pins = "gpio55", "gpio56";
>> +				function = "qup10";
>> +			};
>> +
>> +			qup_i2c11_default: qup-i2c11-default-state {
>> +				pins = "gpio31", "gpio32";
>> +				function = "qup11";
>> +			};
>> +
>> +			qup_i2c12_default: qup-i2c12-default-state {
>> +				pins = "gpio49", "gpio50";
>> +				function = "qup12";
>> +			};
>> +
>> +			qup_i2c13_default: qup-i2c13-default-state {
>> +				pins = "gpio105", "gpio106";
>> +				function = "qup13";
>> +			};
>> +
>> +			qup_i2c14_default: qup-i2c14-default-state {
>> +				pins = "gpio33", "gpio34";
>> +				function = "qup14";
>> +			};
>> +
>> +			qup_i2c15_default: qup-i2c15-default-state {
>> +				pins = "gpio81", "gpio82";
>> +				function = "qup15";
>> +			};
>> +
>> +			sdc1_state_on: sdc1-on-state {
>> +				clk-pins {
>> +					pins = "sdc1_clk";
>> +					bias-disable;
>> +					drive-strength = <16>;
>> +				};
>> +
>> +				cmd-pins {
>> +					pins = "sdc1_cmd";
>> +					bias-pull-up;
>> +					drive-strength = <10>;
>> +				};
>> +
>> +				data-pins {
>> +					pins = "sdc1_data";
>> +					bias-pull-up;
>> +					drive-strength = <10>;
>> +				};
>> +
>> +				rclk-pins {
>> +					pins = "sdc1_rclk";
>> +					bias-pull-down;
>> +				};
>> +			};
>> +
>> +			sdc1_state_off: sdc1-off-state {
>> +				clk-pins {
>> +					pins = "sdc1_clk";
>> +					bias-disable;
>> +					drive-strength = <2>;
>> +				};
>> +
>> +				cmd-pins {
>> +					pins = "sdc1_cmd";
>> +					bias-pull-up;
>> +					drive-strength = <2>;
>> +				};
>> +
>> +				data-pins {
>> +					pins = "sdc1_data";
>> +					bias-pull-up;
>> +					drive-strength = <2>;
>> +				};
>> +
>> +				rclk-pins {
>> +					pins = "sdc1_rclk";
>> +					bias-pull-down;
>> +				};
>> +			};
>> +		};
>> +
>> +		usb_1_hsphy: phy@88e2000 {
>> +			compatible = "qcom,sdm670-qusb2-phy", "qcom,qusb2-v2-phy";
>> +			reg = <0 0x088e2000 0 0x400>;
>> +			status = "disabled";
>
> Status last, please.

Moved (also moved the prop in usb_1).

>
>
>> +			#phy-cells = <0>;
>> +
>> +			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
>> +				 <&rpmhcc RPMH_CXO_CLK>;
>> +			clock-names = "cfg_ahb", "ref";
>> +
>> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>> +		};
>> +
>> +		usb_1: usb@a6f8800 {
>> +			compatible = "qcom,sdm670-dwc3", "qcom,dwc3";
>> +			reg = <0 0x0a6f8800 0 0x400>;
>> +			status = "disabled";
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			dma-ranges;
>> +
>> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
>> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
>> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
>> +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
>> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
>> +			clock-names = "cfg_noc",
>> +				      "core",
>> +				      "iface",
>> +				      "sleep",
>> +				      "mock_utmi";
>> +
>> +			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
>> +					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
>> +			assigned-clock-rates = <19200000>, <150000000>;
>> +
>> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hs_phy_irq", "ss_phy_irq",
>> +					  "dm_hs_phy_irq", "dp_hs_phy_irq";
>> +
>> +			power-domains = <&gcc USB30_PRIM_GDSC>;
>> +
>> +			resets = <&gcc GCC_USB30_PRIM_BCR>;
>> +
>> +			usb_1_dwc3: usb@a600000 {
>> +				compatible = "snps,dwc3";
>> +				reg = <0 0x0a600000 0 0xcd00>;
>> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>> +				iommus = <&apps_smmu 0x740 0>;
>> +				snps,dis_u2_susphy_quirk;
>> +				snps,dis_enblslpm_quirk;
>> +				phys = <&usb_1_hsphy>;
>> +				phy-names = "usb2-phy";
>> +			};
>> +		};
>> +
>> +		spmi_bus: spmi@c440000 {
>> +			compatible = "qcom,spmi-pmic-arb";
>> +			reg = <0 0x0c440000 0 0x1100>,
>> +			      <0 0x0c600000 0 0x2000000>,
>> +			      <0 0x0e600000 0 0x100000>,
>> +			      <0 0x0e700000 0 0xa0000>,
>> +			      <0 0x0c40a000 0 0x26000>;
>> +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>> +			interrupt-names = "periph_irq";
>> +			interrupts = <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
>> +			qcom,ee = <0>;
>> +			qcom,channel = <0>;
>> +			#address-cells = <2>;
>> +			#size-cells = <0>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <4>;
>> +		};
>> +
>> +		apps_smmu: iommu@15000000 {
>> +			/*
>> +			 * The hardware tolerates the SDM845 reset quirk. The
>> +			 * iommu maintainers aren't responding to any patches
>> +			 * that would add support for new platforms. Set this
>> +			 * compatible so this dtsi is valid and functional.
>
> Not sure if this is the right approach. SDM670 is more or less a factory
> reject 845,
>
> but the software stack may be hiding some differences..

This compat string is why I don't want this applied just yet.

>
>
> Konrad
>
>> +			 */
>> +			compatible = "qcom,sdm845-smmu-500", "qcom,smmu-500", "arm,mmu-500";
>> +			reg = <0 0x15000000 0 0x80000>;
>> +			#iommu-cells = <2>;
>> +			#global-interrupts = <1>;
>> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +
>> +		apps_rsc: rsc@179c0000 {
>> +			label = "apps_rsc";
>> +			compatible = "qcom,rpmh-rsc";
>> +			reg = <0 0x179c0000 0 0x10000>,
>> +			      <0 0x179d0000 0 0x10000>,
>> +			      <0 0x179e0000 0 0x10000>;
>> +			reg-names = "drv-0", "drv-1", "drv-2";
>> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +			qcom,tcs-offset = <0xd00>;
>> +			qcom,drv-id = <2>;
>> +			qcom,tcs-config = <ACTIVE_TCS  2>,
>> +					  <SLEEP_TCS   3>,
>> +					  <WAKE_TCS    3>,
>> +					  <CONTROL_TCS 1>;
>> +
>> +			apps_bcm_voter: bcm-voter {
>> +				compatible = "qcom,bcm-voter";
>> +			};
>> +
>> +			rpmhcc: clock-controller {
>> +				compatible = "qcom,sdm670-rpmh-clk";
>> +				#clock-cells = <1>;
>> +				clock-names = "xo";
>> +				clocks = <&xo_board>;
>> +			};
>> +
>> +			rpmhpd: power-controller {
>> +				compatible = "qcom,sdm670-rpmhpd";
>> +				#power-domain-cells = <1>;
>> +				operating-points-v2 = <&rpmhpd_opp_table>;
>> +
>> +				rpmhpd_opp_table: opp-table {
>> +					compatible = "operating-points-v2";
>> +
>> +					rpmhpd_opp_ret: opp1 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
>> +					};
>> +
>> +					rpmhpd_opp_min_svs: opp2 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
>> +					};
>> +
>> +					rpmhpd_opp_low_svs: opp3 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +					};
>> +
>> +					rpmhpd_opp_svs: opp4 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
>> +					};
>> +
>> +					rpmhpd_opp_svs_l1: opp5 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>> +					};
>> +
>> +					rpmhpd_opp_nom: opp6 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
>> +					};
>> +
>> +					rpmhpd_opp_nom_l1: opp7 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
>> +					};
>> +
>> +					rpmhpd_opp_nom_l2: opp8 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
>> +					};
>> +
>> +					rpmhpd_opp_turbo: opp9 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
>> +					};
>> +
>> +					rpmhpd_opp_turbo_l1: opp10 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		intc: interrupt-controller@17a00000 {
>> +			compatible = "arm,gic-v3";
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			reg = <0 0x17a00000 0 0x10000>,     /* GICD */
>> +			      <0 0x17a60000 0 0x100000>;    /* GICR * 8 */
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +	};
>> +};
