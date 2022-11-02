Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34972616EFE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKBUok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiKBUoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:44:38 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207E64C4;
        Wed,  2 Nov 2022 13:44:36 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id DC9A91F987;
        Wed,  2 Nov 2022 21:44:33 +0100 (CET)
Message-ID: <d5f5756c-7372-d905-a321-0c2d19a43192@somainline.org>
Date:   Wed, 2 Nov 2022 21:44:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: add sdm670 and pixel 3a device
 trees
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
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
References: <20221101235722.53955-1-mailingradian@gmail.com>
 <20221101235722.53955-5-mailingradian@gmail.com>
 <bebf005c-3666-1442-47f7-dd000375af5d@somainline.org>
 <5f13efce-844c-dd21-4e22-16b849dc3fa2@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <5f13efce-844c-dd21-4e22-16b849dc3fa2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/11/2022 21:30, Krzysztof Kozlowski wrote:
> On 02/11/2022 16:26, Konrad Dybcio wrote:
>> On 02/11/2022 00:57, Richard Acayan wrote:
>>> The Qualcomm Snapdragon 670 has been out for a while. Add a device tree
>>> for it and the Google Pixel 3a as the first device.
>>>
>>> The Pixel 3a has the same bootloader issue as the Pixel 3 and will not work
>>> on Android 10 bootloaders or later until it gets fixed for the Pixel 3.
>>>
>>> SoC Initial Features:
>>>    - power management
>>>    - clocks
>>>    - pinctrl
>>>    - eMMC
>>>    - USB 2.0
>>>    - GENI I2C
>>>    - IOMMU
>>>    - RPMh
>>>    - interrupts
>>>
>>> Device-Specific Initial Features:
>>>    - side buttons (keys)
>>>    - regulators
>>>    - touchscreen
>>>
>>> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
>>> ---
>>>    arch/arm64/boot/dts/qcom/Makefile             |    1 +
>>>    .../boot/dts/qcom/sdm670-google-sargo.dts     |  519 +++++++
>>>    arch/arm64/boot/dts/qcom/sdm670.dtsi          | 1216 +++++++++++++++++
>>>    3 files changed, 1736 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
>>>    create mode 100644 arch/arm64/boot/dts/qcom/sdm670.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index b0558d3389e5..4eb5d8829efb 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -124,6 +124,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-voyager.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm670-google-sargo.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
>>>    dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
>>> new file mode 100644
>>> index 000000000000..fa3dee78e442
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
>>> @@ -0,0 +1,519 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Device tree for Google Pixel 3a, adapted from google-blueline device tree,
>>> + * xiaomi-lavender device tree, and oneplus-common device tree.
>>> + *
>>> + * Copyright (c) 2022, Richard Acayan. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>> +#include <dt-bindings/power/qcom-rpmpd.h>
>>> +#include "sdm670.dtsi"
>>> +#include "pm660.dtsi"
>>> +#include "pm660l.dtsi"
>>> +
>>> +/delete-node/ &mpss_region;
>>> +/delete-node/ &venus_mem;
>>> +/delete-node/ &wlan_msa_mem;
>>> +/delete-node/ &cdsp_mem;
>>> +/delete-node/ &mba_region;
>>> +/delete-node/ &adsp_mem;
>>> +/delete-node/ &ipa_fw_mem;
>>> +/delete-node/ &ipa_gsi_mem;
>>> +/delete-node/ &gpu_mem;
>>> +
>>> +/ {
>>> +	model = "Google Pixel 3a";
>>> +	compatible = "google,sargo", "qcom,sdm670";
>>> +	qcom,board-id = <0x00041e05 0>;
>>> +	qcom,msm-id = <321 0x20001>;
>>> +
>>> +	aliases { };
>>> +
>>> +	chosen {
>>> +		stdout-path = "serial0:115200n8";
>>> +
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		ranges;
>>> +
>>> +		framebuffer@9c000000 {
>>> +			compatible = "simple-framebuffer";
>>> +			reg = <0x0 0x9c000000 0x0 (1080 * 2220 * 4)>;
>>> +			width = <1080>;
>>> +			height = <2220>;
>>> +			stride = <(1080 * 4)>;
>>> +			format = "a8r8g8b8";
>>> +		};
>>> +	};
>>> +
>>> +	reserved-memory {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +
>>> +		mpss_region: mpss@8b000000 {
>> Please call the nodes memory@
> I think the actual recommendation is to use the purpose as name:
>
> https://lore.kernel.org/linux-arm-msm/CAL_Jsq+66j8Y5y+PQ+mezkaxN1pfHFKz524YUF4Lz_OU5E-mZQ@mail.gmail.com/
>
> https://devicetree-specification.readthedocs.io/en/latest/chapter3-devicenodes.html#reserved-memory-child-nodes
> (second paragraph)

Ok, my bad.


Konrad

>
>
> Best regards,
> Krzysztof
>
