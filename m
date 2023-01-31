Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96EB68290D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjAaJji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjAaJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:39:36 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13339AE;
        Tue, 31 Jan 2023 01:39:36 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V9ZUjh015611;
        Tue, 31 Jan 2023 09:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vNYmD2GxBRHAlpUVB83Gn5/p4UGml6Tjhc7vDpUWX7Y=;
 b=PxDMMMCseYIKdahO6S1KCC+GNEZtEUhR9QlHNBVUWVufLZdl/+gIguQ40uJHFBl6NGCl
 Fw4ZSVO5OOX9uO3ItOjlFH7xeWGUYuk5+Mc1w7p7/hHXHGDHWHQDOSkXJv7o2v7wjVUA
 3uREYMm/esUAGsTByu48lnqGiTqK7DeFs67qse8mGXIKt0eyprz5lZpK/5tRgZ0RNvmF
 F245ukhyJBaRqlzsWaMBe6NQHkbSekGulAf6v7tALsSHHYkjoXjlCsj83CtcjI+T4LSE
 HHpjAjiU4KMxeYebTSGMscYIfmmzVKVJaE77Fra+5tJvXu/zYYFXptjzXKVCTaJIak3u Rw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncuxap1ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 09:39:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V9dHZi022202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 09:39:17 GMT
Received: from [10.50.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 01:39:09 -0800
Message-ID: <c9b5ecf4-29ac-1326-0dff-80577440b587@quicinc.com>
Date:   Tue, 31 Jan 2023 15:09:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/6] clk: qcom: ipq9574: Enable APSS clock driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-3-quic_devipriy@quicinc.com>
 <c51ab88e-d568-8322-093e-b82f11f63a0b@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <c51ab88e-d568-8322-093e-b82f11f63a0b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xrRLYhldeRNOwJJ7I3xyoiVoc1vcTekk
X-Proofpoint-GUID: xrRLYhldeRNOwJJ7I3xyoiVoc1vcTekk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_04,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310084
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dmitry for taking time to review the patch!

On 1/31/2023 2:59 PM, Dmitry Baryshkov wrote:
> On 13/01/2023 16:36, devi priya wrote:
>> Enable APSS clock driver for IPQ9574 based devices
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   drivers/clk/qcom/apss-ipq-pll.c         | 13 +++++++++++++
>>   drivers/mailbox/qcom-apcs-ipc-mailbox.c |  5 +++++
> 
> Note, the drivers/mailbox isn't a part of the 'drivers/clk', so it 
> should go to a separate patch (and it will be handled by a different 
> maintainer).
> 
Sure, got it. will split the changes in V2
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c 
>> b/drivers/clk/qcom/apss-ipq-pll.c
>> index a5aea27eb867..dd0c01bf5a98 100644
>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>> @@ -61,6 +61,18 @@ static const struct alpha_pll_config 
>> ipq8074_pll_config = {
>>       .test_ctl_hi_val = 0x4000,
>>   };
>> +static const struct alpha_pll_config ipq9574_pll_config = {
>> +    .l = 0x3b,
>> +    .config_ctl_val = 0x200D4828,
>> +    .config_ctl_hi_val = 0x6,
>> +    .early_output_mask = BIT(3),
>> +    .aux2_output_mask = BIT(2),
>> +    .aux_output_mask = BIT(1),
>> +    .main_output_mask = BIT(0),
>> +    .test_ctl_val = 0x0,
>> +    .test_ctl_hi_val = 0x4000,
>> +};
>> +
>>   static const struct regmap_config ipq_pll_regmap_config = {
>>       .reg_bits        = 32,
>>       .reg_stride        = 4,
>> @@ -102,6 +114,7 @@ static int apss_ipq_pll_probe(struct 
>> platform_device *pdev)
>>   static const struct of_device_id apss_ipq_pll_match_table[] = {
>>       { .compatible = "qcom,ipq6018-a53pll", .data = 
>> &ipq6018_pll_config },
>>       { .compatible = "qcom,ipq8074-a53pll", .data = 
>> &ipq8074_pll_config },
>> +    { .compatible = "qcom,ipq9574-a73pll", .data = 
>> &ipq9574_pll_config },
>>       { }
>>   };
>>   MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
>> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c 
>> b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> index 0e9f9cba8668..90e74f9d7cb3 100644
>> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> @@ -33,6 +33,10 @@ static const struct qcom_apcs_ipc_data 
>> ipq6018_apcs_data = {
>>       .offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
>>   };
>> +static const struct qcom_apcs_ipc_data ipq9574_apcs_data = {
>> +    .offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
>> +};
> 
> As the data is identical to ipq6018's one, please don't add a duplicate 
> of it.
> 
Sure, okay
>> +
>>   static const struct qcom_apcs_ipc_data msm8916_apcs_data = {
>>       .offset = 8, .clk_name = "qcom-apcs-msm8916-clk"
>>   };
>> @@ -143,6 +147,7 @@ static int qcom_apcs_ipc_remove(struct 
>> platform_device *pdev)
>>   static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>>       { .compatible = "qcom,ipq6018-apcs-apps-global", .data = 
>> &ipq6018_apcs_data },
>>       { .compatible = "qcom,ipq8074-apcs-apps-global", .data = 
>> &ipq6018_apcs_data },
>> +    { .compatible = "qcom,ipq9574-apcs-apps-global", .data = 
>> &ipq9574_apcs_data },
>>       { .compatible = "qcom,msm8916-apcs-kpss-global", .data = 
>> &msm8916_apcs_data },
>>       { .compatible = "qcom,msm8939-apcs-kpss-global", .data = 
>> &msm8916_apcs_data },
>>       { .compatible = "qcom,msm8953-apcs-kpss-global", .data = 
>> &msm8994_apcs_data },
> 
Best Regards,
Devi Priya
