Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DF3703CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbjEOSnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbjEOSnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:43:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FDFD047;
        Mon, 15 May 2023 11:43:30 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FHQogp032030;
        Mon, 15 May 2023 18:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=R0eL5hlG5xBTgql3E5nRXW21+XfHEyt9V6eYNF2sbag=;
 b=bEG3fLbf5YJ4QX4PTyD3sHbjb+cex9JzfmQ5L2PApQ9Stvz/FpB6gdMQSPMHhzfg7c45
 QpgNvaCXPwFRwqJhMpE7t13zaPzSjaZmVoI+/zVlALJ3ivw+FiihvN2pkh7NnC3ZUUVq
 Wc5RxAC2LjHEhWzNYiP5GVqQGqFi6BXANX6iUo6eBdLcgqmpD72qyfO7SGY4ro/w4r8s
 CZ06GMksfrxblaBCasMLswrri1IfXhHNe27NQvHPw3yJHJhmUld99hulU2vougJyAPNb
 DpNnCVtx5FwZMD1YmdWbMWueW7l7bDhJ8dBVMBara0kl+m/aG34syEtoSLfFp1N47FY1 GA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkkq9979p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 18:20:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34FIK93E024743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 18:20:09 GMT
Received: from [10.134.70.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 11:20:09 -0700
Message-ID: <69538f77-ff08-c3ce-3d4a-9f7250ee2505@quicinc.com>
Date:   Mon, 15 May 2023 11:20:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v8 1/8] drm/msm/dpu: add dsc blocks for remaining chipsets
 in catalog
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
CC:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1683914423-17612-1-git-send-email-quic_khsieh@quicinc.com>
 <1683914423-17612-2-git-send-email-quic_khsieh@quicinc.com>
 <4tmuqrz3du7pwwih3gzp6zveyfvwxj3meeksgxkbg2v5mdtyu3@e5xxuoe64rvv>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <4tmuqrz3du7pwwih3gzp6zveyfvwxj3meeksgxkbg2v5mdtyu3@e5xxuoe64rvv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XW14jqWLNJJheK1Yy7F1lj8HiN4v114j
X-Proofpoint-ORIG-GUID: XW14jqWLNJJheK1Yy7F1lj8HiN4v114j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=884 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150153
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/2023 2:39 PM, Marijn Suijten wrote:
> DSC*, and mention 1.1 explicitly (since this skips the 1.2 blocks, while
> the series is clearly aimed at 1.1...).  This was done for the DSC 1.2
> HW block patch after all.
> 
> in catalog -> to catalog
> 
> But it's just two platforms, you can fit MSM8998 and SC8180X in the
> title.
> 
> On 2023-05-12 11:00:16, Kuogee Hsieh wrote:
>>
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> There are some platforms has DSC blocks but it is not declared at catalog.
> 
> Some platforms have DSC blocks which have not yet been declared in the
> catalog.*
> 
>> For completeness, this patch adds DSC blocks for platforms which missed
>> them.
> 
> Drop "this patch":
> 
>      Complete DSC 1.1 support for all platforms by adding the missing
>      blocks to MSM8998 and SC8180X.
> 
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h |  7 +++++++
>>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 11 +++++++++++
> 
> How about SC7180, and any other DPU 6.x revision?
> 

Will let kuogee respond to the other nits. There is no DSC in sc7180 / 
sm6115 / qcm2290. So this patch is complete.

> Rest of the patch looks good and complete.
> 
> - Marijn
> 
>>   2 files changed, 18 insertions(+)
>>
