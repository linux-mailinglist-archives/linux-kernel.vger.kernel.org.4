Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4D56F620A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjECXYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjECXYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:24:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F8A8A74;
        Wed,  3 May 2023 16:24:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343NBmCE018439;
        Wed, 3 May 2023 23:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=v73srPm2Ygdh8jPbwFEnqSjx3SDVfJDGkEjFiw8b6N8=;
 b=a6Z7oRCgkYJ+3gjwA8iSf4wX+lxbEYB4a+UzonVGrvbHD1H3c2DMjtYgJruPeskWqiFT
 D3QHeQlxsWitqawZbyvl6AQpI+JXiHELjQJDKXIAuIqmENp4gpqwGRaTv4S8E+3GSTuj
 xmtmhXKq7cOormTDnMpiRoKRR2WcNYHC+uca5xqucwfzalGC/eRHhBSs25Z+coPzvOM3
 hL0pKUwYizJ+gCeYV2qVw7O2s+Szkh7O2oVmC2WncN26uw78iBvh4ro2kljjd1nysmkc
 NaqiE4WMATD7xvlKCOuw2iLrhwlfQPu5yOfm2ieEAi30zCdBdB1X3MOGjHuLUsSIGYy3 wg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbn0a9kbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 23:24:32 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343NO8lv005662
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 23:24:08 GMT
Received: from [10.71.110.193] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 3 May 2023
 16:24:08 -0700
Message-ID: <5c54a6f1-63e1-0870-4fb1-f9128291d15a@quicinc.com>
Date:   Wed, 3 May 2023 16:24:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/4] drm/msm/dpu: Add has_data_compress to dpu_caps
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230405-add-dsc-support-v1-0-6bc6f03ae735@quicinc.com>
 <20230405-add-dsc-support-v1-3-6bc6f03ae735@quicinc.com>
 <v5hmqtjwd3syqwo5nqru7xgpt3rv5ubfbzt6pssriyb7cuprkf@7zdvwsil67nc>
 <7117aadb-0289-01ff-6eb9-8bfc358eca63@quicinc.com>
 <46an5zrsxplqo3h35okjyhfes6sqwmw5kez3nm3x5vrkqyvsn5@lxca65m7ju6n>
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <46an5zrsxplqo3h35okjyhfes6sqwmw5kez3nm3x5vrkqyvsn5@lxca65m7ju6n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ESwn2-N3gT_KrTnHV0ym-VmikpmPWYA2
X-Proofpoint-ORIG-GUID: ESwn2-N3gT_KrTnHV0ym-VmikpmPWYA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=825 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030201
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/2023 4:03 PM, Marijn Suijten wrote:
> Hi Jessica,
> 
> On 2023-05-03 12:03:40, Jessica Zhang wrote:
>>
>>
>> On 5/3/2023 12:07 AM, Marijn Suijten wrote:
>>> On 2023-05-02 18:19:14, Jessica Zhang wrote:
>>>> Add data_compress feature to DPU HW catalog.
>>>>
>>>> In DPU 7.x and later, there is a DATA_COMPRESS register that must be set
>>>> within the DPU INTF block for DSC to work.
>>>>
>>>> As core_rev (and related macros) was removed from the dpu_kms struct, the
>>>> most straightforward way to indicate the presence of this register would be
>>>> to have a flag in dpu_caps.
>>>
>>> This is a very generic name to have in the global dpu_caps for a very
>>> specific register on the INTF block since DPU >= 7.0.0, and I doubt any
>>> new catalog contributor will know how to fill this field.  After all,
>>> DPU < 7.0.0 also has DCE but it is controlled via the PINGPONG block.
>>>
>>> Instead, how about having it as a DPU_INTF_DATA_COMPRESS (or similar)
>>> feature flag on the INTF block?  We do the same for other (register
>>> related) features on the INTF block, and you did the same to disable DSC
>>> callbacks on PP in [1].
> 
> (Note: I said "you" but meant Kuogee)
> 
>> Hi Marijn,
>>
>> Sounds good.
>>
>>>
>>> In fact it seems that the DSC/DCE (enablement) registers have been moved
>>> from PINGPONG to INTF in DPU 7.0.0.  Can you clarify in the patch
>>> message for v2 that this is the case, and do the same in the linked
>>> PINGPONG patch?  Perhaps these patches should be part of the same series
>>> as they do not seem DSI-specific.
>>
>> Will make a note of the PP to INTF change in the commit message.
> 
> Thanks.
> 
>> I would prefer to keep this patch in this series is because it is needed
>> for DSI over command mode to work and the subsequent patch is
>> specifically for command mode.
> 
> That is fine, but do mention this in the commit message if it is
> relevant here.  Otherwise only mention it as part of patch 4/4.

Acked.

Thanks,

Jessica Zhang

> 
> - Marijn
