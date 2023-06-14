Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD6C7303DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244842AbjFNP1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjFNP1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:27:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEFFC7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:27:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f642a24568so8888639e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686756447; x=1689348447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XaodULpx93bhaMgasCg20jVwTzInKVTrlrTMvfuinVI=;
        b=nFwS5B0lhBgtFdQVs7vOetdeXczFg68Koa9owmCGc1U4FHRTK4fATvLChYhFoFJU+r
         1NZpXR147c3UtQZQwteqzx9aHzsgJNefC/4G5myLggcstfvPQLCkwfp6hU0mzQINCEq+
         HWrJReOwEfcSUZwsuVo6PID/H/o+he/zGhDBXb2XGwnlMH8uPsB5o9S+HWXBzsM4wRdN
         nNgoOCIZxpJolG43LW5yhjncFO8PypumIrn8LrkL0SjjCvsXKBzH+fvR1QmWn2CZ/r83
         t+NEX0lYATbH5ONiaH5t3NDcw/yj9LJEkXEwsnWS9RBBuFx/ETSFi641JGjZwRkTjASB
         60Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686756447; x=1689348447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaodULpx93bhaMgasCg20jVwTzInKVTrlrTMvfuinVI=;
        b=D0Zok/rHndflIEJz0X4OrdiSgq8cPb2+X/wID22KIQK7vxUAheV9p+gzf7sCFc+g/7
         zEpLwRe5Ru3/cJ62ZrJL9W0oLvxQeLmDvf64U7n9XyQZLDrjnulY+ZKYrloKySHPPvi2
         s9nz7IJjLFCXjNlkAL47etNkdFPg371ujPpOHhrLZb5GFysgq2nSodDVhw5mlcbCQyQh
         oTdrafSR3iu+IblfHmR4OorsLnmTe6ilnjT4G+DiDJjX8WSb998zpEPhbICvomYrNw+h
         mgcYR7By5pupu/SHKyb+L5MBCq86VkdVAGyA1IKQLwzNotrX1cbyISiPOrRbKT1UCuz5
         oQmQ==
X-Gm-Message-State: AC+VfDzg5JiASPhJCjzrVFBeEZijFNllw23zmlVYbwZxnQCZMKk2nPYW
        I6wA2WftGxTxLLf+rVhHtUdVqQ==
X-Google-Smtp-Source: ACHHUZ5qHZ0XHSvNY5Er+5xVDd9+YbHVFL6nwRBwyo0osPEjAoRpp2Lu4p+OVeu3z9RoDZuVR1cJeg==
X-Received: by 2002:a19:6419:0:b0:4f6:1916:4170 with SMTP id y25-20020a196419000000b004f619164170mr7342197lfb.5.1686756446884;
        Wed, 14 Jun 2023 08:27:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id d2-20020ac25ec2000000b004f24e797c55sm2173748lfq.25.2023.06.14.08.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 08:27:26 -0700 (PDT)
Message-ID: <8f8d5e09-50a6-a83f-d4bb-3d7bc8c07162@linaro.org>
Date:   Wed, 14 Jun 2023 17:27:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sc8280xp: Enable GPU related
 nodes
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        johan@kernel.org, mani@kernel.org,
        Steev Klimaszewski <steev@kali.org>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20230614142204.2675653-1-quic_bjorande@quicinc.com>
 <20230614142204.2675653-3-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230614142204.2675653-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.2023 16:22, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add memory reservation for the zap-shader and enable the Adreno SMMU,
> GPU clock controller, GMU and the GPU nodes for the SC8280XP CRD and the
> Lenovo ThinkPad X13s.
> 
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

one question below
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          | 14 ++++++++++++++
>  .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 14 ++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index cd7e0097d8bc..b566e403d1db 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -210,6 +210,11 @@ vreg_wwan: regulator-wwan {
>  	};
>  
>  	reserved-memory {
> +		gpu_mem: gpu-mem@8bf00000 {
Is it ever going to differ on other platforms, including the automotive ones?

Konrad
> +			reg = <0 0x8bf00000 0 0x2000>;
> +			no-map;
> +		};
> +
>  		linux,cma {
>  			compatible = "shared-dma-pool";
>  			size = <0x0 0x8000000>;
> @@ -390,6 +395,15 @@ &dispcc0 {
>  	status = "okay";
>  };
>  
> +&gpu {
> +	status = "okay";
> +
> +	zap-shader {
> +		memory-region = <&gpu_mem>;
> +		firmware-name = "qcom/sc8280xp/qcdxkmsuc8280.mbn";
> +	};
> +};
> +
>  &mdss0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 5ae057ad6438..7cc3028440b6 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -264,6 +264,11 @@ vreg_wwan: regulator-wwan {
>  	};
>  
>  	reserved-memory {
> +		gpu_mem: gpu-mem@8bf00000 {
> +			reg = <0 0x8bf00000 0 0x2000>;
> +			no-map;
> +		};
> +
>  		linux,cma {
>  			compatible = "shared-dma-pool";
>  			size = <0x0 0x8000000>;
> @@ -518,6 +523,15 @@ &dispcc0 {
>  	status = "okay";
>  };
>  
> +&gpu {
> +	status = "okay";
> +
> +	zap-shader {
> +		memory-region = <&gpu_mem>;
> +		firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn";
> +	};
> +};
> +
>  &mdss0 {
>  	status = "okay";
>  };
