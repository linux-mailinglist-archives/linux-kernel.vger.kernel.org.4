Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4ED717A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjEaIla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjEaIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:41:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E5E193
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:41:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so6366988e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685522456; x=1688114456;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vc1IO9E9zjMZ2kN7szLFGbYb7R13NrbmFXuFho+WGu8=;
        b=uep2XW4/cD4ta3yCwXLQs8KJQF/ieoJTx9Bz5EjeFReI/Wik3Vbmmbmez94A6Rg2bS
         B8c1mcNmVm00GfxQEPmBoJrQAKATMpALARsEr3Jc7krUbIHqtC6rTOhEVf8OLwiqvXVo
         EKbjbS7XztKHeeFbomyUyP/sr06JVvqRKKmz6LSOnHnZJIrhPO0Pfk1eC+ZkE5o0QlAo
         Mv2CaJrwFYG87SsZC9KDjVq856Kc8N+ud+qmVSSd2Y8yNEuXw4T1zvklCvPmyTkg81KA
         rxCQ3erSXoX9v67nTbLaaYLyOBp/oyLM46HPAiCfxCxNCbZDeMmLYnz6zQDD/krIoBnf
         ZdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685522456; x=1688114456;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc1IO9E9zjMZ2kN7szLFGbYb7R13NrbmFXuFho+WGu8=;
        b=ARTHyJkI/h1jJREooJdP2CzLpF6F5Cus8CD/bABfODNETE0i4naTkMOD7ziDnK9uW/
         /4LTcFDX0HYgV3Kv/77ypO/9mMIA3udPQBos8uWwUXjyFc0fCAfWvVeWM4IDZbeFGT1u
         ue6qGrLemWq3b9I9gp1s9HEmD/4N3ntgCzXVzeWEM3LLYloeEDyYolgJOcI799KZHwPo
         2/QQZKuYqrcWJOfdRcpkvPoGzfvuJI08oGMkfAhfqNPsNq6A+ISTz/iuWbE5q+oYZBAP
         pYoJgRDwOKRvabD/csN0VthZuSaDQtC8b8XHPxdUq7sHYgacewjthzkog8YGHF8V26no
         FnyQ==
X-Gm-Message-State: AC+VfDxdpbIFex/VFs0OiFlfqNE34M5zCEMpHVPda4njhGmx07Eu4uSP
        ICC4FmQT836+veJSMzmS6tqgVQ==
X-Google-Smtp-Source: ACHHUZ5nI0RP7ItVlidAWuFxojReYmq+IexNAs+IbR/o3ImyBt94GW/72PA17KfUCSG3bNJX7jbUCw==
X-Received: by 2002:a05:6512:49c:b0:4f4:b92c:eef5 with SMTP id v28-20020a056512049c00b004f4b92ceef5mr2033159lfq.68.1685522456095;
        Wed, 31 May 2023 01:40:56 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id f21-20020a19ae15000000b004f13ece6a4fsm628536lfc.101.2023.05.31.01.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:40:55 -0700 (PDT)
Message-ID: <507831fd-326a-a5f7-cdc1-5584ad1aa11b@linaro.org>
Date:   Wed, 31 May 2023 10:40:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, andersson@kernel.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     ansuelsmth@gmail.com
References: <20230530165807.642084-1-robimarko@gmail.com>
 <20230530165807.642084-2-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [RESEND PATCH v2 2/2] cpufreq: qcom-nvmem: add support for
 IPQ8064
In-Reply-To: <20230530165807.642084-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.05.2023 18:58, Robert Marko wrote:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> IPQ8064 comes in 3 families:
> * IPQ8062 up to 1.0GHz
> * IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
> * IPQ8065/IPQ8069 up to 1.7Ghz
> 
> So, in order to be able to share one OPP table, add support for
> IPQ8064 family based of SMEM SoC ID-s as speedbin fuse is always 0 on
> IPQ8064.
> 
> Bit are set with the following logic:
> * IPQ8062 BIT 0
> * IPQ8064/IPQ8066/IPQ8068 BIT 1
> * IPQ8065/IPQ8069 BIT 2
> 
> speed is never fused, only psv values are fused.
> Set speed to the versions to permit a unified opp table following
> this named opp:
> 
> opp-microvolt-speed<SPEED_VALUE>-pvs<PSV_VALUE>-v0
> 
> Example:
> - for ipq8062 psv2
>   opp-microvolt-speed0-pvs2-v0 = < 925000 878750 971250>
> - for ipq8064 psv2
>   opp-microvolt-speed2-pvs2-v0 = <925000 878750 971250>;
> - for ipq8065 psv2
>   opp-microvolt-speed4-pvs2-v0 = <950000 902500 997500>;
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 +++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index ce444b5962f2..c644138680ba 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -34,6 +34,10 @@
>  #define IPQ8074_HAWKEYE_VERSION		BIT(0)
>  #define IPQ8074_ACORN_VERSION		BIT(1)
>  
> +#define IPQ8062_VERSION		BIT(0)
> +#define IPQ8064_VERSION		BIT(1)
> +#define IPQ8065_VERSION		BIT(2)
> +
>  struct qcom_cpufreq_drv;
>  
>  struct qcom_cpufreq_match_data {
> @@ -207,6 +211,69 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>  	return ret;
>  }
>  
> +static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
> +					     struct nvmem_cell *speedbin_nvmem,
> +					     char **pvs_name,
> +					     struct qcom_cpufreq_drv *drv)
> +{
> +	int speed = 0, pvs = 0, pvs_ver = 0;
> +	int msm_id, ret = 0;
> +	u8 *speedbin;
> +	size_t len;
> +
> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
> +
> +	switch (len) {
Do we expect more variety here? Otherwise a switch statement sounds a
bit too heavy for the job, imo.

> +	case 4:
> +		get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
> +				       speedbin);
> +		break;
> +	default:
> +		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
> +		ret = -ENODEV;
> +		goto len_error;
> +	}
> +
> +	ret = qcom_smem_get_soc_id(&msm_id);
> +	if (ret)
> +		return ret;
> +
> +	switch (msm_id) {
> +	case QCOM_ID_IPQ8062:
> +		drv->versions = IPQ8062_VERSION;
> +		break;
> +	case QCOM_ID_IPQ8064:
> +	case QCOM_ID_IPQ8066:
> +	case QCOM_ID_IPQ8068:
> +		drv->versions = IPQ8064_VERSION;
> +		break;
> +	case QCOM_ID_IPQ8065:
> +	case QCOM_ID_IPQ8069:
> +		drv->versions = IPQ8065_VERSION;
> +		break;
> +	default:
> +		dev_err(cpu_dev,
> +			"SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
> +			msm_id);
> +		drv->versions = IPQ8062_VERSION;
> +		break;
> +	}
> +
> +	/*
> +	 * IPQ8064 speed is never fused. Only psv values are fused.
> +	 * Set speed to the versions to permit a unified opp table.
> +	 */
> +	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
> +		 drv->versions, pvs, pvs_ver);
> +
> +len_error:
> +	kfree(speedbin);
Perhaps we should switch to devres-managed nvmem soon..

Konrad
> +	return ret;
> +}
> +
>  static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
>  					     struct nvmem_cell *speedbin_nvmem,
>  					     char **pvs_name,
> @@ -256,6 +323,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
>  	.genpd_names = qcs404_genpd_names,
>  };
>  
> +static const struct qcom_cpufreq_match_data match_data_ipq8064 = {
> +	.get_version = qcom_cpufreq_ipq8064_name_version,
> +};
> +
>  static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
>  	.get_version = qcom_cpufreq_ipq8074_name_version,
>  };
> @@ -404,7 +475,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>  	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
>  	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
>  	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
> -	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
> +	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
>  	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
>  	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
>  	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
