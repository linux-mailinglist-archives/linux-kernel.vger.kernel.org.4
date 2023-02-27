Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5A96A3DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjB0I7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjB0I6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:58:47 -0500
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D089C26CDF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:50:01 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id g17so7505417lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677487633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGEvxiIce6M0SGXJ5oF+mxzxGYDkt2DuO9DUSxA4Nhc=;
        b=DbYxzYd2egvjqQVaE54QMDImLRBvo2tB+2pSsAFL6cS0WM2EON5MTROQQHlYJlzbv7
         eOkA1276kEfRKLawg17GO6ur3BDp2eOeBieMhTSSArIzg34xSekrFJhzS/yogKQZutlM
         GEpUL9/znyFxZCy/DUxzjslBwsG91jFZHBJ8u83foePcb1eErY1GsRkOBI+GQapxxL3U
         UU1ArqCqJre2wSzeWuHJUf199TMel7PmWVUGfucOQD9nfmarDaepqONWqqKRS3pRX4aK
         fZmlNicKzjlYudQadii3pDFAmd6brtZxMhhQEe+M8iZx+kiYSfyRNopsnzt8r4Xho9SD
         pxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677487633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGEvxiIce6M0SGXJ5oF+mxzxGYDkt2DuO9DUSxA4Nhc=;
        b=rcdg6F7SmrD9FhD5jJHJM2zjBFowAGJvUSuZGnrPOjavgkQHv86HQsD9UodTaFOvyQ
         sl+yHfFcezalVk404aZZnaiFfdYxpakiYIwpYZ3TRAYw1Ld6EbN/9OuRszU3cbwha4PP
         NMPKweu8STiafAhURVvr+1jFvIuzyg688+ZRH4r3xMZhY2VPsi0BACxbjymxYBWyGmPt
         58QB2T+Ws3gdE0gy+0CWOZ30ORUVa2spmnRNruQrSNi7VqsR4mesWvhoIxIlWFdc5a5c
         U/iPgLAQ9YC2axDVjFt/bEOrqsexyvk6P5DerCvU7wnUWCe6KGB9qWoOszREMBIp7OOC
         pL9g==
X-Gm-Message-State: AO0yUKWN22jDQrlYORA0ZoBLef1+7nZSgocrDjZ1U8GlEn4G4wHL/TEe
        zSm/FdffsD/1EXF1Kbk6tBRGpg==
X-Google-Smtp-Source: AK7set+jRlP3Ws0pk91xzP8Ph3OLMg+5mB5YM01sUtHzwiuA+FFG2+OP37l/eZVFlbwMvoHRKPydiw==
X-Received: by 2002:ac2:5a5c:0:b0:4d7:58c8:5f44 with SMTP id r28-20020ac25a5c000000b004d758c85f44mr7382294lfn.12.1677487633674;
        Mon, 27 Feb 2023 00:47:13 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id a7-20020a2eb547000000b00290716d65dcsm641925ljn.136.2023.02.27.00.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:47:13 -0800 (PST)
Message-ID: <8991446f-88f0-9f83-e284-be67b376b1f6@linaro.org>
Date:   Mon, 27 Feb 2023 09:47:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 09/13] ARM: dts: qcom: sdx55-t55: Enable PCIe RC
 support
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
 <20230224105906.16540-10-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230224105906.16540-10-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.02.2023 11:59, Manivannan Sadhasivam wrote:
> Enable PCIe RC support on Thundercomm T55 board.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-sdx55-t55.dts | 42 ++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom-sdx55-t55.dts
> index 7ed8feb99afb..6339af791b0b 100644
> --- a/arch/arm/boot/dts/qcom-sdx55-t55.dts
> +++ b/arch/arm/boot/dts/qcom-sdx55-t55.dts
> @@ -242,6 +242,23 @@ &ipa {
>  	memory-region = <&ipa_fw_mem>;
>  };
>  
> +&pcie_phy {
> +	vdda-phy-supply = <&vreg_l1e_bb_1p2>;
> +	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
> +
> +	status = "okay";
> +};
> +
> +&pcie_rc {
> +	perst-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 53 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-0 = <&pcie_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
>  &qpic_bam {
>  	status = "ok";
>  };
> @@ -265,6 +282,31 @@ &remoteproc_mpss {
>  	memory-region = <&mpss_adsp_mem>;
>  };
>  
> +&tlmm {
> +	pcie_default: pcie-default-state {
> +		clkreq-pins {
> +			pins = "gpio56";
> +			function = "pcie_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-pins {
> +			pins = "gpio57";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		wake-pins {
> +		       pins = "gpio53";
> +		       function = "gpio";
> +		       drive-strength = <2>;
> +		       bias-pull-up;
> +	       };
> +	};
> +};
> +
>  &usb_hsphy {
>  	status = "okay";
>  	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
