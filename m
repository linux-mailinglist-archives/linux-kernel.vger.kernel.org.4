Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594AF64CEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbiLNR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiLNR0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:26:24 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52641A45F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:26:23 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NXMj96lHDz1S5Cp
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:26:21 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:from
        :references:to:content-language:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1671038780; x=1671902781; bh=OUGHUqz
        7mS3QtSBTgCe2qk6OhCYlol8t5UAMAbyC0LI=; b=HSQ8Y9zwA/JIaswCscztuTX
        dRLVrbgiN7bMos5pRzp4j8WLHZeab0iYXx2a/a2t9thyOqfpcLkBy9JJfxzPe2M1
        SznKmsFf4B3pMxOc8hqOAsGL7qZKWWlUq2eX7F1DSUMC47lNKXAZbes01IhIIIf9
        Me7S+I8rc8tWgkSkNerKAnZ89z4ces7Dtxu9LPAF0QIa17cXLn6b+5c2se88m23x
        KGm9AF1d1kaWeDiL0XK6S3PeQfgS7gnl//SA39Ue/T8uo870DjGnP650Wr6UT6Pq
        PBtJVnzSsgfG6RWM85Ytszp3o79kxnTTozIaKY1HmFQi4/2cF35/DzosLyBxNAQ=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6ptw8Dsb0Gp0 for <linux-kernel@vger.kernel.org>;
        Wed, 14 Dec 2022 12:26:20 -0500 (EST)
Received: from [192.168.4.25] (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NXMhz1slRz1S4tC;
        Wed, 14 Dec 2022 12:26:10 -0500 (EST)
Message-ID: <5a511002-5cd2-b95b-a45a-faaf78e2f4a7@mint.lgbt>
Date:   Wed, 14 Dec 2022 14:26:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel_sprout
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221214093342.153479-1-they@mint.lgbt>
 <ea20c58f-3a53-7cdd-8669-228c4acac49a@linaro.org>
From:   Lux Aliaga <they@mint.lgbt>
In-Reply-To: <ea20c58f-3a53-7cdd-8669-228c4acac49a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a bit confused at the "Node name: usb-id" comment. Should I change 
"extcon_usb" or "extcon-usb" to usb-id?

On 14/12/2022 06:52, Krzysztof Kozlowski wrote:
> On 14/12/2022 10:33, Lux Aliaga wrote:
>> This commit implements support for the Xiaomi Mi A3
>> (xiaomi-laurel_sprout). Here's a summary on what's working.
>>
>> - dmesg output to bootloader preconfigured display
>> - USB
>> - UFS
>> - SMD RPM regulators
>>
>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>   .../dts/qcom/sm6125-xiaomi-laurel_sprout.dts  | 251 ++++++++++++++++++
>>   2 files changed, 252 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel_sprout.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index d7669a7cee9f..7b4fbb4cbb84 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -140,6 +140,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel_sprout.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel_sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel_sprout.dts
>> new file mode 100644
>> index 000000000000..edc5f13bae28
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel_sprout.dts
>> @@ -0,0 +1,251 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2022, Lux Aliaga <they@mint.lgbt>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sm6125.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/input/gpio-keys.h>
>> +
>> +/ {
>> +	/* required for bootloader to select correct board */
>> +	qcom,msm-id = <0x18a 0x00>; /* sm6125 v1 */
>> +	qcom,board-id = <0x0b 0x00>;
>> +
>> +	model = "Xiaomi Mi A3";
>> +	compatible = "xiaomi,laurel_sprout", "qcom,sm6125";
>> +	chassis-type = "handset";
>> +
>> +	chosen {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		framebuffer0: framebuffer@5c000000 {
>> +			compatible = "simple-framebuffer";
>> +			reg = <0 0x5c000000 0 (1560 * 720 * 4)>;
>> +			width = <720>;
>> +			height = <1560>;
>> +			stride = <(720 * 4)>;
>> +			format = "a8r8g8b8";
>> +		};
>> +	};
>> +
>> +	extcon_usb: extcon-usb {
> Node name: usb-id
>
>> +		compatible = "linux,extcon-usb-gpio";
>> +		id-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	reserved_memory {
> No underscores in node names. Use same node name as other boards, don't
> invent own stuff.
>
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		debug_mem: memory@ffb00000 {
>> +			reg = <0x0 0xffb00000 0x0 0xc0000>;
>> +			no-map;
>> +		};
>> +
>> +		last_log_mem: memory@ffbc0000 {
>> +			reg = <0x0 0xffbc0000 0x0 0x80000>;
>> +			no-map;
>> +		};
>> +
>> +		pstore_mem: ramoops@ffc00000 {
>> +			compatible = "ramoops";
>> +			reg = <0x0 0xffc40000 0x0 0xc0000>;
>> +			record-size = <0x1000>;
>> +			console-size = <0x40000>;
>> +			msg-size = <0x20000 0x20000>;
>> +		};
>> +
>> +		cmdline_mem: memory@ffd00000 {
>> +			reg = <0x0 0xffd40000 0x0 0x1000>;
>> +			no-map;
>> +		};
>> +	};
>> +};
>> +
>> +&rpm_requests {
>> +	regulators-0 {
>> +		compatible = "qcom,rpm-pm6125-regulators";
>> +
>> +		vreg_s6a: s6 {
>> +			regulator-min-microvolt = <936000>;
>> +			regulator-max-microvolt = <1422000>;
>> +		};
>> +
>> +		vreg_l1a: l1 {
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1256000>;
>> +		};
>> +
>> +		vreg_l2a: l2 {
>> +			regulator-min-microvolt = <1000000>;
>> +			regulator-max-microvolt = <1056000>;
>> +		};
>> +
>> +		vreg_l3a: l3 {
>> +			regulator-min-microvolt = <1000000>;
>> +			regulator-max-microvolt = <1064000>;
>> +		};
>> +
>> +		vreg_l4a: l4 {
>> +			regulator-min-microvolt = <872000>;
>> +			regulator-max-microvolt = <976000>;
>> +		};
>> +
>> +		vreg_l5a: l5 {
>> +			regulator-min-microvolt = <1648000>;
>> +			regulator-max-microvolt = <3104000>;
>> +		};
>> +
>> +		vreg_l6a: l6 {
>> +			regulator-min-microvolt = <576000>;
>> +			regulator-max-microvolt = <656000>;
>> +		};
>> +
>> +		vreg_l7a: l7 {
>> +			regulator-min-microvolt = <872000>;
>> +			regulator-max-microvolt = <976000>;
>> +		};
>> +
>> +		vreg_l8a: l8 {
>> +			regulator-min-microvolt = <400000>;
>> +			regulator-max-microvolt = <728000>;
>> +		};
>> +
>> +		vreg_l9a: l9 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1896000>;
>> +		};
>> +
>> +		vreg_l10a: l10 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1896000>;
>> +		};
>> +
>> +		vreg_l11a: l11 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1952000>;
>> +		};
>> +
>> +		vreg_l12a: l12 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1996000>;
>> +		};
>> +
>> +		vreg_l13a: l13 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1832000>;
>> +		};
>> +
>> +		vreg_l14a: l14 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1904000>;
>> +		};
>> +
>> +		vreg_l15a: l15 {
>> +			regulator-min-microvolt = <3104000>;
>> +			regulator-max-microvolt = <3232000>;
>> +		};
>> +
>> +		vreg_l16a: l16 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1904000>;
>> +		};
>> +
>> +		vreg_l17a: l17 {
>> +			regulator-min-microvolt = <1248000>;
>> +			regulator-max-microvolt = <1304000>;
>> +		};
>> +
>> +		vreg_l18a: l18 {
>> +			regulator-min-microvolt = <1200000>;
>> +			regulator-max-microvolt = <1264000>;
>> +		};
>> +
>> +		vreg_l19a: l19 {
>> +			regulator-min-microvolt = <1648000>;
>> +			regulator-max-microvolt = <2952000>;
>> +		};
>> +
>> +		vreg_l20a: l20 {
>> +			regulator-min-microvolt = <1648000>;
>> +			regulator-max-microvolt = <2952000>;
>> +		};
>> +
>> +		vreg_l21a: l21 {
>> +			regulator-min-microvolt = <2600000>;
>> +			regulator-max-microvolt = <2856000>;
>> +		};
>> +
>> +		vreg_l22a: l22 {
>> +			regulator-min-microvolt = <2944000>;
>> +			regulator-max-microvolt = <3304000>;
>> +		};
>> +
>> +		vreg_l23a: l23 {
>> +			regulator-min-microvolt = <3000000>;
>> +			regulator-max-microvolt = <3400000>;
>> +		};
>> +
>> +		vreg_l24a: l24 {
>> +			regulator-min-microvolt = <2944000>;
>> +			regulator-max-microvolt = <3304000>;
>> +		};
>> +	};
>> +};
>> +
>> +&hsusb_phy1 {
>> +	status = "okay";
>> +};
>> +
>> +
>> +&sdc2_off_state {
>> +	sd-cd {
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
>
> that's missing -pins suffix but most likely it does not match other DTS
> neither. So probably was based on some old kernel.
>
>> +		pins = "gpio98";
>> +		bias-disable;
>> +		drive-strength = <2>;
>> +	};
>> +};
>> +
>> +&sdc2_on_state {
>> +	sd-cd {
> Same problems.
>
>> +		pins = "gpio98";
>> +		bias-pull-up;
>> +		drive-strength = <2>;
>> +	};
>> +};
> Best regards,
> Krzysztof
>
-- 
Lux Aliaga
https://nixgoat.me/

