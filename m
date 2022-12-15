Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE5364DB9A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLOMtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLOMtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:49:08 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C7E6273
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:49:04 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j4so15553349lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WfT89eaBmCMQmtonczLRbdlvyXOUyfcZDQHrYJPUDhM=;
        b=g90Ijv3dZYlnt3LOm41pP9z4hSebp/XoDdDjDZdOf4memohHmJfBcUX1DsjlqNy5vv
         tFTX2A12tIf8cM9lStAHhX5o8hBt7g8oxNgvv87s+suuf/vGT9ejpryMVoL1gp4fzABM
         /GypcQqBjasHMV8sNDKsoEUI83UF3P8SoXQdVAykxmPImqvl/zp8t74KkOv0DF81r2Wy
         Y2i8XOZS7l9Ed3Q5j+dweS9vCrFh0m38NWtj8QlIMrnUKj9HPwqSaySWqMiDRbGWlLsG
         cD4ujeft9aXGmOHaZk35sq+/3ghqVsJ72seEvl5vTefi7qyxStD42axI98yvjRBCOnJb
         j8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfT89eaBmCMQmtonczLRbdlvyXOUyfcZDQHrYJPUDhM=;
        b=vxJzTzjffP+rvKRCkzubl2ajWlaoDjd++sd7VQPfGLYC5gbx5r1wL0yWhR8BSxUhXx
         liDO84uO8bHSzpJGOjuSzV9nyRdzMiymin86NHDC7iZ2nfSso6P29KvY378b+6lkcIvs
         +yOMyffycs2IQ4B+EKTjaTav6ODQLRp8g4LiiQRTD+q4mHittcDmpvrs0/Lf3GFHmwOg
         W/wWmRl3hCfNJuQnC0U6lYxvEqZscOi2Hkr6FBC9GOrEHR3UvGxNfyg7Q5L2TAwE6xsU
         l0JBGScpnH9vJdcQ5N2YkFAvthun+A2nSgEDiJnqOKelsUCDisqA+IRM0jWCrbCUk44N
         gDaA==
X-Gm-Message-State: ANoB5plbYZxuavhL9iS6MJN5V8DruUflstuIGiBhHwoGt7Z0l4dqj5mP
        FakZUa8kqfLrtcmFiwhferzpAQ==
X-Google-Smtp-Source: AA0mqf7DD9iJev7KjfRdZ4KseOkEeyzD+eOrjtJuK8oaocNzCIfGOnAARthk22KNRjLcpdoyZk23vA==
X-Received: by 2002:a05:6512:acd:b0:4b6:f0ac:7af8 with SMTP id n13-20020a0565120acd00b004b6f0ac7af8mr5545156lfu.67.1671108543153;
        Thu, 15 Dec 2022 04:49:03 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id g12-20020ac24d8c000000b004b0b2212315sm1154062lfe.121.2022.12.15.04.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 04:49:02 -0800 (PST)
Message-ID: <af9e5b18-5494-6060-d280-efda8f67693c@linaro.org>
Date:   Thu, 15 Dec 2022 13:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/7] arm64: dts: qcom: sc8280xp: rename qup2_uart17 to
 uart17
To:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
References: <20221214171145.2913557-1-bmasney@redhat.com>
 <20221214171145.2913557-2-bmasney@redhat.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221214171145.2913557-2-bmasney@redhat.com>
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



On 14.12.2022 18:11, Brian Masney wrote:
> In preparation for adding the missing SPI and I2C nodes to
> sc8280xp.dtsi, it was decided to rename all of the existing qupX_
> uart, spi, and i2c nodes to drop the qupX_ prefix. Let's go ahead
> and rename qup2_uart17 to uart17. Note that some nodes are moved in the
> file by this patch to preserve the expected sort order in the file.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Link: https://lore.kernel.org/lkml/20221212182314.1902632-1-bmasney@redhat.com/
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> This is a new patch that's introduced in v2.
> 
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts  | 12 ++++++------
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 12 ++++++------
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 14 +++++++-------
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi    |  2 +-
>  4 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index 84cb6f3eeb56..61f2e44e70c1 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -17,7 +17,7 @@ / {
>  	compatible = "qcom,sa8295p-adp", "qcom,sa8540p";
>  
>  	aliases {
> -		serial0 = &qup2_uart17;
> +		serial0 = &uart17;
>  	};
>  
>  	chosen {
> @@ -240,11 +240,6 @@ &qup2 {
>  	status = "okay";
>  };
>  
> -&qup2_uart17 {
> -	compatible = "qcom,geni-debug-uart";
> -	status = "okay";
> -};
> -
>  &remoteproc_adsp {
>  	firmware-name = "qcom/sa8540p/adsp.mbn";
>  	status = "okay";
> @@ -338,6 +333,11 @@ pm8450g_gpios: gpio@c000 {
>  	};
>  };
>  
> +&uart17 {
> +	compatible = "qcom,geni-debug-uart";
> +	status = "okay";
> +};
> +
>  &ufs_mem_hc {
>  	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
>  
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index 21f3ff024910..b6e0db5508c7 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -17,7 +17,7 @@ / {
>  	compatible = "qcom,sa8540p-ride", "qcom,sa8540p";
>  
>  	aliases {
> -		serial0 = &qup2_uart17;
> +		serial0 = &uart17;
>  	};
>  
>  	chosen {
> @@ -192,11 +192,6 @@ &qup2 {
>  	status = "okay";
>  };
>  
> -&qup2_uart17 {
> -	compatible = "qcom,geni-debug-uart";
> -	status = "okay";
> -};
> -
>  &remoteproc_nsp0 {
>  	firmware-name = "qcom/sa8540p/cdsp.mbn";
>  	status = "okay";
> @@ -207,6 +202,11 @@ &remoteproc_nsp1 {
>  	status = "okay";
>  };
>  
> +&uart17 {
> +	compatible = "qcom,geni-debug-uart";
> +	status = "okay";
> +};
> +
>  &ufs_mem_hc {
>  	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 551768f97729..db273face248 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -17,7 +17,7 @@ / {
>  	compatible = "qcom,sc8280xp-crd", "qcom,sc8280xp";
>  
>  	aliases {
> -		serial0 = &qup2_uart17;
> +		serial0 = &uart17;
>  	};
>  
>  	backlight {
> @@ -363,12 +363,6 @@ keyboard@68 {
>  	};
>  };
>  
> -&qup2_uart17 {
> -	compatible = "qcom,geni-debug-uart";
> -
> -	status = "okay";
> -};
> -
>  &remoteproc_adsp {
>  	firmware-name = "qcom/sc8280xp/qcadsp8280.mbn";
>  
> @@ -381,6 +375,12 @@ &remoteproc_nsp0 {
>  	status = "okay";
>  };
>  
> +&uart17 {
> +	compatible = "qcom,geni-debug-uart";
> +
> +	status = "okay";
> +};
> +
>  &ufs_mem_hc {
>  	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 109c9d2b684d..951cb1b6fcc4 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -813,7 +813,7 @@ qup2: geniqup@8c0000 {
>  
>  			status = "disabled";
>  
> -			qup2_uart17: serial@884000 {
> +			uart17: serial@884000 {
>  				compatible = "qcom,geni-uart";
>  				reg = <0 0x00884000 0 0x4000>;
>  				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
