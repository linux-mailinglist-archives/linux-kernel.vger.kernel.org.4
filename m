Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34CA69ADAD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjBQOOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjBQOOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:14:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083286CA0D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 06:14:04 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id be32so1659290lfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 06:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYtCMx/kti0jpLx30V7iRToqe2dlKfo8PgV47Er9Snw=;
        b=uMmgk3jk5YihD4JseTRRVnUYVNjtimUEyzbCPwgpy1MFIUYeyGcYT+bLMfLRysoLHM
         3sn7t9eudbpljQID7T+ckb7lqmFk7S5W6ggfA0rIulpdzu7Vn+egyGi8hwPAKJHsJZ92
         USQ6WocfXD06707nhFid9xmueHGpm59H16YESvOBUxpKYTHqN8UKNxoyufXWm+NOvb1B
         ZUfO21vzm24ecyV0x20miNEx8i0mcrCJFLw/SKnoL8E4vmcIAuZavJvGoe2jwAAXv+rN
         c92dORpOVLL4vdZKTWHsOcnSnW6YE7YCK6AlNh+i17DRFkeXWE7G/duEQrYT2BivvrLf
         9qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYtCMx/kti0jpLx30V7iRToqe2dlKfo8PgV47Er9Snw=;
        b=ryeCukL8Dh+Zt4La9tQjUSB0bgXXJOnV/HqQdVFwkPpsmtB5WvMidQlq98hprangMX
         UR4XCLSEKKtEn4QuteZ8YgP5Q7p8YaFJDa8mtZXEV+o4pmHCmHCAxioosuE7Hxha0eSc
         GvrOeditgoeiyH5b9MHVZfkRgfB0CBHqOWop7MO4282M6CUB4k/uHDQHuWBAWrMiskSD
         U+4Uj8MdaliCrS9ryIlLT562zcY81fVGPqA3k0q4uK4/4vUi/hRgPYUjvc0E3pK/4YCg
         u5u80F04RZtF8WuOZ48dFvoxiRWpZYDkjb+Ar8NUN1X/oqDqCtfbq2GKLC4SpXzW7oPq
         q5YQ==
X-Gm-Message-State: AO0yUKV2xB2L3E+RV+fgIA4T22r5m4JKKEb4cQUm1USn+RgtxfGVMVPt
        cj1QYiBsX/Z7e8CPse6wyz2aoA==
X-Google-Smtp-Source: AK7set+svXre1fPN5AAKA8TPRXVWNEQ1Aqr05EubQA9KL9NoO35A//rxqj06+qBqcI2diF6uLlM6XA==
X-Received: by 2002:a19:c510:0:b0:4b5:2ef3:fd2a with SMTP id w16-20020a19c510000000b004b52ef3fd2amr690350lfe.47.1676643236489;
        Fri, 17 Feb 2023 06:13:56 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id q28-20020ac2511c000000b004dc4bb914c7sm694085lfb.201.2023.02.17.06.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 06:13:55 -0800 (PST)
Message-ID: <3bc2f33d-163c-1f26-1d05-e3056f852bcd@linaro.org>
Date:   Fri, 17 Feb 2023 15:13:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 2/5] clk: qcom: apss-ipq-pll: Enable APSS clock driver
 in IPQ9574
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dmitry.baryshkov@linaro.org, arnd@arndb.de,
        geert+renesas@glider.be, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com
References: <20230217134107.13946-1-quic_devipriy@quicinc.com>
 <20230217134107.13946-3-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230217134107.13946-3-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.02.2023 14:41, Devi Priya wrote:
The subject is.. weird.. something like:

clk: qcom: apss-ipq-pll: add support for IPQ9574

would have made more sense, as you're not enabling the clock
driver, and certainly not *in* the SoC.

> Add the compatible and configuration values
Generally the lines in commit messages should be broken at 70-75
chars, not 40.

> for A73 Huayra PLL found on IPQ9574
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Is Praveenkumar's last name "I"?

> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
Otherwise the code looks good, I think.

Konrad
>  Changes in V2:
> 	- Rebased the changes on the below series which refactors the
> 	  driver to accommodate Huayra & Stromer Plus PLLs
> 	  https://lore.kernel.org/linux-arm-msm/20230217083308.12017-2-quic_kathirav@quicinc.com/
> 	- Changed the hex value in ipq9574_pll_config to lowercase
> 	- Dropped the mailbox driver changes as ipq9574 mailbox is 
> 	  compatible with ipq6018
> 
>  drivers/clk/qcom/apss-ipq-pll.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index cf4f0d340cbf..ce28d882ee78 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -111,6 +111,18 @@ static const struct alpha_pll_config ipq8074_pll_config = {
>  	.test_ctl_hi_val = 0x4000,
>  };
>  
> +static const struct alpha_pll_config ipq9574_pll_config = {
> +	.l = 0x3b,
> +	.config_ctl_val = 0x200d4828,
> +	.config_ctl_hi_val = 0x6,
> +	.early_output_mask = BIT(3),
> +	.aux2_output_mask = BIT(2),
> +	.aux_output_mask = BIT(1),
> +	.main_output_mask = BIT(0),
> +	.test_ctl_val = 0x0,
> +	.test_ctl_hi_val = 0x4000,
> +};
> +
>  struct apss_pll_data {
>  	int pll_type;
>  	struct clk_alpha_pll *pll;
> @@ -135,6 +147,12 @@ static struct apss_pll_data ipq6018_pll_data = {
>  	.pll_config = &ipq6018_pll_config,
>  };
>  
> +static struct apss_pll_data ipq9574_pll_data = {
> +	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
> +	.pll = &ipq_pll_huayra,
> +	.pll_config = &ipq9574_pll_config,
> +};
> +
>  static const struct regmap_config ipq_pll_regmap_config = {
>  	.reg_bits		= 32,
>  	.reg_stride		= 4,
> @@ -180,6 +198,7 @@ static const struct of_device_id apss_ipq_pll_match_table[] = {
>  	{ .compatible = "qcom,ipq5332-a53pll", .data = &ipq5332_pll_data },
>  	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_data },
>  	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_data },
> +	{ .compatible = "qcom,ipq9574-a73pll", .data = &ipq9574_pll_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
