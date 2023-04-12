Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A4C6DFCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjDLRde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDLRda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:33:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A795BAA;
        Wed, 12 Apr 2023 10:33:29 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CAJKAV013575;
        Wed, 12 Apr 2023 17:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+hQca6aJFCTeUv4DhPPARdu8+ozw1MikI+1sASk8QeM=;
 b=Jo+jogq89Vnp6T7RKZ70yo9RgojTCksqe1uEAjXH/dmMz1YFWE0rIY6gk+8PiEBRNVEB
 VL5CwPBE/da6rqSXsaTXrKvs6KFLf/M8MArwbxrZKxlu9+BfAE7y3B/SaHDx+mRmLtsA
 HwSMM+UjukdM+wvPD/+38gFMRl9LumIvH3RNSJ++V8iDyaLCOAtgYfe0FqljSzw5gLin
 PYVR/6jvSag4/ljq6DaNYlRbteuXLpZddVgdd63JBvEUqXBn64HGMoLqSWmOJmlvW15Z
 qD33GKfk4IoYmFD0bUog79pEr0NX4hC+FpdqHD/CS8PQjoK91Fz/1mMhXxWPMNU1orGx 7A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwqn1hd6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 17:33:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CHXHl0014185
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 17:33:17 GMT
Received: from [10.110.115.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 10:33:16 -0700
Message-ID: <e78e576a-2a04-e7ca-f6c4-701d508541ad@quicinc.com>
Date:   Wed, 12 Apr 2023 10:33:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu: always program dsc active bits
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1681247095-1201-1-git-send-email-quic_khsieh@quicinc.com>
 <z7wj2lcgcdxsqh7ylhec3ig6o4p6q37zqvpzoxp4bd4vid2z2n@ubsgt3ebqrwr>
 <83f9a438-52c5-83f3-1767-92d16518d8f0@quicinc.com>
 <feedv4isliterjtwyicqfarwuvzhtov3jkmvjcwqvt7itkyh7y@e2jq5t6r3lxc>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <feedv4isliterjtwyicqfarwuvzhtov3jkmvjcwqvt7itkyh7y@e2jq5t6r3lxc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -r8w261Un6rqEpUZc2hU7W3jdsN8Hsre
X-Proofpoint-ORIG-GUID: -r8w261Un6rqEpUZc2hU7W3jdsN8Hsre
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=695 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120150
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/2023 12:24 AM, Marijn Suijten wrote:
> On 2023-04-11 16:45:34, Abhinav Kumar wrote:
> [..]
>>> Does this flush all DSCs programmed in CTL_DSC_FLUSH as set above?  That
>>> is currently still in `if (cfg->dsc)` and never overwritten if all DSCs
>>> are disabled, should it be taken out of the `if` to make sure no DSCs
>>> are inadvertently flushed, or otherwise cache the "previous mask" to
>>> make sure we flush exactly the right DSC blocks?
>>>
>>
>> Yes, DSC flush is hierarchical. This is the main DSC flush which will
>> enforce the flush of the DSC's we are trying to flush in the
>> CTL_DSC_FLUSH register.
> 
> That's what I was thinking, thanks for confirming.
> 
>> So if DSC was active, the CTL_FLUSH will only enforce the flush of the
>> DSC's programmed in CTL_DSC_FLUSH
>>
>> If DSC is not active, we still need to flush that as well (that was the
>> missing bit).
>>
>> No need to cache previous mask. That programming should be accurate in
>> cfg->dsc already.
> 
> This kind of implicit dependency warrants a comment at the very least.
> 

Sure.

> What happens if a device boots without DSC panel connected?  Will
> CTL_DSC_FLUSH be zero and not (unnecessarily, I assume) flush any of the
> DSC blocks?  Or could this flush uninitialized state to the block?
> 

If we bootup without DSC panel connected, the kernel's cfg->dsc will be 
0 and default register value of CTL_DSC_FLUSH will be 0 so it wont flush 
any DSC blocks. Sure, as I wrote in the other response, we can move this 
to reset_intf_cfg later when the other pieces are fixed. And leave a 
FIXME here.

> - Marijn
