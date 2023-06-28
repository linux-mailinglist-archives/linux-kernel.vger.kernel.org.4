Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41CB740C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjF1JFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:05:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131]:62860 "EHLO
        mx0a-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234369AbjF1IyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:54:02 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S4p7vU025065;
        Wed, 28 Jun 2023 08:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4cad0skK9AAH/Nt8JpqNPc+L0GbdFkEEbEx+He/bSxQ=;
 b=ByB6MuWh94gxAXSMiv2aAKTUecQjVqf4mEja5Q7HQaJmcRDlDEeuCWylvWN34Y8g+NRY
 r9ESsGYi6GEoW0b1APMu8zVZwkMGVQ6hhikWF6szHXcBzUoNHNANI6jh+kKejMp2SiNI
 B6YzZ8RRyOO4aaIa+Oag8fPvTtIbFfBKOVT8D9OgCXTqC92JKSH/GooboRXZVIj4wDiG
 AHYuMDT+dVR/+mE3F07ssDp6imqOsi4cXTujg8qEZb5LYGbgXxUaG5PBleCuD1uiVIL4
 Rq3+lw6eWgBUEb/XJ0/ze7Fh5BGtX9IbO3GlAID8Vb3nAdcSirjYG3+b8MuODeLCfg84 Gw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg21ta24v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 08:53:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35S8rv7q004642
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 08:53:57 GMT
Received: from [10.214.230.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 28 Jun
 2023 01:53:53 -0700
Message-ID: <06f6efb1-6047-b9e5-6653-4771ceefccc0@quicinc.com>
Date:   Wed, 28 Jun 2023 14:23:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 6/6] soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC
 support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-7-quic_kbajaj@quicinc.com>
 <CAA8EJprPLt2bumvFvCMNL0DQs9XFxLfcrBxrrJHk6NFhNBJx_g@mail.gmail.com>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <CAA8EJprPLt2bumvFvCMNL0DQs9XFxLfcrBxrrJHk6NFhNBJx_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VbHFpci3LLkuxosu4Nda0BR9rKh3X7ma
X-Proofpoint-GUID: VbHFpci3LLkuxosu4Nda0BR9rKh3X7ma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_05,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/2023 7:57 PM, Dmitry Baryshkov wrote:
> On Fri, 23 Jun 2023 at 17:19, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>> Add LLCC configuration data for QDU1000 and QRU1000 SoCs
>> and updating macro name for LLCC_DRE to LLCC_ECC as per
>> the latest specification.
> Two commits please.

Okay, will split this into two commits.

Thanks
Komal

>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   drivers/soc/qcom/llcc-qcom.c       | 65 +++++++++++++++++++++++++++++-
>>   include/linux/soc/qcom/llcc-qcom.h |  2 +-
>>   2 files changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 3c29612da1c5..d2826158ae60 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -187,7 +187,7 @@ static const struct llcc_slice_config sc8280xp_data[] = {
>>          { LLCC_MMUHWT,   13, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
>>          { LLCC_DISP,     16, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>>          { LLCC_AUDHW,    22, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>> -       { LLCC_DRE,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>> +       { LLCC_ECC,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>>          { LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>>          { LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0, 0 },
>>          { LLCC_WRCACHE,  31, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
>> @@ -358,6 +358,36 @@ static const struct llcc_slice_config sm8550_data[] =  {
>>          {LLCC_VIDVSP,   28,  256, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
>>   };
>>
>> +static const struct llcc_slice_config qdu1000_data_2ch[] = {
>> +       {LLCC_MDMHPGRW, 7, 512, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_MODHW,    9, 256, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_MDMPNG,  21, 256, 0, 1,   0x3, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_ECC,     26, 512, 3, 1, 0xFFC, 0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +       {LLCC_MODPE,   29, 256, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_APTCM,   30, 256, 3, 1,   0x0, 0xC, 1, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_WRCACHE, 31, 128, 1, 1,   0x3, 0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +};
>> +
>> +static const struct llcc_slice_config qdu1000_data_4ch[] = {
>> +       {LLCC_MDMHPGRW, 7, 1024, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_MODHW,    9, 512,  1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_MDMPNG,  21, 512,  0, 1,   0x3, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_ECC,     26, 1024, 3, 1, 0xFFC, 0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +       {LLCC_MODPE,   29, 512,  1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_APTCM,   30, 512,  3, 1,   0x0, 0xC, 1, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_WRCACHE, 31, 256,  1, 1,   0x3, 0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +};
>> +
>> +static const struct llcc_slice_config qdu1000_data_8ch[] = {
>> +       {LLCC_MDMHPGRW, 7, 2048, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_MODHW,    9, 1024, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_MDMPNG,  21, 1024, 0, 1,   0x3, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_ECC,     26, 2048, 3, 1, 0xFFC, 0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +       {LLCC_MODPE,   29, 1024, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_APTCM,   30, 1024, 3, 1,   0x0, 0xC, 1, 0, 0, 1, 0, 0, 0 },
>> +       {LLCC_WRCACHE, 31, 512,  1, 1,   0x3, 0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +};
>> +
>>   static const struct llcc_edac_reg_offset llcc_v1_edac_reg_offset = {
>>          .trp_ecc_error_status0 = 0x20344,
>>          .trp_ecc_error_status1 = 0x20348,
>> @@ -557,6 +587,38 @@ static const struct qcom_llcc_config sm8550_cfg[] = {
>>          { },
>>   };
>>
>> +static const struct qcom_llcc_config qdu1000_cfg[] = {
>> +       {
>> +               .sct_data       = qdu1000_data_8ch,
>> +               .size           = ARRAY_SIZE(qdu1000_data_8ch),
>> +               .need_llcc_cfg  = true,
>> +               .reg_offset     = llcc_v2_1_reg_offset,
>> +               .edac_reg_offset = &llcc_v2_1_edac_reg_offset,
>> +       },
>> +       {
>> +               .sct_data       = qdu1000_data_4ch,
>> +               .size           = ARRAY_SIZE(qdu1000_data_4ch),
>> +               .need_llcc_cfg  = true,
>> +               .reg_offset     = llcc_v2_1_reg_offset,
>> +               .edac_reg_offset = &llcc_v2_1_edac_reg_offset,
>> +       },
>> +       {
>> +               .sct_data       = qdu1000_data_4ch,
>> +               .size           = ARRAY_SIZE(qdu1000_data_4ch),
>> +               .need_llcc_cfg  = true,
>> +               .reg_offset     = llcc_v2_1_reg_offset,
>> +               .edac_reg_offset = &llcc_v2_1_edac_reg_offset,
>> +       },
>> +       {
>> +               .sct_data       = qdu1000_data_2ch,
>> +               .size           = ARRAY_SIZE(qdu1000_data_2ch),
>> +               .need_llcc_cfg  = true,
>> +               .reg_offset     = llcc_v2_1_reg_offset,
>> +               .edac_reg_offset = &llcc_v2_1_edac_reg_offset,
>> +       },
>> +       { },
>> +};
>> +
>>   static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
>>
>>   /**
>> @@ -1114,6 +1176,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>>   }
>>
>>   static const struct of_device_id qcom_llcc_of_match[] = {
>> +       { .compatible = "qcom,qdu1000-llcc", .data = qdu1000_cfg},
>>          { .compatible = "qcom,sc7180-llcc", .data = sc7180_cfg },
>>          { .compatible = "qcom,sc7280-llcc", .data = sc7280_cfg },
>>          { .compatible = "qcom,sc8180x-llcc", .data = sc8180x_cfg },
>> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
>> index 93417ba1ead4..1a886666bbb6 100644
>> --- a/include/linux/soc/qcom/llcc-qcom.h
>> +++ b/include/linux/soc/qcom/llcc-qcom.h
>> @@ -30,7 +30,7 @@
>>   #define LLCC_NPU         23
>>   #define LLCC_WLHW        24
>>   #define LLCC_PIMEM       25
>> -#define LLCC_DRE         26
>> +#define LLCC_ECC         26
>>   #define LLCC_CVP         28
>>   #define LLCC_MODPE       29
>>   #define LLCC_APTCM       30
>> --
>> 2.40.1
>>
>

