Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B430621DFB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiKHUrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiKHUr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:47:28 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E75163ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:47:27 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id t10so22962124ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH0kqwpxGIZYfxFpOcVNB2gb2+jLt3tA6OnKcaJzpJw=;
        b=LL6DhQeKueOBbZ0yrubELXYbG9bPM4jB+g3J6wp2AZiF0Ec7wh822/bdNIG2FlCVSr
         ZZVoRE50QEjtc268iTWooeNSE5nWjiUlAOyz1aPLWKw4Jn9MxZavtqZhoekuA5yzcw9+
         jplSY2C5WMO7lW1lK/0ncvZjCxyVLsPKNIjXY2bVcu5eQKa7VT8Nx1BCt90f21CWfEdp
         KtxIzZN9AhJWpPwZ/iLgdcpmDXc5TFJwOBElnl+fs0ROvU4DoVs+JIWeQ+GkHhqYoG/K
         3O9GZ64tm31dj30hx63slzfEg3hKDTl0WRlAw5UIXJxU+0e/+/StEBzdOsvtkNHsyaIU
         isPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WH0kqwpxGIZYfxFpOcVNB2gb2+jLt3tA6OnKcaJzpJw=;
        b=svTnyECrq0wl9K2SdRxHEac6MwWZ32V2yFS1KJOnLEx+TYlhEitMpYv80bSzG5J5Jp
         kkiTxvigk5Cel2lLVnCwqr9ps5saHp5x6BdEkbYduO9pA2jPQIXKzcvmt+l6SKdE/Vl/
         RnzqlOAZbHiPEL2wZ8/fxrfiiFC5Pm9qqBd0NzDZnksevPLx3ON6uCtaLJsJtt9MWhGk
         B3k2F8XsBbWLpi4RbKB3HRJ1ubdYDWnm14GLCQY24e85NAUjg/lLg6luHK13WFA6Uh1g
         pTqNP66z79xkwUIKxhinZyHfJcydU/4MGCMivKpp/ZLNz7VAsD9iTo5xCTyxl2osJLVe
         S+uA==
X-Gm-Message-State: ACrzQf07TAuQM1dCbnA0WIwEmXADZbpyGv2EfPTmXh6T9znHlNTJPbeI
        IOIhre/DvU/X8h6IYla2OOn/tg==
X-Google-Smtp-Source: AMsMyM6WchxytjU83P1mNKppO4lxP/cfuiEpegw2PhzeLuNkIqtJuWOB+GSEATPdCX7+GwDNlIMbCw==
X-Received: by 2002:a05:651c:30b:b0:277:6cc:c6ae with SMTP id a11-20020a05651c030b00b0027706ccc6aemr18907935ljp.179.1667940445769;
        Tue, 08 Nov 2022 12:47:25 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id w20-20020a05651c119400b0026c4c1a0b4dsm1856127ljo.126.2022.11.08.12.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 12:47:25 -0800 (PST)
Message-ID: <11d29754-3e36-895b-e791-2c2f88c6dbed@linaro.org>
Date:   Tue, 8 Nov 2022 21:47:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] arm64: dts: qcom: sc7280-idp: don't modify &ipa twice
To:     Alex Elder <elder@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        agross@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221108201625.1220919-1-elder@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221108201625.1220919-1-elder@linaro.org>
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



On 08/11/2022 21:16, Alex Elder wrote:
> In "sc7280-idp.dts", the IPA node is modified after being defined.
> However that file includes "sc7280-idp.dtsi", which also modifies
> the IPA node (in the same way).  This only needs to be done in
> "sc7280-idp.dtsi".
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/sc7280-idp.dts | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index 7559164cdda08..9ddfdfdd354ee 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -61,11 +61,6 @@ &bluetooth {
>   	vddio-supply = <&vreg_l19b_1p8>;
>   };
>   
> -&ipa {
> -	status = "okay";
> -	modem-init;
> -};
> -
>   &pmk8350_rtc {
>   	status = "okay";
>   };
