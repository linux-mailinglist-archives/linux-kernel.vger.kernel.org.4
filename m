Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C41A64E107
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiLOShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiLOSgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:36:36 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8FE4AF29
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:34:32 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so17031566lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6e3yW7x5+d2m6j9A2MK5+s299jU8kfbfVwl2EjGdCQ=;
        b=IQq0jWp9n3+0c5Wj0e8Si2PdzglmSa34vFUVEZihJDons+TTnQjsl49v6S3403smYE
         bkqbEC7Y9JHYBm3wVkNj+Ie2nAXQen5kajZWA10cTKv97meA1eA5mT2rdjZeGAShCfnK
         lUn8rlIicd7byoKgUgd+s8OkQWY7mnqsKI78ntHqLvfKqYDqZYDgJVs13WitkcLubOLl
         bE+l9IxB87Q8ooDfMi8JoO4+lsxIG0pkE5R97B1vSWUg1NvwZGHp8FHstpb7JZYudm9T
         NrY+7Fczjobh4OC4P6NZyXpnUALK221T56PHRhgShjFz94Sf5moLvf44FFLd/eu2o68r
         jQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6e3yW7x5+d2m6j9A2MK5+s299jU8kfbfVwl2EjGdCQ=;
        b=d55aiPLexMG+qG6R+h8whdO7JHpO601rs6Q2jhQf104qYMdsQxTUXhwSdumDZNBOYI
         q15aofaTW8JrtreBNZaQyRl8yXjXLSrkjLpOBuzSw4mJHH7cbx4F3ZPwxkgePOhJbWyZ
         Xml/tcpcjfHveuo8LaUgGWcWTUIGnc1/kdjA+ixhARBtKLxgPwZpUcOJJApe4l6SDYfp
         ZR0LX/cWP8dHJ+2PwI/tzuM8DzU3J9aKw2SC5gUgaTR36IGamhryTLFkTGZ3MZoDRCLJ
         Nrbny1itdVmtbrDO/P/zXMtlkEb0DmoGLTqck5QUed8Yc+WvKha0Av6HdG1+lk/0hCxE
         AYow==
X-Gm-Message-State: ANoB5pkQgfSIInT7UXccZXqoUqFoWEwqqhLs6D18IzuWsvEYLTmIvsL0
        ISKuI2Re31EVVualq+cBrw/lWA==
X-Google-Smtp-Source: AA0mqf47W0/hJtdOQNTRumWK14ENORojGhfdY3TRT5sT77zQdzV4EEJeNSMx8gFUC1Jl1a0Zya6p+A==
X-Received: by 2002:a05:6512:242:b0:4b5:89fe:829c with SMTP id b2-20020a056512024200b004b589fe829cmr7396498lfo.43.1671129271287;
        Thu, 15 Dec 2022 10:34:31 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id w26-20020a05651204da00b004a27d2ea029sm1230283lfq.172.2022.12.15.10.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 10:34:30 -0800 (PST)
Message-ID: <7c30fc89-8801-7801-de5c-c05fde423bf8@linaro.org>
Date:   Thu, 15 Dec 2022 19:34:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel-sprout
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221215182412.386064-1-they@mint.lgbt>
 <20221215182412.386064-4-they@mint.lgbt>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221215182412.386064-4-they@mint.lgbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.12.2022 19:24, Lux Aliaga wrote:
> Adds support for the Xiaomi Mi A3 (xiaomi-laurel-sprout). Here's a
> summary on what's working.
> 
> - dmesg output to bootloader preconfigured display
> - USB
> - UFS
> - SMD RPM regulators
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
You don't seem to have addressed the review comments from
v2 on this patch.

Konrad
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sm6125-xiaomi-laurel-sprout.dts  | 254 ++++++++++++++++++
>  2 files changed, 255 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 3e79496292e7..2b2a0170db14 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -157,6 +157,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> new file mode 100644
> index 000000000000..acdfaa83b152
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Lux Aliaga <they@mint.lgbt>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include "sm6125.dtsi"
> +
> +/ {
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <394 0>; /* sm6125 v0 */
> +	qcom,board-id = <11 0>;
> +
> +	model = "Xiaomi Mi A3";
> +	compatible = "xiaomi,laurel-sprout", "qcom,sm6125";
> +	chassis-type = "handset";
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer@5c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x5c000000 0 (1560 * 720 * 4)>;
> +			width = <720>;
> +			height = <1560>;
> +			stride = <(720 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +
> +	extcon_usb: usb-id {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		debug_mem: memory@ffb00000 {
> +			reg = <0x0 0xffb00000 0x0 0xc0000>;
> +			no-map;
> +		};
> +
> +		last_log_mem: memory@ffbc0000 {
> +			reg = <0x0 0xffbc0000 0x0 0x80000>;
> +			no-map;
> +		};
> +
> +		pstore_mem: ramoops@ffc00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xffc40000 0x0 0xc0000>;
> +			record-size = <0x1000>;
> +			console-size = <0x40000>;
> +			msg-size = <0x20000 0x20000>;
> +		};
> +
> +		cmdline_mem: memory@ffd00000 {
> +			reg = <0x0 0xffd40000 0x0 0x1000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +
> +&hsusb_phy1 {
> +	status = "okay";
> +};
> +
> +&rpm_requests {
> +	regulators-0 {
> +		compatible = "qcom,rpm-pm6125-regulators";
> +
> +		vreg_s6a: s6 {
> +			regulator-min-microvolt = <936000>;
> +			regulator-max-microvolt = <1422000>;
> +		};
> +
> +		vreg_l1a: l1 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1256000>;
> +		};
> +
> +		vreg_l2a: l2 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1056000>;
> +		};
> +
> +		vreg_l3a: l3 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1064000>;
> +		};
> +
> +		vreg_l4a: l4 {
> +			regulator-min-microvolt = <872000>;
> +			regulator-max-microvolt = <976000>;
> +		};
> +
> +		vreg_l5a: l5 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <3104000>;
> +		};
> +
> +		vreg_l6a: l6 {
> +			regulator-min-microvolt = <576000>;
> +			regulator-max-microvolt = <656000>;
> +		};
> +
> +		vreg_l7a: l7 {
> +			regulator-min-microvolt = <872000>;
> +			regulator-max-microvolt = <976000>;
> +		};
> +
> +		vreg_l8a: l8 {
> +			regulator-min-microvolt = <400000>;
> +			regulator-max-microvolt = <728000>;
> +		};
> +
> +		vreg_l9a: l9 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1896000>;
> +		};
> +
> +		vreg_l10a: l10 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1896000>;
> +		};
> +
> +		vreg_l11a: l11 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1952000>;
> +		};
> +
> +		vreg_l12a: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1996000>;
> +		};
> +
> +		vreg_l13a: l13 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1832000>;
> +		};
> +
> +		vreg_l14a: l14 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		vreg_l15a: l15 {
> +			regulator-min-microvolt = <3104000>;
> +			regulator-max-microvolt = <3232000>;
> +		};
> +
> +		vreg_l16a: l16 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		vreg_l17a: l17 {
> +			regulator-min-microvolt = <1248000>;
> +			regulator-max-microvolt = <1304000>;
> +		};
> +
> +		vreg_l18a: l18 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1264000>;
> +		};
> +
> +		vreg_l19a: l19 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <2952000>;
> +		};
> +
> +		vreg_l20a: l20 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <2952000>;
> +		};
> +
> +		vreg_l21a: l21 {
> +			regulator-min-microvolt = <2600000>;
> +			regulator-max-microvolt = <2856000>;
> +		};
> +
> +		vreg_l22a: l22 {
> +			regulator-min-microvolt = <2944000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +
> +		vreg_l23a: l23 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3400000>;
> +		};
> +
> +		vreg_l24a: l24 {
> +			regulator-min-microvolt = <2944000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +	};
> +};
> +
> +&sdc2_off_state {
> +	sd-cd-pins {
> +		pins = "gpio98";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> +
> +&sdc2_on_state {
> +	sd-cd-pins {
> +		pins = "gpio98";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <22 2>, <28 6>;
> +};
> +
> +&ufs_mem_hc {
> +	vcc-supply = <&vreg_l24a>;
> +	vccq2-supply = <&vreg_l11a>;
> +	vcc-max-microamp = <600000>;
> +	vccq2-max-microamp = <600000>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l4a>;
> +	vdda-pll-supply = <&vreg_l10a>;
> +	vdda-phy-max-microamp = <51400>;
> +	vdda-pll-max-microamp = <14200>;
> +	vddp-ref-clk-supply = <&vreg_l18a>;
> +
> +	status = "okay";
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> +
> +&usb3_dwc3 {
> +	extcon = <&extcon_usb>;
> +};
