Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CA372F076
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjFMXqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241382AbjFMXqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:46:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC71FEF;
        Tue, 13 Jun 2023 16:45:25 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DKRYZv001552;
        Tue, 13 Jun 2023 23:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ctKTyt/vRYOW2hOdkAlAFbDbF0FXeBY7ZxXL6QXrUQo=;
 b=OeStJ6ICslW1RtplU02TncC7ORiDwoBmHxjH8SUKt60Ha/mAjlsCWEgFMHs0domtJHH4
 QdH9DpGn9IgN1WWk/YLbmpmsTj57UV15LmbskDcX/SgjVXw/lJBTwmsS9vNuvJRRK5Qa
 vFGjd1RHFeYj6CFHpsBzWO1mvvJjtVht/AEcnCTiwkCxmeB2+vPZ1bRUyz+cIuWCDcaN
 SaSJY5Gkiz1rhdHzKDYVWEegSSr0m867zrutErechyOVJd6BLOU5+ts2Vx5mVSdd7DGr
 pEZ2xLtmP+W6zhLUyhakGCpbQWWd/eCyi7d0XtFXUHCdWIIMyALeLG23074FWUDYGeJe jw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6f7a2h9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 23:44:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35DNiH8t018899
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 23:44:17 GMT
Received: from [10.134.70.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 16:44:16 -0700
Message-ID: <8ed140ba-3731-6f42-dc01-de6a983af1bb@quicinc.com>
Date:   Tue, 13 Jun 2023 16:44:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/2] retrieve DSI DSC through priv-dsi[0]
Content-Language: en-US
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1686694742-20862-1-git-send-email-quic_khsieh@quicinc.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <1686694742-20862-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PlSHYPrqrDit3TLZzI22Eu1MbMhAD6oq
X-Proofpoint-ORIG-GUID: PlSHYPrqrDit3TLZzI22Eu1MbMhAD6oq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_23,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130208
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2023 3:19 PM, Kuogee Hsieh wrote:
> moving retrieving struct drm_dsc_cofnig from setup_display to
> atomic_enable() and delete struct drm_dsc_config from
> struct msm_display_info.
> 

This needs re-wording.

Currently, struct drm_dsc_config is retrieved from DSI driver in 
dpu_encoder_setup_display() and this model works for non-pluggable 
displays. However this does not scale for pluggable displays because the 
struct drm_dsc_config is no longer valid after a disconnect and needs to 
be retrieved from the sink again.

Move retrieval of struct drm_dsc_config from dpu_encoder_setup_display() 
to dpu_encoder_virt_atomic_enable() to make the code path common between 
pluggable and non-pluggable displays.

And also delete struct drm_dsc_config from struct msm_display_info as it 
will now be unused.

> Kuogee Hsieh (2):
>    drm/msm/dpu: retrieve DSI DSC struct through priv->dsi[0]
>    drm/msm/dpu: remove struct drm_dsc_config from struct msm_display_info
> 
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 44 ++++++++++++++++++++---------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 --
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 --
>   3 files changed, 30 insertions(+), 18 deletions(-)
> 
