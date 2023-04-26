Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08586EFB06
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbjDZTXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbjDZTXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:23:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C94359A;
        Wed, 26 Apr 2023 12:23:08 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QIeqH4024254;
        Wed, 26 Apr 2023 19:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=qrF3PHA/LTofJyqIZNo4xMGwShOGEkjlvcHgFnXUyJs=;
 b=Mx1i0bocb3PmTgQoBrGm3/3shvXSCP1hCLsw5uHtJB4ZdC7dYw/hTfnUTJVO1yE3UrhV
 pdIbDddvYnT6FYQ6tzbLDIJZrGOBTRvgJra6bRtMM71FdMfFTAdzOBReLeZWOl/j5O6I
 lZ7nbmiUMwhQ4RsS6DAicB+nFNcoJ7o2bsKId2QPKGYzQrzRzzmpb6NxpABCcQBa+6kI
 Dy59Ril9NOmLrCN49z7jRVFGVX19ILJFgIYqk9Ug6QKe5NanqyNLylOfrIECSlKZgHNZ
 SnxCIzfGVKIpP7jssLh2zmIDoD7DCIKz3e6il3BMqCQUA7SlIR+Yl4gm/e99VnQ0nxrB bQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q79eug23y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 19:23:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33QJN3BZ032677
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 19:23:03 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 26 Apr 2023 12:23:02 -0700
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <quic_jesszhan@quicinc.com>,
        <marijn.suijten@somainline.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] drm/msm/dpu: drop DSPP_MSM8998_MASK from hw catalog
Date:   Wed, 26 Apr 2023 12:22:46 -0700
Message-ID: <20230426192246.5517-4-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230426192246.5517-1-quic_abhinavk@quicinc.com>
References: <20230426192246.5517-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K5qSOzafJwPie_Y_8OwS8H46bgW-VF0F
X-Proofpoint-ORIG-GUID: K5qSOzafJwPie_Y_8OwS8H46bgW-VF0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=875 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since GC and IGC masks have now been dropped DSPP_MSM8998_MASK
is same as DSPP_SC7180_MASK. Since DSPP_SC7180_MASK is used more
than DSPP_MSM8998_MASK, lets drop the latter.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h | 4 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c          | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index 2b3ae84057df..5f6e4715aa04 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
@@ -127,9 +127,9 @@ static const struct dpu_pingpong_cfg msm8998_pp[] = {
 };
 
 static const struct dpu_dspp_cfg msm8998_dspp[] = {
-	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_MSM8998_MASK,
+	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
 		 &msm8998_dspp_sblk),
-	DSPP_BLK("dspp_1", DSPP_1, 0x56000, DSPP_MSM8998_MASK,
+	DSPP_BLK("dspp_1", DSPP_1, 0x56000, DSPP_SC7180_MASK,
 		 &msm8998_dspp_sblk),
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index badfc3680485..2cabba0bb513 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -91,8 +91,6 @@
 
 #define MERGE_3D_SM8150_MASK (0)
 
-#define DSPP_MSM8998_MASK BIT(DPU_DSPP_PCC)
-
 #define DSPP_SC7180_MASK BIT(DPU_DSPP_PCC)
 
 #define INTF_SDM845_MASK (0)
-- 
2.40.1

