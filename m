Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7546CBA14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjC1JG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1JGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:06:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1055659F8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:06:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c9so4440922lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679994366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ogVdg59OvtEGhTTAtCeTATzo7VTOuITJJjSGfK73PZE=;
        b=dAjWmLzjsnSJ8Zcysv9m6l46+Iqp6eV1esydN03bb/xRSs0HpowY3EyZdoPc4ZA2fk
         uTjCye7LO+vS8JrAczzEGXl3u4PngMayUMyVVCtRZ3HuOGVAZbyyfUwbOQTTyMieMJ01
         qHe3EgCQgCL/R7MeC5NYr8VUHs6HTyiFWAxMLztr5VG1bU5U4pf58sy1DmAv4N5868Nx
         /hTyuBECzYqGriUJIMzel9o6YuxoUxKJhX4jouatLEbtlYHCUthT5VsSIrgyRths6GP8
         eOlIxGOwUzRMbwvkjzFuhiw7E72U5acuZR98l3JaYNfJVT+Z3O0GDHvZ3p8xppsuqrP/
         ivCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679994366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogVdg59OvtEGhTTAtCeTATzo7VTOuITJJjSGfK73PZE=;
        b=an7m7ptWgC58Mjfcp++/padq+HJyGPFvqmP6sle0wIgg132HXOht5Hr/8S5H2UtP7g
         Gsyv1ZU2k6OB1kL7ZLBQm8qCiwG6OQ3GaPRKLVkaxGOuKm12ervLUPNliTkag8/2mowe
         UZnAeZvEaLIjKxHCGma4kCCgymdbJAU8m9M/ZglslweCOuVElqqzy//nwj2v+Etpcwn+
         eEMc4r8jJyhT61x/orm57m8x5M4Y0Sn8qBKRjtfHfsqZv/Bw8gzDJkx40p7Bf2wK8EQk
         IL9X8veeL2c+30XdPm/bI54e96kELyuJbzKRtvMU+F7PgnytDxmViFfdNbK9BHNFDJBB
         oe5Q==
X-Gm-Message-State: AAQBX9cWkgleiKffQUKWweyjLWNsVRCX/XjWPGMJD79LJeKFKNt2miQm
        MRHGR3CCtD3HSKq2Pe3qlDjedQ==
X-Google-Smtp-Source: AKy350aLWBsBDlf4pkqsGQd4V0rQEatYU3yJjtu5Pp8yX7hyd+wvFIIFc9mM7PQ6h+3SfqTq42S0wA==
X-Received: by 2002:ac2:596b:0:b0:4d5:d0f9:e57 with SMTP id h11-20020ac2596b000000b004d5d0f90e57mr4249037lfp.21.1679994366456;
        Tue, 28 Mar 2023 02:06:06 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id y11-20020a2e9d4b000000b00295a5aa9d05sm4929716ljj.120.2023.03.28.02.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 02:06:06 -0700 (PDT)
Message-ID: <75243bf3-180d-ded3-22e6-018eb347a54d@linaro.org>
Date:   Tue, 28 Mar 2023 11:06:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 14/18] arm64: dts: qcom: sa8775p: add PMIC GPIO
 controller nodes
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230327125316.210812-1-brgl@bgdev.pl>
 <20230327125316.210812-15-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230327125316.210812-15-brgl@bgdev.pl>
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



On 27.03.2023 14:53, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add GPIO controller nodes to PMICs that have the GPIO hooked up on
> sa8775p-ride.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 40 +++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> index be12997a080c..7602cca47bae 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> @@ -125,6 +125,16 @@ pmm8654au_0_pon_resin: resin {
>  				status = "disabled";
>  			};
>  		};
> +
> +		pmm8654au_0_gpios: gpio@8800 {
> +			compatible = "qcom,pmm8654au-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmm8654au_0_gpios 0 0 12>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
>  	};
>  
>  	pmm8654au_1: pmic@2 {
> @@ -139,6 +149,16 @@ pmm8654au_1_temp_alarm: temp-alarm@a00 {
>  			interrupts-extended = <&spmi_bus 0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
>  			#thermal-sensor-cells = <0>;
>  		};
> +
> +		pmm8654au_1_gpios: gpio@8800 {
> +			compatible = "qcom,pmm8654au-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmm8654au_2_gpios 0 0 12>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
>  	};
>  
>  	pmm8654au_2: pmic@4 {
> @@ -153,6 +173,16 @@ pmm8654au_2_temp_alarm: temp-alarm@a00 {
>  			interrupts-extended = <&spmi_bus 0x4 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
>  			#thermal-sensor-cells = <0>;
>  		};
> +
> +		pmm8654au_2_gpios: gpio@8800 {
> +			compatible = "qcom,pmm8654au-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmm8654au_2_gpios 0 0 12>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
>  	};
>  
>  	pmm8654au_3: pmic@6 {
> @@ -167,5 +197,15 @@ pmm8654au_3_temp_alarm: temp-alarm@a00 {
>  			interrupts-extended = <&spmi_bus 0x6 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
>  			#thermal-sensor-cells = <0>;
>  		};
> +
> +		pmm8654au_3_gpios: gpio@8800 {
> +			compatible = "qcom,pmm8654au-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmm8654au_3_gpios 0 0 12>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
>  	};
>  };
