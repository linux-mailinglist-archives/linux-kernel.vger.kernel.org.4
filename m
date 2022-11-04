Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532D7618E83
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiKDC5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKDC4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:56:54 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9745B25287;
        Thu,  3 Nov 2022 19:56:52 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b2so2876735iof.12;
        Thu, 03 Nov 2022 19:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOBjK/oxBW5coVxRuNxHDGQNyTX798lKI6xKNExDeeM=;
        b=GJGKLbiBy5uBS0p7xYddItZhaNHGrgHbgRxVSgCd/R715mAMrOTHBf9TWchioCkHeU
         MzgiaY85lM4G7poN1veUtWQkjHy/uhL1g9k+8coJhkPpPTdqClM2a36wyubTe/mXmk/d
         qMYT0Qh2Lu9BgmL+yTcrDjs8vMjYVimGyayyctiVA2mnjoUs3V3+KqRuoGilMS/tiimQ
         v8yyW3VGqpm1Q29Q7m9lLxCCx4iKkhb6PxWZ24zkkvstqG/wEgFAILZOSlLfODFTzfAy
         f7messIAnTuX4o7GPnkFkL6xZ5zmeSIex0QHl+0P6snfr/m5z7EmCS6CSISpwdyMTL/b
         11iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOBjK/oxBW5coVxRuNxHDGQNyTX798lKI6xKNExDeeM=;
        b=3+NrgqaNKDEgz93D5xy4MrgPr7kBMD8zqs3eWRj+boqmqDCubk/SaveZ9waasdTRL9
         PrMXKCWcWwshG6Xrs3pDYbYjGG/6yFWT02hwiFMevM4K/6raM4Tz4iIiiMcjaDIAvqla
         KpWW7mAhCFQYh9FcxTpzxEE+f0Rf9VU7a3yxlwAo+QPCGiMI03gPSrmakrW0EILWUqFt
         3/7R3z6a7RGAN7b4qd4sWPTlWnSP6uXnh2p/UppfRWgnz1/H8EkmF7r7zmeUc24UhRhI
         VFiN1TO74vaIUzOy/tiblgMvKU/BBMH/kNaQHJWCXwY+IYwOe7VSFgDTP6k9TYr+Hk4q
         lmZA==
X-Gm-Message-State: ACrzQf0WjaYXSHb9B7NGq85sJHO3L8vqWuV68+Aa4vVzCUS0SBYwe3nr
        BDNQjW1C5rJQzy7z1FN8jVk=
X-Google-Smtp-Source: AMsMyM5HW1vtLgkRjY3ZqFvgIeVhi/yAZ32JwwYMHlHgf6ZpYuvLCmygJ8skVFDc8DDz2rO2ns3naA==
X-Received: by 2002:a02:c98d:0:b0:374:75a4:60c4 with SMTP id b13-20020a02c98d000000b0037475a460c4mr217930jap.189.1667530612003;
        Thu, 03 Nov 2022 19:56:52 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id a1-20020a92d101000000b002fadf9505b4sm914202ilb.16.2022.11.03.19.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 19:56:51 -0700 (PDT)
Date:   Thu, 3 Nov 2022 22:56:49 -0400
From:   Richard Acayan <mailingradian@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: add sdm670 and pixel 3a device
 trees
Message-ID: <Y2R/cWkdqlmCGlvC@mailingradian>
References: <20221103230349.212861-1-mailingradian@gmail.com>
 <20221103230349.212861-5-mailingradian@gmail.com>
 <1a4423c2-42e6-756d-50d8-a844534eae0d@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a4423c2-42e6-756d-50d8-a844534eae0d@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 12:49:34AM +0100, Konrad Dybcio wrote:
> On 04/11/2022 00:03, Richard Acayan wrote:
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
>>   .../boot/dts/qcom/sdm670-google-sargo.dts     |  532 ++++++++
>>   arch/arm64/boot/dts/qcom/sdm670.dtsi          | 1169 +++++++++++++++++
>>   3 files changed, 1702 insertions(+)
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
>> index 000000000000..3a01859dd42c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
>> @@ -0,0 +1,532 @@
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
>
> Please use '0x0' and '0' consistently in reg properties.

Will also do this in aop_cmd_db_mem because grep works, but not in cpus
because the sm6350 has <0x0 0x0> in cpus and <0x0 0x80000000 0x0 0x0> in
memory. The sdm670 dtsi has <0 0x80000000 0 0>, maybe I should change
that according to other dtsi's already in the kernel.

>
>
>> +			width = <1080>;
>> +			height = <2220>;
>> +			stride = <(1080 * 4)>;
>> +			format = "a8r8g8b8";
>> +		};
>> +	};
>> +
>
> [...]
>
>
>> 
>> +
>> +&i2c9 {
>> +	clock-frequency = <100000>;
>> +	status = "okay";
>> +
>> +	synaptics-rmi4-i2c@20 {
>> +		compatible = "syna,rmi4-i2c";
>> +		reg = <0x20>;
>> +		#address-cells = <0x1>;
>> +		#size-cells = <0x0>;
>
> #-cells properties should have decimal values.
>
>
> [...]
>
>
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
>> new file mode 100644
>> index 000000000000..cbebe29ca6f8
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
>> @@ -0,0 +1,1169 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * SDM670 SoC device tree source, adapted from SDM845 SoC device tree
>> + *
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022, Richard Acayan. All rights reserved.
>> + */
>> +
>
> [...]
>
>
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
>
> &apps_smmu 0x16 0x0
>
>
> [...]
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
>
> reg second, #cells and ranges last, please.

I'll also move the label property down in apps_rsc and move the #cells
down in touchscreen.

>
>
> Other than that, lgtm
>
>
> Konrad
>
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +	};
>> +};
