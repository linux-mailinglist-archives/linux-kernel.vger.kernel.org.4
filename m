Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECE36B3406
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCJCI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCJCIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:08:53 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1EEFAD57
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 18:08:52 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j11so4743838lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 18:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678414130;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNebAFc/OVjCS4NYNisA6Hl/ajEXWUl72HEvVLWLC7Y=;
        b=VT/rVOK5YHM/n9rhLxP2gV6vMw9yltQDUDDeZoWWjWqwrPSfYA1q8Tqr8ITEKl94Qm
         F10M2Pr2tTWwWMNUHRAwBocEh3vtx0bZn6JFWiQ8q7I9f0dGiYW2aAR2TXYWcYRKctzB
         NXcAswjT7BEUbdB87oxx5Z1jkZM7A8hdDFGUsOexyyG8/ZdtMXehfMS8pluemssI2y4Y
         nOawnYNfC35DziEXFmfN8xsjxszmFCW4vRN0uHIRzzLNfVjOy99SvFuV+p5WszV6AeoV
         xEOJYIlKHrdlP4jjWsJ/3XsF2M1rLmes93ZA68MmzK/YX+M25tbue7Aacj7mlgpTWHdx
         lDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678414130;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNebAFc/OVjCS4NYNisA6Hl/ajEXWUl72HEvVLWLC7Y=;
        b=YVI6TcYY9ZcDye93aqt84z0/uLuvTI88qLMAv6wJ9k+cCethlb8H8XIab/XmQAG8gL
         R+Q03Ek7q3fFuWKRWifjeRiEjwSl0YkuNoN3Yxri26AmBwtYKqtmnfRqdRlbhQPtvGYx
         S5Zsy39v1cqnW5CcCACPBd+wphczTthc5dKnZV8+iktwk21ge6+5eKwe0ju6Yqup5+ru
         CV3R+MFqN4I8Gb8SMxadawjqcdGdf4rfY/On0xIfWyBhE0Ic2HeJytUDh+DOJKCgWzAS
         XdQ6QpZuOfC+rNcIMX/OG/tuEfprTkvTi8ZrZctqyqh53iNuMuV0vzoku+m4hChV6Wv/
         Kl7A==
X-Gm-Message-State: AO0yUKXDxTbQrMs9/tdBG+KWG0d8LkTwjp5IMjrYvMfBgLKYeo+pmVCs
        idRIM2IkAwWgBddru+xBW3svXg==
X-Google-Smtp-Source: AK7set9YbQOYtZLPwJfvJodS4BJF9I9OC8HAsPOy1rlNikBThFm6bv5J02yx0u+u3eDbPP0sar9Xtg==
X-Received: by 2002:a05:6512:902:b0:4b6:fddc:1fcd with SMTP id e2-20020a056512090200b004b6fddc1fcdmr196031lft.23.1678414130580;
        Thu, 09 Mar 2023 18:08:50 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id z10-20020ac25dea000000b004db297957e8sm87347lfq.305.2023.03.09.18.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 18:08:50 -0800 (PST)
Message-ID: <7e50790e-5b2d-4c5f-7a31-de71fa6cc967@linaro.org>
Date:   Fri, 10 Mar 2023 03:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] pinctrl: qcom: lpass-lpi: use consistent name for
 "group" variable
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230309154949.658380-1-krzysztof.kozlowski@linaro.org>
 <20230309154949.658380-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230309154949.658380-2-krzysztof.kozlowski@linaro.org>
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



On 9.03.2023 16:49, Krzysztof Kozlowski wrote:
> The set_mux callback in SoC TLMM driver (pinctrl-msm.c) uses "group",
> not "group_num" for the number of the pin group.  Other places of
> lpass-lpi also use "group", so let's be consistent for code readability.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> index 27fc8b671954..bd32556d75a5 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> @@ -84,10 +84,10 @@ static int lpi_gpio_get_function_groups(struct pinctrl_dev *pctldev,
>  }
>  
>  static int lpi_gpio_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
> -			    unsigned int group_num)
> +			    unsigned int group)
>  {
>  	struct lpi_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> -	const struct lpi_pingroup *g = &pctrl->data->groups[group_num];
> +	const struct lpi_pingroup *g = &pctrl->data->groups[group];
>  	u32 val;
>  	int i, pin = g->pin;
>  
