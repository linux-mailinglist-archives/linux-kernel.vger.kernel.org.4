Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6E6B1372
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCHU6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCHU6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:58:47 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8D98C83D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:58:45 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f18so23021131lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 12:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678309124;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNJiJRqzTIJmEZGIdAoWu3k4M01PZusme6WbXOwMXeU=;
        b=s2qIda+Ogt9+xzbriwpMjHJZyITeYygTX8UZbSnQcMAvlzbnQE+F6r+98c9l0ATB9j
         GATbrKf284ZP/7TYJbqjVKgChQwuiiEY82tNaUYBksKBzs+PxMcV1G/KlHWedTgDVKn/
         nMcvfVFn2DIGBDYxxqRlAdN5cQ1pnjMwa5FrPwaWfppR1JUafs+X5J8b+GVBd4fv7BQm
         veLJaJMzhTIYtJR+lEp3GtMDQXEw9Win8tvDv7dGnH9yooEhua3Jl1FIMD+2BVgjHNdo
         qbjHmLxFTqTKfLf8lobJXPGFA9S2kNzqRh4O7iSijU3q0BYxOpSbeUskTvR5cjb7FwWv
         wYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678309124;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNJiJRqzTIJmEZGIdAoWu3k4M01PZusme6WbXOwMXeU=;
        b=G/xh0jqdrB4dslCz0hiZcDjmd5bPCmZtXggBTMQVUojlUEDlIh+S87UzxvmcEzkVWA
         KEwXi06tLjgjA7zEOnR8U3UR7F1abC7A0bemTlpeZa62Ox+VO2lrwbdiD7r7VHERZsEA
         0UgOk1gtKtSIe98KnV0fYk9AwRVl2G7G6fQtT6IexVISscAG/GaKfBZCkR8Uc45nu5R0
         HQ+6xtzmqRhYRnwp/L5T3RbkRPDIZQc60qPYjoLKada0YVPSUVRhlSgf/SuYhOTaXlyB
         4F7blMq4pvYtcgYLQ2kmDK/X8HR+OkjcBlEv7wG7T32Q5J4wewbeUQGMwV0KoMzk4wJQ
         c1NQ==
X-Gm-Message-State: AO0yUKVQ7CvLdreqsuWncYM5+oYun49k24fzMv9ge9UytNhS+ZjqkI22
        hRSZ+WNEMyDa1sQeXVFnU+z5UQ==
X-Google-Smtp-Source: AK7set801/CtXpPx1Z9upNz1VTWuexNLTuuutWkKmfXN/t0hFJPIRYY7dwhJWUFLtc2A04pLrzZOAg==
X-Received: by 2002:ac2:46e5:0:b0:4db:3e31:20fa with SMTP id q5-20020ac246e5000000b004db3e3120famr5515822lfo.53.1678309124067;
        Wed, 08 Mar 2023 12:58:44 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id t5-20020ac25485000000b004dc4b0a0543sm2441721lfk.58.2023.03.08.12.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 12:58:43 -0800 (PST)
Message-ID: <2563238d-b480-1717-4afa-dba52159508b@linaro.org>
Date:   Wed, 8 Mar 2023 21:58:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8450-hdk: align WCD9385 reset pin
 with downstream config
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308183317.559253-1-krzysztof.kozlowski@linaro.org>
 <20230308183317.559253-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230308183317.559253-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.03.2023 19:33, Krzysztof Kozlowski wrote:
> Downstream DTS uses 16 mA drive strength for the WCD9385 audio codec
> RESET_N reset pin.  It also pulls the pin down in shutdown mode, thus it
> is more like a shutdown pin, not a reset.  Use the same settings here
> for HDK8450 and keep the WCD9385 by default in powered off (so pin as
> low).  Align the name of pin configuration node with other pins in the
> DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index 9cd1d1bd86cb..4020e54e16f5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -767,9 +767,11 @@ spkr_2_sd_n_active: spkr-2-sd-n-active-state {
>  		output-low;
>  	};
>  
> -	wcd_default: wcd-default-state {
> +	wcd_default: wcd-reset-n-active-state {
>  		pins = "gpio43";
>  		function = "gpio";
> +		drive-strength = <16>;
>  		bias-disable;
> +		output-low;
>  	};
>  };
