Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA376828DA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjAaJ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjAaJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:29:31 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E0012065
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:29:29 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gr7so15156658ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRk91iZt0V7nVEmmcjUezSryXc3efPUiO2hod8kq60c=;
        b=lmm7qvL7RUNHMdC3C3o9kT9i/U3OiGufUVJsPuGjzw4/clYbkHY1OHBjjKsOjvrhzu
         wlBlV2HZ+Uhx7rkvvG/VOdACeG3NL7+2lrFJdX4ATN7xB5xLbjavaKlDubi5eHoacnuo
         0pS93RyDSgdM0kMMAjQMH4X2k1qnXVIlbU0VsWl5Jz17Op4ehTSnfmVzGea1gqZFwPaH
         VNLIIgJWKp1HUyTscLnF+ybdFYoddLKGVl20E6ptvkRLYiD4YR4js/I63k+ddYCfQ1at
         NMkQZPnSll2x5ABjQCWq7BN+6YPXkACR2EbtIHqKLB4VeSdxHUC2oQB9tDRIKQmbg+46
         /MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRk91iZt0V7nVEmmcjUezSryXc3efPUiO2hod8kq60c=;
        b=VSGDWbErJZTan3aosGIkzClYYuDWBZVPLESc2s2NOoHgRdkQqEvq3CJ4PRhdhvfohZ
         gj2XIF0b5R9jWehNGCkRf5tLqyDnF1H49vdEYxA9pyRl2k2ajiJCY/Bo3zIEIL3fzuFE
         xOAbNm5d3EQKP5JwBlYUMMiR53vgXUHcpefJ0Z81zZbB3klEjftpYeYjgOXdYHU5T1by
         FW4WefDtUoF5l8JmhLduX1DoYREO+bSEM8p8XIowcQCT8TpVbEqyK5kOGyCB2iqdlExH
         U+nbfwhxoYKER4ZOP2ccv38IecVL16u+lsDD87tiFGWOssk9vxf+FbQN0PBJBReNOrmQ
         98gA==
X-Gm-Message-State: AFqh2kplLEl+QglyIeEfSQdqPcG3M0zlWjIwkCCDDL2TQU8o3gHvldC9
        /hrJbVzk4ZSqblKrgo+4YVaF2Q==
X-Google-Smtp-Source: AMrXdXuPnvGBiRaonxEYWamjUI2/fuicXzoJhRHIf4HzBHfB/bCMnAhTRc1GF7DwC8GeLBAM8NjctQ==
X-Received: by 2002:a17:907:ca07:b0:7c0:a1f9:c778 with SMTP id uk7-20020a170907ca0700b007c0a1f9c778mr47614392ejc.13.1675157368093;
        Tue, 31 Jan 2023 01:29:28 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906155700b00869f2ca6a87sm8089800ejd.135.2023.01.31.01.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 01:29:27 -0800 (PST)
Message-ID: <c51ab88e-d568-8322-093e-b82f11f63a0b@linaro.org>
Date:   Tue, 31 Jan 2023 11:29:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/6] clk: qcom: ipq9574: Enable APSS clock driver
Content-Language: en-GB
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, jassisinghbrar@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, marcel.ziswiler@toradex.com,
        nfraprado@collabora.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-3-quic_devipriy@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230113143647.14961-3-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 16:36, devi priya wrote:
> Enable APSS clock driver for IPQ9574 based devices
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>   drivers/clk/qcom/apss-ipq-pll.c         | 13 +++++++++++++
>   drivers/mailbox/qcom-apcs-ipc-mailbox.c |  5 +++++

Note, the drivers/mailbox isn't a part of the 'drivers/clk', so it 
should go to a separate patch (and it will be handled by a different 
maintainer).

>   2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index a5aea27eb867..dd0c01bf5a98 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -61,6 +61,18 @@ static const struct alpha_pll_config ipq8074_pll_config = {
>   	.test_ctl_hi_val = 0x4000,
>   };
>   
> +static const struct alpha_pll_config ipq9574_pll_config = {
> +	.l = 0x3b,
> +	.config_ctl_val = 0x200D4828,
> +	.config_ctl_hi_val = 0x6,
> +	.early_output_mask = BIT(3),
> +	.aux2_output_mask = BIT(2),
> +	.aux_output_mask = BIT(1),
> +	.main_output_mask = BIT(0),
> +	.test_ctl_val = 0x0,
> +	.test_ctl_hi_val = 0x4000,
> +};
> +
>   static const struct regmap_config ipq_pll_regmap_config = {
>   	.reg_bits		= 32,
>   	.reg_stride		= 4,
> @@ -102,6 +114,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
>   static const struct of_device_id apss_ipq_pll_match_table[] = {
>   	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_config },
>   	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_config },
> +	{ .compatible = "qcom,ipq9574-a73pll", .data = &ipq9574_pll_config },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 0e9f9cba8668..90e74f9d7cb3 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -33,6 +33,10 @@ static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
>   	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
>   };
>   
> +static const struct qcom_apcs_ipc_data ipq9574_apcs_data = {
> +	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
> +};

As the data is identical to ipq6018's one, please don't add a duplicate 
of it.

> +
>   static const struct qcom_apcs_ipc_data msm8916_apcs_data = {
>   	.offset = 8, .clk_name = "qcom-apcs-msm8916-clk"
>   };
> @@ -143,6 +147,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
>   static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>   	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
>   	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
> +	{ .compatible = "qcom,ipq9574-apcs-apps-global", .data = &ipq9574_apcs_data },
>   	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
>   	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
>   	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },

-- 
With best wishes
Dmitry

