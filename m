Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E250867822F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjAWQvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjAWQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:51:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EF72CC69
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:51:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v13so15289710eda.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFIft8S32BmFZKXY5TvNYqQs4sV2+M7z/vCsuLNDIQE=;
        b=pM4MCpPZ58vBoPT5SaN7QWcijJhXPym6TiFxQeHTPGWJ7oVF6196AL0E2oFMBnTBWv
         UEABa6ZOXpI3n4hhk2g9xHy424c10v73x30XC3JTnQHYxVQ0a9NEKgPahnWVs2Jajq3q
         uPokLboxZrVWSzy1if8wyka+clN99G4TBYhYrEtPfRDVRKuYBzjpkgfAY1CAhkue3mdQ
         5AtyGSvtvc9h38hQOoTooh42TFAwHD44LGcbs6zwf1AigZDs0tErfJ256nEwxFX83RLW
         SHy4LtYUw+bOmgM4rRAzQwPY/y0++X4epXLza3zzaSFWEXGDx8XEeLNcNz2ltecfaNYt
         8qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFIft8S32BmFZKXY5TvNYqQs4sV2+M7z/vCsuLNDIQE=;
        b=yE5M0PNzlRsaMerd7ygC62qM89irI4lqHv2NUiHJs8anMyfVCgcMC/JqdJmXF3H309
         6kOeg/RllEWMkYezS1yyNGewveJvBjdtcjpjRXKQBUOC0+uPhZ1fB0OYrVkm+bttakvi
         fjRJylbkDIkgNrbfaHu5ludLrCRDp9RNJblV/Qwomf+H1YUk3QCu+9wT3bnngTxDGwfl
         x1JRQgOktdKBKuKk12cJuMy4qVCMHZqJigRTks0cffggVomxeePttY7HQD3neW4mwj/6
         VRYwXGHy14X4n2+woiHedxLX0T3cWzA3+o73arZ55H+/t4HNHP5NczbEiSablkNTiG1H
         We2w==
X-Gm-Message-State: AFqh2kpK/wPikEWXjubxBxNCGqDpCGqx+QnucwfnzgMLWYW9tWBrNxim
        Mckpz1N4IuKpSmU9OgyrZ+n5Tg==
X-Google-Smtp-Source: AMrXdXv5E+oOzXqjXTpRxirJ47TSsNWS2CN2ScOVvs+G5nw1KdES0FIdpKuXaVeAJyIRrcFsuq3e4w==
X-Received: by 2002:aa7:c393:0:b0:49e:6887:9f88 with SMTP id k19-20020aa7c393000000b0049e68879f88mr17844573edq.29.1674492661547;
        Mon, 23 Jan 2023 08:51:01 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id r25-20020a50aad9000000b0049f29a7c0d6sm80220edc.34.2023.01.23.08.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:51:01 -0800 (PST)
Message-ID: <22746282-3029-8451-bd3d-9aacc4112eb7@linaro.org>
Date:   Mon, 23 Jan 2023 17:50:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 1/3] clk: qcom: smd: Add XO RPM clocks for
 MSM8226/MSM8974
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20230121192540.9177-1-rayyan@ansari.sh>
 <20230121192540.9177-2-rayyan@ansari.sh>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230121192540.9177-2-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.01.2023 20:25, Rayyan Ansari wrote:
> Add the XO and XO_A clocks to the MSM8974 clock list, which is also
> used on MSM8226.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/clk/qcom/clk-smd-rpm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index 6f23ca4828f4..31f6de13d156 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -610,6 +610,8 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8936 = {
>  };
>  
>  static struct clk_smd_rpm *msm8974_clks[] = {
> +	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
> +	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
>  	[RPM_SMD_PNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
>  	[RPM_SMD_PNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
>  	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
