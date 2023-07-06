Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA5874982F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjGFJUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGFJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:20:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041041BD8;
        Thu,  6 Jul 2023 02:20:29 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3669KPX5007255;
        Thu, 6 Jul 2023 09:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=jY9ziIqV32GPA6L/bCbsk0le+xfJFpClFeXGbc1h5nk=;
 b=Qp07lHGAaxiVRlyQC1muAizmb6MDgaalDZ+f6U59mBjNYpQG26JOBPsI5L8vq3W5DXB1
 Bkr4vVkxCZdBnaFcZ9t/p0xq3jkZt9wc7GifBpzaTj0Y/izAArqVQJ+FHXfyvD/u4/Tp
 2U9WiH2HfUBQL2qQKUXmDuuWge63nG8DucINGmaNx/GU++d1k9bH12CX20bNJ2BRGhmi
 tWfSQ+IgEU8qDGBObmALpiyz1zJQnnjsiaEW5yDK0Mb6ecryZuSkS2BvoyrDXtXtL18t
 s3JIQGCxDVG7twaacWuf1uDevOnn5esZ9Jk5+kvp/ilIKViJkwTQFKozPaMCX4YOZq8s hA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn2w5ayv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 09:20:25 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3669KLsl015389;
        Thu, 6 Jul 2023 09:20:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rjd7ky0xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 06 Jul 2023 09:20:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3669KLJ1015101;
        Thu, 6 Jul 2023 09:20:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3669KLZm014984;
        Thu, 06 Jul 2023 09:20:21 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id A649A5FE6; Thu,  6 Jul 2023 14:50:20 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 3/3] soc: qcom: rpmphd: Update the entries of PD macros
Date:   Thu,  6 Jul 2023 14:50:18 +0530
Message-Id: <1688635218-23779-4-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5aE79JOcWLuo1SKKQUd0w-tmbBpSwR98
X-Proofpoint-GUID: 5aE79JOcWLuo1SKKQUd0w-tmbBpSwR98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_06,2023-07-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=744
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 drivers/soc/qcom/rpmhpd.c | 338 +++++++++++++++++++++++-----------------------
 1 file changed, 169 insertions(+), 169 deletions(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 63c35a3..0b844a3 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -204,17 +204,17 @@ static struct rpmhpd qphy = {
 
 /* SA8540P RPMH powerdomains */
 static struct rpmhpd *sa8540p_rpmhpds[] = {
-	[SC8280XP_CX] = &cx,
-	[SC8280XP_CX_AO] = &cx_ao,
-	[SC8280XP_EBI] = &ebi,
-	[SC8280XP_GFX] = &gfx,
-	[SC8280XP_LCX] = &lcx,
-	[SC8280XP_LMX] = &lmx,
-	[SC8280XP_MMCX] = &mmcx,
-	[SC8280XP_MMCX_AO] = &mmcx_ao,
-	[SC8280XP_MX] = &mx,
-	[SC8280XP_MX_AO] = &mx_ao,
-	[SC8280XP_NSP] = &nsp,
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_NSP] = &nsp,
 };
 
 static const struct rpmhpd_desc sa8540p_desc = {
@@ -224,20 +224,20 @@ static const struct rpmhpd_desc sa8540p_desc = {
 
 /* SA8775P RPMH power domains */
 static struct rpmhpd *sa8775p_rpmhpds[] = {
-	[SA8775P_CX] = &cx,
-	[SA8775P_CX_AO] = &cx_ao,
-	[SA8775P_EBI] = &ebi,
-	[SA8775P_GFX] = &gfx,
-	[SA8775P_LCX] = &lcx,
-	[SA8775P_LMX] = &lmx,
-	[SA8775P_MMCX] = &mmcx,
-	[SA8775P_MMCX_AO] = &mmcx_ao,
-	[SA8775P_MXC] = &mxc,
-	[SA8775P_MXC_AO] = &mxc_ao,
-	[SA8775P_MX] = &mx,
-	[SA8775P_MX_AO] = &mx_ao,
-	[SA8775P_NSP0] = &nsp0,
-	[SA8775P_NSP1] = &nsp1,
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_NSP0] = &nsp0,
+	[RPMHPD_NSP1] = &nsp1,
 };
 
 static const struct rpmhpd_desc sa8775p_desc = {
@@ -247,14 +247,14 @@ static const struct rpmhpd_desc sa8775p_desc = {
 
 /* SDM670 RPMH powerdomains */
 static struct rpmhpd *sdm670_rpmhpds[] = {
-	[SDM670_CX] = &cx_w_mx_parent,
-	[SDM670_CX_AO] = &cx_ao_w_mx_parent,
-	[SDM670_GFX] = &gfx,
-	[SDM670_LCX] = &lcx,
-	[SDM670_LMX] = &lmx,
-	[SDM670_MSS] = &mss,
-	[SDM670_MX] = &mx,
-	[SDM670_MX_AO] = &mx_ao,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sdm670_desc = {
@@ -264,15 +264,15 @@ static const struct rpmhpd_desc sdm670_desc = {
 
 /* SDM845 RPMH powerdomains */
 static struct rpmhpd *sdm845_rpmhpds[] = {
-	[SDM845_CX] = &cx_w_mx_parent,
-	[SDM845_CX_AO] = &cx_ao_w_mx_parent,
-	[SDM845_EBI] = &ebi,
-	[SDM845_GFX] = &gfx,
-	[SDM845_LCX] = &lcx,
-	[SDM845_LMX] = &lmx,
-	[SDM845_MSS] = &mss,
-	[SDM845_MX] = &mx,
-	[SDM845_MX_AO] = &mx_ao,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sdm845_desc = {
@@ -282,9 +282,9 @@ static const struct rpmhpd_desc sdm845_desc = {
 
 /* SDX55 RPMH powerdomains */
 static struct rpmhpd *sdx55_rpmhpds[] = {
-	[SDX55_CX] = &cx_w_mx_parent,
-	[SDX55_MSS] = &mss,
-	[SDX55_MX] = &mx,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
 };
 
 static const struct rpmhpd_desc sdx55_desc = {
@@ -294,12 +294,12 @@ static const struct rpmhpd_desc sdx55_desc = {
 
 /* SDX65 RPMH powerdomains */
 static struct rpmhpd *sdx65_rpmhpds[] = {
-	[SDX65_CX] = &cx_w_mx_parent,
-	[SDX65_CX_AO] = &cx_ao_w_mx_parent,
-	[SDX65_MSS] = &mss,
-	[SDX65_MX] = &mx,
-	[SDX65_MX_AO] = &mx_ao,
-	[SDX65_MXC] = &mxc,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
 };
 
 static const struct rpmhpd_desc sdx65_desc = {
@@ -309,12 +309,12 @@ static const struct rpmhpd_desc sdx65_desc = {
 
 /* SM6350 RPMH powerdomains */
 static struct rpmhpd *sm6350_rpmhpds[] = {
-	[SM6350_CX] = &cx_w_mx_parent,
-	[SM6350_GFX] = &gfx,
-	[SM6350_LCX] = &lcx,
-	[SM6350_LMX] = &lmx,
-	[SM6350_MSS] = &mss,
-	[SM6350_MX] = &mx,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
 };
 
 static const struct rpmhpd_desc sm6350_desc = {
@@ -324,17 +324,17 @@ static const struct rpmhpd_desc sm6350_desc = {
 
 /* SM8150 RPMH powerdomains */
 static struct rpmhpd *sm8150_rpmhpds[] = {
-	[SM8150_CX] = &cx_w_mx_parent,
-	[SM8150_CX_AO] = &cx_ao_w_mx_parent,
-	[SM8150_EBI] = &ebi,
-	[SM8150_GFX] = &gfx,
-	[SM8150_LCX] = &lcx,
-	[SM8150_LMX] = &lmx,
-	[SM8150_MMCX] = &mmcx,
-	[SM8150_MMCX_AO] = &mmcx_ao,
-	[SM8150_MSS] = &mss,
-	[SM8150_MX] = &mx,
-	[SM8150_MX_AO] = &mx_ao,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sm8150_desc = {
@@ -343,13 +343,13 @@ static const struct rpmhpd_desc sm8150_desc = {
 };
 
 static struct rpmhpd *sa8155p_rpmhpds[] = {
-	[SA8155P_CX] = &cx_w_mx_parent,
-	[SA8155P_CX_AO] = &cx_ao_w_mx_parent,
-	[SA8155P_EBI] = &ebi,
-	[SA8155P_GFX] = &gfx,
-	[SA8155P_MSS] = &mss,
-	[SA8155P_MX] = &mx,
-	[SA8155P_MX_AO] = &mx_ao,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sa8155p_desc = {
@@ -359,16 +359,16 @@ static const struct rpmhpd_desc sa8155p_desc = {
 
 /* SM8250 RPMH powerdomains */
 static struct rpmhpd *sm8250_rpmhpds[] = {
-	[SM8250_CX] = &cx_w_mx_parent,
-	[SM8250_CX_AO] = &cx_ao_w_mx_parent,
-	[SM8250_EBI] = &ebi,
-	[SM8250_GFX] = &gfx,
-	[SM8250_LCX] = &lcx,
-	[SM8250_LMX] = &lmx,
-	[SM8250_MMCX] = &mmcx,
-	[SM8250_MMCX_AO] = &mmcx_ao,
-	[SM8250_MX] = &mx,
-	[SM8250_MX_AO] = &mx_ao,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sm8250_desc = {
@@ -378,19 +378,19 @@ static const struct rpmhpd_desc sm8250_desc = {
 
 /* SM8350 Power domains */
 static struct rpmhpd *sm8350_rpmhpds[] = {
-	[SM8350_CX] = &cx_w_mx_parent,
-	[SM8350_CX_AO] = &cx_ao_w_mx_parent,
-	[SM8350_EBI] = &ebi,
-	[SM8350_GFX] = &gfx,
-	[SM8350_LCX] = &lcx,
-	[SM8350_LMX] = &lmx,
-	[SM8350_MMCX] = &mmcx,
-	[SM8350_MMCX_AO] = &mmcx_ao,
-	[SM8350_MSS] = &mss,
-	[SM8350_MX] = &mx,
-	[SM8350_MX_AO] = &mx_ao,
-	[SM8350_MXC] = &mxc,
-	[SM8350_MXC_AO] = &mxc_ao,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
 };
 
 static const struct rpmhpd_desc sm8350_desc = {
@@ -400,19 +400,19 @@ static const struct rpmhpd_desc sm8350_desc = {
 
 /* SM8450 RPMH powerdomains */
 static struct rpmhpd *sm8450_rpmhpds[] = {
-	[SM8450_CX] = &cx,
-	[SM8450_CX_AO] = &cx_ao,
-	[SM8450_EBI] = &ebi,
-	[SM8450_GFX] = &gfx,
-	[SM8450_LCX] = &lcx,
-	[SM8450_LMX] = &lmx,
-	[SM8450_MMCX] = &mmcx_w_cx_parent,
-	[SM8450_MMCX_AO] = &mmcx_ao_w_cx_parent,
-	[SM8450_MSS] = &mss,
-	[SM8450_MX] = &mx,
-	[SM8450_MX_AO] = &mx_ao,
-	[SM8450_MXC] = &mxc,
-	[SM8450_MXC_AO] = &mxc_ao,
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
+	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
 };
 
 static const struct rpmhpd_desc sm8450_desc = {
@@ -422,20 +422,20 @@ static const struct rpmhpd_desc sm8450_desc = {
 
 /* SM8550 RPMH powerdomains */
 static struct rpmhpd *sm8550_rpmhpds[] = {
-	[SM8550_CX] = &cx,
-	[SM8550_CX_AO] = &cx_ao,
-	[SM8550_EBI] = &ebi,
-	[SM8550_GFX] = &gfx,
-	[SM8550_LCX] = &lcx,
-	[SM8550_LMX] = &lmx,
-	[SM8550_MMCX] = &mmcx_w_cx_parent,
-	[SM8550_MMCX_AO] = &mmcx_ao_w_cx_parent,
-	[SM8550_MSS] = &mss,
-	[SM8550_MX] = &mx,
-	[SM8550_MX_AO] = &mx_ao,
-	[SM8550_MXC] = &mxc,
-	[SM8550_MXC_AO] = &mxc_ao,
-	[SM8550_NSP] = &nsp,
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
+	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_NSP] = &nsp,
 };
 
 static const struct rpmhpd_desc sm8550_desc = {
@@ -445,10 +445,10 @@ static const struct rpmhpd_desc sm8550_desc = {
 
 /* QDU1000/QRU1000 RPMH powerdomains */
 static struct rpmhpd *qdu1000_rpmhpds[] = {
-	[QDU1000_CX] = &cx,
-	[QDU1000_EBI] = &ebi,
-	[QDU1000_MSS] = &mss,
-	[QDU1000_MX] = &mx,
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
 };
 
 static const struct rpmhpd_desc qdu1000_desc = {
@@ -458,14 +458,14 @@ static const struct rpmhpd_desc qdu1000_desc = {
 
 /* SC7180 RPMH powerdomains */
 static struct rpmhpd *sc7180_rpmhpds[] = {
-	[SC7180_CX] = &cx_w_mx_parent,
-	[SC7180_CX_AO] = &cx_ao_w_mx_parent,
-	[SC7180_GFX] = &gfx,
-	[SC7180_LCX] = &lcx,
-	[SC7180_LMX] = &lmx,
-	[SC7180_MSS] = &mss,
-	[SC7180_MX] = &mx,
-	[SC7180_MX_AO] = &mx_ao,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sc7180_desc = {
@@ -475,15 +475,15 @@ static const struct rpmhpd_desc sc7180_desc = {
 
 /* SC7280 RPMH powerdomains */
 static struct rpmhpd *sc7280_rpmhpds[] = {
-	[SC7280_CX] = &cx,
-	[SC7280_CX_AO] = &cx_ao,
-	[SC7280_EBI] = &ebi,
-	[SC7280_GFX] = &gfx,
-	[SC7280_LCX] = &lcx,
-	[SC7280_LMX] = &lmx,
-	[SC7280_MSS] = &mss,
-	[SC7280_MX] = &mx,
-	[SC7280_MX_AO] = &mx_ao,
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sc7280_desc = {
@@ -493,17 +493,17 @@ static const struct rpmhpd_desc sc7280_desc = {
 
 /* SC8180x RPMH powerdomains */
 static struct rpmhpd *sc8180x_rpmhpds[] = {
-	[SC8180X_CX] = &cx_w_mx_parent,
-	[SC8180X_CX_AO] = &cx_ao_w_mx_parent,
-	[SC8180X_EBI] = &ebi,
-	[SC8180X_GFX] = &gfx,
-	[SC8180X_LCX] = &lcx,
-	[SC8180X_LMX] = &lmx,
-	[SC8180X_MMCX] = &mmcx,
-	[SC8180X_MMCX_AO] = &mmcx_ao,
-	[SC8180X_MSS] = &mss,
-	[SC8180X_MX] = &mx,
-	[SC8180X_MX_AO] = &mx_ao,
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
 };
 
 static const struct rpmhpd_desc sc8180x_desc = {
@@ -513,18 +513,18 @@ static const struct rpmhpd_desc sc8180x_desc = {
 
 /* SC8280xp RPMH powerdomains */
 static struct rpmhpd *sc8280xp_rpmhpds[] = {
-	[SC8280XP_CX] = &cx,
-	[SC8280XP_CX_AO] = &cx_ao,
-	[SC8280XP_EBI] = &ebi,
-	[SC8280XP_GFX] = &gfx,
-	[SC8280XP_LCX] = &lcx,
-	[SC8280XP_LMX] = &lmx,
-	[SC8280XP_MMCX] = &mmcx,
-	[SC8280XP_MMCX_AO] = &mmcx_ao,
-	[SC8280XP_MX] = &mx,
-	[SC8280XP_MX_AO] = &mx_ao,
-	[SC8280XP_NSP] = &nsp,
-	[SC8280XP_QPHY] = &qphy,
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_NSP] = &nsp,
+	[RPMHPD_QPHY] = &qphy,
 };
 
 static const struct rpmhpd_desc sc8280xp_desc = {
-- 
2.7.4

