Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22207042E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEPB1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjEPB1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:27:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615696A6B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:27:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f00d41df22so1409543e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684200467; x=1686792467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTgYLuA9A9QIzBfKyR+OtnbBepNacp9tevci+hgaznc=;
        b=noAYfQQpLyERkrCP3s8F1J1fUiP9Uup6GoUEmR6hUfaOSQmH3G1PXJCPTggI+aGCxJ
         0wfH9TOYDUMEDjAWBxFqbWVqRkK0GaR4ZRHLGdbiU5FWGx1SrvL58AThoZQYW9yWbkLg
         gCUKR/jgb4Rve8GVQNLsRZVcYjQQ7untlIwHqxhqILKJVEeT92JXZM1Yc8Qdd99IUHOP
         klSCyPyvhjufMDKnauW+ycDyqiiCjbCan0WOalKO/NRAvPN7dLlDQH8JAcFxN/qqQYYP
         SUPYakbKyFuxNyMI9E0Qi6xtOxd40QP9+VO41befRPl8EdPBjzBK483rLhuxgP0AF1pg
         C8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200467; x=1686792467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTgYLuA9A9QIzBfKyR+OtnbBepNacp9tevci+hgaznc=;
        b=DtIVxeYFE0izSg4i9gEHWFSATVKzvpnyXVLY/7ozKq0tBvM9lTcCEMmWeUfN01kE13
         KNt0UHNGx64MY/+74DDRphX33s27GdSLLYb88LpWoXheDHWkTxACkZeJfHr6aFL0e0DB
         E3AvDVPX33mjNFVhOZTDJ9eaH4QPEFOFo1Sv7b2Npe1gpp2LSwE/YSsmW9MzDkvvXBHx
         ZCrLuvnIo5TvkwasIfQ5F99R8lsgOj26JiKcLnuz9QLSOakVNB8SSpOhZMeDmlqMzx1Q
         0Cv98RDLk5hNlMFhe8LTNecH3W0lPT0ZXpqEl87HlLK4MKn9+owkxFIjl2vh65g2Oiyj
         tpvg==
X-Gm-Message-State: AC+VfDyCKRKhcFLQSsZKmchcpeTT3I7XlQsXSocaBXCeWMmsbMTqQ8TU
        LRXgjv7EBkdde2A1SWNPiMKdUg==
X-Google-Smtp-Source: ACHHUZ7nMJtjojvQzwCdIe3knUwEEfaDB0GS1SyGPCOamQAeFXTLFmH/VkF9R1kKZSwHaFjA999A1Q==
X-Received: by 2002:a05:6512:3990:b0:4ef:ef1d:a987 with SMTP id j16-20020a056512399000b004efef1da987mr6746251lfu.25.1684200467628;
        Mon, 15 May 2023 18:27:47 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id n2-20020a195502000000b004f3789c8bd5sm1079540lfe.132.2023.05.15.18.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:27:47 -0700 (PDT)
Message-ID: <20bd79c1-6c38-f1ed-1661-6fa4c308c5c5@linaro.org>
Date:   Tue, 16 May 2023 03:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] clk: qcom: smd-rpm: conditionally enable scaling before
 doing handover
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230506-rpmcc-scaling-handover-v1-1-374338a8dfd9@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230506-rpmcc-scaling-handover-v1-1-374338a8dfd9@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.05.2023 22:10, Luca Weiss wrote:
> On older platforms like msm8226, msm8974 and msm8916 the driver in the
> downstream kernel enables scaling first before doing the handover of the
> clocks.
> 
> While this normally doesn't seem to cause noticeable problems, on
> apq8026-asus-sparrow this causes the device to immediately reboot,
> perhaps due to older rpm firmware that becomes unhappy.
> 
> On newer platforms the order has swapped and enabling scaling is done
> after the handover, so let's introduce this behavior only conditionally
> for msm8226 and msm8974 for now.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Did you give this a spin on some 8974? I think hammerhead had
issues around rpmcc in the past..

Konrad
>  drivers/clk/qcom/clk-smd-rpm.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index 887b945a6fb7..6d5476afc4d1 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -178,6 +178,7 @@ struct clk_smd_rpm_req {
>  struct rpm_smd_clk_desc {
>  	struct clk_smd_rpm **clks;
>  	size_t num_clks;
> +	bool scaling_before_handover;
>  };
>  
>  static DEFINE_MUTEX(rpm_smd_clk_lock);
> @@ -693,6 +694,7 @@ static struct clk_smd_rpm *msm8974_clks[] = {
>  static const struct rpm_smd_clk_desc rpm_clk_msm8974 = {
>  	.clks = msm8974_clks,
>  	.num_clks = ARRAY_SIZE(msm8974_clks),
> +	.scaling_before_handover = true,
>  };
>  
>  static struct clk_smd_rpm *msm8976_clks[] = {
> @@ -1318,6 +1320,12 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
>  	rpm_smd_clks = desc->clks;
>  	num_clks = desc->num_clks;
>  
> +	if (desc->scaling_before_handover) {
> +		ret = clk_smd_rpm_enable_scaling(rpm);
> +		if (ret)
> +			goto err;
> +	}
> +
>  	for (i = 0; i < num_clks; i++) {
>  		if (!rpm_smd_clks[i])
>  			continue;
> @@ -1329,9 +1337,11 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
>  			goto err;
>  	}
>  
> -	ret = clk_smd_rpm_enable_scaling(rpm);
> -	if (ret)
> -		goto err;
> +	if (!desc->scaling_before_handover) {
> +		ret = clk_smd_rpm_enable_scaling(rpm);
> +		if (ret)
> +			goto err;
> +	}
>  
>  	for (i = 0; i < num_clks; i++) {
>  		if (!rpm_smd_clks[i])
> 
> ---
> base-commit: dd9e11d6477a52ede9ebe575c83285e79e823889
> change-id: 20230506-rpmcc-scaling-handover-a63029ed9d13
> 
> Best regards,
