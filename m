Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56F462BC75
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiKPLtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbiKPLs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:48:26 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886792CE26
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:35:15 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kt23so43372503ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFpitQZPCSWmV4KA7TF9v27Tmab4o5r/cI7HcmDfwD0=;
        b=BdcT7uFZ8E89eJyftSJmR4Mc8UNEcplvKOVj45D0zWF8CdKH1o9+DB/M1NZEMVIU5M
         HjKqRuc9cyq2KKSEgV7rteWepSGrfTWXQMLRKG10dGoprBaLxC8TKoyk6P2YtWQj+A9W
         U9Fzf9QwYI3cpEtfMa45weQq6F128DYDb3Iaokg3xKY5+vVStTBBOZ3mI4GmRCFAdxVb
         iuLRzOwt2frl5LJxDumsS2mrEmAYD0Fmqyk7s+mdQuCt5vVylF2Eki0xxGvVSMJ5A3G1
         4Dz6dXV/UB7q4DOHQFKOZp31siFyLkZRl0Dviqrg4jYY1tYRQ2PB+mjdGmqeo8fgVgi3
         jUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lFpitQZPCSWmV4KA7TF9v27Tmab4o5r/cI7HcmDfwD0=;
        b=wNwQY6m28ou0pTmbI6zmwIs+N18hfhMO0hbuZJeGPlSapjpVbOo2r5migbvfSiqq8d
         R3eWmYGb9k49G2fS52/9SdMzOx4GWq4Dwtz//A+mbo9mfh9BvKO80fVS1tWDOEaHqrV9
         6Cdk1bgrg36+P40u28NBMMmRValL1ZHExw9FQgraNQGwFCesRLHMAfPHKmJEQBd9h1ZN
         t7SzmQC1ca2zDt0HAMzdguK982dr3gmSyJQ+atSO8V5z32gDRsDTsK7JZKHM08Txyydg
         2eZVnCYr2pkgtuoIZKfZCJY0zNvDnHvaq6/gQSQNiKA5tdtnx1xr+8/1Pti0kW00GioS
         A8FA==
X-Gm-Message-State: ANoB5pm3riVcLvbqdrTtXQ5MpncN2sz/9Iv0wpXa8UpecDu0lqAjNrnR
        MAQD3d9HZ/vxOUU4B/nqW7UCvQ==
X-Google-Smtp-Source: AA0mqf4RPlD4qaXv5hV8z02A2OS0cAmFX5lc4FTfvdfIDr+PYkSDp3IyOpwiJnvwFKktNfibc/XuzA==
X-Received: by 2002:a17:906:66da:b0:7a5:f8a5:6f84 with SMTP id k26-20020a17090666da00b007a5f8a56f84mr16753704ejp.569.1668598514103;
        Wed, 16 Nov 2022 03:35:14 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ft31-20020a170907801f00b0078d9cd0d2d6sm6907537ejc.11.2022.11.16.03.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:35:13 -0800 (PST)
Message-ID: <340c0769-d51f-88df-5cd5-02c3337a24c0@linaro.org>
Date:   Wed, 16 Nov 2022 12:35:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] soc: qcom: rpmhpd: Add SM8550 power domains
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221116111745.2633074-1-abel.vesa@linaro.org>
 <20221116111745.2633074-3-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116111745.2633074-3-abel.vesa@linaro.org>
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



On 16/11/2022 12:17, Abel Vesa wrote:
> Add the power domains exposed by RPMH in the Qualcomm SM8550 platform.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/soc/qcom/rpmhpd.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 7af68cd720f5..4c2d2c296790 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -372,6 +372,29 @@ static const struct rpmhpd_desc sm8450_desc = {
>   	.num_pds = ARRAY_SIZE(sm8450_rpmhpds),
>   };
>   
> +/* SM8550 RPMH powerdomains */
> +static struct rpmhpd *sm8550_rpmhpds[] = {
> +	[SM8550_CX] = &cx,
> +	[SM8550_CX_AO] = &cx_ao,
> +	[SM8550_EBI] = &ebi,
> +	[SM8550_GFX] = &gfx,
> +	[SM8550_LCX] = &lcx,
> +	[SM8550_LMX] = &lmx,
> +	[SM8550_MMCX] = &mmcx_w_cx_parent,
> +	[SM8550_MMCX_AO] = &mmcx_ao_w_cx_parent,
> +	[SM8550_MSS] = &mss,
> +	[SM8550_MX] = &mx,
> +	[SM8550_MX_AO] = &mx_ao,
> +	[SM8550_MXC] = &mxc,
> +	[SM8550_MXC_AO] = &mxc_ao,
> +	[SM8550_NSP] = &nsp,
> +};
> +
> +static const struct rpmhpd_desc sm8550_desc = {
> +	.rpmhpds = sm8550_rpmhpds,
> +	.num_pds = ARRAY_SIZE(sm8550_rpmhpds),
> +};
> +
>   /* QDU1000/QRU1000 RPMH powerdomains */
>   static struct rpmhpd *qdu1000_rpmhpds[] = {
>   	[QDU1000_CX] = &cx,
> @@ -477,6 +500,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
>   	{ .compatible = "qcom,sm8250-rpmhpd", .data = &sm8250_desc },
>   	{ .compatible = "qcom,sm8350-rpmhpd", .data = &sm8350_desc },
>   	{ .compatible = "qcom,sm8450-rpmhpd", .data = &sm8450_desc },
> +	{ .compatible = "qcom,sm8550-rpmhpd", .data = &sm8550_desc },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, rpmhpd_match_table);
