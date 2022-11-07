Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023C461F7F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiKGPsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiKGPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:48:22 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E915E1FFAE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:48:19 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u24so18178043edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 07:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFZbCwEAf5xvmFibQbTSCqyngiA1gCMbpOH+dBVu8iE=;
        b=CZ8TGNRlE5jmJffm9Yx0cmQI4SfkpxDCjF0CUs2Eo78TqWT6+m/jyXCqqzr0l482Nf
         bZ5N559p66DFquV0L7YT6toyJmIMaAzdHaSVJhA3fsSLwj2u6dSuId1C7haefteeYblH
         g28tShiu7o6XNcbT9DIRO0DOF9TsaAMDwQgfDek1ekvzeXEQ1SPswpUVBHKwaCt11pNz
         Lylxs6d2TprhGOql/pyKa0d6d3jO5AK2uqREQdAykb0/oUef2BIpJJUQ0PO3ST/QQNZW
         mGLU4TzPtjlpsFOS5ZHtyW73YEYhFtFEjxNPj6eRhlZ7Q5VPgi5irG7Y9qWs69ffQ+7t
         5sQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PFZbCwEAf5xvmFibQbTSCqyngiA1gCMbpOH+dBVu8iE=;
        b=tnhmyGIOB8ijXWnbTJ9q7r2uOfzl9qOZTFYAIQ6rt8/Aukw+xZhkpK3RwitAyHNve1
         BlAM2h/Jzy8b6NigLAdzsF1QSMAr5hVrA8iKo8w1G639U3hll49cskCMnY2eb88Pc3pC
         KFYPJY7wm31hc9fKYw5UwOmIZDRtfp/ACTE+SDYg7YMA8lvYZSk+6TqWSaryy5SMQKqS
         tLkCawAo/L5g9dRpste1geJ4bFJjTjQNVDAtzwQ3Sqhdv6N3WKDz/JuswO6aScilz887
         2UlZDhx5O0rQdD5M4QEunsd0w9VrhIhqp7Y1Sjzv40F6sgdqNfDlkSdxcBYhQk2Jrmnk
         ix+w==
X-Gm-Message-State: ACrzQf1o/dBTmvXRfAGpjQ2oQf6OQxh1zKb1aIgiZwvShrVo7lUf+Fuc
        /+912NHBMpoJJuAafUqNp6Yp5A==
X-Google-Smtp-Source: AMsMyM4C4BS78FBPn0mzYLjEHkzToQ5EH3PogrfSySzn/OQCGvYBG56Zr7WlIdFu1ic0QJe9/FVAzg==
X-Received: by 2002:a50:cd07:0:b0:464:63b:1017 with SMTP id z7-20020a50cd07000000b00464063b1017mr28653410edi.364.1667836098543;
        Mon, 07 Nov 2022 07:48:18 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id k18-20020a05640212d200b0044ef2ac2650sm4337439edx.90.2022.11.07.07.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 07:48:17 -0800 (PST)
Message-ID: <49407328-de28-9018-321b-c649c5bc7435@linaro.org>
Date:   Mon, 7 Nov 2022 16:48:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: Remove redundant soundwire
 property
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        mka@chromium.org
Cc:     Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
References: <1667830844-31566-1-git-send-email-quic_srivasam@quicinc.com>
 <1667830844-31566-3-git-send-email-quic_srivasam@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1667830844-31566-3-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2022 15:20, Srinivasa Rao Mandadapu wrote:
> Remove redundant property qcom,port-offset in soundwire
> controller nodes.
> This patch is required to avoid dtbs_check errors with
> qcom,soundwie.yaml
> 
> Fixes: 12ef689f09ab ("arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital macro codecs")
> Fixes: 24f52ef0c4bf ("arm64: dts: qcom: sm8250: Add nodes for tx and rx macros with soundwire masters")
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 -
>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 748eef6..71be873 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2317,7 +2317,6 @@
>   			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff>;
>   			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff>;
>   			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00>;
> -			qcom,port-offset = <1>;
>   
>   			#sound-dai-cells = <1>;
>   			#address-cells = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index eb5a10c..0f430ca 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2360,7 +2360,6 @@
>   			qcom,ports-word-length =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF>;
>   			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF>;
>   			qcom,ports-lane-control =	/bits/ 8 <0xFF 0x00 0x01 0x00 0x01>;
> -			qcom,port-offset = <1>;
>   			#sound-dai-cells = <1>;
>   			#address-cells = <2>;
>   			#size-cells = <0>;
