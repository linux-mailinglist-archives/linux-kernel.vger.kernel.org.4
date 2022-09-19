Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0311A5BCDD0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiISOAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiISOAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:00:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E049D10D;
        Mon, 19 Sep 2022 06:59:59 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JDcQCW020820;
        Mon, 19 Sep 2022 13:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YJ6lt8jijqWxdiUZpeN9DUy3QpZl0C9wO+k+f22TYhg=;
 b=DObkgIha+VFfNvfrwPWYlXAiPVWVS12sD7eJLZmJASOWibJWM/fn5Qzrz63vuVYTIWA8
 JTGS8ft4e53pHgQH+zToRTeEZzY/vt8HqLZ7jrsuptnFav4ipS2DQyuY6BxpFxyluUAb
 9UNj+zBT3cz9kQNvpCW0LtxJBB5Jxw9o8CDtmNpY2cGPwXsSIH9kTVmDRS3yWYoIm+AJ
 HCvCBZBaHuH/4BWTrxkLeD223HhE8pd5lX9yFnoq3B6OybMG0QB6kpwZrwVehD0CpVaZ
 64ww5oX1+MNhOMKX7DgrtbNggDim6ea1CoAn3Eqszi4RSpj4jGxGGhOrZJV6VjFX6trG 9g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6bumd97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 13:59:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JDxHqw024271
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 13:59:17 GMT
Received: from [10.216.41.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 06:59:12 -0700
Message-ID: <e9b0187b-f4b1-5aef-862e-7bc2bbab4e1a@quicinc.com>
Date:   Mon, 19 Sep 2022 19:29:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 7/8] remoteproc: qcom: Add support for memory sandbox
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bgoswami@quicinc.com>, <bjorn.andersson@linaro.org>,
        <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <judyhsiao@chromium.org>, <lgirdwood@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <perex@perex.cz>,
        <quic_plai@quicinc.com>, <quic_rohkumar@quicinc.com>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>
References: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com>
 <1662643422-14909-8-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53CUPAW2P5uC-4fN+qPw0PLCaz4Dfom7htYOTT9-o+A9Q@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n53CUPAW2P5uC-4fN+qPw0PLCaz4Dfom7htYOTT9-o+A9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gGp6h2FQqNJ__92cyf3bsbZ_BgrOqbQ2
X-Proofpoint-GUID: gGp6h2FQqNJ__92cyf3bsbZ_BgrOqbQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190093
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/12/2022 4:31 AM, Stephen Boyd wrote:
Thanks for Your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-09-08 06:23:41)
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index ccb5592..e55d593 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/firmware.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>> +#include <linux/iommu.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mfd/syscon.h>
>> @@ -48,6 +49,8 @@
>>   #define LPASS_PWR_ON_REG               0x10
>>   #define LPASS_HALTREQ_REG              0x0
>>
>> +#define SID_MASK_DEFAULT        0xF
>> +
>>   #define QDSP6SS_XO_CBCR                0x38
>>   #define QDSP6SS_CORE_CBCR      0x20
>>   #define QDSP6SS_SLEEP_CBCR     0x3c
>> @@ -333,6 +336,42 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>>          return 0;
>>   }
>>
>> +static void adsp_unmap_smmu(struct rproc *rproc)
>> +{
>> +       struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> Drop the cast, it's unnecessary.
Okay. Will drop casting.
>
>> +
>> +       iommu_unmap(rproc->domain, adsp->mem_phys, adsp->mem_size);
>> +}
>> +
> [..]
>> @@ -343,9 +382,17 @@ static int adsp_start(struct rproc *rproc)
>>          if (ret)
>>                  return ret;
>>
>> +       if (adsp->has_iommu) {
>> +               ret = adsp_map_smmu(adsp, rproc);
>> +               if (ret) {
>> +                       dev_err(adsp->dev, "ADSP smmu mapping failed\n");
>> +                       goto disable_irqs;
>> +               }
>> +       }
>> +
>>          ret = clk_prepare_enable(adsp->xo);
>>          if (ret)
>> -               goto disable_irqs;
>> +               goto adsp_smmu_unmap;
>>
>>          ret = qcom_rproc_pds_enable(adsp, adsp->proxy_pds,
>>                                      adsp->proxy_pd_count);
>> @@ -401,6 +448,9 @@ static int adsp_start(struct rproc *rproc)
>>          qcom_rproc_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>>   disable_xo_clk:
>>          clk_disable_unprepare(adsp->xo);
>> +adsp_smmu_unmap:
>> +       if (adsp->has_iommu)
>> +               adsp_unmap_smmu(rproc);
> Why not pass adsp directly to adsp_unmap_smmu()? And even better would
> be to make it a no-op when adsp->has_iommu is false, so that the code
> reads straight-line otherwise.
Okay. Will update accordingly.
>
>>   disable_irqs:
>>          qcom_q6v5_unprepare(&adsp->q6v5);
>>
>> @@ -429,6 +479,9 @@ static int adsp_stop(struct rproc *rproc)
>>          if (ret)
>>                  dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
>>
>> +       if (adsp->has_iommu)
>> +               adsp_unmap_smmu(rproc);
>> +
>>          handover = qcom_q6v5_unprepare(&adsp->q6v5);
>>          if (handover)
>>                  qcom_adsp_pil_handover(&adsp->q6v5);
>> --
>> 2.7.4
>>
