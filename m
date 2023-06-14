Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC1572FB73
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbjFNKn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241042AbjFNKn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:43:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0553A1732
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:43:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f74cda5f1dso3878943e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686739402; x=1689331402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KX2oz9dWGFqldPJQ9r6bqvH9GcXtanP/Kfl3ifq5YG8=;
        b=cYtqR9G5ulap7us1Es5qk1ont+OmpqIg9m/dsoDBp60uAP11Wo+qjENQ84msMCIYtp
         op1QqlAhqMBniLy9Zbl1kcVc2FfQ+l73brMv1KT10oDjh3aKdyn25ywkvA0dgvesa91J
         D3pTuePr77Xksof7ke6AGs9cRbZHZ/4f4Py/GyJI964zHQaWUrl4ra/Di+6LWAvUx6aD
         F/aRJzedJXoXt/DixJlzO6pBeRSBStXK7Iw/c7puVYzeWlqOHRQtUTNCbjpJtCrIy3KX
         MxOzhtY8FRggDQhEceNPOhmxWgUJk7e6M5pCfWJIaixg9Vk6yDrLAvnklI4Iw+OnfXDe
         yehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686739402; x=1689331402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KX2oz9dWGFqldPJQ9r6bqvH9GcXtanP/Kfl3ifq5YG8=;
        b=A6OT7Z+LPvtWsZksGv1SjsCfXRpa+e1MV5UA9foLhBMmjd8EwMiJTaky2UdKRr6Axg
         n/oHtJYF0TVYUoiFOFmfrKEsB9xcKA4JFOfhwcdk3Ursp0fG+LPgT6mk146hd+0yFBME
         u7YS904SEdE8H/pxzH10XENLmpUWgJ30Zy5swx8hKMI0lMvQPUmUQr2Q9ZUhWOntH67H
         BjKG2PAx2VNarscYfnYeMN2olksTYlWahLyelBsLEKlRNHYEXQ4l5NDQed45brO4MNzX
         TTl2K+ZOrt+a/iOVIW9P+MnWAp8Lcj8aQP8WPdSQSi8FKV0kO0WNfP1dzRTnsoKlycFz
         Zppw==
X-Gm-Message-State: AC+VfDyqoQNoSEjOoIILzFRHXzgga1J6xpQVv4CsZup76y0q4XZFpXYf
        qgT7CTxEPcWSVaE5xvoTxslQrQ==
X-Google-Smtp-Source: ACHHUZ5yJC3sg+ZaaQdHsIPExVPQQIkgNP1xklN6445l4fln1K7bgxDzG2Cw7aMw1Bgo434T5e9/mw==
X-Received: by 2002:a19:d602:0:b0:4ed:d4ac:1e17 with SMTP id n2-20020a19d602000000b004edd4ac1e17mr7288562lfg.49.1686739402251;
        Wed, 14 Jun 2023 03:43:22 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id 7-20020ac24847000000b004f001b0eda2sm2063026lfy.56.2023.06.14.03.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 03:43:21 -0700 (PDT)
Message-ID: <0848ee8e-f520-06a1-9a15-f6dadc2fd69e@linaro.org>
Date:   Wed, 14 Jun 2023 12:43:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5332: add support for the RDP446
 variant
Content-Language: en-US
To:     Hariharan K <quic_harihk@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com
References: <20230606095732.12884-1-quic_harihk@quicinc.com>
 <20230606095732.12884-3-quic_harihk@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230606095732.12884-3-quic_harihk@quicinc.com>
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



On 6.06.2023 11:57, Hariharan K wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 446 based on IPQ5332 family of SoC. This patch carries
> the support for Console UART, SPI NOR and I2C.
> 
> Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
> ---
Please consider making a common dtsi, like for 9574 here:

https://lore.kernel.org/linux-arm-msm/20230614085040.22071-1-quic_anusha@quicinc.com

Konrad
>  arch/arm64/boot/dts/qcom/Makefile           |  1 +
>  arch/arm64/boot/dts/qcom/ipq5332-rdp446.dts | 83 +++++++++++++++++++++
>  2 files changed, 84 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp446.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 4f9e81253e18..f962e1b7cf7a 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp442.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp446.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp446.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp446.dts
> new file mode 100644
> index 000000000000..0e1d98b093e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp446.dts
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * IPQ5332 AP-MI04.1 board device tree source
> + *
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq5332.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ5332 MI04.1";
> +	compatible = "qcom,ipq5332-ap-mi04.1", "qcom,ipq5332";
> +
> +	aliases {
> +		serial0 = &blsp1_uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +};
> +
> +&blsp1_uart0 {
> +	pinctrl-0 = <&serial_0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&blsp1_i2c1 {
> +	clock-frequency  = <400000>;
> +	pinctrl-0 = <&i2c_1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&blsp1_spi0 {
> +	pinctrl-0 = <&spi_0_data_clk_pins &spi_0_cs_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "micron,n25q128a11", "jedec,spi-nor";
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32000>;
> +};
> +
> +&xo_board {
> +	clock-frequency = <24000000>;
> +};
> +
> +/* PINCTRL */
> +
> +&tlmm {
> +	i2c_1_pins: i2c-1-state {
> +		pins = "gpio29", "gpio30";
> +		function = "blsp1_i2c0";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	spi_0_data_clk_pins: spi-0-data-clk-state {
> +		pins = "gpio14", "gpio15", "gpio16";
> +		function = "blsp0_spi";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	spi_0_cs_pins: spi-0-cs-state {
> +		pins = "gpio17";
> +		function = "blsp0_spi";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +};
