Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14766D989E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjDFNw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjDFNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:52:23 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC4559CD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:52:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id o20so37855808ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680789140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fi3MbKEX3/1oXOmLA6/02HNxunRbR6J+mBMPZLKnID4=;
        b=V6Lvgn5UmaJHwGcsdXTIlnxWzrSKyZcw3V2db72LTXKnPOF7k5mYDurVM4PrZBtBzK
         n5edXOVBy0oZ2KEilqIVEZSplIwyhgICDhNmuENrVHbPlR+Cwf0dQixpyU+66BdCmrJu
         RyclY0AdpVi5bVaQiwx02gcE6l8/CWQOLWaGgcxai1MHkWLeorJdDTWk/Y/CbfmK9oED
         xpRDF7mVhrNfwPDcP/IudYw7CGng6u0gUk0zgMbIhohWYoN/TKF25KnNfOVsVYFdzdLq
         vWW6iHsgO33I1eYzzetlWD8JgiCpTO6SQzwGT4d4q8pSbkv2t4BfuEaBnLHXp1FjhNkz
         3yHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680789140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi3MbKEX3/1oXOmLA6/02HNxunRbR6J+mBMPZLKnID4=;
        b=FbIJJyELr0i1wnCXOWUptJYfl5NatA6kP0R3qDUWzXnRSnk/H+1YIo/ipeX1fCEvbb
         rj6FjzXbL4hv5+/dPZNCZuXoslGIvIMc/aBN1Vi+c8vX3vnWPdXptToICIxy5ShI90rH
         d3hAwxm+Tm/mMlZVm9KdRBptljydKJ/eZ5p+hbYed62HGhFbsueF+Pk19EnUPlod1TMg
         mXEkuVwwmsAr9XWfDI0zFI56rl4r7JWbWJH2XOtP6S+3Mb/J+Z3MGxhCxrRM+7rcKWet
         r0xGvWuG3G4Y12dcGSEazFeSsSpm9YoOIFwnMvVaav4fIzni4z9ucoBfGLvGaUZ7eVdK
         cgVw==
X-Gm-Message-State: AAQBX9euxZeHoVkNYz350BpThPj5pNEhGkhkC9PuoDRIAkw4h32zwuky
        uFYMcWKoVGnIBt35FoOtAa/new==
X-Google-Smtp-Source: AKy350YtOAzeOkwF1HQZlElfqcsFwRMN4c5y60bpJ2y5/F1fIAJg9bOYn481jfAhRCok7/++GyKBXA==
X-Received: by 2002:a2e:8058:0:b0:29b:aee8:29b3 with SMTP id p24-20020a2e8058000000b0029baee829b3mr3005558ljg.38.1680789139665;
        Thu, 06 Apr 2023 06:52:19 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id p3-20020a2e9a83000000b0029462e98c07sm295517lji.35.2023.04.06.06.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:52:19 -0700 (PDT)
Message-ID: <dfc5797a-784c-0a3e-a290-714fdf356713@linaro.org>
Date:   Thu, 6 Apr 2023 15:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 07/11] arm64: dts: qcom: sm6115: Add Crypto Engine
 support
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
 <20230405072836.1690248-8-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230405072836.1690248-8-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.04.2023 09:28, Bhupesh Sharma wrote:
> Add crypto engine (CE) and CE BAM related nodes and definitions to
> 'sm6115.dtsi'.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 2a51c938bbcb..ebac026b4cc7 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -650,6 +650,28 @@ usb_hsphy: phy@1613000 {
>  			status = "disabled";
>  		};
>  
> +		cryptobam: dma-controller@1b04000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0x0 0x01b04000 0x0 0x24000>;
> +			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,controlled-remotely;
> +			num-channels = <8>;
> +			qcom,num-ees = <2>;
> +			iommus = <&apps_smmu 0x94 0x11>,
> +				 <&apps_smmu 0x96 0x11>;
> +		};
> +
> +		crypto: crypto@1b3a000 {
> +			compatible = "qcom,sm6115-qce", "qcom,sm8150-qce", "qcom,qce";
> +			reg = <0x0 0x01b3a000 0x0 0x6000>;
> +			dmas = <&cryptobam 6>, <&cryptobam 7>;
> +			dma-names = "rx", "tx";
> +			iommus = <&apps_smmu 0x94 0x11>,
> +				 <&apps_smmu 0x96 0x11>;
> +		};
> +
>  		qfprom@1b40000 {
>  			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
>  			reg = <0x0 0x01b40000 0x0 0x7000>;
