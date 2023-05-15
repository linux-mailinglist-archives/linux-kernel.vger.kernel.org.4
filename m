Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A868703209
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbjEOP6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242204AbjEOP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:58:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4693A10C3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:58:03 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f49bf0223cso60198525e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684166281; x=1686758281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYtOy4X/SWVzvtmwiAJl8YrjSQxYxSnNOPbDK5E9sfc=;
        b=hI5KlthvwUnK0xWgSyEOI4NK8WuvC+Hxg3TQLRZXd74eSuJggTd0LIdtnEFxPUWF55
         8On504gwd5R8T+8GLpXUceeM3WkPu2h7raFdEiuFoW8q0IhXdX4LUgMEr+zOhKX7EuMZ
         2zMRXjsmY/zliq7uiwwpvP7L8cCM4UI8pAFILWdKERDJrBrDt8iqMMagrxHOfvm7E2CI
         7Ft425F6hTJTOxBVjwHwrDRa3wO95YapeTLVOZkRIG8gm0n7kPj3KP+PryqhdMpz6zsh
         CI8VH/r7QKiFBCArIBp7cncz8CXPZxivMm7gQkP6q+C4v2jXH7ZNQK3FO6+2OyFNcsio
         /M5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684166281; x=1686758281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYtOy4X/SWVzvtmwiAJl8YrjSQxYxSnNOPbDK5E9sfc=;
        b=ZIEctHoKhCCHahy3aQAkk4D8xbNCIxlFM/rFm3LQdjXrnw75kq7QfqEMHbygEr91Wb
         2dQGdC1/B53AlLoM833jP1wfCQx6cMHMxMgVQlekodPw9zVgFAJvmiesFmLF7oMJao+o
         eFiGgkfIc9x99VOwyzx/It1H0+2DECjgBPyJseqdYpWo8HyXThnHcNqFN/gD4cjOuGAe
         HZJRFBKLr+gUQJ7sgwBerYMTNE5dnYsSQglAqhA8mvhJVLUb+HR1w+t26JGwjNlY0mIj
         M2lukLgt6+OiY5J+JZyJSKE3Wa+IojuefHDA58tNN0uGOMxHu3bBto/Tx2dbSETUsWsM
         WMUw==
X-Gm-Message-State: AC+VfDx2vJpQn41QPO09PgVZgrTzuT1QHjhuqlG57Bhrqp4SgQVFsqjG
        NZBuN8WzDkM4qzzdiJPIH3FIT4hkH5RFHAkNrAQ8iQ==
X-Google-Smtp-Source: ACHHUZ6LGBi+JJJTo0FxjkmBflSLX3OI2MNzvwlnqVBh4HuhgaI0WcfGQkU27sgsWtHHwpeAVSZLQg==
X-Received: by 2002:a05:600c:2055:b0:3f1:806a:83d5 with SMTP id p21-20020a05600c205500b003f1806a83d5mr22140786wmg.20.1684166281603;
        Mon, 15 May 2023 08:58:01 -0700 (PDT)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003f32f013c3csm37540400wmh.6.2023.05.15.08.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 08:58:01 -0700 (PDT)
Message-ID: <fd4276f6-f54b-3455-1263-8a8d534f0bda@linaro.org>
Date:   Mon, 15 May 2023 15:57:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/5] arm64: dts: qcom: qrb4210-rb2: Enable display out
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
 <20230515-topic-rb2-bits-v1-2-a52d154a639d@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230515-topic-rb2-bits-v1-2-a52d154a639d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/05/2023 13:04, Konrad Dybcio wrote:
> The RB2 has a HDMI output via an LT9611UXC bridge. Set it up.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 88 +++++++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> index 80c6b59c8ff6..9b539720f05d 100644
> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts

[...]
> @@ -312,11 +385,24 @@ &sleep_clk {
>  };
>  
>  &tlmm {
> -	gpio-reserved-ranges = <37 5>, <43 2>, <47 1>,
> +	gpio-reserved-ranges = <43 2>, <47 1>,

Is this intentional?
>  			       <49 1>, <52 1>, <54 1>,
>  			       <56 3>, <61 2>, <64 1>,
>  			       <68 1>, <72 8>, <96 1>;
>  
> +	lt9611_rst_pin: lt9611-rst-state {
> +		pins = "gpio41";
> +		function = "gpio";
> +		input-disable;
> +		output-high;
> +	};
> +
> +	lt9611_irq_pin: lt9611-irq-state {
> +		pins = "gpio46";
> +		function = "gpio";
> +		bias-disable;
> +	};
> +
>  	sdc2_card_det_n: sd-card-det-n-state {
>  		pins = "gpio88";
>  		function = "gpio";
> 

-- 
Kind Regards,
Caleb (they/them)
