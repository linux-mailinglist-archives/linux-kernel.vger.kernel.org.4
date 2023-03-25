Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2726C8DBD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCYMDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCYMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:03:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE26D26A6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:02:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g17so5478392lfv.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679745778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y12pBMJMfkHML5M9T8BiKwKEu+VsqbjbY9flvBgFo4A=;
        b=bHBDp+PitHQJsPu2SBExO61KY01Ffrpt1+Zx7U8F3weijGoIJ49jflcMo50/LRnZHU
         lvFShYdQhU3ocZnRMQtxToC9brMnX5mjUyh6MJqvWTbz87nuXZTsc+6cGhCnYxHQmMOZ
         kLna+BNmMIVv01oIcHcxgCLiOB06z2hgbgX9jiXRHp9sDVkPcLK6TDa95K3QkDVOLFAS
         eOh7rUgWTa9TuTQSz1Hmj6A0GZCJr+4AXLokMCENqVbtw5YLyDRBoabdKe8ER3sT4YzH
         u43urYU4urBP+jCUkYgyhSghUCr7XVIGkKjM6c6BF+qgSG5wKfFRxVBGMxBoHZNpZjKl
         B0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679745778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y12pBMJMfkHML5M9T8BiKwKEu+VsqbjbY9flvBgFo4A=;
        b=1oBoo/ssWbHcpCtYz6oiKIEzAeP3S/OFaZ4T0tIrXfVFf4/yGLpbWV19ITI/kewy6L
         ir2UZRXkTp36vdGbmGT2Vpj1oR95G0HSG59g3HkADK3isRIPkeCnk6DrFvJy6wfVYLln
         UtEcOLN1OKlvir5ZQuX78IQurmZ9slGKzh8889NCZrVcZl44j69rYOTbMTwCJIJanpNb
         6oWAYufsO5mNagIUhs7cML21JFMSZwld0YMPs9QWcX4PiBE8VOR055xYxy2/u9uiqlQd
         cDj3bhf0Uf1/IZrP/BoaCpSm+u3mp8bufUAldrHC6j8Cr0S3wR/w+RkvM2QAQenDgl4N
         nWlQ==
X-Gm-Message-State: AAQBX9dFQvK2t2D/MB1b4grknUFmFmdrVaUnlMKHkZQqay0v0u2g+cHt
        7/S9umyGwTNTOPr6cB9IvQdeog==
X-Google-Smtp-Source: AKy350bCqmIoZXlZuYM6DqJCydMcQCEWpt/97ZNj0696jDVmL1ZKG3/mpIvblmWRunGhRjOeMqp1Dg==
X-Received: by 2002:a05:6512:67:b0:4d5:6583:d2e4 with SMTP id i7-20020a056512006700b004d56583d2e4mr1669830lfo.29.1679745778203;
        Sat, 25 Mar 2023 05:02:58 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id d19-20020ac241d3000000b004cf07a0051csm3783948lfi.228.2023.03.25.05.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 05:02:57 -0700 (PDT)
Message-ID: <580ae0ef-3ff8-7022-4675-f77f0f5102e9@linaro.org>
Date:   Sat, 25 Mar 2023 13:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/5] arm64: dts: qcom: msm8916-thwc-ufi001c: add function
 to pin config
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
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



On 24.03.2023 21:22, Krzysztof Kozlowski wrote:
> Bindings require pin configuration nodes to have the function, even if
> it is GPIO:
> 
>   msm8916-thwc-ufi001c.dtb: pinctrl@1000000: sim-ctrl-default-state: 'oneOf' conditional failed, one must be fixed:
>     'esim-sel-pins', 'sim-en-pins', 'sim-sel-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
> index 8433c9710b1c..978f0abcdf8f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
> @@ -44,18 +44,21 @@ &msmgpio {
>  	sim_ctrl_default: sim-ctrl-default-state {
>  		esim-sel-pins {
>  			pins = "gpio0", "gpio3";
> +			function = "gpio";
>  			bias-disable;
>  			output-low;
>  		};
>  
>  		sim-en-pins {
>  			pins = "gpio1";
> +			function = "gpio";
>  			bias-disable;
>  			output-low;
>  		};
>  
>  		sim-sel-pins {
>  			pins = "gpio2";
> +			function = "gpio";
>  			bias-disable;
>  			output-high;
>  		};
