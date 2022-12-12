Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E093B649E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiLLMCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiLLMCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:02:52 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEB610B79
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:02:50 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b13so18177717lfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v26oKHbeiySA4kWi2fJuL0+d0H1ofT34dxbF61fRM5c=;
        b=BHwF9+AYwVUAVHN+h3qZkRQjQ4ZPsDq+R2UF7ZHxEXGZ9/El3/AkUnWwG045tXnWaf
         3AtLc8P7T7gNzLAIA6UTzbFh1dPKjj7hDFKqmw9DXu//pVnsY/UcYqN1EFrPKj/7xolc
         TZEwKyKvProisUkXx56iGXqxqlXmpL/VxWluACpYWciSSUApCImd2NEmXTfiuIENfWUy
         P65BILCgpdvG54wgmc7yH16osnPdCAdgV49azoSjpchVRtw7XH9yOg19CmB3B5lOR7FU
         qRIF+v+BIXOUfZoM/g/XxbCRAVcErLuhILB6AvzaZjRq4c/bBui8RwNkolOgQbaG8hyD
         bvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v26oKHbeiySA4kWi2fJuL0+d0H1ofT34dxbF61fRM5c=;
        b=O+3IqSXjj0ykJL+FWteTQtJ4JG/dGcpm+NG1GdkFsjXhSGEm9e7YlmDuxJa2I7qUf6
         yTAAHIiTB/izgoiCLXIJ/DvaJPLiAcI/YP72t7zHomS0irtT0b7xf3eIYeeqnTmCfrOE
         bSDlD92EkPsr5qW48EROAeDq1B4ZVDOGcmVHhYxK3iLmqerHLt2p1tyVzh67wIRttduh
         xfuQJNRYnumjT8LIvAdQq8LpNSu5LsOmWai2j01AcNOaKMlXb55Ajto6WK/7BOunYFZ1
         55gR/fzRva8GmUfvEMek8DqlpKTOEXoUTKDcXjAHqcQZKWJUku3He9/hZZREEf5H+e00
         8HSg==
X-Gm-Message-State: ANoB5pnGrYXlPyyIbahXeDxNJOGTYGtTwQE/7X1Fg1AamZBdGztuh8dF
        f3Xe/4YQDZZwMxSvZGC5krYH4Q==
X-Google-Smtp-Source: AA0mqf4ebqMEVJKCcpr9mQriAOW1MpcbgVEb5AX8eqiH98nKBjZNes7Uz9OSSSS/gGIuh6lzcoTDGg==
X-Received: by 2002:a05:6512:3f1d:b0:4a4:68b7:d621 with SMTP id y29-20020a0565123f1d00b004a468b7d621mr5279903lfa.8.1670846568705;
        Mon, 12 Dec 2022 04:02:48 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id w6-20020a05651234c600b004b5480edf67sm1626203lfr.36.2022.12.12.04.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 04:02:48 -0800 (PST)
Message-ID: <8bf713d5-85ea-06a0-d4aa-5aa75bf8d498@linaro.org>
Date:   Mon, 12 Dec 2022 13:02:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
Content-Language: en-US
To:     Shazad Hussain <quic_shazhuss@quicinc.com>, andersson@kernel.org,
        johan@kernel.org
Cc:     bmasney@redhat.com, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221212114502.1616-1-quic_shazhuss@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221212114502.1616-1-quic_shazhuss@quicinc.com>
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



On 12.12.2022 12:45, Shazad Hussain wrote:
> Add the pcie2a, pcie2a_phy, and respective tlmm
> nodes that are needed to get pcie 2a controller
> enabled on Qdrive3.
> 
> This patch enables 4GB 64bit memory space for
> PCIE_2A to have BAR allocations of 64bit pref mem
> needed on this Qdrive3 platform with dual SoCs
> for root port and switch NT-EP. Hence this ranges
> property is overridden in sa8540p-ride.dts only.
> 
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> ---
> This patch depends on below patch series for vreg_l11a.
> 
> [v4] arm64: dts: qcom: sa8540p-ride: enable PCIe support
> https://lore.kernel.org/all/20221206161916.315640-1-bmasney@redhat.com/
> 
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 44 +++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index bb4afd3a9632..ed20423ec8ac 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -146,6 +146,27 @@ vreg_l8g: ldo8 {
>  	};
>  };
>  
> +&pcie2a {
> +	ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
> +			 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>,
> +			 <0x03000000 0x5 0x00000000 0x5 0x00000000 0x1 0x00000000>;
Hi, please fix this indentation.

Konrad
> +
> +	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 145 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie2a_default>;
> +
> +	status = "okay";
> +};
> +
> +&pcie2a_phy {
> +	vdda-phy-supply = <&vreg_l11a>;
> +	vdda-pll-supply = <&vreg_l3a>;
> +
> +	status = "okay";
> +};
> +
>  &pcie3a {
>  	ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
>  	         <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x20000000>,
> @@ -247,6 +268,29 @@ &xo_board_clk {
>  /* PINCTRL */
>  
>  &tlmm {
> +	pcie2a_default: pcie2a-default-state {
> +		perst-pins {
> +			pins = "gpio143";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		clkreq-pins {
> +			pins = "gpio142";
> +			function = "pcie2a_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		wake-pins {
> +			pins = "gpio145";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
>  	pcie3a_default: pcie3a-default-state {
>  		perst-pins {
>  			pins = "gpio151";
