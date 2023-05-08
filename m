Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412D06FA15B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjEHHqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjEHHqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:46:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041194C19
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:46:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac831bb762so40170291fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 00:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683531978; x=1686123978;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wt6pLD7MHdTWBr6e66n+7CXt8GUDxkqGHCNLuv8XbzA=;
        b=ELMV39iNCbjFpKSUczM8EmQOKMsuRQInsJvObD53XxzKExoMN3OaO19WR0WsmVsztz
         mIcN9nboSBYa46LxRpr+FWMdo9lxwmMeFcb844UuxOcCqsjVo/Jzw+EWMSblPzJvA6Ve
         MzPRF4UF11cHN5Xr88gNUpsitvN9GffvBOy42GKwaHs3JFjT1WeKM/PqLwoSfnaYQy76
         pzHq0FzRMqU+noUwqqW8AHHeiCEJ4Jnv116mWal/DBMMG6O3ZAbZdmOTIH0j/PxvcqC9
         fK6mnEl0e8EiFN7Qz0fGVKSdRFio+XaKxTpZgM7bMCMUQuvVz7jRkzRwnE5og57pDQ2c
         EigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683531978; x=1686123978;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt6pLD7MHdTWBr6e66n+7CXt8GUDxkqGHCNLuv8XbzA=;
        b=YdRGy0CTcw//rg7av5tQcPtd8ck6XPFruCH/J6NiWn0Go/cvQk1h1A2OTDe4CwEx/9
         8Ez468RdmrxUxIEjuXFo/8ad+tBJTm2FjOSGHxuUJEKrYHfFo+9VRZcRgWiVwZSnq//8
         y8rdPwKOWTnTf1fTxUfbIrz9u4j5oMaGcwwYmC74OL1K+vXyV4LunYzCxyfpuuTXaLVm
         EyWo2HNZ8J9Xz+eJfIFoQxGb6ye7VrzbEAQk7+4OF4zt6fdeX6g0SUt/QkXhapDrwGw9
         rHHANyBXusJlSFkiWh1eON0m4DiIeBiTJtaniyBHcpRU6m/VEVUlXazW0dOC7BiXe5zc
         BhbA==
X-Gm-Message-State: AC+VfDwLtI+HB8aaV4uKmZ+bwJ4s6np64HraKHvOEez5wbTlbDhEHgJK
        7p5Vgn0O6Yr11Yp9VRFMZOT0UA==
X-Google-Smtp-Source: ACHHUZ6QSoghnLXkb0SQUicbC528xUsFmlnJAQJypi0FSxPrTHpa7Qt7Zo8TZbUUwmOUUucl8niORQ==
X-Received: by 2002:a2e:9ec5:0:b0:2a9:ebd4:1c45 with SMTP id h5-20020a2e9ec5000000b002a9ebd41c45mr2397706ljk.48.1683531978396;
        Mon, 08 May 2023 00:46:18 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id t1-20020a2e9541000000b002a8e73c83ffsm1090163ljh.33.2023.05.08.00.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 00:46:18 -0700 (PDT)
Message-ID: <91b5cbb7-f3cf-c77d-faf4-bd1000f3e363@linaro.org>
Date:   Mon, 8 May 2023 09:46:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/3] arm64: dts: qcom: msm8916: correct LPASS CPU clocks
 order
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230507174516.264936-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230507174516.264936-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.05.2023 19:45, Krzysztof Kozlowski wrote:
> Re-order the clocks for LPASS CPU node to match the bindings (Linux
> driver takes by name):
> 
>   msm8916-asus-z00l.dtb: audio-controller@7708000: clock-names:1: 'mi2s-bit-clk0' was expected
>   msm8916-asus-z00l.dtb: audio-controller@7708000: clock-names:2: 'mi2s-bit-clk1' was expected
>   msm8916-asus-z00l.dtb: audio-controller@7708000: clock-names:3: 'mi2s-bit-clk2' was expected
>   msm8916-asus-z00l.dtb: audio-controller@7708000: clock-names:4: 'mi2s-bit-clk3' was expected
>   msm8916-asus-z00l.dtb: audio-controller@7708000: clock-names:5: 'pcnoc-mport-clk' was expected
>   msm8916-asus-z00l.dtb: audio-controller@7708000: clock-names:6: 'pcnoc-sway-clk' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index bf88c10ff55b..e7ae81296b20 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1520,20 +1520,20 @@ lpass: audio-controller@7708000 {
>  			 * Primary/Secondary MI2S both use the PRI_I2S_CLK.
>  			 */
>  			clocks = <&gcc GCC_ULTAUDIO_AHBFABRIC_IXFABRIC_CLK>,
> -				 <&gcc GCC_ULTAUDIO_PCNOC_MPORT_CLK>,
> -				 <&gcc GCC_ULTAUDIO_PCNOC_SWAY_CLK>,
>  				 <&gcc GCC_ULTAUDIO_LPAIF_PRI_I2S_CLK>,
>  				 <&gcc GCC_ULTAUDIO_LPAIF_PRI_I2S_CLK>,
>  				 <&gcc GCC_ULTAUDIO_LPAIF_SEC_I2S_CLK>,
> -				 <&gcc GCC_ULTAUDIO_LPAIF_AUX_I2S_CLK>;
> +				 <&gcc GCC_ULTAUDIO_LPAIF_AUX_I2S_CLK>,
> +				 <&gcc GCC_ULTAUDIO_PCNOC_MPORT_CLK>,
> +				 <&gcc GCC_ULTAUDIO_PCNOC_SWAY_CLK>;
>  
>  			clock-names = "ahbix-clk",
> -					"pcnoc-mport-clk",
> -					"pcnoc-sway-clk",
>  					"mi2s-bit-clk0",
>  					"mi2s-bit-clk1",
>  					"mi2s-bit-clk2",
> -					"mi2s-bit-clk3";
> +					"mi2s-bit-clk3",
> +					"pcnoc-mport-clk",
> +					"pcnoc-sway-clk";
>  			#sound-dai-cells = <1>;
>  
>  			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
