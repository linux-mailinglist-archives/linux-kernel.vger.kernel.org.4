Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09736C5FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCWGog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCWGoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:44:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398212DE59
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 23:44:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eg48so82156055edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 23:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679553847;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nM/3ywyvpAsiOiRY1HG3AOIo3FGoRoVm1IbIAeulEYo=;
        b=xmy41Dff79qydbj9wKemr6aBQC0XKLClWYZ1/+XIZiVohdMkGZJ3QKWXtj7Oas6pAn
         ldPX8vzbA8iht3C0HmibE5watwyMozHf0LmEN4iP2kI/b+Qtq05XzUA0kTEP17vPOmy9
         5tVHC1kyAfrLGtjIWpY4P8gRjvj3HErA819f1QHu+QOcszwMScwZl5EPe+2pUx/a1Okk
         mjedExTz7dM5edumDgRMTPZheLYzy//eor94c+ffp3c7KbJmJp23O2RowN7igR4mlAaO
         ypmEGPtxEKgG2/TK15pKhCTwzMLKBPdimmQGskMRgXeZzSuLVD2YK6jCd8L4ZKRBS9E1
         X1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679553847;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nM/3ywyvpAsiOiRY1HG3AOIo3FGoRoVm1IbIAeulEYo=;
        b=lX9QIQiyTyYcMeDSVXmpO/9IT4PXFSr7uW6CvEuDHZ7Zg88/T1xj1vF4cDLrt7PSiz
         wk1RDhHuA7iXilGLr5IUhug1DWAAiiXv2VP2QdXERogTSqNTQIekj0QDOlbG6YJojGyp
         v1F8OcE4PMK7JWEYW56xTATOwRCBa5Xo4kieA+Qwufp96YzPkWzvbm00AlNUyYKG8zEl
         PqATxsT0/I7PC8RtfVzdzYQRgrehIXtmLPt2TfKPrLpwB4xi2OWgXrzkx2MK4GlYxxpl
         74ivDmPTexWynIURiBO7RjMc0bFmZi/sUfmQ3/2NCuQYJaCviFtJ1TBKqvjJukoU7aRC
         76kA==
X-Gm-Message-State: AO0yUKXeLjYQ42L5c73xYTn+17pIe3nGEn2duFwxoIDsuiWrMaPyD3d2
        1JZce67eVo2z4Y6CWwz9w3rYSA==
X-Google-Smtp-Source: AK7set99aCxB2NNu170LpJUYY1O9/A3/pVich1AlGKdGJ2lRlsdCiHActK9XKOraSg3Fw0G08QsM2g==
X-Received: by 2002:a17:907:382:b0:921:412b:d8c1 with SMTP id ss2-20020a170907038200b00921412bd8c1mr9233255ejb.71.1679553847515;
        Wed, 22 Mar 2023 23:44:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id ch19-20020a170906c2d300b00933d64cd447sm5552271ejb.121.2023.03.22.23.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 23:44:07 -0700 (PDT)
Message-ID: <b50470b0-4062-5d2c-2eaf-29cef34fd2d4@linaro.org>
Date:   Thu, 23 Mar 2023 07:44:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5332: add support for the RDP468
 variant
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230323044929.8694-1-quic_kathirav@quicinc.com>
 <20230323044929.8694-3-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323044929.8694-3-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 05:49, Kathiravan T wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 468 based on IPQ5332 family of SoCs. This patch carries the
> support for Console UART, SPI NOR, eMMC.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>  arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 103 ++++++++++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 1a29403400b7..79cf8373997f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> new file mode 100644
> index 000000000000..b2899f953aa4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * IPQ5332 RDP468 board device tree source
> + *
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq5332.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.6";
> +	compatible = "qcom,ipq5332-ap-mi01.6", "qcom,ipq5332";
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
> +&blsp1_spi0 {
> +	pinctrl-0 = <&spi_0_data_clk_pins &spi_0_cs_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "micron,n25q128a11", "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0>;

reg is always second property, after compatible.

> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +


Best regards,
Krzysztof

