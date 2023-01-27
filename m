Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8347D67E9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjA0PoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjA0PoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:44:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2261784FB3;
        Fri, 27 Jan 2023 07:44:02 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RFQXjq020952;
        Fri, 27 Jan 2023 15:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZQK4sRAhX36f+rwA/b5JzFXbG3mx1Qla2NGHATTEnR0=;
 b=QYa1RvIo0l4+7tzNYRKH1kH2N9Jo9VKZN3yFra+lbGIAeDRmAMF0n1vR7ZPKmuiNTydx
 U6bPkaZOzCAinzgkkITThpuTcZowOXiDKq787fP7ZX/WquHpvvCFyBUpbEgB9UybzJx4
 jcWyVhuU/grvkv6ZFVBJrpCJhnfFfI5blZ5AQt8aid41AFizMvAPodPuo5TCJgjM+2e/
 FU7zpMmFiAcDhn9znryMh0PO41L6FuGpqrC4YkryW0hrI4vQqnEPOBkyXTTOjjH3EbY3
 R1N7h2/0koGCpsic97uhs/0C4jvuSV7lle2kkmUh53qHkojiwmRaKYwC5OQ19SZMF7NC 3g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nc95jrrrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 15:43:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RFhj2b001303
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 15:43:45 GMT
Received: from [10.50.41.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 07:43:38 -0800
Message-ID: <32ca2bd2-f928-ff23-5d57-4399c2e50c39@quicinc.com>
Date:   Fri, 27 Jan 2023 21:13:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/6] clk: qcom: ipq9574: Enable APSS clock driver
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-3-quic_devipriy@quicinc.com>
 <9157d3c9-cca2-8694-ffcb-6cafa7b43d84@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <9157d3c9-cca2-8694-ffcb-6cafa7b43d84@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lWz08vQI1L2rO3_wGafEd-dmrClRZ6DM
X-Proofpoint-ORIG-GUID: lWz08vQI1L2rO3_wGafEd-dmrClRZ6DM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270145
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2023 8:42 PM, Konrad Dybcio wrote:
> 
> 
> On 13.01.2023 15:36, devi priya wrote:
>> Enable APSS clock driver for IPQ9574 based devices
> Please be more descriptive of what you're doing and why
> you're doing it.
> 
> clk: qcom: apss-ipq-pll: Add IPQ9574 support
> 
> Add IPQ9574-specific APSS PLL configuration values.
> 
> 
> mailbox: qcom-apcs-ipc: Add IPQ9574 support
> 
> Add a compatible for IPQ9574's mailbox. The SoC, similarly
> to other IPQs uses the APSS IPQ PLL driver for CPU scaling.
> 
Sure, okay
> 
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   drivers/clk/qcom/apss-ipq-pll.c         | 13 +++++++++++++
>>   drivers/mailbox/qcom-apcs-ipc-mailbox.c |  5 +++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
>> index a5aea27eb867..dd0c01bf5a98 100644
>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>> @@ -61,6 +61,18 @@ static const struct alpha_pll_config ipq8074_pll_config = {
>>   	.test_ctl_hi_val = 0x4000,
>>   };
>>   
>> +static const struct alpha_pll_config ipq9574_pll_config = {
>> +	.l = 0x3b,
>> +	.config_ctl_val = 0x200D4828,
> Lowercase hex, please.
Okay
> 
>> +	.config_ctl_hi_val = 0x6,
>> +	.early_output_mask = BIT(3),
>> +	.aux2_output_mask = BIT(2),
>> +	.aux_output_mask = BIT(1),
>> +	.main_output_mask = BIT(0),
>> +	.test_ctl_val = 0x0,
>> +	.test_ctl_hi_val = 0x4000,
>> +};
>> +
>>   static const struct regmap_config ipq_pll_regmap_config = {
>>   	.reg_bits		= 32,
>>   	.reg_stride		= 4,
>> @@ -102,6 +114,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
>>   static const struct of_device_id apss_ipq_pll_match_table[] = {
>>   	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_config },
>>   	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_config },
>> +	{ .compatible = "qcom,ipq9574-a73pll", .data = &ipq9574_pll_config },
>>   	{ }
>>   };
> These are very small changes, so maybe they'll pass, but generally
> it's preferred to split changes per-file if possible (and here it is
> possible if you change the APSS PLL driver first and then bind it in
> APCS mbox afterwards).
> 
Sure, will split the file changes in V2

>>   MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
>> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> index 0e9f9cba8668..90e74f9d7cb3 100644
>> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> @@ -33,6 +33,10 @@ static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
>>   	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
>>   };
>>   
>> +static const struct qcom_apcs_ipc_data ipq9574_apcs_data = {
>> +	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
>> +};
> Please reuse ipq6018_apcs_data, it's identical.
> 
> Konrad
Okay
>> +
>>   static const struct qcom_apcs_ipc_data msm8916_apcs_data = {
>>   	.offset = 8, .clk_name = "qcom-apcs-msm8916-clk"
>>   };
>> @@ -143,6 +147,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
>>   static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>>   	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
>>   	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
>> +	{ .compatible = "qcom,ipq9574-apcs-apps-global", .data = &ipq9574_apcs_data },
>>   	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
>>   	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
>>   	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
Best Regards,
Devi Priya
