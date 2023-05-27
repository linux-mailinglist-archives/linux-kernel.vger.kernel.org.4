Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BEE71358B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjE0P4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 11:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjE0P4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 11:56:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992ECA2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 08:56:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f4f8b94c06so16737e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685202968; x=1687794968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/cqYMlSk8xZ/AYAV4YOl8MtaHv1NVr7y1pd2r773yPA=;
        b=NBNmJtyUPMssgu3Jo2k9smK5k0RDHqvwFDGNDHQB/XaVP/DqWZB+/0YgDV36wUgj2Q
         ntRBHLP+CVOBol8UcjsIcdIxtPJRxQtCr9m98pBiVxIrLqn0nzcaibZN5emDRjTCp5Ud
         ox5nlOGyl7BUKPGrsa1cUIPrOJfvEbSSHCWA7qYqszAxTReyom+2VffTW3IMBs/6f6uR
         BumkGw4/XUc9w6eZ2ZcfQSaJycbWFZoj2dzgeBdnq36TCv5mWs5nz2VdKUEMxYoYaFXt
         UeEANA2g65mp2gGT8x3i6xyzqWzhxC3Z/uAJ4cimiITF5x2a3F6N9Be8PhxgGDDypzsl
         H+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685202968; x=1687794968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cqYMlSk8xZ/AYAV4YOl8MtaHv1NVr7y1pd2r773yPA=;
        b=MaDKBFxGxYWKpqxo6Kv9wlp8cd2iZ092ABwhvdLuon343DYbRY5jnc3Wn22XC4cPEq
         nNeu9tl7vaTgnoiVcX1K58Lp8paCWzS2WmEMzF93iT664OaX1oXv3xvSCPmxcmKPL1FZ
         PQmNmDbIxI7YY4n5QSPmCbeoGpFIRfZLNK2eFXH/VrFy0EVsgW9fcFIytUcedzcMNnk4
         UzA1yfkbq1g6iGhrZUMguP8yccCqLz32mrA3CrJYrGBVTyRcGhflWgVIHkKoBzVYWXIY
         WSVXClL89KQiZGkpcGFVfv6ohwg4lMtVORgX8KA7/Ir0wQIOIuLBcPT0C3EDgnuSoO88
         YEJg==
X-Gm-Message-State: AC+VfDxxt+tzxa/cS2zv8vWFsyjIQrxJogWfb4jF4XUmp98sxxXnaCj6
        tjd9jpOTW3bpy8j3gP+ogj9OaQ==
X-Google-Smtp-Source: ACHHUZ57z815Rw86ZAzccrmEVlvtwRLiuRUNeKT9FtM/L5APrmviTWfXN5tVxSi5pYXFr65QdkxOEA==
X-Received: by 2002:a19:ee01:0:b0:4f4:b3e2:ff54 with SMTP id g1-20020a19ee01000000b004f4b3e2ff54mr1423055lfb.51.1685202967853;
        Sat, 27 May 2023 08:56:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004f13634da05sm1175648lfl.180.2023.05.27.08.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 08:56:07 -0700 (PDT)
Message-ID: <b227820b-239d-32fa-4dd4-78cba2a148e0@linaro.org>
Date:   Sat, 27 May 2023 17:56:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] cpufreq: qcom-nvmem: add support for IPQ8074
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        agross@kernel.org, andersson@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ansuelsmth@gmail.com
References: <20230527095229.12019-1-robimarko@gmail.com>
 <20230527095229.12019-2-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230527095229.12019-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.05.2023 11:52, Robert Marko wrote:
> IPQ8074 comes in 2 families:
> * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
> 
> So, in order to be able to share one OPP table lets add support for IPQ8074
> family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
> 
> IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
> will get created by NVMEM CPUFreq driver.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 40 ++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 14aa8281c7f4..e4d6d128647d 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -169,6 +169,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "ti,am625", },
>  
>  	{ .compatible = "qcom,ipq8064", },
> +	{ .compatible = "qcom,ipq8074", },
>  	{ .compatible = "qcom,apq8064", },
>  	{ .compatible = "qcom,msm8974", },
>  	{ .compatible = "qcom,msm8960", },
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index a88b6fe5db50..607fc0273e9c 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -31,6 +31,9 @@
>  
>  #include <dt-bindings/arm/qcom,ids.h>
>  
> +#define IPQ8074_HAWKEYE_VERSION		BIT(0)
> +#define IPQ8074_ACORN_VERSION		BIT(1)
> +
>  struct qcom_cpufreq_drv;
>  
>  struct qcom_cpufreq_match_data {
> @@ -204,6 +207,38 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>  	return ret;
>  }
>  
> +static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
> +					     struct nvmem_cell *speedbin_nvmem,
> +					     char **pvs_name,
> +					     struct qcom_cpufreq_drv *drv)
> +{
> +	u32 msm_id;
> +	int ret;
> +	*pvs_name = NULL;
> +
> +	ret = qcom_smem_get_soc_id(&msm_id);
> +	if (ret)
> +		return ret;
> +
> +	switch (msm_id) {
> +	case QCOM_ID_IPQ8070A:
> +	case QCOM_ID_IPQ8071A:
> +		drv->versions = IPQ8074_ACORN_VERSION;
> +		break;
> +	case QCOM_ID_IPQ8072A:
> +	case QCOM_ID_IPQ8074A:
> +	case QCOM_ID_IPQ8076A:
> +	case QCOM_ID_IPQ8078A:
> +		drv->versions = IPQ8074_HAWKEYE_VERSION;
> +		break;
> +	default:
> +		BUG();
I'd say pr_err, or at least WARN() + setting the slowest bin would be
more desirable here, cpufreq probes early so people without uart etc.
will be unlikely to find out why their kernel dies.

Konrad
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct qcom_cpufreq_match_data match_data_kryo = {
>  	.get_version = qcom_cpufreq_kryo_name_version,
>  };
> @@ -218,6 +253,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
>  	.genpd_names = qcs404_genpd_names,
>  };
>  
> +static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
> +	.get_version = qcom_cpufreq_ipq8074_name_version,
> +};
> +
>  static int qcom_cpufreq_probe(struct platform_device *pdev)
>  {
>  	struct qcom_cpufreq_drv *drv;
> @@ -363,6 +402,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>  	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
>  	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
>  	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
> +	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
>  	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
>  	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
>  	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
