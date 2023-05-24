Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBCD70FBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjEXQdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEXQdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:33:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9C4E9;
        Wed, 24 May 2023 09:33:30 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OFfUiq008677;
        Wed, 24 May 2023 16:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WHPoXP5utHdLTSZGO5wV4RpG8TRwXt/UKLbt8oGZ07Q=;
 b=XJN1T6ZZ31tfgiO02UaluszxxVqkYrjH3og/Q3AxxIWrmACU4GCtscAfupfPrY2nRdGl
 sfy0xLbLP9sdjHIaT2d9Tbq/GcAqoFvlqgm1Ao7io54RQvQxL33sOPabx9V/7+7TFBeY
 ZSfSw9cKnY03J1BfeYcAiniwPyMCPT+gpn7rB0I9IIOjvS7uJzwzGb9mfB9RKS7bJHad
 ZGBG1Z9eZcHz9yRAtdmTLgZc3fLajsjv2C90sGCN45LtUNjAU+DdC3HkdAYCvdC6ZGNz
 4O/+qC8/mHvqRCrk7VO1dKgggqsnafp+MRIpDAwY1SrvBI8IbkbnW8mz1Wgo0/lHR1qY Qg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qscgmheuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 16:33:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34OGXEjN028531
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 16:33:14 GMT
Received: from [10.71.110.189] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 09:33:13 -0700
Message-ID: <81399377-cd0b-ba9c-e58f-e1955912b263@quicinc.com>
Date:   Wed, 24 May 2023 09:33:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 00/10] add DSC 1.2 dpu supports
Content-Language: en-US
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1684800039-18231-1-git-send-email-quic_khsieh@quicinc.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <1684800039-18231-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1i6xzJ6550qlbC9RKlRvNvBFYClxXQqK
X-Proofpoint-ORIG-GUID: 1i6xzJ6550qlbC9RKlRvNvBFYClxXQqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_11,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=966 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240137
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry/Marijn,

Are you satisfy with this patch series or any more comments will be added?

Thanks,


kuogee


On 5/22/2023 5:00 PM, Kuogee Hsieh wrote:
> This series adds the DPU side changes to support DSC 1.2 encoder. This
> was validated with both DSI DSC 1.2 panel and DP DSC 1.2 monitor.
> The DSI and DP parts will be pushed later on top of this change.
> This seriel is rebase on [1], [2] and catalog fixes from rev-4 of [3].
>
> [1]: https://patchwork.freedesktop.org/series/116851/
> [2]: https://patchwork.freedesktop.org/series/116615/
> [3]: https://patchwork.freedesktop.org/series/112332/
>
> Abhinav Kumar (2):
>    drm/msm/dpu: add dsc blocks to the catalog of MSM8998 and SC8180X
>    drm/msm/dpu: add DSC 1.2 hw blocks for relevant chipsets
>
> Kuogee Hsieh (8):
>    drm/msm/dpu: set DSC flush bit correctly at MDP CTL flush register
>    drm/msm/dpu: add DPU_PINGPONG_DSC feature bit for DPU < 7.0.0
>    drm/msm/dpu: Guard PINGPONG DSC ops behind DPU_PINGPONG_DSC bit
>    drm/msm/dpu: Introduce PINGPONG_NONE to disconnect DSC from PINGPONG
>    drm/msm/dpu: add support for DSC encoder v1.2 engine
>    drm/msm/dpu: always clear every individual pending flush mask
>    drm/msm/dpu: separate DSC flush update out of interface
>    drm/msm/dpu: tear down DSC data path when DSC disabled
>
>   drivers/gpu/drm/msm/Makefile                       |   1 +
>   .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |   7 +
>   .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |  11 +
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  14 +
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |   7 +
>   .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  16 +
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  14 +
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  14 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  51 ++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  24 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  35 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  33 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  11 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |  14 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h         |  15 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     | 387 +++++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   3 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |   9 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |   7 +-
>   19 files changed, 644 insertions(+), 29 deletions(-)
>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
>
