Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE516569CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiL0LTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiL0LS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:18:59 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE610B6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:18:43 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u12so9754152ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPeeDfdfuwD5pOgpo7qdoUyt0/sniOKcvtKlYeNVOaw=;
        b=ikOuYl+/gxxSWz7l/rs1bdCdgLc+iJmSJ4MetmWFSyfW9ZP2D5mTuLpGotfus0QCCu
         VXPsT+KxXlZcpCeMBVz7ug5UVrGcs7E1W7ei34NghSK9y+ong6E8dDjUq0BaPAbJBo1I
         M6rWrT7k5FU55cN4vkYzZ8YAh/dOuHjIBhj7Ts2SGBhVHjl6hHgwjWD7v8n4Cwz4hxuo
         eA51zB4WejzYMM2Y6ZLPvA8ou7sELuJZmxI8BksmrqJayh3kpO+JgXJR/pIi61HHU0C3
         yTEY2RG0FDzh4nrahb3LihH60dQgG8OEHuHXH60Yd0MIuDvtzmcCyPRM2fg0UOzQ4eL/
         lKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPeeDfdfuwD5pOgpo7qdoUyt0/sniOKcvtKlYeNVOaw=;
        b=v12n3mCTo1dtKf7qfrQXQfJF4pTzUnP8N08U9MFL0grdI3zGHckMgvaL8EYykH1MXi
         cGL8oyfatucTBf/2ETb4y75BEbpl6lJjmsc+uUVoekds3npchROFADaSwpN3XFk+q3tR
         NGEj7/o6kQ5JYFHM8oSbnHuVeXC/683FVBIHtZzJS2uRWV0WF/as1uUlNr1qoPM+mbw0
         6q30sM/+7MAirGy2BGy6av7zWH8Bh6BwJewUVT7Ei4Bmuxykn8zh+4S8sYWdg6cPBvBw
         ZLufvLkrkpsuJnNQpRWRG0itqx3Kx5M0MGWxQrlYe3Lwhb5Ol0sHljvQA+igDr79SiZy
         /v0w==
X-Gm-Message-State: AFqh2kr/aD5EdZXL5dtUlYcPl8gsLMWieMcWr16cYUuLC9zhAolAG6c4
        zPIEhrD9gjfkY8NvOe1VA0sexg==
X-Google-Smtp-Source: AMrXdXt0hMBh9s+sHYJniksksYK2O5SUKbZJxFtVSXHLdkC0rlutCpUWxFHQieFiQurwxFw3JO6yDw==
X-Received: by 2002:a05:651c:1685:b0:27a:cd8:dcf with SMTP id bd5-20020a05651c168500b0027a0cd80dcfmr5366980ljb.39.1672139921658;
        Tue, 27 Dec 2022 03:18:41 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id z3-20020a05651c022300b0027f94a09cb4sm1574153ljn.135.2022.12.27.03.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 03:18:41 -0800 (PST)
Message-ID: <0b4c7758-2272-5bd2-cf59-43c9e3b3f09a@linaro.org>
Date:   Tue, 27 Dec 2022 12:18:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm8250: drop unused clock-frequency
 from wsa-macro
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221225115844.55126-1-krzysztof.kozlowski@linaro.org>
 <20221225115844.55126-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221225115844.55126-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.12.2022 12:58, Krzysztof Kozlowski wrote:
> Neither qcom,sm8250-lpass-wsa-macro bindings nor the driver use
> "clock-frequency" property.
> 
>   sm8250-hdk.dtb: codec@3240000: Unevaluated properties are not allowed ('clock-frequency' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 434e2c4cce79..a58f51083715 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2215,7 +2215,6 @@ wsamacro: codec@3240000 {
>  			clock-names = "mclk", "npl", "macro", "dcodec", "va", "fsgen";
>  
>  			#clock-cells = <0>;
> -			clock-frequency = <9600000>;
>  			clock-output-names = "mclk";
>  			#sound-dai-cells = <1>;
>  
