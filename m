Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868A26F8851
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjEESAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjEER7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:59:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDAB3588
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:59:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so29458195a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683309586; x=1685901586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rey0KwBHM7411diwiWKCmyMvBOFP1gJrFypl112tTpk=;
        b=FIWg5//zkmQBoHwXGNqCTnDVWd1gtbUfxOhUrcgaPtk+qmt14BgBQFyKSrZ/5ymBeR
         RsUN1ZKzdkXoEogPG1w/QMfr6ONZDAhX3uJnIz1sweZmmPFctJ5Ag9T41uM9eK6ZHZ/I
         D5bza/THw4Cbb9obL5BmJ+zf/3sLWsB43QWya3eLDxV2zXY1dGmOk6V3FFVMqU+YMiHV
         HtuMV3JZAJlLPHp8ogDSBDZVYRvrwysgUozGtaq9/cbJAnWNCmXsruOHZl+rtTvKmbvc
         SoH+gHp1hRKk/lTwN/Gbq9tVZrnMHVdssuplZ7ZqEkfg7aUlhqk3/mDh6Jdo3VTK4I4l
         9xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683309586; x=1685901586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rey0KwBHM7411diwiWKCmyMvBOFP1gJrFypl112tTpk=;
        b=jl39Hs0LO+wX6hyfn6D5JeUnCLo8RaTV6inlPlWOJV238fDUe/sOHqT1yiUarzu0LZ
         YAnusVQpOQWQo/RD31WEF4C5HqYdpeuNEg76mcC1+/pJzP6J0+VQz3jT+khCu0zaf5QV
         pcTF5rmDqTXqoAemXYW4y7Fe37KJ33mOqqIZi+LQzGAEiCTiOueXH8y9fVy0lkOH8h14
         U5HLTxmi3H6YJeGi6Y/Ku+BWSHv4uKwTmiCzkz7WUgj+e04Cjz0OjXvgZCILsL9dgKbx
         L4wZsJ6jaulwUyCx55ZeXnL06ttNwWg9MpYvmfjJxD5uiV5KVIpUdnzS+bVRlD8i6TNl
         0vQg==
X-Gm-Message-State: AC+VfDzdcmxa5uwzssiIA41bqB3B8V3+8K3ilg0tMlGSqkatixnzlqgr
        zR6E4ArtlbtNYdKrGD/rAVYcWUjxu3nMsrPrNsKu0g==
X-Google-Smtp-Source: ACHHUZ5QsPEulEy0kj2+EyVMU3Y5hH5nToROx8vdNuK76JsBo6gj5bsviqNIgrxk+C2GcjyIWyz78Q==
X-Received: by 2002:a17:907:9728:b0:960:ddba:e5bf with SMTP id jg40-20020a170907972800b00960ddbae5bfmr2567704ejc.0.1683309586112;
        Fri, 05 May 2023 10:59:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id ss13-20020a170907038d00b009659fed3612sm1211351ejb.24.2023.05.05.10.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 10:59:45 -0700 (PDT)
Message-ID: <bee3bfbc-a8fe-ec91-e9ce-287347da5aac@linaro.org>
Date:   Fri, 5 May 2023 19:59:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS
Content-Language: en-US
To:     Dang Huynh <danct12@riseup.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230505-fxtec-pro1x-support-v2-0-0ea2378ba9ae@riseup.net>
 <20230505-fxtec-pro1x-support-v2-1-0ea2378ba9ae@riseup.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505-fxtec-pro1x-support-v2-1-0ea2378ba9ae@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 19:12, Dang Huynh wrote:
> The F(x)tec Pro1X is a mobile phone released by FX Technologies Ltd
> in 2022.
> 
> The phone is exactly the same as the Pro1 released in 2019 with some
> changes:
> - MSM8998 -> SM6115
> - Camera button is no longer multistate
> - Only one 48MP back camera
> - A new keyboard layout picked by the community.
> 
> This commit has the following features working:
> - Display (using simplefb)
> - UFS
> - Power and volume buttons
> - Pinctrl
> - RPM Regulators
> - USB (Device Mode)
> 
> To get a successful boot run:
> 
> cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/\
> sm6115-fxtec-pro1x.dtb  > .Image.gz-dtb
> 
> mkbootimg --kernel .Image.gz-dtb \
> --ramdisk initrd.img \
> --base 0x0 \
> --kernel_offset 0x8000 \
> --ramdisk_offset 0x1000000 \
> --second_offset 0xf00000 \
> --tags_offset 0x100 \
> --pagesize 4096 \
> --cmdline "CMDLINE HERE" \
> -o qx1050-boot.img
> 
> fastboot flash boot qx1050-boot.img
> fastboot erase dtbo
> fastboot reboot
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  arch/arm64/boot/dts/qcom/Makefile               |   1 +
>  arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 248 ++++++++++++++++++++++++
>  2 files changed, 249 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d42c59572ace..e311ba675f35 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -174,6 +174,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> new file mode 100644
> index 000000000000..a9ff1d9534ae
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
> + */
> +
> +/dts-v1/;
> +
> +#include "sm6115.dtsi"
> +#include "pm6125.dtsi"
> +
> +/ {
> +	model = "F(x)tec Pro1X (QX1050)";
> +	compatible = "fxtec,pro1x", "qcom,sm6115";
> +	chassis-type = "handset";
> +
> +	qcom,msm-id = <417 0x10000>, <444 0x10000>;
> +	qcom,board-id = <34 0>;
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer@5c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x5c000000 0 (1080 * 2160 * 4)>;
> +			width = <1080>;
> +			height = <2160>;
> +			stride = <(1080 * 4)>;
> +			format = "a8r8g8b8";
> +			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_n>;
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm6125_gpios 5 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
> +		};
> +	};
> +};
> +
> +&dispcc {
> +	/* HACK: disable until a panel driver is ready to retain simplefb */
> +	status = "disabled";
> +};
> +
> +&pm6125_gpios {
> +	vol_up_n: vol-up-n-state {
> +		pins = "gpio5";
> +		function = "normal";
> +		power-source = <0>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
> +&rpm_requests {
> +	pm6125-regulators {

No improvements.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

