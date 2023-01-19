Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0020673A32
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjASN3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjASN3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:29:45 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9698C7929C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:29:43 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so1272170wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3dW0pBIAKxEtxU2RORikWEFqQVlFjW5pcOn+Qp2gyM=;
        b=VNpjeXq3OZVrzKoFwoENfxprV0c/LHQ/ja2SbF6Ueo9L9iG5dfVKrDwgsBaGLiP0NX
         htavdbNyI3VCb3Fc4cJNZB9kOP9FUqb/WznH7/oRBN8dQktYvjC0gCRALkv4fm1j+42a
         SGzS53uwoHPZ0AzTPwdVXHvt5tCtoOx2OHlRkDCwsye+4WaGN0jkjXTA8T4q164+duOq
         xWDirg55Ok5y2QwhoSSYJJNU47Gmy/v9QSA+FAgshFd2qwKAz+g3xruyi3IBxqSkZy16
         AxZA6+bN6ZE/WjSPIMk9cd7VjTMYwX9AsZfLkk0KATIQz/qKlwpt3vLBRltnnuevNPFT
         fJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3dW0pBIAKxEtxU2RORikWEFqQVlFjW5pcOn+Qp2gyM=;
        b=f+gdKtfnRML9s8rWsB8HOaikK1W3pRRl6520aJLXLiWgN8w1XBgGFKhYCSVHip3H3D
         jR2F3j4IQXiQR2IwI5W/RecncRehZC7qZIY5KXPn/P289+vOULmx2LJgud1m/r06RTuP
         Mndt7G02pm07H82Ons3CeJDmgSaWjNjhG5vuJeOcbik2bmbYmD9CBfb2u5tAbD2i6LYn
         XxEVfAtdfrjwOnO8WrcKHHfZofLfJ6xm530oUv/nzQEaGyPPv1p12UTrLrzvdUmhyG3w
         hWtX9Oa4UC/BsZclKBjZaqKPTyniCtJIM9WQYd3k2c1oyKuAmVPAyoon1/tkCE6E28Kj
         NBcQ==
X-Gm-Message-State: AFqh2koVeyq6qjckvlBIaNL8gw27KOif3E9oLUS/nGCyx8PQepCRqHKJ
        7LTntozc0CIxsFWq/f0dnaR2iQ==
X-Google-Smtp-Source: AMrXdXutMqkmGbFSaII+0b3BWhZKLvebXXTCpEBdUITKyeT6dH7yiekgvhHNEYUi/sJ6hmCQbPDkfg==
X-Received: by 2002:a05:600c:5114:b0:3db:254e:59a9 with SMTP id o20-20020a05600c511400b003db254e59a9mr1687123wms.15.1674134982119;
        Thu, 19 Jan 2023 05:29:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z4-20020a1cf404000000b003da2932bde0sm5538891wma.23.2023.01.19.05.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 05:29:41 -0800 (PST)
Message-ID: <a3da518d-0247-e36c-1161-f82fddd76476@linaro.org>
Date:   Thu, 19 Jan 2023 14:29:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 3/7] arm64: dts: qcom: sc7280: Add LPASS PIL node
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org
References: <1674131227-26456-1-git-send-email-quic_srivasam@quicinc.com>
 <1674131227-26456-4-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1674131227-26456-4-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 13:27, Srinivasa Rao Mandadapu wrote:
> Add LPASS PIL node for sc7280 based audioreach platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  |  4 +
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 95 ++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index 7b3f7ee..81e0f3a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -107,3 +107,7 @@
>  		};
>  	};
>  };
> +
> +&remoteproc_adsp {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 6908bca..08142047 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/clock/qcom,dispcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,gpucc-sc7280.h>
> +#include <dt-bindings/clock/qcom,lpass-sc7280.h>
>  #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
>  #include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
> @@ -21,6 +22,7 @@
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/reset/qcom,sdm845-pdc.h>
> +#include <dt-bindings/soc/qcom,gpr.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/sound/qcom,lpass.h>
>  #include <dt-bindings/thermal/thermal.h>
> @@ -3439,6 +3441,99 @@
>  			status = "disabled";
>  		};
>  
> +		remoteproc_adsp: remoteproc@3000000 {
> +			compatible = "qcom,sc7280-adsp-pil";
> +			reg = <0 0x03000000 0 0x5000>, <0 0x0355b000 0 0x10>;
> +			reg-names = "qdsp6ss_base", "lpass_efuse";
> +
> +			status = "disabled";

Status is always the last property.


Best regards,
Krzysztof

