Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69A2616D43
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiKBS6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiKBS62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:58:28 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EEDB88
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:58:26 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s4so1589900qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CK1nwLnaZfHLJC35TKOIbk7yfY5XumzUCBbd0vJ1QN4=;
        b=EH1L/IUrvbshBo8J3IbF7F0vTI8Jn/KB/STRlZRzlruxqIl0b2iGjxV2iXqU33YSnE
         ed8chL8bCHNPK6Xu4jF3QOh8+yqWs2kc+ecLsT4ajSsIoCko4xnRa69kJZ5ZrMWTLMpU
         8AdnQz/+3o4w4wKxFJqGcxqFsHcSf2p85iK2w7m78bxauR59xr2Y88ZaLtvPDdgpa/Os
         a1HhPPUUfEllgwc/VvcCV6faBaoki1+PvtQggJMwH8m4sZuNZh84PkO2z9Hm5Liavuuh
         V0E4XZdgRecOdILKJGORaw6cjW/SZG16rXV0aHI5uuFw1ljsfQGW2TcV1MOh6X1o205X
         ywBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CK1nwLnaZfHLJC35TKOIbk7yfY5XumzUCBbd0vJ1QN4=;
        b=v0OmUGIWcLna9IoYL5e2V3m209rgl/jlm5wg5KOQyWA4xmnEJdUdzNznuWZT533b3n
         TXPfxoDGd0mUT2JDO6YPY1GccqMX4XWg9bCYXTTG5yuJ26SSkqIYwH6iX3giNLjqxXSF
         h9tRGwqXid3bWQp2RXp4bZlEzHKFBzPvLiDn1ek6fUfd4CSNo33p/WEeeR7sD3j0Q7Vb
         1AIy37QUUWVq74S1pOsuV7MUZzi5nOZDKGpOre5kjySCuskdAm4AIbBv5JB5KTQDINfo
         11JYIenl3wxDB4kHIu740ZTkWimPmM5qjuKsUliIkcGITYI0OOvgRs1+/vTPRdC7yUeh
         Ra9Q==
X-Gm-Message-State: ACrzQf14jgRFQFb668cBCm+19DC3G9Y8k0jSzhUgO5uz3QMXkhU6sKmP
        fht4iU61U+Hq/N/wJnD+fAFjoA==
X-Google-Smtp-Source: AMsMyM7WIeBh/hplLzngz68KOHNf6goPHvlFSHbZjweK97vyH4utErQd2S8a5oybzrckNagryezZ5Q==
X-Received: by 2002:a05:622a:1052:b0:39c:da70:3204 with SMTP id f18-20020a05622a105200b0039cda703204mr20911411qte.689.1667415505871;
        Wed, 02 Nov 2022 11:58:25 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id e1-20020ac84b41000000b00398ed306034sm6956027qts.81.2022.11.02.11.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 11:58:25 -0700 (PDT)
Message-ID: <40be8adc-663b-1e44-a095-7da5cbd9d51a@linaro.org>
Date:   Wed, 2 Nov 2022 14:58:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: add SA8540P ride(Qdrive-3)
Content-Language: en-US
To:     Parikshit Pareek <quic_ppareek@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>,
        Johan Hovold <johan@kernel.org>
References: <20221102103552.29388-1-quic_ppareek@quicinc.com>
 <20221102103552.29388-3-quic_ppareek@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102103552.29388-3-quic_ppareek@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 06:35, Parikshit Pareek wrote:
> Introduce the Qualcomm SA8540P ride automotive platform, also known as
> Qdrive-3 development board.
> 
> This initial contribution supports SMP, CPUFreq, cluster idle, UFS, RPMh
> regulators, debug UART, PMICs, remoteprocs and USB.
> 
> The SA8540P ride contains four PM8450 PMICs. A separate DTSI file has
> been created for PMIC, so that it can be used for future SA8540P based
> boards.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Tested-by: Brian Masney <bmasney@redhat.com>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile         |   1 +
>  arch/arm64/boot/dts/qcom/pm8450a.dtsi     |  77 ++++++++
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 227 ++++++++++++++++++++++
>  3 files changed, 305 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8450a.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b0558d3389e5..c89d44756791 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
> diff --git a/arch/arm64/boot/dts/qcom/pm8450a.dtsi b/arch/arm64/boot/dts/qcom/pm8450a.dtsi
> new file mode 100644
> index 000000000000..34fc72896761
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8450a.dtsi
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +	pm8450a: pmic@0 {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8450a_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			gpio-ranges = <&pm8450a_gpios 0 0 10>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pm8450c: pmic@4 {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> +		reg = <0x4 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8450c_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			gpio-ranges = <&pm8450c_gpios 0 0 10>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pm8450e: pmic@8 {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> +		reg = <0x8 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8450e_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			gpio-ranges = <&pm8450e_gpios 0 0 10>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pm8450g: pmic@c {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> +		reg = <0xc SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8450g_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			gpio-ranges = <&pm8450g_gpios 0 0 10>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> new file mode 100644
> index 000000000000..b480b4927549
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "sa8540p.dtsi"
> +#include "pm8450a.dtsi"
> +
> +/ {
> +	model = "Qualcomm SA8540P Ride";
> +	compatible = "qcom,sa8540p-ride", "qcom,sa8540p";
> +
> +	aliases {
> +		serial0 = &qup2_uart17;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&apps_rsc {
> +	pmm8540-a-regulators {

I expect schema to be changed like that:
https://lore.kernel.org/linux-devicetree/ad1d4135-031e-9393-07af-7b81c9ecffb5@linaro.org/

thus I am not sure if it is worth adding something which is going to be
changed soon...


Best regards,
Krzysztof

