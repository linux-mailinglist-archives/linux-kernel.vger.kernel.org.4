Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2DB6ABD85
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCFK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCFK6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:58:11 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1403525B94
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:58:07 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id t14so9155787ljd.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678100285;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPfq8uiSYsCyujDvSAsxGR3w/X00qYYVFRW1cWy6Eok=;
        b=PQZtZqB/fO/xawC9lR5Lt2q91cGUSS0qbab+YmNBPfJbIokavqDWS6kyvlHZOx1y0B
         t1HHF+g5Z4VuLT8m9KuSL91Zv8oSUtVNZ/2s4da99p/NDwktFf9v5tPGeMq3u3uwdORm
         hwy6e+mTS+kxTvtM45mA4t0PRuDSMrTtVe7KG3jwZpiLnRmaCdAuUG3/TOfICAlRVpgA
         1BNZS6Z7+HW3XK0G3wyoY719WVdvIKpB4iXH5Q5t8e7GVdqsjN/zpWI0oP4PEROwJY0M
         IKLSx+p8oYHtIVOA+qIThaUvWDEdYwWsWRdt1rAUOZ7NaOAQDFvYbwNwuGNKm7Gm9yxz
         mfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678100285;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPfq8uiSYsCyujDvSAsxGR3w/X00qYYVFRW1cWy6Eok=;
        b=OVluIqBnToS6gzHSxj4OxUau0rUzwlRVViJY9KRVq0MR2GUPgD5elR3hpmQlLbsOGX
         waSVgEZAumYKh8RBzauAWbq1PYqS7KK6L7ubXktLDzBFS9SVNcyX4gsOuozVUYbXjRfn
         +PGWSQjRni7wgXWU6Nk3D+Qn/OqtlgGhCDvTWCmVMJBFgWJFAbOLSgFkxy2YiI5q4EXL
         rvuManjPrn4NHdH+jkA0TXJQJQbsfAm35noOQr8t80SMrH7BAuTjhbVs2gPIMANK6My6
         XaYnxcDsVSaL9txW0v2ushSQP0KxSJnW5aN5qZEKMb/CSeeWrVKzEtcCxoc64CVbrUVj
         0DKQ==
X-Gm-Message-State: AO0yUKWjZA3vknAep2FIakoZtpa+mz0qHB80MOPwYc6gEWte7CHHPw8B
        GY+DMYKLTcQSu9DYSENXu6vUcQ==
X-Google-Smtp-Source: AK7set/4oWNIMlfteWmBuPP7rNvm1Ih9yjAW7OgZF5yGluuC0rFVIXJkOsIMlCbiLeufLIQ8JS5elA==
X-Received: by 2002:a2e:8853:0:b0:290:6533:42d4 with SMTP id z19-20020a2e8853000000b00290653342d4mr3091537ljj.37.1678100285440;
        Mon, 06 Mar 2023 02:58:05 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id k6-20020a2e2406000000b002958bf18efcsm1600008ljk.104.2023.03.06.02.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 02:58:05 -0800 (PST)
Message-ID: <97ebdf2c-df51-ff4d-5702-4afbffcb425e@linaro.org>
Date:   Mon, 6 Mar 2023 11:58:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 07/11] arm64: dts: qcom: msm8953: correct RPMCC node name
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
 <20230305125954.209559-7-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230305125954.209559-7-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.03.2023 13:59, Krzysztof Kozlowski wrote:
> The bindings expect RPM clock controller subnode to be named
> 'clock-controller':
> 
>   msm8953-motorola-potter.dtb: smd: rpm:rpm-requests: 'rpmcc' does not match any of the regexes: '^regulators(-[01])?$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 610f3e3fc0c2..4e362b9012bd 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -269,7 +269,7 @@ rpm_requests: rpm-requests {
>  				compatible = "qcom,rpm-msm8953";
>  				qcom,smd-channels = "rpm_requests";
>  
> -				rpmcc: rpmcc {
> +				rpmcc: clock-controller {
>  					compatible = "qcom,rpmcc-msm8953", "qcom,rpmcc";
>  					clocks = <&xo_board>;
>  					clock-names = "xo";
