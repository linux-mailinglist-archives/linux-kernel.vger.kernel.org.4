Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE176E7F23
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjDSQGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjDSQGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:06:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B9A10C7;
        Wed, 19 Apr 2023 09:06:01 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JC4EY0006968;
        Wed, 19 Apr 2023 16:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ghih59l77BimLZsOkkfjGfE/JW6vIG6Nn+R0fM4hb/I=;
 b=pXpNZK+rBbFnwS3mg7PHqEuKLfRwb99N7pQVsS4h6qHqua9USlmoFFht0tE+gnhCuMOu
 4A3u8uIonYyqcBWEoIN3I1/yucQGZkHkBztO+CtTv/m+wUZj3lL+A4sCXhLh9wmmUpie
 vCGQCCrLW2UqAmdqN7Ra0ny1vG1erfIonVvjPeZRJt4u+9ff4Lf7cyifwjcO56xjxneY
 6zYuaKx6R+cHdrD7s5NcbiK+EtHclYDeI6U/hZV66ChcdQ8Yn/Ev6s0uw3gTWJx41+ka
 fOGkbwDYvcR1AgjGPYmE0oWXZwEkLt9PMxm4qG8L9BYLvLjRyiZXh68DDp/5e3qQ1Svi Fg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q25kwsyh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 16:05:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33JG5nKX027637
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 16:05:49 GMT
Received: from [10.110.74.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 19 Apr
 2023 09:05:48 -0700
Message-ID: <0eff5993-7826-25c7-cdde-8291b947eed4@quicinc.com>
Date:   Wed, 19 Apr 2023 09:05:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/3] drm/msm/dpu: Assign missing writeback log_mask
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230418-dpu-drop-useless-for-lookup-v1-0-b9897ceb6f3e@somainline.org>
 <20230418-dpu-drop-useless-for-lookup-v1-2-b9897ceb6f3e@somainline.org>
 <60bb4a4a-f414-e926-df53-d6d1a01fc221@quicinc.com>
 <p5b6zwgbrxbhs7hgo4sh2btwmbjgoyxp5mxdutt4fkh2hjv7dz@6dq5ug5l2ohu>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <p5b6zwgbrxbhs7hgo4sh2btwmbjgoyxp5mxdutt4fkh2hjv7dz@6dq5ug5l2ohu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wurd_67FZrzjGh6floZpR6sXoy13DDxx
X-Proofpoint-GUID: wurd_67FZrzjGh6floZpR6sXoy13DDxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_10,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=992 mlxscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190145
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/2023 2:28 AM, Marijn Suijten wrote:
> On 2023-04-18 09:06:34, Abhinav Kumar wrote:
>>
>> On 4/17/2023 4:14 PM, Marijn Suijten wrote:
>>> The WB debug log mask ended up never being assigned, leading to writes
>>> to this block to never be logged even if the mask is enabled in
>>> dpu_hw_util_log_mask via sysfs.
>>
>> This should be debugfs not sysfs.
> 
> Good catch!  I've queued this up for v2 if it comes to it, otherwise it
> can perhaps be fixed up while applying for msm-fixes?
> 

Yes, I can fix it up while applying to -fixes.

>>> Fixes: 84a33d0fd921 ("drm/msm/dpu: add dpu_hw_wb abstraction for writeback blocks")
>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>> ---
>>
>> With that fixed,
>>
>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Thanks!
> 
> - Marijn
