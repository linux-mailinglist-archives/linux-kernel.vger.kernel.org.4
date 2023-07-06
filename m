Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9828E74982C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjGFJUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjGFJUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:20:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74941BD3;
        Thu,  6 Jul 2023 02:20:29 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3666kQMu001240;
        Thu, 6 Jul 2023 09:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=yLKrOiFei4IRXEDLfGuz/ybuCbV8aRN9M6AWq16w2zw=;
 b=F9A2RxSl7RMR6BFXoCNnafRZjC9mPolTwCtMhbKsoF1yGs659V/bd4VRnNiPOv1d2NkV
 ZgiZf7rH3wtxdLTVFtuYD9cA8EUVZy8ecF9FnNa8lYsN4HE1TUx8OJUQ+xVIx3ve2rqg
 1kjOO1OyZMUDi66LrmMzlCw1BzB+Eh5otTqksEu1wYI69maoW629gpTj5SNOnSjQLjZf
 m2MqlZvY6mBENkEhj78QVQK0Ks0xDyZoocTyLVN5fxXh9OUnyiqmTStE4Nu6+whaOP5M
 6+4uDWHIGqkrncaxxOsf2+J7w1bkb8MgN3De32k5/McDP3L1oUSq6TMhsfn1Xt3uPsYt Lg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn2cpb2yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 09:20:25 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3669KLuY015099;
        Thu, 6 Jul 2023 09:20:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rjd7ky0xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 06 Jul 2023 09:20:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3669KLGO014836;
        Thu, 6 Jul 2023 09:20:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3669KKwQ014709;
        Thu, 06 Jul 2023 09:20:20 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 375005FDF; Thu,  6 Jul 2023 14:50:20 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/3] soc: qcom: rpmpd: Update the entries of PD macros
Date:   Thu,  6 Jul 2023 14:50:17 +0530
Message-Id: <1688635218-23779-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -4Um20bvPSr8A0aN_gErOTPnX9t-7spC
X-Proofpoint-ORIG-GUID: -4Um20bvPSr8A0aN_gErOTPnX9t-7spC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_06,2023-07-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=656
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060082
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the PD macros used in SoC specific entries to use
the newly defined generic macros.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/soc/qcom/rpmpd.c | 216 +++++++++++++++++++++++------------------------
 1 file changed, 108 insertions(+), 108 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 99b017f..cff9c2d 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -515,12 +515,12 @@ static struct rpmpd ssc_mx_rwsm0_vfl = {
 };
 
 static struct rpmpd *mdm9607_rpmpds[] = {
-	[MDM9607_VDDCX] =	&cx_s3a_lvl,
-	[MDM9607_VDDCX_AO] =	&cx_s3a_lvl_ao,
-	[MDM9607_VDDCX_VFL] =	&cx_s3a_vfl,
-	[MDM9607_VDDMX] =	&mx_l12a_lvl,
-	[MDM9607_VDDMX_AO] =	&mx_l12a_lvl_ao,
-	[MDM9607_VDDMX_VFL] =	&mx_l12a_vfl,
+	[RPMPD_VDDCX] =		&cx_s3a_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_s3a_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_s3a_vfl,
+	[RPMPD_VDDMX] =		&mx_l12a_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_l12a_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_l12a_vfl,
 };
 
 static const struct rpmpd_desc mdm9607_desc = {
@@ -530,9 +530,9 @@ static const struct rpmpd_desc mdm9607_desc = {
 };
 
 static struct rpmpd *msm8226_rpmpds[] = {
-	[MSM8226_VDDCX] =	&cx_s1a_corner,
-	[MSM8226_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8226_VDDCX_VFC] =	&cx_s1a_vfc,
+	[RPMPD_VDDCX] =		&cx_s1a_corner,
+	[RPMPD_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[RPMPD_VDDCX_VFC] =	&cx_s1a_vfc,
 };
 
 static const struct rpmpd_desc msm8226_desc = {
@@ -542,14 +542,14 @@ static const struct rpmpd_desc msm8226_desc = {
 };
 
 static struct rpmpd *msm8939_rpmpds[] = {
-	[MSM8939_VDDMDCX] =	&md_s1a_corner,
-	[MSM8939_VDDMDCX_AO] =	&md_s1a_corner_ao,
-	[MSM8939_VDDMDCX_VFC] =	&md_s1a_vfc,
-	[MSM8939_VDDCX] =	&cx_s2a_corner,
-	[MSM8939_VDDCX_AO] =	&cx_s2a_corner_ao,
-	[MSM8939_VDDCX_VFC] =	&cx_s2a_vfc,
-	[MSM8939_VDDMX] =	&mx_l3a_corner,
-	[MSM8939_VDDMX_AO] =	&mx_l3a_corner_ao,
+	[RPMPD_VDDMDCX] =	&md_s1a_corner,
+	[RPMPD_VDDMDCX_AO] =	&md_s1a_corner_ao,
+	[RPMPD_VDDMDCX_VFC] =	&md_s1a_vfc,
+	[RPMPD_VDDCX] =		&cx_s2a_corner,
+	[RPMPD_VDDCX_AO] =	&cx_s2a_corner_ao,
+	[RPMPD_VDDCX_VFC] =	&cx_s2a_vfc,
+	[RPMPD_VDDMX] =		&mx_l3a_corner,
+	[RPMPD_VDDMX_AO] =	&mx_l3a_corner_ao,
 };
 
 static const struct rpmpd_desc msm8939_desc = {
@@ -559,11 +559,11 @@ static const struct rpmpd_desc msm8939_desc = {
 };
 
 static struct rpmpd *msm8916_rpmpds[] = {
-	[MSM8916_VDDCX] =	&cx_s1a_corner,
-	[MSM8916_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8916_VDDCX_VFC] =	&cx_s1a_vfc,
-	[MSM8916_VDDMX] =	&mx_l3a_corner,
-	[MSM8916_VDDMX_AO] =	&mx_l3a_corner_ao,
+	[RPMPD_VDDCX] =		&cx_s1a_corner,
+	[RPMPD_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[RPMPD_VDDCX_VFC] =	&cx_s1a_vfc,
+	[RPMPD_VDDMX] =		&mx_l3a_corner,
+	[RPMPD_VDDMX_AO] =	&mx_l3a_corner_ao,
 };
 
 static const struct rpmpd_desc msm8916_desc = {
@@ -573,13 +573,13 @@ static const struct rpmpd_desc msm8916_desc = {
 };
 
 static struct rpmpd *msm8953_rpmpds[] = {
-	[MSM8953_VDDMD] =	&md_s1a_lvl,
-	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
-	[MSM8953_VDDCX] =	&cx_s2a_lvl,
-	[MSM8953_VDDCX_AO] =	&cx_s2a_lvl_ao,
-	[MSM8953_VDDCX_VFL] =	&cx_s2a_vfl,
-	[MSM8953_VDDMX] =	&mx_s7a_lvl,
-	[MSM8953_VDDMX_AO] =	&mx_s7a_lvl_ao,
+	[RPMPD_VDDMD] =		&md_s1a_lvl,
+	[RPMPD_VDDMD_AO] =	&md_s1a_lvl_ao,
+	[RPMPD_VDDCX] =		&cx_s2a_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_s2a_vfl,
+	[RPMPD_VDDMX] =		&mx_s7a_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_s7a_lvl_ao,
 };
 
 static const struct rpmpd_desc msm8953_desc = {
@@ -589,12 +589,12 @@ static const struct rpmpd_desc msm8953_desc = {
 };
 
 static struct rpmpd *msm8976_rpmpds[] = {
-	[MSM8976_VDDCX] =	&cx_s2a_lvl,
-	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
-	[MSM8976_VDDCX_VFL] =	&cx_rwsc2_vfl,
-	[MSM8976_VDDMX] =	&mx_s6a_lvl,
-	[MSM8976_VDDMX_AO] =	&mx_s6a_lvl_ao,
-	[MSM8976_VDDMX_VFL] =	&mx_rwsm6_vfl,
+	[RPMPD_VDDCX] =		&cx_s2a_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_rwsc2_vfl,
+	[RPMPD_VDDMX] =		&mx_s6a_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_s6a_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwsm6_vfl,
 };
 
 static const struct rpmpd_desc msm8976_desc = {
@@ -604,15 +604,15 @@ static const struct rpmpd_desc msm8976_desc = {
 };
 
 static struct rpmpd *msm8994_rpmpds[] = {
-	[MSM8994_VDDCX] =	&cx_s1a_corner,
-	[MSM8994_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8994_VDDCX_VFC] =	&cx_s1a_vfc,
-	[MSM8994_VDDMX] =	&mx_s2a_corner,
-	[MSM8994_VDDMX_AO] =	&mx_s2a_corner_ao,
+	[RPMPD_VDDCX] =		&cx_s1a_corner,
+	[RPMPD_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[RPMPD_VDDCX_VFC] =	&cx_s1a_vfc,
+	[RPMPD_VDDMX] =		&mx_s2a_corner,
+	[RPMPD_VDDMX_AO] =	&mx_s2a_corner_ao,
 
 	/* Attention! *Some* 8994 boards with pm8004 may use SMPC here! */
-	[MSM8994_VDDGFX] =	&gfx_s2b_corner,
-	[MSM8994_VDDGFX_VFC] =	&gfx_s2b_vfc,
+	[RPMPD_VDDGFX] =	&gfx_s2b_corner,
+	[RPMPD_VDDGFX_VFC] =	&gfx_s2b_vfc,
 };
 
 static const struct rpmpd_desc msm8994_desc = {
@@ -622,13 +622,13 @@ static const struct rpmpd_desc msm8994_desc = {
 };
 
 static struct rpmpd *msm8996_rpmpds[] = {
-	[MSM8996_VDDCX] =	&cx_s1a_corner,
-	[MSM8996_VDDCX_AO] =	&cx_s1a_corner_ao,
-	[MSM8996_VDDCX_VFC] =	&cx_s1a_vfc,
-	[MSM8996_VDDMX] =	&mx_s2a_corner,
-	[MSM8996_VDDMX_AO] =	&mx_s2a_corner_ao,
-	[MSM8996_VDDSSCX] =	&ssc_cx_l26a_corner,
-	[MSM8996_VDDSSCX_VFC] =	&ssc_cx_l26a_vfc,
+	[RPMPD_VDDCX] =		&cx_s1a_corner,
+	[RPMPD_VDDCX_AO] =	&cx_s1a_corner_ao,
+	[RPMPD_VDDCX_VFC] =	&cx_s1a_vfc,
+	[RPMPD_VDDMX] =		&mx_s2a_corner,
+	[RPMPD_VDDMX_AO] =	&mx_s2a_corner_ao,
+	[RPMPD_VDDSSCX] =	&ssc_cx_l26a_corner,
+	[RPMPD_VDDSSCX_VFC] =	&ssc_cx_l26a_vfc,
 };
 
 static const struct rpmpd_desc msm8996_desc = {
@@ -638,16 +638,16 @@ static const struct rpmpd_desc msm8996_desc = {
 };
 
 static struct rpmpd *msm8998_rpmpds[] = {
-	[MSM8998_VDDCX] =	&cx_rwcx0_lvl,
-	[MSM8998_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
-	[MSM8998_VDDCX_VFL] =	&cx_rwcx0_vfl,
-	[MSM8998_VDDMX] =	&mx_rwmx0_lvl,
-	[MSM8998_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
-	[MSM8998_VDDMX_VFL] =	&mx_rwmx0_vfl,
-	[MSM8998_SSCCX] =	&ssc_cx_rwsc0_lvl,
-	[MSM8998_SSCCX_VFL] =	&ssc_cx_rwsc0_vfl,
-	[MSM8998_SSCMX] =	&ssc_mx_rwsm0_lvl,
-	[MSM8998_SSCMX_VFL] =	&ssc_mx_rwsm0_vfl,
+	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[RPMPD_SSCCX] =		&ssc_cx_rwsc0_lvl,
+	[RPMPD_SSCCX_VFL] =	&ssc_cx_rwsc0_vfl,
+	[RPMPD_SSCMX] =		&ssc_mx_rwsm0_lvl,
+	[RPMPD_SSCMX_VFL] =	&ssc_mx_rwsm0_vfl,
 };
 
 static const struct rpmpd_desc msm8998_desc = {
@@ -657,13 +657,13 @@ static const struct rpmpd_desc msm8998_desc = {
 };
 
 static struct rpmpd *qcs404_rpmpds[] = {
-	[QCS404_VDDMX] =	&mx_rwmx0_lvl,
-	[QCS404_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
-	[QCS404_VDDMX_VFL] =	&mx_rwmx0_vfl,
-	[QCS404_LPICX] =	&lpi_cx_rwlc0_lvl,
-	[QCS404_LPICX_VFL] =	&lpi_cx_rwlc0_vfl,
-	[QCS404_LPIMX] =	&lpi_mx_rwlm0_lvl,
-	[QCS404_LPIMX_VFL] =	&lpi_mx_rwlm0_vfl,
+	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[RPMPD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
+	[RPMPD_LPICX_VFL] =	&lpi_cx_rwlc0_vfl,
+	[RPMPD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
+	[RPMPD_LPIMX_VFL] =	&lpi_mx_rwlm0_vfl,
 };
 
 static const struct rpmpd_desc qcs404_desc = {
@@ -673,16 +673,16 @@ static const struct rpmpd_desc qcs404_desc = {
 };
 
 static struct rpmpd *sdm660_rpmpds[] = {
-	[SDM660_VDDCX] =	&cx_rwcx0_lvl,
-	[SDM660_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
-	[SDM660_VDDCX_VFL] =	&cx_rwcx0_vfl,
-	[SDM660_VDDMX] =	&mx_rwmx0_lvl,
-	[SDM660_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
-	[SDM660_VDDMX_VFL] =	&mx_rwmx0_vfl,
-	[SDM660_SSCCX] =	&ssc_cx_rwlc0_lvl,
-	[SDM660_SSCCX_VFL] =	&ssc_cx_rwlc0_vfl,
-	[SDM660_SSCMX] =	&ssc_mx_rwlm0_lvl,
-	[SDM660_SSCMX_VFL] =	&ssc_mx_rwlm0_vfl,
+	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[RPMPD_SSCCX] =		&ssc_cx_rwlc0_lvl,
+	[RPMPD_SSCCX_VFL] =	&ssc_cx_rwlc0_vfl,
+	[RPMPD_SSCMX] =		&ssc_mx_rwlm0_lvl,
+	[RPMPD_SSCMX_VFL] =	&ssc_mx_rwlm0_vfl,
 };
 
 static const struct rpmpd_desc sdm660_desc = {
@@ -692,14 +692,14 @@ static const struct rpmpd_desc sdm660_desc = {
 };
 
 static struct rpmpd *sm6115_rpmpds[] = {
-	[SM6115_VDDCX] =	&cx_rwcx0_lvl,
-	[SM6115_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
-	[SM6115_VDDCX_VFL] =	&cx_rwcx0_vfl,
-	[SM6115_VDDMX] =	&mx_rwmx0_lvl,
-	[SM6115_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
-	[SM6115_VDDMX_VFL] =	&mx_rwmx0_vfl,
-	[SM6115_VDD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
-	[SM6115_VDD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
+	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[RPMPD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
+	[RPMPD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
 };
 
 static const struct rpmpd_desc sm6115_desc = {
@@ -709,12 +709,12 @@ static const struct rpmpd_desc sm6115_desc = {
 };
 
 static struct rpmpd *sm6125_rpmpds[] = {
-	[SM6125_VDDCX] =	&cx_rwcx0_lvl,
-	[SM6125_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
-	[SM6125_VDDCX_VFL] =	&cx_rwcx0_vfl,
-	[SM6125_VDDMX] =	&mx_rwmx0_lvl,
-	[SM6125_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
-	[SM6125_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
 };
 
 static const struct rpmpd_desc sm6125_desc = {
@@ -724,16 +724,16 @@ static const struct rpmpd_desc sm6125_desc = {
 };
 
 static struct rpmpd *sm6375_rpmpds[] = {
-	[SM6375_VDDCX] =	&cx_rwcx0_lvl,
-	[SM6375_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
-	[SM6375_VDDCX_VFL] =	&cx_rwcx0_vfl,
-	[SM6375_VDDMX] =	&mx_rwmx0_lvl,
-	[SM6375_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
-	[SM6375_VDDMX_VFL] =	&mx_rwmx0_vfl,
-	[SM6375_VDDGX] =	&gx_rwgx0_lvl,
-	[SM6375_VDDGX_AO] =	&gx_rwgx0_lvl_ao,
-	[SM6375_VDD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
-	[SM6375_VDD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
+	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[RPMPD_VDDGX] =		&gx_rwgx0_lvl,
+	[RPMPD_VDDGX_AO] =	&gx_rwgx0_lvl_ao,
+	[RPMPD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
+	[RPMPD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
 };
 
 static const struct rpmpd_desc sm6375_desc = {
@@ -743,14 +743,14 @@ static const struct rpmpd_desc sm6375_desc = {
 };
 
 static struct rpmpd *qcm2290_rpmpds[] = {
-	[QCM2290_VDDCX] =	&cx_rwcx0_lvl,
-	[QCM2290_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
-	[QCM2290_VDDCX_VFL] =	&cx_rwcx0_vfl,
-	[QCM2290_VDDMX] =	&mx_rwmx0_lvl,
-	[QCM2290_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
-	[QCM2290_VDDMX_VFL] =	&mx_rwmx0_vfl,
-	[QCM2290_VDD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
-	[QCM2290_VDD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
+	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[RPMPD_VDDMX] =	&mx_rwmx0_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
+	[RPMPD_LPI_CX] =	&lpi_cx_rwlc0_lvl,
+	[RPMPD_LPI_MX] =	&lpi_mx_rwlm0_lvl,
 };
 
 static const struct rpmpd_desc qcm2290_desc = {
-- 
2.7.4

