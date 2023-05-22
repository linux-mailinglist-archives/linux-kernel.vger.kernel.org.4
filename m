Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC7770CD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjEVWC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjEVWCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:02:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974D6E9;
        Mon, 22 May 2023 15:02:10 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLXKgN032383;
        Mon, 22 May 2023 22:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8GvuSPgZNd92C4M1QHSsTSkbArm56P31JsJM4xaanXk=;
 b=GdPLmhx+SeQh8x9C4FSciuQzzhAT1VJPLVS+/QTI+hddp8plBXnPjZcSW8v0uBXCv0vU
 nDpSQsic1ubrRynOQFGDR2Ktbv7aN6sMrUAt/1U7K5HBRXKuLSQUv5UfMHucDpeiRJa2
 YEXog0IRiCnwvfSB+ye26Ekh2kmfZdeTs+bhruNtFqodFa/u6q3m1BZQprLzgOayrHv2
 PpLFgO7B0KOeAfghGSOJziRNgMfy6Tdn5rsaCc0IS7QGR4kXMEhf22FgKA+nFawNaE3z
 ozSTGALLTFj81pj9qfIIk3ul2FTA+Js2WzNJfrSVjfv9tcXajQoW0f61gLPmHInYO2aW /w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrc388g9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 22:02:05 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34MM232s001638
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 22:02:03 GMT
Received: from [10.71.110.193] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 22 May
 2023 15:02:03 -0700
Message-ID: <81b146de-c2fa-bd40-dee2-006cd7abb6a8@quicinc.com>
Date:   Mon, 22 May 2023 15:02:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Freedreno] [PATCH v4 3/5] drm/msm/dpu: Add
 DPU_INTF_DATA_COMPRESS feature flag
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     <freedreno@lists.freedesktop.org>, Sean Paul <sean@poorly.run>,
        "Abhinav Kumar" <quic_abhinavk@quicinc.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rob Clark" <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>
References: <20230405-add-dsc-support-v4-0-15daf84f8dcb@quicinc.com>
 <20230405-add-dsc-support-v4-3-15daf84f8dcb@quicinc.com>
 <qrxir7a6l75ocavrwdfearjz6j4etwvzmqwc7o5ftrdc6awwz4@wsoftsrewqcm>
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <qrxir7a6l75ocavrwdfearjz6j4etwvzmqwc7o5ftrdc6awwz4@wsoftsrewqcm>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0L1uDQw0ohzzbYff5nMBfP1_Cdw67pbp
X-Proofpoint-ORIG-GUID: 0L1uDQw0ohzzbYff5nMBfP1_Cdw67pbp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220186
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 1:47 PM, Marijn Suijten wrote:
> Can you fit DPU >= 7.0 in the title?

Hi Marijn,

Sure.

> 
> On 2023-05-22 13:30:22, Jessica Zhang wrote:
>> Add DATA_COMPRESS feature flag to DPU INTF block.
> 
> Nit: repeating the title, perhaps you can reflow this with the second
> paragraph?

Acked.

Thanks,

Jessica Zhang

> 
> - Marijn
> 
>> In DPU 7.x and later, DSC/DCE enablement registers have been moved from
>> PINGPONG to INTF.
>>
>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 3 ++-
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 ++
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> index 7944481d0a33..8e12e07728df 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> @@ -104,7 +104,8 @@
>>   #define INTF_SC7180_MASK \
>>   	(BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE) | BIT(DPU_INTF_STATUS_SUPPORTED))
>>   
>> -#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN)
>> +#define INTF_SC7280_MASK \
>> +	(INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN) | BIT(DPU_INTF_DATA_COMPRESS))
>>   
>>   #define WB_SM8250_MASK (BIT(DPU_WB_LINE_MODE) | \
>>   			 BIT(DPU_WB_UBWC) | \
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> index 4eda2cc847ef..01c65f940f2a 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> @@ -185,6 +185,7 @@ enum {
>>    * @DPU_DATA_HCTL_EN                Allows data to be transferred at different rate
>>    *                                  than video timing
>>    * @DPU_INTF_STATUS_SUPPORTED       INTF block has INTF_STATUS register
>> + * @DPU_INTF_DATA_COMPRESS          INTF block has DATA_COMPRESS register
>>    * @DPU_INTF_MAX
>>    */
>>   enum {
>> @@ -192,6 +193,7 @@ enum {
>>   	DPU_INTF_TE,
>>   	DPU_DATA_HCTL_EN,
>>   	DPU_INTF_STATUS_SUPPORTED,
>> +	DPU_INTF_DATA_COMPRESS,
>>   	DPU_INTF_MAX
>>   };
>>   
>>
>> -- 
>> 2.40.1
>>
