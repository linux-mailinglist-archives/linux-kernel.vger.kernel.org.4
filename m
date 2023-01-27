Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE467E67B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjA0NUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjA0NUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:20:25 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CB919F18
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:19:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v10so4695732edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OcgPAMgrAZ/C7xPMvBkfJEfxIjKIhIiRt6e2oEpw2P8=;
        b=QeQDzrGiKaOpTK0L4ffCwsCnXl55BXQ2SKM3wzAUrretYfLqPKBeAxLZgnLV17ELto
         c8S4Mw75ZK4P9OGJOLmntTJDb+I72QcNAUcgM3vGgBhd1Yrk/XR98o0geLrPp2T+jFyl
         8vSz/GoPJ+tnsQtMwegXUK6pm4AfUZ98q2+920rv0OoBYgddgk04LoHnAMesbT5Hohww
         hBsKQD1Fi2zgZHuMjF0ul0aF2q5nfUKtgvi2y3X2U/jGs3G5psoS0xUhmjKtU8Lnogjr
         ewLR3QTEE0lXaZJM6ufM1F6Sf26iYV5ooSNdJSW9HG3qqXiDEdcQnVIIMuP+aH1kV5KX
         0ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcgPAMgrAZ/C7xPMvBkfJEfxIjKIhIiRt6e2oEpw2P8=;
        b=Y/lEpCVSvxZfNWXjfCY3QvOd1ckYe/RyZNS/WGMa3QM+0dwJpCEB+yHXYgD1Zn1K27
         I1EV5WGQvddeTfjce1dOLLBv3Y1q/9YciOoR+lckPyetI/mQKv55A/Lazd7W6mu2K7oi
         YHJk5Zak9zWhbrTGi4x6Sg/J/8YfSYtQWJGADlOeUIrczjA8rRNWapGgh/OFaoXtEsds
         hfZOmPGehzwbFrzO0yvsBzxOrdLvlHiV6Q5PmTguimEXY0/pPBbSYO0RMlikjZ3IBMZk
         kNPGl8BvQKEvkGPm+c2RtYbMBbPvQrdgqsGLri19gjzQYELUI9FUPIBtGn4G7ZHmrdjS
         +JzQ==
X-Gm-Message-State: AFqh2kpvmvlf02ezsoqOdau2RmP42wRNJ+hD6gjGuM9ppNF1SwRIl908
        E6Y+HLKWEQ6oJ77Bus5/ypHaXQ==
X-Google-Smtp-Source: AMrXdXuQF/+vduGhh7O4LY2Mxe6x5n/9zOd0Pawa+WdOyFosu/ndcYTzHQOWa4l/PZN3CukIRJxNig==
X-Received: by 2002:a05:6402:4d6:b0:46c:6ed1:83ac with SMTP id n22-20020a05640204d600b0046c6ed183acmr41608812edw.9.1674825584239;
        Fri, 27 Jan 2023 05:19:44 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id e9-20020a50fb89000000b0048ecd372fc9sm2335204edq.2.2023.01.27.05.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 05:19:43 -0800 (PST)
Message-ID: <7da76295-7d0f-f401-1501-7932f31ecbee@linaro.org>
Date:   Fri, 27 Jan 2023 14:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: Fix the aoss_qmp node name
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20230127131441.1157679-1-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230127131441.1157679-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.01.2023 14:14, Abel Vesa wrote:
> The proper name for it is power-management. Currently, with the node
> name being power-controller, the bindings check fails due to the
> property #power-domain-cells missing.
> 
> Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 6ff135191ee0..57878ea64ee0 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2503,7 +2503,7 @@ tsens2: thermal-sensor@c273000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -		aoss_qmp: power-controller@c300000 {
> +		aoss_qmp: power-management@c300000 {
>  			compatible = "qcom,sm8550-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
>  			interrupt-parent = <&ipcc>;
