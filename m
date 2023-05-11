Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF3D6FEADE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjEKEmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjEKEmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:42:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6D82D68;
        Wed, 10 May 2023 21:42:15 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B2LJrx019918;
        Thu, 11 May 2023 04:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WnaEZ/hrDXv4JIBL/URErpZ1fvDCqaexQA/xJTQYwgw=;
 b=fGEmLNYIP+9QGIoEze9jzdPvFzwi+wS8CaeYEYEpBUzdk8ra78zso0kTZWZtxLLhoG02
 tNWilDx/pvjLT2QBftQdVen+4badhnw+nXcGW0Tzs584zCfK3ogL76JorLvXi5kw/muM
 tu7buXyVx/LMemR3KyjxY5eclEOo2jZACRzBwbUPDdMuepOUTpho6SKZoYACTKELxWz9
 UynBO9/pv3jAFzqDhBMrhtBfTt1U0sFZ9izM+oXIxgpfS0ktfPPBnKv8ba3HZiNBKeQO
 CrSE3C4r+J0Laex4tCmReBdUJW8SpBTFB8ptpaU1K9ypT0siWoJf6s3PtCOsBFS3Lolk BA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qg5mptcyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 04:42:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34B4g33M013210
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 04:42:03 GMT
Received: from [10.110.82.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 21:42:02 -0700
Message-ID: <ff0a7628-b9e2-d5f5-cb1e-678ea25ec1cb@quicinc.com>
Date:   Wed, 10 May 2023 21:42:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v6 2/8] drm/msm/dpu: add DPU_PINGPONG_DSC feature bit for
 DPU < 7.0.0
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1683756453-22050-1-git-send-email-quic_khsieh@quicinc.com>
 <1683756453-22050-3-git-send-email-quic_khsieh@quicinc.com>
 <b4438422-f24b-7fc1-18cf-3cebdd777530@linaro.org>
 <1a6109ae-7c83-c04e-60c9-dfca6b83d662@quicinc.com>
 <a6146d03-18d1-b1c6-cdbb-d3527cb9021a@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <a6146d03-18d1-b1c6-cdbb-d3527cb9021a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kNV8cmfP4i2KXlo-0mgbeAlY_QlSPyka
X-Proofpoint-GUID: kNV8cmfP4i2KXlo-0mgbeAlY_QlSPyka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=492 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305110038
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2023 9:39 PM, Dmitry Baryshkov wrote:
> On 11/05/2023 07:38, Abhinav Kumar wrote:
>>
>>
>> On 5/10/2023 9:29 PM, Dmitry Baryshkov wrote:
>>> On 11/05/2023 01:07, Kuogee Hsieh wrote:
>>>> DPU < 7.0.0 requires the PINGPONG block to be involved during
>>>> DSC setting up. Since DPU >= 7.0.0, enabling and starting the DSC
>>>> encoder engine moved to INTF with the help of the flush mechanism.
>>>
>>> Nit: was moved.
>>>
>>>> Add a DPU_PINGPONG_DSC feature bit to restrict the availability of
>>>> dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_{enable,disable}() on the
>>>> PINGPONG block to DPU < 7.0.0 hardware, as the registers are not
>>>> available [in the PINGPONG block] on DPU 7.0.0 and higher anymore.
>>>
>>> this looks good
>>>
>>>> Existing call-sites to these callbacks already skip calling into
>>>> them if the function pointer is NULL.
>>>
>>> This is more relevant for patch 3 commit message.
>>>
>>>> Add DPU_PINGPONG_DSC feature
>>>> bit to all chipset with DPU < 7.0.0.
>>>
>>> This is incorrect, as we do not change the catalog in this patch.
>>>
>>
>> Sorry but why not? The changes done to dpu_hw_catalog.c do exactly that.
> 
> Because the patch does not add this feature bit to any of the chipsets. 
> I think the relevant patch was lost somewhere during the rework/rebase.
> 
> 
> 

This is adding it right?

   #define PINGPONG_SDM845_MASK \
-    (BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_TE))
+    (BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_TE) | 
BIT(DPU_PINGPONG_DSC))
   #define PINGPONG_SDM845_TE2_MASK \
