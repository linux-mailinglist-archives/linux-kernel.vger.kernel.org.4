Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494E07161A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjE3NYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjE3NY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:24:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CE2C9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:24:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-974265a1a40so107867366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685453058; x=1688045058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f13+//j5TUSK7f17I23pgVcVd7PAgs1drwm4AW53RHM=;
        b=zC14MYkKGvdGUnL0dteMGGW+ZVB+LtSJnuFAGxZ/yRtnxaHKhM2+owjsNOlMVqR2zz
         QCOcAeSXtqxWdqUcu7BgM3t1mkvqUHoCIETz/izhIQ2clL/1yrr6/eyi5eujcIjQSDg5
         4tFrkX5xraNaG4SScrEQ1WIAO7Kh8kjw+ZqfOouXU7sSFWciqn2J2Bby10nGMuy5/bp+
         pA9XuUc7Ohz7HKYlwJcwl27Y4yA5dz3pstZ1iQB760AJnYos3PDZi+X57zapbUEl5vcX
         baySGpbCaL4zCDgIGimm8Zl1I0XQPTCng8O/2rpHAfejd3kOnP6x1vI95UeaYIm0F50x
         eeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685453058; x=1688045058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f13+//j5TUSK7f17I23pgVcVd7PAgs1drwm4AW53RHM=;
        b=VcPakGqKVEkqEq973vbzzS4xSqg5cbqsOrCrX0sq9gmshect3ktApiqXdjYJPSUAFJ
         VVghy8qEvSccgLU5FYTBaAvwXTFAfsk4B5cRcqO3q6hmuCNcsKqa63RR3QbLcxVJ+K6v
         ZYy/lBXjIfuETaBQ210/UNrHPbG+i5LA2O7vNigjJh6c3z238Vub+PzVje14H0btCxVO
         VcawUatubZOMfE7GIlYFTTd8pb5gYjeYUE3QhuF/g2ko3fGnTqKWnGBnAwnTDcTN2L7l
         haBg/HTAzBEgCzXklS+jdw2j+ObRYug92CKq6u5WNpV9HG78zAeaOfB6aJ6l6mx+TwZf
         OBMQ==
X-Gm-Message-State: AC+VfDyPCgvc/oClBB1aduumUmwe8DYirwXksQnViBRUIrWlrTc6qIoD
        +7Ej2ElQsn8B73bDts3njVvmtg==
X-Google-Smtp-Source: ACHHUZ45MHzQv6JgtBdSZV3zezwsX8mKYWid5QGh2Tm9MTh1hRIo/ZlaX97ft0SeEvZoCw6qfiVN2A==
X-Received: by 2002:a17:906:9753:b0:965:d7c7:24db with SMTP id o19-20020a170906975300b00965d7c724dbmr2131710ejy.32.1685453058029;
        Tue, 30 May 2023 06:24:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id me21-20020a170906aed500b0096a16e49b0fsm7305207ejb.51.2023.05.30.06.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:24:17 -0700 (PDT)
Message-ID: <3f2eefcc-fb0b-d374-995d-3c0b7e4b4507@linaro.org>
Date:   Tue, 30 May 2023 15:24:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] ARM: dts: qcom: Add Samsung Galaxy Express support
Content-Language: en-US
To:     Rudraksha Gupta <guptarud@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230527040905.stmnoshkdqgiaex6@ripper>
 <20230528001010.47868-5-guptarud@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230528001010.47868-5-guptarud@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your patch. There is something to discuss/improve.



On 28/05/2023 02:10, Rudraksha Gupta wrote:
> This adds a very basic device tree file for the Samsung Galaxy Express

Please do not use "This commit/patch", but imperative mood. See longer
explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95


> SGH-I437. Currently, the following things work: UART, eMMC, SD Card, and
> USB.
> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/qcom-msm8960-samsung-expressatt.dts   | 334 ++++++++++++++++++
>  2 files changed, 335 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 59829fc90315..12c90f263142 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1081,6 +1081,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-msm8916-samsung-grandmax.dtb \
>  	qcom-msm8916-samsung-serranove.dtb \
>  	qcom-msm8960-cdp.dtb \
> +	qcom-msm8960-samsung-expressatt.dtb \
>  	qcom-msm8974-lge-nexus5-hammerhead.dtb \
>  	qcom-msm8974-sony-xperia-rhine-amami.dtb \
>  	qcom-msm8974-sony-xperia-rhine-honami.dtb \
> diff --git a/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
> new file mode 100644
> index 000000000000..a1ee9c272558
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/input/input.h>
> +
> +#include "qcom-msm8960.dtsi"
> +#include <dt-bindings/reset/qcom,gcc-msm8960.h>
> +
> +/ {
> +	model = "Samsung Galaxy Express SGH-I437";
> +	compatible = "samsung,expressatt", "qcom,msm8960";
> +	chassis-type = "handset";
> +
> +	aliases {
> +		serial0 = &gsbi5_serial;
> +		mmc0 = &sdcc1; /* SDCC1 eMMC slot */
> +		mmc1 = &sdcc3; /* SDCC3 SD card slot */
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&gsbi5 {
> +	qcom,mode = <GSBI_PROT_I2C_UART>;
> +	status = "okay";
> +};
> +
> +&gsbi5_serial {
> +	status = "okay";
> +};
> +
> +&sdcc1 {
> +	vmmc-supply = <&pm8921_l5>;
> +	status = "okay";
> +};
> +
> +&sdcc3 {
> +	vmmc-supply = <&pm8921_l6>;
> +	vqmmc-supply = <&pm8921_l7>;
> +	status = "okay";
> +};
> +
> +&gsbi1 {
> +	qcom,mode = <GSBI_PROT_SPI>;
> +	pinctrl-0 = <&spi1_default>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&gsbi1_spi {
> +	status = "okay";
> +};
> +
> +&msmgpio {
> +	spi1_default: spi1_default {

No underscores in node names, missing proper suffix.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +		mux {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +			pins = "gpio6", "gpio7", "gpio9";
> +			function = "gsbi1";
> +		};
> +
> +		mosi {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +			pins = "gpio6";
> +			drive-strength = <12>;
> +			bias-disable;
> +		};
> +
> +		miso {
> +			pins = "gpio7";
> +			drive-strength = <12>;
> +			bias-disable;
> +		};
> +
> +		cs {
> +			pins = "gpio8";
> +			drive-strength = <12>;
> +			bias-disable;
> +			output-low;
> +		};
> +
> +		clk {
> +			pins = "gpio9";
> +			drive-strength = <12>;
> +			bias-disable;
> +		};
> +	};
> +};
> +
> +

One blank line, not two.

...

> +&usb1 {
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +

No improvements here.

Best regards,
Krzysztof

