Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABD2625C17
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiKKOAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiKKN7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:59:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF03E8D7E1;
        Fri, 11 Nov 2022 05:56:26 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ABDqkGd007901;
        Fri, 11 Nov 2022 13:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=hawB2hozmEIbG+S0PxbOS0Lg6mklfrCYrE5506MfVBQ=;
 b=MhKg6a3yUjo6Ao6a5jjfi8p3sSVXST2S11Ybe0YQpkO947TsRrpT/ZkRIkCT5EXSfl26
 IOLFOKYa9/mSx/WWf1ynkR5pPbewnz/ENlvhjguWy0y0qZkOEayFHbBGV1Udswqbcxra
 kxF/kAC3wV9DnNmr5GpEk73Fu59ZfKXDh6DX5MW3KFFKW9rbxkU9Fh4aaeBEsCyajGK1
 c0tagyQyEO4sBQ7JdZIXN9M0o/TVfGYfmQWV3FS1iFYfG+QnqzbHxsF4CVvj76cSqOAH
 eYhPCDV258VLbPcDb4bQuLBPA435LuSey1KQldwJtCrOpOEmBItfxGH8Ylfg47cy7NzJ hw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksh98s1jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 13:56:23 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDuKsM031611;
        Fri, 11 Nov 2022 13:56:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3kngwkm2nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Nov 2022 13:56:20 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ABDuK5U031604;
        Fri, 11 Nov 2022 13:56:20 GMT
Received: from kalyant-linux.qualcomm.com (kalyant-linux.qualcomm.com [10.204.66.210])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2ABDuKaT031603;
        Fri, 11 Nov 2022 13:56:20 +0000
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id 591B43892; Fri, 11 Nov 2022 05:56:19 -0800 (PST)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com
Subject: [v1] drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
Date:   Fri, 11 Nov 2022 05:56:18 -0800
Message-Id: <1668174978-10676-1-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p3K9OGmL20MGRoA_wKrWepqYl-LqhdTD
X-Proofpoint-ORIG-GUID: p3K9OGmL20MGRoA_wKrWepqYl-LqhdTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110093
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin each crtc with one encoder. This arrangement will
disallow crtc switching between encoders and also will
facilitate to advertise certain features on crtc based
on encoder type.

Changes in v1:
- use drm_for_each_encoder macro while iterating through
  encoder list (Dmitry)

Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 7a5fabc..0d94eec0d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -798,19 +798,20 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
 	max_crtc_count = min(max_crtc_count, primary_planes_idx);
 
 	/* Create one CRTC per encoder */
-	for (i = 0; i < max_crtc_count; i++) {
-		crtc = dpu_crtc_init(dev, primary_planes[i], cursor_planes[i]);
-		if (IS_ERR(crtc)) {
-			ret = PTR_ERR(crtc);
-			return ret;
+	i = 0;
+	drm_for_each_encoder(encoder, dev) {
+		if (i < max_crtc_count) {
+			crtc = dpu_crtc_init(dev, primary_planes[i], cursor_planes[i]);
+			if (IS_ERR(crtc)) {
+				ret = PTR_ERR(crtc);
+				return ret;
+			}
+			priv->crtcs[priv->num_crtcs++] = crtc;
+			encoder->possible_crtcs = 1 << drm_crtc_index(crtc);
 		}
-		priv->crtcs[priv->num_crtcs++] = crtc;
+		i++;
 	}
 
-	/* All CRTCs are compatible with all encoders */
-	drm_for_each_encoder(encoder, dev)
-		encoder->possible_crtcs = (1 << priv->num_crtcs) - 1;
-
 	return 0;
 }
 
-- 
2.7.4

