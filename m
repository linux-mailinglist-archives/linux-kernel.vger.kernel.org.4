Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4911D6A21ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBXTBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBXTBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:01:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69748144BA;
        Fri, 24 Feb 2023 11:01:43 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OGklpG025126;
        Fri, 24 Feb 2023 19:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=pNt187UIysRCOHYMou9Qzp8ot/ClNuFb1krtI4f6YVQ=;
 b=js6cqnz8Gp6mlQeqlWoafmfBg9TN87On0EGj+7TtPw8k10Ydnluu1SebIwzR2JRKB8SW
 zcQuUyVtvrr5W4Fhv6Lg2mJw81fz9jhUjFqSDfMuJCclJHXDveD0w3psLdytDeIR+HMM
 cq4NYHI2ibLLAWvq1Q3PEqG38OUQ0Y4K781/nXVn2EOAOdxU9gzjxb7WkmQSFOezIDpm
 GP2GuYmUTUq3tDfkDrtCz2z5462394NxDK6rSgWqtEHQbb7hwwqxWt4kfCGjiikSKXPA
 jWyJXKJ+vvc11EK733qMfbr9FPN+k5BnyWgSpt74C2ZnAg0JF4HcJnlPla6OhCP92ymh 5w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwybm5xhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 19:01:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OJ1Z4l013272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 19:01:35 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 24 Feb 2023 11:01:34 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] add V1.1 dsc_helper fucntion
Date:   Fri, 24 Feb 2023 11:01:25 -0800
Message-ID: <1677265287-7765-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fOdvCiW64bYbqnncCOduwyZpbh3b_3Gx
X-Proofpoint-GUID: fOdvCiW64bYbqnncCOduwyZpbh3b_3Gx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_14,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=772
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V1.1 dsc function and have dsi use it instead of hardcode value

Kuogee Hsieh (2):
  drm/msm/dpu: add dsc helper functions
  drm/msm/dsi: use new dpu_dsc_populate_dsc_config()

 drivers/gpu/drm/msm/Makefile                   |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c | 209 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h |  28 ++++
 drivers/gpu/drm/msm/dsi/dsi_host.c             |  78 ++-------
 drivers/gpu/drm/msm/msm_drv.h                  |   7 +
 5 files changed, 257 insertions(+), 66 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

