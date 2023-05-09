Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6A6FC5BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjEIMBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjEIMBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:01:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDBB1713;
        Tue,  9 May 2023 05:01:38 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349ASFxM018918;
        Tue, 9 May 2023 12:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rFWxx/yqlbgsjzLBRvryLMRgg6Bs28xakqZEhpRdvDk=;
 b=itoPX8Zik6FYry9BLDl31+MD2lHs5A+aI8LKqULHiXbdA+9l9X1i8xEI3Nx3aOD6M0YI
 sF25OVkf6TNnh6BHN24JWt7K9RvcFzGXuCtdBnvKXXqwC2PwzBdkxfqjl56f9zTKJ/Ha
 Ry+el3VLK0f6UEfyiw01Ju5WzhrdfbOcppOtwkItBwy1A7inAggEFxDX8IvCcGrEkWhr
 OpxYyibFe/Wjoi2Nv7SZ8pxLQ7IH3XQr+9iTvhIHL6fAab7b9nNp2XRplHUwuVZxn5VR
 VTFmMpm1i7PvGEQ1/yEdDUcn62YaybR92oifcxRJUloFXvd3j7o0062tTJZ3900l5Ps1 ag== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf77g1pbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 12:01:03 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349C12xF029893
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 12:01:02 GMT
Received: from [10.216.61.171] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 9 May 2023
 05:00:57 -0700
Message-ID: <df8d6f3b-28f5-551f-b585-db237eb93545@quicinc.com>
Date:   Tue, 9 May 2023 17:30:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 06/18] media: venus: firmware: Leave a clue for
 homegrown porters
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <20230228-topic-venus-v2-6-d95d14949c79@linaro.org>
 <ef50ac6c-a635-7f83-c484-a4f91b5e5d12@quicinc.com>
 <579f3480-1cbc-5688-7226-986205b5825e@quicinc.com>
 <9acc7001-2b3a-f635-9814-95850a71f142@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <9acc7001-2b3a-f635-9814-95850a71f142@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ccT-cbVLcZ4lCLkVG6q3EMx18l-HkrZs
X-Proofpoint-ORIG-GUID: ccT-cbVLcZ4lCLkVG6q3EMx18l-HkrZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090096
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/2023 12:54 AM, Konrad Dybcio wrote:
> 
> 
> On 5.05.2023 15:00, Vikash Garodia wrote:
>>
>> On 5/5/2023 6:27 PM, Vikash Garodia wrote:
>>>
>>> On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
>>>> Leave a clue about where the seemingly magic values come from, as it
>>>> is not obvious and requires some digging downstream..
>> Rephrase the commit text.
> Please be more specific, do you want me to use the
> explanations you gave in the previous reply?

Something which describes the patch like - Add comments to describe the
arguments of the qcom_scm_mem_protect_video_var TZ call. The TZ call programs
the video hardware with CP and non-CP VARs, and the comments describes these VARs.

> Konrad
>>>> Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>>>> ---
>>>>   drivers/media/platform/qcom/venus/firmware.c | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
>>>> index cfb11c551167..a4cd919e1dbe 100644
>>>> --- a/drivers/media/platform/qcom/venus/firmware.c
>>>> +++ b/drivers/media/platform/qcom/venus/firmware.c
>>>> @@ -241,6 +241,13 @@ int venus_boot(struct venus_core *core)
>>>>           return ret;
>>>>         if (core->use_tz && res->cp_size) {
>>>> +        /*
>>>> +         * Clues for porting using downstream data:
>>>> +         * cp_start = 0
>>>> +         * cp_size = venus_ns/virtual-addr-pool[0] (yes, addr not size)
>>>
>>> The field is the start address of ns context bank. Since the cp_start is 0, the start address for (next) non-secure context bank
>>>
>>> is interpreted as size of the (previous) content protection region.
>>>
>>>> +         * cp_nonpixel_start = venus_sec_non_pixel/virtual-addr-pool[0]
>>>> +         * cp_nonpixel_size = venus_sec_non_pixel/virtual-addr-pool[1]
>>>> +         */
>>>>           ret = qcom_scm_mem_protect_video_var(res->cp_start,
>>>>                                res->cp_size,
>>>>                                res->cp_nonpixel_start,
>>>>
