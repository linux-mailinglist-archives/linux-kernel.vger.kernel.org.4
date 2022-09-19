Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5FB5BCE61
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiISOUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiISOUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:20:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48CD101D3;
        Mon, 19 Sep 2022 07:20:05 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JD2DKA020587;
        Mon, 19 Sep 2022 14:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6FvUUMjBQ4Tmmg+xMylaMIdIDDi/qMiE1oA2eitemEg=;
 b=c0cs2ntQ96LO6vGDJ90HGKUw3M8DuJVIlfZ2uQJThQTkZAlWSsIwq24xbwsVt0TxGkax
 E2YGPwVhyMOzSahEFjkirUoA1PtztIcxWgWyAqyTm/oS/a7orlU8frCNleZvGTbYrK+P
 g+0PCRhT1fNlqkc6E+3Y+bXAjFhIvrnuMSxLSJbMzmeV9teEJPMixOhbqcTfvewn9eiv
 b2V2s7OLS1tE3Z8yZFaigDAaNoNrCsL9TQ9kHCRYoZ+LjJ/l/PB4PYorxJE8ddbU+v2K
 FTd5beITQKfiYu6FcHCu2X/2DRhP6n6FyJxImyyPHBBWojuBVyZA0xQnabs2XesznVno rA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6f84wym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 14:19:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JEJMkV010401
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 14:19:22 GMT
Received: from [10.216.41.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:19:16 -0700
Message-ID: <0497f6a4-6b9c-f0f9-56f5-8ec4e2becf61@quicinc.com>
Date:   Mon, 19 Sep 2022 19:49:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 7/8] remoteproc: qcom: Add support for memory sandbox
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com>
 <1662643422-14909-8-git-send-email-quic_srivasam@quicinc.com>
 <3c951582-070c-675f-14c7-ca033ca347b6@quicinc.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <3c951582-070c-675f-14c7-ca033ca347b6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oWky8pG9qXPxqCSc8H2_e7rPqKBKO1aO
X-Proofpoint-ORIG-GUID: oWky8pG9qXPxqCSc8H2_e7rPqKBKO1aO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190096
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/2022 3:40 PM, Sibi Sankar wrote:
Thanks for Your Time Sibi Sankar!!!
>
> On 9/8/22 6:53 PM, Srinivasa Rao Mandadapu wrote:
>> Update pil driver with SMMU mapping for allowing authorised
>> memory access to ADSP firmware, by carveout reserved adsp memory
>> region from device tree file.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>> Changes since V5:
>>     -- Remove adsp_rproc_unmap_smmu, adsp_of_unmap_smmu, 
>> adsp_of_map_smmu and
>>        adsp_rproc_map_smmu functions.
>>     -- Remove find_loaded_rsc_table call back initialization.
>>     -- Rename adsp_sandbox_needed to has_iommu.
>> Changes since V4:
>>     -- Split the code and add appropriate APIs for resource 
>> allocation and free.
>>     -- Update adsp_unmap_smmu with missing free ops call.
>>     -- Update normalizing length value in adsp_of_unmap_smmu.
>> Changes since V3:
>>     -- Rename is_adsp_sb_needed to adsp_sandbox_needed.
>>     -- Add smmu unmapping in error case and in adsp stop.
>> Changes since V2:
>>     -- Replace platform_bus_type with adsp->dev->bus.
>>     -- Use API of_parse_phandle_with_args() instead of 
>> of_parse_phandle_with_fixed_args().
>>     -- Replace adsp->is_wpss with adsp->is_adsp.
>>     -- Update error handling in adsp_start().
>>
>>   drivers/remoteproc/qcom_q6v5_adsp.c | 55 
>> ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index ccb5592..e55d593 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/firmware.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>> +#include <linux/iommu.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mfd/syscon.h>
>> @@ -48,6 +49,8 @@
>>   #define LPASS_PWR_ON_REG        0x10
>>   #define LPASS_HALTREQ_REG        0x0
>>   +#define SID_MASK_DEFAULT        0xF
>> +
>>   #define QDSP6SS_XO_CBCR        0x38
>>   #define QDSP6SS_CORE_CBCR    0x20
>>   #define QDSP6SS_SLEEP_CBCR    0x3c
>> @@ -333,6 +336,42 @@ static int adsp_load(struct rproc *rproc, const 
>> struct firmware *fw)
>>       return 0;
>>   }
>>   +static void adsp_unmap_smmu(struct rproc *rproc)
>> +{
>> +    struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> +
>> +    iommu_unmap(rproc->domain, adsp->mem_phys, adsp->mem_size);
>> +}
>> +
>> +static int adsp_map_smmu(struct qcom_adsp *adsp, struct rproc *rproc)
>
> you could perhaps name the func to adsp_map_carveout/adsp_unmap_carveout
Okay. Will modify accordingly.
>
>
>> +{
>> +    struct of_phandle_args args;
>> +    long long sid;
>> +    unsigned long iova;
>> +    int ret;
>> +
>> +    if (!rproc->domain)
>> +        return -EINVAL;
>> +
>> +    ret = of_parse_phandle_with_args(adsp->dev->of_node, "iommus", 
>> "#iommu-cells", 0, &args);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    sid = args.args[0] & SID_MASK_DEFAULT;
>> +
>> +    /* Add SID configuration for ADSP Firmware to SMMU */
>> +    iova =  adsp->mem_phys | (sid << 32);
>> +
>> +    ret = iommu_map(rproc->domain, iova, adsp->mem_phys,
>> +            adsp->mem_size,    IOMMU_READ | IOMMU_WRITE);
>> +    if (ret) {
>> +        dev_err(adsp->dev, "Unable to map ADSP Physical Memory\n");
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int adsp_start(struct rproc *rproc)
>>   {
>>       struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> @@ -343,9 +382,17 @@ static int adsp_start(struct rproc *rproc)
>>       if (ret)
>>           return ret;
>>   +    if (adsp->has_iommu) {
>> +        ret = adsp_map_smmu(adsp, rproc);
>> +        if (ret) {
>> +            dev_err(adsp->dev, "ADSP smmu mapping failed\n");
>> +            goto disable_irqs;
>> +        }
>> +    }
>> +
>>       ret = clk_prepare_enable(adsp->xo);
>>       if (ret)
>> -        goto disable_irqs;
>> +        goto adsp_smmu_unmap;
>>         ret = qcom_rproc_pds_enable(adsp, adsp->proxy_pds,
>>                       adsp->proxy_pd_count);
>> @@ -401,6 +448,9 @@ static int adsp_start(struct rproc *rproc)
>>       qcom_rproc_pds_disable(adsp, adsp->proxy_pds, 
>> adsp->proxy_pd_count);
>>   disable_xo_clk:
>>       clk_disable_unprepare(adsp->xo);
>> +adsp_smmu_unmap:
>> +    if (adsp->has_iommu)
>> +        adsp_unmap_smmu(rproc);
>>   disable_irqs:
>>       qcom_q6v5_unprepare(&adsp->q6v5);
>>   @@ -429,6 +479,9 @@ static int adsp_stop(struct rproc *rproc)
>>       if (ret)
>>           dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
>>   +    if (adsp->has_iommu)
>> +        adsp_unmap_smmu(rproc);
>> +
>>       handover = qcom_q6v5_unprepare(&adsp->q6v5);
>>       if (handover)
>>           qcom_adsp_pil_handover(&adsp->q6v5);
>>
