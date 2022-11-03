Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2696618D00
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiKCXtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKCXtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:49:40 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2645F3885
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 16:49:38 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 632151FF01;
        Fri,  4 Nov 2022 00:49:35 +0100 (CET)
Message-ID: <1a4423c2-42e6-756d-50d8-a844534eae0d@somainline.org>
Date:   Fri, 4 Nov 2022 00:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: add sdm670 and pixel 3a device
 trees
To:     Richard Acayan <mailingradian@gmail.com>,
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
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20221103230349.212861-1-mailingradian@gmail.com>
 <20221103230349.212861-5-mailingradian@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221103230349.212861-5-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2022 00:03, Richard Acayan wrote:
> The Qualcomm Snapdragon 670 has been out for a while. Add a device tree
> for it and the Google Pixel 3a as the first device.
>
> The Pixel 3a has the same bootloader issue as the Pixel 3 and will not work
> on Android 10 bootloaders or later until it gets fixed for the Pixel 3.
>
> SoC Initial Features:
>   - power management
>   - clocks
>   - pinctrl
>   - eMMC
>   - USB 2.0
>   - GENI I2C
>   - IOMMU
>   - RPMh
>   - interrupts
>
> Device-Specific Initial Features:
>   - side buttons (keys)
>   - regulators
>   - touchscreen
>
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile             |    1 +
>   .../boot/dts/qcom/sdm670-google-sargo.dts     |  532 ++++++++
>   arch/arm64/boot/dts/qcom/sdm670.dtsi          | 1169 +++++++++++++++++
>   3 files changed, 1702 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
>   create mode 100644 arch/arm64/boot/dts/qcom/sdm670.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b0558d3389e5..4eb5d8829efb 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -124,6 +124,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-voyager.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm670-google-sargo.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
> new file mode 100644
> index 000000000000..3a01859dd42c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
> @@ -0,0 +1,532 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device tree for Google Pixel 3a, adapted from google-blueline device tree,
> + * xiaomi-lavender device tree, and oneplus-common device tree.
> + *
> + * Copyright (c) 2022, Richard Acayan. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include "sdm670.dtsi"
> +#include "pm660.dtsi"
> +#include "pm660l.dtsi"
> +
> +/delete-node/ &mpss_region;
> +/delete-node/ &venus_mem;
> +/delete-node/ &wlan_msa_mem;
> +/delete-node/ &cdsp_mem;
> +/delete-node/ &mba_region;
> +/delete-node/ &adsp_mem;
> +/delete-node/ &ipa_fw_mem;
> +/delete-node/ &ipa_gsi_mem;
> +/delete-node/ &gpu_mem;
> +
> +/ {
> +	model = "Google Pixel 3a";
> +	compatible = "google,sargo", "qcom,sdm670";
> +	qcom,board-id = <0x00041e05 0>;
> +	qcom,msm-id = <321 0x20001>;
> +
> +	aliases { };
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer@9c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0x0 0x9c000000 0x0 (1080 * 2220 * 4)>;

Please use '0x0' and '0' consistently in reg properties.


> +			width = <1080>;
> +			height = <2220>;
> +			stride = <(1080 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +

[...]


>
> +
> +&i2c9 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	synaptics-rmi4-i2c@20 {
> +		compatible = "syna,rmi4-i2c";
> +		reg = <0x20>;
> +		#address-cells = <0x1>;
> +		#size-cells = <0x0>;

#-cells properties should have decimal values.


[...]


> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> new file mode 100644
> index 000000000000..cbebe29ca6f8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> @@ -0,0 +1,1169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SDM670 SoC device tree source, adapted from SDM845 SoC device tree
> + *
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Richard Acayan. All rights reserved.
> + */
> +

[...]


> +
> +		gpi_dma0: dma-controller@800000 {
> +			#dma-cells = <3>;
> +			compatible = "qcom,sdm670-gpi-dma", "qcom,sdm845-gpi-dma";
> +			reg = <0 0x00800000 0 0x60000>;
> +			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-channels = <13>;
> +			dma-channel-mask = <0xfa>;
> +			iommus = <&apps_smmu 0x0016 0x0>;

&apps_smmu 0x16 0x0


[...]
> +
> +		intc: interrupt-controller@17a00000 {
> +			compatible = "arm,gic-v3";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0 0x17a00000 0 0x10000>,     /* GICD */
> +			      <0 0x17a60000 0 0x100000>;    /* GICR * 8 */

reg second, #cells and ranges last, please.


Other than that, lgtm


Konrad

> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +	};
> +};
