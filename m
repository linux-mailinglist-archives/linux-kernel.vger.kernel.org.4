Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9F74BB40
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 03:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjGHB7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 21:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGHB7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 21:59:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE65C3;
        Fri,  7 Jul 2023 18:59:47 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3681w9bV008133;
        Sat, 8 Jul 2023 01:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JXWNvPoJbPRdniGbsQNPN1BPjVQImLkwH3AzerANLGM=;
 b=SdQ4we4oNHUjqKPyxPhfF6JMjR1eUWp3TSXQ1sFQOPyFLovCbRuxJDYAH3eGd3TOfA7F
 J70dlhjaL6V8y9nhWuvwBG8RN8W3wpSur/bL91/u8+Dx4Up8l7UaZT719trcGA1vDb53
 kiZh+SmKEci1b7Yo3yZRPw+iC+wDXmOal8JCocp1EhMWs3BKdn+KaGfwRncsUAPmTFl5
 B014Ilc2H5JfeutNhOiuzRUd07kMyZoZTmY1vFQl+gXg9FMm+Fv8A8vbiZdQN6a8LK7j
 6uPWP2ubE8Wo1kQqHHP9nKED0L+D2SrR/TlgVJ5DwsQzKBnGefavgfpxCpM7wr5txQlg Kw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rp96vtu96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 01:59:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3681xOFV017717
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 01:59:24 GMT
Received: from [10.110.118.168] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 7 Jul
 2023 18:59:23 -0700
Message-ID: <94a7730e-9241-d334-b1b5-5fac573cbbb3@quicinc.com>
Date:   Fri, 7 Jul 2023 18:59:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 0/6] Add support to print sub-block registers in dpu hw
 catalog
Content-Language: en-US
To:     Ryan McCann <quic_rmccann@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Rob Clark <robdclark@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <quic_jesszhan@quicinc.com>
References: <20230622-devcoredump_patch-v5-0-67e8b66c4723@quicinc.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20230622-devcoredump_patch-v5-0-67e8b66c4723@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IwaaL7JPUI9Qf8-1uTg2G7xlMqbuIb0R
X-Proofpoint-GUID: IwaaL7JPUI9Qf8-1uTg2G7xlMqbuIb0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307080017
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/2023 6:24 PM, Ryan McCann wrote:
> The purpose of this patch series is to add support to print the registers
> of sub-blocks in the DPU hardware catalog and fix the order in which all
> hardware blocks are dumped for a device core dump. This involves:
> 

Nice work on completing this feature and working patiently through all 
the comments !


> 1. Changing data structure from stack to queue to fix the printing order
> of the device core dump.
> 
> 2. Removing redundant suffix of sub-block names.
> 
> 3. Removing redundant prefix of sub-block names.
> 
> 4. Eliminating unused variable from relevant macros.
> 
> 5. Defining names for sub-blocks that have not yet been defined.
> 
> 6. Implementing wrapper function that prints the registers of sub-blocks
> when there is a need.
> 
> Sample Output of the sspp_0 block and its sub-blocks for devcore dump:
> ======sspp_0======
> ...registers
> ...
> ====sspp_0_scaler====
> ...
> ...
> ====sspp_0_csc====
> ...
> ...
> ====next_block====
> ...
> 
> This series depends on https://patchwork.freedesktop.org/series/119776/.
> 
> ---
> Changes in v5:
> - Fixed indentation in refactor main block printing patch
> - Fixed formatting issues to satisfy checkpatch
> - Instead of passing 0 for DSC block, used actual length thanks to https://patchwork.freedesktop.org/series/119776/
> - Link to v4: https://lore.kernel.org/r/20230622-devcoredump_patch-v4-0-e304ddbe9648@quicinc.com
> 
> Changes in v4:
> - Added review tags
> - Link to v3: https://lore.kernel.org/r/20230622-devcoredump_patch-v3-0-83601b72eb67@quicinc.com
> 
> Changes in v3:
> - Split sub-block changes and main block changes into two commits
> - Corrected typo in comment located in DSC for loop block
> - Eliminated variables mmio and base
> - Dropped unnecessary "%s"
> - Link to v2: https://lore.kernel.org/r/20230622-devcoredump_patch-v2-0-9e90a87d393f@quicinc.com
> 
> Changes in v2:
> - Changed spelling "sub block" to "sub-block" or "sblk".
> - Capitalized DPU.
> - Eliminated multiplexer/wrapper function. Inlined instead.
> - Changed if statements from feature checks to length checks.
> - Squashed prefix and suffix patch into one.
> - Link to v1: https://lore.kernel.org/r/20230622-devcoredump_patch-v1-0-3b2cdcc6a576@quicinc.com
> 
> ---
> Ryan McCann (6):
>        drm/msm: Update dev core dump to not print backwards
>        drm/msm/dpu: Drop unused num argument from relevant macros
>        drm/msm/dpu: Define names for unnamed sblks
>        drm/msm/dpu: Remove redundant prefix/suffix in name of sub-blocks
>        drm/msm/dpu: Refactor printing of main blocks in device core dump
>        drm/msm/dpu: Update dev core dump to dump registers of sub-blocks
> 
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 90 +++++++++++------------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c           | 74 +++++++++++++++----
>   drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c |  2 +-
>   3 files changed, 104 insertions(+), 62 deletions(-)
> ---
> base-commit: a92b5625851098af521cd92e4c518429b661c8f4
> change-id: 20230622-devcoredump_patch-df7e8f6fd632
> 
> Best regards,
