Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683EF622E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKIOf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiKIOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:35:58 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C4CAE7A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:35:56 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t10so26151819ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 06:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgNpl8C4iBNYvOOWoX8NPXlg4rH8L8HyQLMoDwL+0HM=;
        b=NQk8t2AbEPU/qlVt4CMjHppqeR6boJaJmxSIgYmN6jtFUUTm6kHzntU4OU1MKoyhWK
         HjOhx7KPnv7SSIIDzKJclF0NySbnfmY98Xl4XRKTPzpUmItA9MBIIWN2/7UpRopdIqgT
         iyAiwllUJbbiLUFyckmx2eJl5584q+uJKcpMxW4PfN4Tms/Uyl77rsdkgMZiTyKkLX1V
         9qnlThy9Janu6Z4/CHqJLWB977Vcf293JYT3FtB6RxuhaVGjGVpAvDwdG7E+LO7PEaYt
         sRefkIBhT4UeInmWKKeEJ2tfvgUShHn5qR3Lb3uxP/IeWo7dKfuRFuGnIdpXAW9QP0CN
         AJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgNpl8C4iBNYvOOWoX8NPXlg4rH8L8HyQLMoDwL+0HM=;
        b=deE4rGmPmQuCuIvFeMakNJkhgRmGoDxrf0124Cfc1nFtpY3YbYlHcM3qfpVYPr7iOt
         xFgX07bP9fXLcq48l8avxvCu4Ww3YK8zdlxOZI7gM4oUhqqCzIGJSJxL+JgDHy03Z+Bx
         nxRdsq75mk0CcmEqLbtsZj1OmEj1h/yZkOJYf8NjyopyoiGemgUQfqv8lHKGM9E6EBJB
         u2wL6RaaQOejAPeU62hzljHWUD+SQ+acN2ocpbJb+lqvGYcmYp9WztR0NTp8OybCQbBz
         A+UpHJzsKvXoO6CFZhm6zlv3mmbQqquP3Ryw7ZbuSA4myjElZDxc1W6142bNnwIRud/k
         J4Lg==
X-Gm-Message-State: ACrzQf33nIMpEZ7GGMV4pSC6MdstUZE7RYJC+1qDd5DZayj1pW5sK2we
        kNEdWfy4yU9K+g7WE3E0+j2xzw==
X-Google-Smtp-Source: AMsMyM6dbYGIXJoas0iyFdKUCrjS77dbN7utqs2pCahKT+GiStFnYszVKkXp1V+GsNuYnRXCqF0h8A==
X-Received: by 2002:a2e:b637:0:b0:277:74dd:1fbd with SMTP id s23-20020a2eb637000000b0027774dd1fbdmr12726026ljn.378.1668004555018;
        Wed, 09 Nov 2022 06:35:55 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id b21-20020a056512071500b00494978b0caesm2254240lfs.276.2022.11.09.06.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 06:35:54 -0800 (PST)
Message-ID: <805126e9-5e71-c44e-d586-8c687ef02357@linaro.org>
Date:   Wed, 9 Nov 2022 15:35:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm6375: Add SDHCI2
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221109142623.53052-1-konrad.dybcio@linaro.org>
 <20221109142623.53052-3-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109142623.53052-3-konrad.dybcio@linaro.org>
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

On 09/11/2022 15:26, Konrad Dybcio wrote:
> Configure the second SDHCI bus controller, which usually the
> interface used for SD cards.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6375.dtsi | 82 ++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> index 6adffd927a8e..483202e60cd7 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> @@ -540,6 +540,46 @@ tlmm: pinctrl@500000 {
>  			#interrupt-cells = <2>;
>  			#gpio-cells = <2>;
>  
> +			sdc2_off_state: sdc2-off-state {
> +				clk-pins {
> +					pins = "sdc2_clk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc2_cmd";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +
> +				data-pins {
> +					pins = "sdc2_data";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			sdc2_on_state: sdc2-on-state {
> +				clk-pins {
> +					pins = "sdc2_clk";
> +					drive-strength = <16>;
> +					bias-disable;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc2_cmd";
> +					drive-strength = <10>;
> +					bias-pull-up;
> +				};
> +
> +				data-pins {
> +					pins = "sdc2_data";
> +					drive-strength = <10>;
> +					bias-pull-up;
> +				};
> +			};
> +
>  			qup_i2c0_default: qup-i2c0-default-state {
>  				pins = "gpio0", "gpio1";
>  				function = "qup00";
> @@ -630,6 +670,48 @@ rpm_msg_ram: sram@45f0000 {
>  			reg = <0 0x045f0000 0 0x7000>;
>  		};
>  
> +		sdhc_2: sdhci@4784000 {

Node name: mmc

> +			compatible = "qcom,sm6375-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x04784000 0 0x1000>;
> +

Best regards,
Krzysztof

