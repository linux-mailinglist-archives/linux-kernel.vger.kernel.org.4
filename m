Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D176A3DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjB0I57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjB0I5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:57:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFDF22DC2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:49:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f18so7522352lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677487673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xo8PtnWwrkMmqBNl5fqzttHUQWsR2w/0MA7Lt9F2iOA=;
        b=OYOsCBJyu3PHkuz4lYrNd2nYJTguh0SF8n494ysqVraXW/m4/fY9uyu6Jf7WE1TlNn
         OsuoZDeiEwmkjyUSn2gDKzfJTUN8K6VAzXfD3b4x/6hvq/5uig+tSM6GDMg+Rapb7U6p
         psHZYDvHgkMC4dVFHCg7/wVfUtpxur8A4Jcb3Od7uTPU7mpRtS71rVVg3UWXiRG8rk7u
         7GrGhq/6NJLOQhNq+Q6StCmlH3B4kvZ+rmrU4k6hxGpwfyNWWfcaYx2OY68p+T+DBzSR
         WfM4lbWdmQi33ImL5TE8JxsTMuUSbE+huCCTash1TqmGFU41QE7U7ozt/dKtrIFSqMad
         NSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677487673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xo8PtnWwrkMmqBNl5fqzttHUQWsR2w/0MA7Lt9F2iOA=;
        b=kRUEBvz1SM1EYNU4LcHSSB2HYltoRk4hH+109oiiyppt3Ws8QEEnjI10ZA+uTC9Y+L
         VrSphWIOs9qz1C1i0TVrkPnxQzFqWlbmc7vVodex98v4Hw3MahAVuwYQpLLAxYFdy0Jj
         u4QGSNsmQYEizFvMQBv9yXAIFgKe+eIN1qzxX8luISknGyXpLHHNjhKPF28VmPOA1Rb7
         H8wGmAUon99sZURikN6lum4I2pFmIUtJ1qfZgwIz3YpCjVr1ozYV6H6r4LPMpqMwLWfE
         8Br0CdxF9TQ7BNSK5VIF6pbxhHheDN2PmK9qm2KmrB0J4rEN9M58kKybIulMNEX+eZez
         cnNg==
X-Gm-Message-State: AO0yUKWrkQ9Ms/0qWFT48Caj4ORFDuf+jvCPIlPRpuKTZbkT2r/4+HDL
        3+cH1Dhsq4A+q5C6obNB1ZzPjA==
X-Google-Smtp-Source: AK7set+JJS1YW5TUWtrH1VpLzxjXK6AtJde7pvJNoin4ZpdcCauRyk91EBRFYq7xKQTZVa4hiSBh9g==
X-Received: by 2002:ac2:51b9:0:b0:4dd:cb1d:b3cc with SMTP id f25-20020ac251b9000000b004ddcb1db3ccmr2440581lfk.11.1677487673430;
        Mon, 27 Feb 2023 00:47:53 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id x20-20020a19f614000000b004cb43eb09dfsm844139lfe.123.2023.02.27.00.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:47:53 -0800 (PST)
Message-ID: <211a237f-17b6-429c-1671-50f7002f98be@linaro.org>
Date:   Mon, 27 Feb 2023 09:47:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 10/13] ARM: dts: qcom: sdx55-t55: Move "status"
 property down
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
 <20230224105906.16540-11-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230224105906.16540-11-manivannan.sadhasivam@linaro.org>
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



On 24.02.2023 11:59, Manivannan Sadhasivam wrote:
> To align with rest of the devicetree files, let's move the "status"
> property down
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-sdx55-t55.dts | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom-sdx55-t55.dts
> index 6339af791b0b..67e366700105 100644
> --- a/arch/arm/boot/dts/qcom-sdx55-t55.dts
> +++ b/arch/arm/boot/dts/qcom-sdx55-t55.dts
> @@ -237,9 +237,9 @@ &blsp1_uart3 {
>  };
>  
>  &ipa {
> -	status = "okay";
> -
>  	memory-region = <&ipa_fw_mem>;
> +
> +	status = "okay";
>  };
>  
>  &pcie_phy {
> @@ -278,8 +278,9 @@ nand@0 {
>  };
>  
>  &remoteproc_mpss {
> -	status = "okay";
>  	memory-region = <&mpss_adsp_mem>;
> +
> +	status = "okay";
>  };
>  
>  &tlmm {
> @@ -308,16 +309,18 @@ wake-pins {
>  };
>  
>  &usb_hsphy {
> -	status = "okay";
>  	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
>  	vdda33-supply = <&vreg_l10e_3p1>;
>  	vdda18-supply = <&vreg_l5e_bb_1p7>;
> +
> +	status = "okay";
>  };
>  
>  &usb_qmpphy {
> -	status = "okay";
>  	vdda-phy-supply = <&vreg_l4e_bb_0p875>;
>  	vdda-pll-supply = <&vreg_l1e_bb_1p2>;
> +
> +	status = "okay";
>  };
>  
>  &usb {
