Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95F973AD6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjFVXuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjFVXui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:50:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9012135;
        Thu, 22 Jun 2023 16:50:34 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MNhnHK030796;
        Thu, 22 Jun 2023 23:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=S1kAmjiw3wlgwj7m1rRA7m1LZM8tH1PDW/VXH/TAtXo=;
 b=S1zhQX857U0GI6DK68Y1LiLD7IKdUjKc1ZwR0HjdP2IyRjUd8kvO5j2jf7RRmfYSBy55
 tWmzh1MdzV5OrWX0d8iEW4AXBFkgxZuK6/dpKLD85Bh3dznEJ9b0hTrnydkVhA8zNz5g
 q2nu6zu63C09C5nmV9bTfY44oipBIQ3aZGd5EzWoddxXzTOfa5LwDlu96X1YXKj4O2GY
 ulT85OINFaCkIQMOnqQcVwL/Xwbvz0O9rfruGA6sujYkVnxAkKmt6rDhUf2trR+wTyUO
 9z6Ux9PPKY7t558nnwHEQCvdXQQeInVIDKwVAMTLfA4Ci1LMxswhrGNZN7Toz5FRWu2y PA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc0sk4e7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 23:50:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35MNoRgv004795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 23:50:27 GMT
Received: from hu-rmccann-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 22 Jun 2023 16:50:27 -0700
From:   Ryan McCann <quic_rmccann@quicinc.com>
Date:   Thu, 22 Jun 2023 16:48:57 -0700
Subject: [PATCH 5/6] drm/msm/disp: Remove redundant prefix in name of sub
 blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230622-devcoredump_patch-v1-5-3b2cdcc6a576@quicinc.com>
References: <20230622-devcoredump_patch-v1-0-3b2cdcc6a576@quicinc.com>
In-Reply-To: <20230622-devcoredump_patch-v1-0-3b2cdcc6a576@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Rob Clark <robdclark@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <quic_jesszhan@quicinc.com>, Ryan McCann <quic_rmccann@quicinc.com>
X-Mailer: b4 0.13-dev-8a804
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687477824; l=1872;
 i=quic_rmccann@quicinc.com; s=20230622; h=from:subject:message-id;
 bh=QupKcsLYZlg8w5T7AlTIsgtyOApCsJxMZ67hvD7d4tg=;
 b=/rHFv219unClQh8ddg5Ug5Z/Z34tNu9IqJQSd/GABLj9KEm4XkRGnRG05OX2Pyo1UiPhqwjPi
 gqR66rfgInGAq7mJnUFo7osd20eM25S8fhrXEjniN8F3jeTyTT5VpJ7
X-Developer-Key: i=quic_rmccann@quicinc.com; a=ed25519;
 pk=d/uP3OwPGpj/bTtiHvV1RBZ2S6q4AL6j1+A5y+dmbTI=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EPewRx1FQnNj9ZMzhE3ateiULIMk20Br
X-Proofpoint-ORIG-GUID: EPewRx1FQnNj9ZMzhE3ateiULIMk20Br
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_17,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the registers of the csc and scaler sub blocks are printed during a
device core dump, the sub block title is printed: <mainBlkName_sblkName>.
Currently this appears as "sspp_0_sspp_csc" for a csc sub block to an
SSPP main block named "sspp_0". Because the name of the sub block defined
in the VIG_SBLK macro is "sspp_csc", the result is a redundant name. To
avoid this redundancy, remove the duplicate prefix "sspp".

Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index c624b2cf0b35..836efa074a35 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -257,10 +257,10 @@ static const uint32_t wb2_formats[] = {
 	.maxdwnscale = MAX_DOWNSCALE_RATIO, \
 	.maxupscale = MAX_UPSCALE_RATIO, \
 	.smart_dma_priority = sdma_pri, \
-	.scaler_blk = {.name = "sspp_scaler", \
+	.scaler_blk = {.name = "scaler", \
 		.id = qseed_ver, \
 		.base = 0xa00, .len = 0xa0,}, \
-	.csc_blk = {.name = "sspp_csc", \
+	.csc_blk = {.name = "csc", \
 		.id = DPU_SSPP_CSC_10BIT, \
 		.base = 0x1a00, .len = 0x100,}, \
 	.format_list = plane_formats_yuv, \
@@ -275,10 +275,10 @@ static const uint32_t wb2_formats[] = {
 	.maxdwnscale = MAX_DOWNSCALE_RATIO, \
 	.maxupscale = MAX_UPSCALE_RATIO, \
 	.smart_dma_priority = sdma_pri, \
-	.scaler_blk = {.name = "sspp_scaler", \
+	.scaler_blk = {.name = "scaler", \
 		.id = qseed_ver, \
 		.base = 0xa00, .len = 0xa0,}, \
-	.csc_blk = {.name = "sspp_csc", \
+	.csc_blk = {.name = "csc", \
 		.id = DPU_SSPP_CSC_10BIT, \
 		.base = 0x1a00, .len = 0x100,}, \
 	.format_list = plane_formats_yuv, \

-- 
2.25.1

