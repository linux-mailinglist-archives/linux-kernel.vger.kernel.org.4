Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161E56F6D7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjEDOEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjEDOEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:04:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7510C86B4;
        Thu,  4 May 2023 07:04:43 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34470PpV019322;
        Thu, 4 May 2023 14:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O2HZAVGgMqOM1nhiFWSbffcr2h3NIs/YgmWGVPBFBHk=;
 b=HK+0eKIjVZTz2E3WtFhc6poQnCUkvHgVOe3D40tQhPHroXcS9t1113SvSJ5YNlCQqis6
 o4Ny7nhnMlCYGpvdq/p4+nAaa3ItHH6Ka+yI+kQA5G4AqQw40sfuVtMA6qQNSnpaNXnB
 +E6i3TBKhRcoR8RhEhw6UsPXBFKEO4JA+8SJLc559+3HxI5u9UwCzuwMyS8ZhRlvxm2E
 VKxwmUGTFLKqSwv6d4HRCZXjPElUkgtEp8V4C6jTQEGaThRHKY4f1DU1P9x8qe4UD6W1
 p1VMWs4bsm2TXvFEPeyhiy9qRF0QCq8h+jNGbuxqh5dXbvexii4vslwBcdLZpK0ukZYx qQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc50419yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 14:04:35 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 344E4YMH024591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 14:04:34 GMT
Received: from [10.252.212.215] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 4 May 2023
 07:04:31 -0700
Message-ID: <facc9800-6af4-5cb3-bd22-b22b2250090a@quicinc.com>
Date:   Thu, 4 May 2023 19:34:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/4] venus: add support for 10 bit decoding
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        <linux-media@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
 <8df7f24b-9dbe-4491-bcb1-f53021bb482f@linaro.org>
 <66b8e665-1038-127a-1f4f-20d8fe7bcd8e@linaro.org>
Content-Language: en-US
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <66b8e665-1038-127a-1f4f-20d8fe7bcd8e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QviRIapVLx6W-XTPU26tMQLk-N4yaRlO
X-Proofpoint-ORIG-GUID: QviRIapVLx6W-XTPU26tMQLk-N4yaRlO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_09,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040115
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/2023 7:21 PM, Bryan O'Donoghue wrote:
> On 04/05/2023 14:49, Bryan O'Donoghue wrote:
>> On 04/05/2023 11:36, Dikshita Agarwal wrote:
>>> This series includes the changes to
>>>    - add V4L2_PIX_FMT_P010 as supported decoder format.
>>>    - consider dpb color format while calculating buffer
>>>      size for dpb buffers.
>>>    - update dpb and opb color format when bit depth
>>>      changes is detected, also update preferred color
>>>      format to P010 in this case.
>>>
>>> With this series, divided the previous version [1] into
>>> multiple patches as suggested in review comments.
>>>
>>> [1] 
>>> https://patchwork.linuxtv.org/project/linux-media/list/?series=10376
>>>
>>> Dikshita Agarwal (4):
>>>    venus: add support for V4L2_PIX_FMT_P010 color format
>>>    venus: update calculation for dpb buffers
>>>    venus: add handling of bit depth change from firmwar
>>>    venus: return P010 as preferred format for 10 bit decode
>>>
>>>   drivers/media/platform/qcom/venus/helpers.c        | 24 
>>> ++++++++++++++++++++++
>>>   drivers/media/platform/qcom/venus/hfi_plat_bufs.h  |  3 +++
>>>   .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   |  8 +++++++-
>>>   drivers/media/platform/qcom/venus/vdec.c           | 16 
>>> +++++++++++++--
>>>   4 files changed, 48 insertions(+), 3 deletions(-)
>>>
>>
>> For future reference a series like this should:
>>
>> 1. Include a log of what changed between the last series and this
>> 2. Describe which comments you addressed
>>     I generally try to say
>>     "Added newline to dts - Konrad"
>>     "Sent the series as a -v3 - Bryan"
>>     etc
>> 3. Ideally provide a link to the previous series in
>>
>> https://lore.kernel.org/linux-arm-msm/1682492417-20496-1-git-send-email-quic_dikshita@quicinc.com/ 
>>
>> 4. Use versioning
>>     This set should be prefixed with "v2-0000-cover-letter" 
>> "v2-0001-add-support" etc
>>
>> "git format-patch mybase..targettip --cover-letter -v2"
>>
>> ---
>> bod
>
> Doh I see you did most of that - just missed the V2.
>
> Please remember to version your subsequent series. "git format-patch -v2"

Does this qualify for a version upgrade when a single patch is 
subsequently raised as series ? IMO, the link

to previous single patch in cover letter and then starting the series 
(as v0) seems to provide the required info.

>
> ---
> bod
