Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5534719CCD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjFAM6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjFAM5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:57:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F3E18C;
        Thu,  1 Jun 2023 05:57:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351CcYYw004233;
        Thu, 1 Jun 2023 12:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BbOx2WmCl8/2MgsTTYtXjihrwBpGz0BGc53sXjebfr0=;
 b=B0gw2PKbtikX/C0vo8O/3xvONlNSxQafRweIQbxBAhslLX+bfjBxliuIkEvDV0Fq5fta
 6ubUlKzOAK3CDe/VhDiXZWtg0LhKNDTDfIUgzkw9NUEE6v+/y32gg28pq+CdH+jMVCxX
 bFvxwA2D4braXSG8nyvwQWV36bl38xy+y5S8JJK4Q894Ecp+HCYa9qb8tCM1UYK6ci20
 A0HZiSGCk0yPnKkBGz4sb9LToMsE/9qHTJCFpAkpFQMNGequahk5lyOKF+31NX2y6Pkf
 Ch2LdoPqaorxs9fzeebIWWXrJ2NkpbsyPWFHCKKsHJpA3x6Cg3TZ2nSVcY4CGUDoowHt Dw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugrr1ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 12:57:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351CvlxP006927
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 12:57:47 GMT
Received: from [10.50.0.39] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 05:57:40 -0700
Message-ID: <b565b9b5-d7c1-7779-532e-565c3f5c5cd3@quicinc.com>
Date:   Thu, 1 Jun 2023 18:25:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RESEND PATCH v2 1/2] cpufreq: qcom-nvmem: add support for
 IPQ8074
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <ilia.lin@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC:     <ansuelsmth@gmail.com>
References: <20230530165807.642084-1-robimarko@gmail.com>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230530165807.642084-1-robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q23blFie_dmG8XKaM1Dqw_IRKVQoY9oC
X-Proofpoint-GUID: q23blFie_dmG8XKaM1Dqw_IRKVQoY9oC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010115
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/30/2023 10:28 PM, Robert Marko wrote:
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
> Changes in v2:
> * Print an error if SMEM ID is not part of the IPQ8074 family
> and restrict the speed to Acorn variant (1.4GHz)
> ---
>   drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 43 ++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index ea86c9f3ed7a..78f6ff933f93 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -170,6 +170,7 @@ static const struct of_device_id blocklist[] __initconst = {
>   	{ .compatible = "ti,am62a7", },
>   
>   	{ .compatible = "qcom,ipq8064", },
> +	{ .compatible = "qcom,ipq8074", },
>   	{ .compatible = "qcom,apq8064", },
>   	{ .compatible = "qcom,msm8974", },
>   	{ .compatible = "qcom,msm8960", },
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index a88b6fe5db50..ce444b5962f2 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -31,6 +31,9 @@
>   
>   #include <dt-bindings/arm/qcom,ids.h>
>   
> +#define IPQ8074_HAWKEYE_VERSION		BIT(0)
> +#define IPQ8074_ACORN_VERSION		BIT(1)
> +
>   struct qcom_cpufreq_drv;
>   
>   struct qcom_cpufreq_match_data {
> @@ -204,6 +207,41 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>   	return ret;
>   }
>   
> +static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
> +					     struct nvmem_cell *speedbin_nvmem,
> +					     char **pvs_name,
> +					     struct qcom_cpufreq_drv *drv)


Most of the IPQ SoCs also supports the fuse based frequency selection. 
Can we rename the function name to generic so that all the IPQ chips can 
use the same function?


> +{
> +	u32 msm_id;


soc_id please...?


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
> +		dev_err(cpu_dev,
> +			"SoC ID %u is not part of IPQ8074 family, limiting to 1.4GHz!\n",
> +			msm_id);
> +		drv->versions = IPQ8074_ACORN_VERSION;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct qcom_cpufreq_match_data match_data_kryo = {
>   	.get_version = qcom_cpufreq_kryo_name_version,
>   };
> @@ -218,6 +256,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
>   	.genpd_names = qcs404_genpd_names,
>   };
>   
> +static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
> +	.get_version = qcom_cpufreq_ipq8074_name_version,
> +};
> +
>   static int qcom_cpufreq_probe(struct platform_device *pdev)
>   {
>   	struct qcom_cpufreq_drv *drv;
> @@ -363,6 +405,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>   	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
>   	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
>   	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
> +	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
>   	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
>   	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
>   	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
