Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7F5733CF1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbjFPXeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345651AbjFPXeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:34:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858B83AA9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:34:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f76a4c211dso1818618e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686958445; x=1689550445;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thTv8orjTj3rjjXkddkM+NogwSthGgo/+4qcsYu5RUI=;
        b=FmoL8wERgQkwYfwVf4kHsRx3CcODu6oAR5CeUDknYKkblcTnYzOAG9CfXEikSGhdOh
         riTzGiE3l0YnC3aLbN6mvidnbBiTTMGR32Eabdiey4XcYgMcvH6D5BGNGMuglachqrAi
         gRZgHYMclM1Jpwnz8MHpU89n47NtxXgBhzPoQKNBJKBDLcS9Z+PBuCRA0nRZH9sCrRNE
         CNx70q5o8OFWKldie0zUxyX6YTZBzGJI8jlgjvbn65uhf1/UZnz5frIjrZj/OEO/m8SE
         RoQm5LXylLkSeTxjJRAmsaksis0VezvygMxmlgAbOHGYhHDy8/gmkOtFQdz4y5buWZyB
         Oh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686958445; x=1689550445;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thTv8orjTj3rjjXkddkM+NogwSthGgo/+4qcsYu5RUI=;
        b=SmGTThcicvXNmVbY0lZ+vAZN/7JFRuM51z5SW4JCodvpf0K4iGcpilNgKSxxefNhKJ
         JgsoQf7zojRBboLqq5gp2wAMpvm72pHuqyHkT6h1yy2fzMz8hXqkd9YJcOBKL7PQZ/3F
         iM9hPFYJmI9QQje4iEMawXpTIjUZibfyTvr6RCLqOciAhl7MGmcw0ZCNyIb6B7/B3eLr
         pahp7OqvAL/IvmSkMxEZj8syBoBm7LtqlYOdDkaZhAohiElwuNZIwwoCHyVJr8MZs7KI
         l78Hx+IO7ZcG5LXVywkMqEFKqnO1T/Bqhqg0oUl3SfpxwN40aPlRmcj9vHXSs+jJpK2N
         f+tg==
X-Gm-Message-State: AC+VfDzATBfeBCmgGspNOxB9w/wiR+ghZDLb7V6rvBLq6pMDcJucoIvb
        GKtcEEM/KmlrSkzxCQytvDtxVA==
X-Google-Smtp-Source: ACHHUZ57O35MzBG/45b0nqSMEzO2aDumAZsZrX+yQXAV33NfUTrv8wRsaolp8zlQZnQIOtJbKcBGAw==
X-Received: by 2002:a19:6457:0:b0:4f8:5604:4b50 with SMTP id b23-20020a196457000000b004f856044b50mr2558256lfj.64.1686958444743;
        Fri, 16 Jun 2023 16:34:04 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id p23-20020a19f017000000b004edc9da63bdsm708640lfc.160.2023.06.16.16.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 16:34:04 -0700 (PDT)
Message-ID: <2e1df73c-c23e-8ed0-f766-cd2accab02bb@linaro.org>
Date:   Sat, 17 Jun 2023 01:34:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: correct crypto unit address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230616174955.1783652-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230616174955.1783652-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.2023 19:49, Krzysztof Kozlowski wrote:
> Crypto node unit address should match reg.
> 
> Fixes: b92b0d2f7582 ("arm64: dts: qcom: sm8450: add crypto nodes")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 5cd7296c7660..1c71c0a2cd81 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -4212,7 +4212,7 @@ cryptobam: dma-controller@1dc4000 {
>  				 <&apps_smmu 0x59f 0x0>;
>  		};
>  
> -		crypto: crypto@1de0000 {
> +		crypto: crypto@1dfa000 {
>  			compatible = "qcom,sm8450-qce", "qcom,sm8150-qce", "qcom,qce";
>  			reg = <0 0x01dfa000 0 0x6000>;
>  			dmas = <&cryptobam 4>, <&cryptobam 5>;
