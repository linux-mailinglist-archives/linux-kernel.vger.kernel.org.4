Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8578364F9CB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 16:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLQPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 10:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLQPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 10:19:27 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7EE13F9F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 07:19:25 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id z4so5021209ljq.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 07:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=URaUTK/GfWw7PLgirJVX6WgkpineE0J7wAGdVik915Y=;
        b=MW5VVjCU+WH3Um3nEtLI58RjpJfQ8JBvb8gathoy4tE/9az7VvapuHpQf3foQPClVk
         y9DWIqFG1OBpzvMy9pgg8V7EtsyRupdZSpKxsd6/rzgyT5vBrnTSc6RXfsvBrB5IC2eB
         yERKcdKnl41Y1jdggOzjBg9JU2VTJzaM5K3Z/yLBSaXaziKwauGyL2T5GKn2XvmznE+t
         OIp2hi7t03j6G/YpFRuYePyI2NLIVOOwPT6limVXe4J4fBHYdCYKha0beGHQcrowSc9Z
         9rG1Q5otlN+WIobA6EbwVr8w8aolGx1cLx0/m3I5XJpPOkopViuhe5UY/RkWuR+4AdXk
         tBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URaUTK/GfWw7PLgirJVX6WgkpineE0J7wAGdVik915Y=;
        b=LUYtvT7bOqZiioajzIjj2MmwgUyQHO14jd6rpGGFNuJ4fLYCHviYYudMQ6c0XB8/fj
         9vCh8DAZDRGnCM12gZXVt8liTgM7Tz6/jSlH7mHzX6pVqJYCl2tVt8NqZCNWZchHJezr
         26j7QGSCvFDDJ7HMb3tAcr1p/Ot6KSliNZBoq6fsKa9H2eHGb83b4gr/suRnapK2C/5+
         yMCuF+Q0YLgs1WuzTng1tTNqKi4C9OUYKLLFR9k5RmOTC6elvUSK5+1by2x7EkjbXanl
         zCkGgkg76AHecEKt5Cp6KA88e28fR2aaqiTrfD2Dey9YUzsuW2zG7/QCZAx6x7YetvdP
         KBqQ==
X-Gm-Message-State: AFqh2kp/MzqPe8g6N4g0OSGOkEscR0NDF6/WFQ8y9LVakZyRpwzA0urW
        EtU52J333A7tk7MJhiIqeGQvDw==
X-Google-Smtp-Source: AMrXdXvRJVFIuVZ0ujhkpljSt4/tp9YWUi2aLHBuwhDBCp1KZ2XknKqMjfZd1lG87/EVxTiJVG7u1Q==
X-Received: by 2002:a2e:98c8:0:b0:27a:3e0b:4b64 with SMTP id s8-20020a2e98c8000000b0027a3e0b4b64mr2986425ljj.44.1671290363750;
        Sat, 17 Dec 2022 07:19:23 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id r18-20020a2e8e32000000b0027710117ebdsm381843ljk.121.2022.12.17.07.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 07:19:23 -0800 (PST)
Message-ID: <6d165266-2d0f-ed3d-ad69-0b69ae8262f0@linaro.org>
Date:   Sat, 17 Dec 2022 16:19:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm6125: Add QUPs with SPI and
 I2C Serial Engines
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221216233408.1283581-1-marijn.suijten@somainline.org>
 <20221216233408.1283581-3-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221216233408.1283581-3-marijn.suijten@somainline.org>
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



On 17.12.2022 00:34, Marijn Suijten wrote:
> Add Qualcomm Universal Peripheral nodes with SPI and I2C Serial Engines.
> QUP 0 only has two SPIs at index 0 and 2, QUP 1 has four SPIs with a gap
> in the middle (ranging from 5-9 with SPI 7 missing).  Both QUPs have 5
> I2C Serial Engines.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> [Marijn: Add iommus, reword patch description, reorder all properties,
>  sort based on address, use QCOM_GPI_ constants, drop dma cells from 5
>  to 3]
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Modulo the comment about 0x0/0 in iommus= (let's hear what
others think):

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 298 +++++++++++++++++++++++++++
>  1 file changed, 298 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 5fc304b2da63..36ba74b5ad89 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -753,6 +753,138 @@ gpi_dma0: dma-controller@4a00000 {
>  			status = "disabled";
>  		};
>  
> +		qupv3_id_0: geniqup@4ac0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x04ac0000 0x2000>;
> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +			clock-names = "m-ahb", "s-ahb";
> +			iommus = <&apps_smmu 0x123 0x0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			status = "disabled";
> +
> +			i2c0: i2c@4a80000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a80000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c0_default>;
> +				pinctrl-1 = <&qup_i2c0_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi0: spi@4a80000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04a80000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_spi0_default>;
> +				pinctrl-1 = <&qup_spi0_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
> +				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@4a84000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a84000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c1_default>;
> +				pinctrl-1 = <&qup_i2c1_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c@4a88000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a88000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c2_default>;
> +				pinctrl-1 = <&qup_i2c2_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi2: spi@4a88000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04a88000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_spi2_default>;
> +				pinctrl-1 = <&qup_spi2_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
> +				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c@4a8c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a8c000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c3_default>;
> +				pinctrl-1 = <&qup_i2c3_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c4: i2c@4a90000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04a90000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c4_default>;
> +				pinctrl-1 = <&qup_i2c4_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
> +				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +		};
> +
>  		gpi_dma1: dma-controller@4c00000 {
>  			compatible = "qcom,sm6125-gpi-dma", "qcom,sdm845-gpi-dma";
>  			reg = <0x04c00000 0x60000>;
> @@ -771,6 +903,172 @@ gpi_dma1: dma-controller@4c00000 {
>  			status = "disabled";
>  		};
>  
> +		qupv3_id_1: geniqup@4cc0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x04cc0000 0x2000>;
> +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> +			clock-names = "m-ahb", "s-ahb";
> +			iommus = <&apps_smmu 0x143 0x0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			status = "disabled";
> +
> +			i2c5: i2c@4c80000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c80000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c5_default>;
> +				pinctrl-1 = <&qup_i2c5_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
> +				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi5: spi@4c80000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04c80000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_spi5_default>;
> +				pinctrl-1 = <&qup_spi5_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
> +				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c6: i2c@4c84000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c84000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c6_default>;
> +				pinctrl-1 = <&qup_i2c6_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
> +				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi6: spi@4c84000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04c84000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_spi6_default>;
> +				pinctrl-1 = <&qup_spi6_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
> +				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c7: i2c@4c88000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c88000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c7_default>;
> +				pinctrl-1 = <&qup_i2c7_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
> +				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c8: i2c@4c8c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c8c000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c8_default>;
> +				pinctrl-1 = <&qup_i2c8_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
> +				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi8: spi@4c8c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04c8c000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_spi8_default>;
> +				pinctrl-1 = <&qup_spi8_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
> +				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c9: i2c@4c90000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x04c90000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_i2c9_default>;
> +				pinctrl-1 = <&qup_i2c9_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
> +				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi9: spi@4c90000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x04c90000 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qup_spi9_default>;
> +				pinctrl-1 = <&qup_spi9_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
> +				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
> +				dma-names = "tx", "rx";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +		};
> +
>  		usb3: usb@4ef8800 {
>  			compatible = "qcom,sm6125-dwc3", "qcom,dwc3";
>  			reg = <0x04ef8800 0x400>;
