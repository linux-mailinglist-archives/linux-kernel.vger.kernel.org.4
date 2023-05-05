Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8D6F8369
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjEENBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEENBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:01:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC56A1E988;
        Fri,  5 May 2023 06:01:14 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345BmmTu030028;
        Fri, 5 May 2023 13:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yppvM9mo+aLKslS+25R4RlpqOihLSCJGVrhyXbQmvrc=;
 b=HloXgDBzCnB++knWBwhtgy2fWpG7Z/E/1YWl/gMrjb1Lrh6C+EjMLF2y4wGhpbU+ZfLQ
 Gx0gHWHNG49LgYbwaVr4jm2GdjDphZIhplC8PnjxkBIASnu1Ub5F3Uh5dTfL8TOJm4OI
 hyLu4lZCasikEglQn7hxVsotVVfMKketqawvZQhjZ2A+9pnyypQ5fQcWIXEiRX8JSXaE
 eXKRtPDAaUNbDvlJQ+4OQmlbaSj5wNj4empAoTPiX6bKabWT7SRk/rBhjYvCrYKuolwe
 4HypxzuRUE0WQ2+OVnqTAaz0mbdM84KWJ/d1X6830MGbZ9Itp4YEkFP4XJ449Yy6a2LI 9w== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qckf71mkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 13:00:42 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 345D0fMB008625
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 13:00:41 GMT
Received: from [10.216.37.178] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 5 May 2023
 06:00:36 -0700
Message-ID: <579f3480-1cbc-5688-7226-986205b5825e@quicinc.com>
Date:   Fri, 5 May 2023 18:30:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 06/18] media: venus: firmware: Leave a clue for
 homegrown porters
Content-Language: en-US
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
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
In-Reply-To: <ef50ac6c-a635-7f83-c484-a4f91b5e5d12@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YIpR0oCdUPuyh5BPzjeJAS4uaiEDZiEa
X-Proofpoint-ORIG-GUID: YIpR0oCdUPuyh5BPzjeJAS4uaiEDZiEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_20,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050108
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/2023 6:27 PM, Vikash Garodia wrote:
>
> On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
>> Leave a clue about where the seemingly magic values come from, as it
>> is not obvious and requires some digging downstream..
Rephrase the commit text.
>> Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/venus/firmware.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/firmware.c 
>> b/drivers/media/platform/qcom/venus/firmware.c
>> index cfb11c551167..a4cd919e1dbe 100644
>> --- a/drivers/media/platform/qcom/venus/firmware.c
>> +++ b/drivers/media/platform/qcom/venus/firmware.c
>> @@ -241,6 +241,13 @@ int venus_boot(struct venus_core *core)
>>           return ret;
>>         if (core->use_tz && res->cp_size) {
>> +        /*
>> +         * Clues for porting using downstream data:
>> +         * cp_start = 0
>> +         * cp_size = venus_ns/virtual-addr-pool[0] (yes, addr not size)
>
> The field is the start address of ns context bank. Since the cp_start 
> is 0, the start address for (next) non-secure context bank
>
> is interpreted as size of the (previous) content protection region.
>
>> +         * cp_nonpixel_start = venus_sec_non_pixel/virtual-addr-pool[0]
>> +         * cp_nonpixel_size = venus_sec_non_pixel/virtual-addr-pool[1]
>> +         */
>>           ret = qcom_scm_mem_protect_video_var(res->cp_start,
>>                                res->cp_size,
>>                                res->cp_nonpixel_start,
>>
