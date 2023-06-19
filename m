Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71702735842
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjFSNPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjFSNPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:15:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30B5AF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:15:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so20387e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687180507; x=1689772507;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3Nv7B3Qg3Xe973droWZwY/lOIiMV+BRI3szL7iuJqg=;
        b=k8Ihk7GciJxHk5NVOG/EiKexz9l/a/J2Ud7WvDZe9pu2g1E+Pi1vz569r1TajCx/Go
         FVZbjdaaWUwCtTMe+6sCMBjpKo4MZvu3yfIXgwHf56ZU2e8FcVm4UtgqEt1WHzC9SS4z
         y2u9tlWx+FvE0GCxhWtQfCCLsvN0phZp8v/vexQbJHJMiKTCV0ko1aQBGsqaxyWy6nrV
         2TwVechmXvo8p2gaUqBwVwIC+RDf6xZxE+X/o5TPXEoTLVWVVWp53eUvKWXqYjH3Tu+O
         sFrr4EZu6laRh+qS0WBJ6pbKt0yElaxq9n7GCbb4RE2b+qNyhiww/NLEEyx59gHYG3KX
         bTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180507; x=1689772507;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3Nv7B3Qg3Xe973droWZwY/lOIiMV+BRI3szL7iuJqg=;
        b=Gjxk+v4vRVOvlMrseFLJsEDIVtcz1ipQhDmjL/xw9uYtanfTgxXpTvEQuneFZHnA5v
         Gu4nmOKa/lCEDVVR5Fpu4Utoj7AOiXg6YUr3Od+zTPHPBR1kYl4G8UhsHf5wavgmblqy
         hstvHoGfItHaRccndW/Fi644IRnBmxkj1Qrdv/SvAjtQpjYMM7HrSNpWrRWGHVRMDO3M
         vr90R2yt/jdcMx2ikcNGFrdAmOMCTyfx/uxlqj5jaZ7dHNR6t/S6ar1NKxCfl//6zCtO
         dxmuwHjypnynC1Tgw0yUnQRDEW3lHgZRU4BXPF3f/mtYJV2wrxmzpAzRf4kVueTCLdb0
         r2Fw==
X-Gm-Message-State: AC+VfDyHzFTZVZtQVcy8SrrUhM87sAk/Sw6kVhzP3iyXHiSmuVV3rPyY
        fihTe6IRyRhbQ5GrHifXHi1dvFwRq5xMaBkCXJ0=
X-Google-Smtp-Source: ACHHUZ74Q9+sEkd+kU8ffIrcv/w0txQxTg2j3GBTh9jTgDieC1mJMYFSQ3oXDkAIbrjqPrT2JW4+YQ==
X-Received: by 2002:a19:4302:0:b0:4f8:6ac4:85 with SMTP id q2-20020a194302000000b004f86ac40085mr1846321lfa.19.1687180507266;
        Mon, 19 Jun 2023 06:15:07 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id d14-20020ac2544e000000b004f2532cfbc1sm1339713lfn.81.2023.06.19.06.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:15:06 -0700 (PDT)
Message-ID: <22492cdc-8dc1-4c61-f07d-2788c15ab384@linaro.org>
Date:   Mon, 19 Jun 2023 15:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 12/15] arm64: dts: qcom: sc8180x-flex-5g: correct panel
 ports
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
 <20230617171541.286957-12-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230617171541.286957-12-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.2023 19:15, Krzysztof Kozlowski wrote:
> Panel takes only one port:
> 
>   sc8180x-lenovo-flex-5g.dtb: panel: 'ports' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> index b12e0a61b3c0..39c6ef0802aa 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> @@ -298,11 +298,9 @@ panel {
>  
>  			backlight = <&backlight>;
>  
> -			ports {
> -				port {
> -					auo_b140han06_in: endpoint {
> -						remote-endpoint = <&mdss_edp_out>;
> -					};
> +			port {
> +				auo_b140han06_in: endpoint {
> +					remote-endpoint = <&mdss_edp_out>;
>  				};
>  			};
>  		};
