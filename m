Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D3B669BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjAMPT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjAMPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:19:31 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9AF88A0D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:12:17 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so33561884lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIY98kPJHyijXd7ZkHV2FnXqne7Lt3cNAo7nyQqbLCQ=;
        b=y46y+lz3GKAUel7jfTZ1Si4H+C1iKfJ8kEkvGHVZ+5IwWxYhiR+qf6kV8uSSafmoNE
         bwAE3PLgQ95iVV7nAVjDHuN1ogQt8pc0qD84B/t12k/EUjvHnK90HA+5lGXjzh/gCoC+
         yCAiOqj4tx1U8hgTPcLImYZS/mJrhpkB5Jd/7cevlG7ui92ngjBbKcjokyWewyl1BxjB
         svaP+NUcKIuTBr6Ol1EUBSiILFfeSTA3IOBwMNjQkS2k3GRNJgJ9K0CtSwKj60lGT0s0
         88vdM8Ey6PL08n6CtDm4ewPLl+EvxAJ0Dc3wbSulIjrXTtVs1WKq6H0AO2yo35aEVFsO
         zUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIY98kPJHyijXd7ZkHV2FnXqne7Lt3cNAo7nyQqbLCQ=;
        b=P8MGWveKRXocgqRNXq3uodZbVgVIcisJBT03qNGma1aaMNZb0ixd5SpdxS6zsMjpde
         6lhwBHb0pt4JkhmUQLcyoBG699EHpK2Ic25jHSMEfzaXny3oCoqHPLmCMg2r2ACAU2eG
         7QR67bOs3dpyvoYkQSsedpD8uLi3OXU3kX7uyts/2MdvBVNKz37LfO/0nHMWFlPWjJmf
         tDX2C+8xlXPJubFLxBGzimRRnKbzxynGsCxIZYZxyD5WhDBqz0oOKBTr18Lgvdaop3Gk
         N9P4gahkrJyv2o5QKjterNUqjYyA+yGPJQLmGmE6cFoMlVGSNL+jcu1nicbozdmkVEuA
         7rdA==
X-Gm-Message-State: AFqh2koRD7j5I/3YuauP0o9nSUFYewcTjUeAeGo3lewj0Au0VFudxU6S
        jaXOe1vSfQkLBc4w4TxHNvrRjA==
X-Google-Smtp-Source: AMrXdXsEfUe+AqYQC1WC5x69hG4UhSrgJ8qZxilHr6zseZ/JQN5sQgNY2iXbwoA3BPEANtllwSEHAA==
X-Received: by 2002:ac2:5216:0:b0:4cb:13d7:77e2 with SMTP id a22-20020ac25216000000b004cb13d777e2mr37380lfl.26.1673622736207;
        Fri, 13 Jan 2023 07:12:16 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id i4-20020ac25d24000000b004b578e52d81sm3869961lfb.176.2023.01.13.07.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 07:12:15 -0800 (PST)
Message-ID: <9157d3c9-cca2-8694-ffcb-6cafa7b43d84@linaro.org>
Date:   Fri, 13 Jan 2023 16:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/6] clk: qcom: ipq9574: Enable APSS clock driver
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, jassisinghbrar@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-3-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230113143647.14961-3-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.01.2023 15:36, devi priya wrote:
> Enable APSS clock driver for IPQ9574 based devices
Please be more descriptive of what you're doing and why
you're doing it.

clk: qcom: apss-ipq-pll: Add IPQ9574 support

Add IPQ9574-specific APSS PLL configuration values.


mailbox: qcom-apcs-ipc: Add IPQ9574 support

Add a compatible for IPQ9574's mailbox. The SoC, similarly
to other IPQs uses the APSS IPQ PLL driver for CPU scaling.


> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>  drivers/clk/qcom/apss-ipq-pll.c         | 13 +++++++++++++
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c |  5 +++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index a5aea27eb867..dd0c01bf5a98 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -61,6 +61,18 @@ static const struct alpha_pll_config ipq8074_pll_config = {
>  	.test_ctl_hi_val = 0x4000,
>  };
>  
> +static const struct alpha_pll_config ipq9574_pll_config = {
> +	.l = 0x3b,
> +	.config_ctl_val = 0x200D4828,
Lowercase hex, please.

> +	.config_ctl_hi_val = 0x6,
> +	.early_output_mask = BIT(3),
> +	.aux2_output_mask = BIT(2),
> +	.aux_output_mask = BIT(1),
> +	.main_output_mask = BIT(0),
> +	.test_ctl_val = 0x0,
> +	.test_ctl_hi_val = 0x4000,
> +};
> +
>  static const struct regmap_config ipq_pll_regmap_config = {
>  	.reg_bits		= 32,
>  	.reg_stride		= 4,
> @@ -102,6 +114,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
>  static const struct of_device_id apss_ipq_pll_match_table[] = {
>  	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_config },
>  	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_config },
> +	{ .compatible = "qcom,ipq9574-a73pll", .data = &ipq9574_pll_config },
>  	{ }
>  };
These are very small changes, so maybe they'll pass, but generally
it's preferred to split changes per-file if possible (and here it is
possible if you change the APSS PLL driver first and then bind it in
APCS mbox afterwards).

>  MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 0e9f9cba8668..90e74f9d7cb3 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -33,6 +33,10 @@ static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
>  	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
>  };
>  
> +static const struct qcom_apcs_ipc_data ipq9574_apcs_data = {
> +	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
> +};
Please reuse ipq6018_apcs_data, it's identical.

Konrad
> +
>  static const struct qcom_apcs_ipc_data msm8916_apcs_data = {
>  	.offset = 8, .clk_name = "qcom-apcs-msm8916-clk"
>  };
> @@ -143,6 +147,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
>  static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>  	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
>  	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
> +	{ .compatible = "qcom,ipq9574-apcs-apps-global", .data = &ipq9574_apcs_data },
>  	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
>  	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
>  	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
