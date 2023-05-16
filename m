Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0B07053BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjEPQ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjEPQ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:27:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839C783EC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:27:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4eed764a10cso16401949e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684254447; x=1686846447;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MriSNyHl7C5jnE8BOqZbNnVKPXp+2WOKC/MeNYn0pnQ=;
        b=kBw+PjAXZHS3RjfMWnw8Rgx14arudG1hpqcyqyYVDKp1XqywoUSX57iTrubymd7yLF
         W/VW3LYzRcFvlmZWjkNDUqa6Cmy8K+OAB85h1FLz8vGvNl+/ga2pF8Jfig48NKGhtJIE
         6bc+VUU7q+u6za4DIDR+C0EK4vfjCqCfSkxeHIfmBSLeDraJIOxTvh4AjK9+PBt5U8YD
         mamTlmiYPZQS1cwhl9TE1JQQRx6RoOP1ORkDrudPt7CSiVlkEF7lec6SdYRUDyP6d9Q2
         QNtMqX+i6nXv3EK52jIfhjZvofSaWN0g30x19otyLjVaxElx/EgcQC71UnLMHCqn5KWZ
         KnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684254447; x=1686846447;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MriSNyHl7C5jnE8BOqZbNnVKPXp+2WOKC/MeNYn0pnQ=;
        b=Gx70JKp4OB2eSvpj1ReU0mHOoNaSRnPibZ9InOm+1f6qabwJINtTEodLBF/BkiqmbC
         6roEogYlxRvRN+faL/DO/bXroK227uXfAF3saV1qVI0GVVpsxQcnEWdeatVWHRr4sLbO
         mWV0lAjukP/aJbBb5b1BrG38CXptQCTgIbyVoKyTJRuucM/is8Dq8NTjhBqnN8bREvt5
         X7TX9LfFgpkfHz33gbFZWNaaYiOafyeeNHLxfv113UO+kqLWfD7aqPzi6yk5TxVlfXtP
         95X+u6fRsGCKT4hhWMYZlmj4U0OKsIaNuy4Xhgi7bKxS1+sg9xYstcwixgZGhH8LYdZE
         xlNw==
X-Gm-Message-State: AC+VfDzHy401/MYiVndHhm4EVEt8xHgcndRp1H4ZIdXbn15V+z5KHwRl
        XKoIKwLLrzaDnsP9NhPuntKVAw==
X-Google-Smtp-Source: ACHHUZ6Chq3j+2Elaz4NTC3p3XmVW8KpkCL0whvbUyKS+8HNrEmlzH7cou9SbwSALdF8GRWBg7MePQ==
X-Received: by 2002:ac2:55a6:0:b0:4ec:a18e:f989 with SMTP id y6-20020ac255a6000000b004eca18ef989mr8248478lfg.17.1684254447625;
        Tue, 16 May 2023 09:27:27 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id u25-20020ac243d9000000b004f3892d21a5sm345793lfl.69.2023.05.16.09.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:27:27 -0700 (PDT)
Message-ID: <c40f4c9b-d5d7-f101-2446-fb764a2aab3d@linaro.org>
Date:   Tue, 16 May 2023 18:27:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8550-mtp: drop redundant MDP
 status
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230516154539.238655-1-krzysztof.kozlowski@linaro.org>
 <20230516154539.238655-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230516154539.238655-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.05.2023 17:45, Krzysztof Kozlowski wrote:
> MDP in sm8550.dtsi is not disabled (although its parent MDSS is), so
> board DTS does not have to enable it.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes in v2:
> 1. New patch
> ---
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> index f27d5c657f44..579f65f52370 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> @@ -459,10 +459,6 @@ &mdss_dsi0_phy {
>  	status = "okay";
>  };
>  
> -&mdss_mdp {
> -	status = "okay";
> -};
> -
>  &pcie_1_phy_aux_clk {
>  	clock-frequency = <1000>;
>  };
