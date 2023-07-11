Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71C474EBDF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGKKnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKKnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:43:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF53E60;
        Tue, 11 Jul 2023 03:43:05 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B9Pl1I005030;
        Tue, 11 Jul 2023 10:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=KcrIkF1sJE8FlF7BTNekoVJT3EBQCC1E51sDa804sIo=;
 b=TWV2umHC/2jS525s6LXrO1Z5kmWl6eIq1sRYg2QQK7n4sdVhcjZNGYlQOOGtXhSDlDFN
 CiJdvqS14sB5px89hvpE+LhbAWjRLgc7sC+kVmK6wWS1iUWu3imOI3FRX3dzEMFz6SsF
 R1e2vAL60HXEdj9nS6ri+CcRPyE9Bv47KPMk4B0Wr17tyiG6QOKDntqGbQyw+1Jtt75R
 bA7kR+xnqo64DABQOlEsNdwPb+Q0U4661KRTE1rLrvqXQwqrlsTTj1JV7Nsrbnbo2EYU
 yUPQiT5xS8+Aocj8Xt1RlRLUxk+Cnhj5aAarKG1DLwPioMGcML9yFs9XMpK8D018iTMA Nw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs3vh86an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 10:43:01 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36BAeCwc021490;
        Tue, 11 Jul 2023 10:42:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vkm6gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 10:42:58 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BAgwOq023577;
        Tue, 11 Jul 2023 10:42:58 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36BAgvHr023576;
        Tue, 11 Jul 2023 10:42:58 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 18FFC5000AA; Tue, 11 Jul 2023 16:12:57 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V1] arm64: dts: qcom: sa8775p-ride: Update L4C parameters
Date:   Tue, 11 Jul 2023 16:12:55 +0530
Message-Id: <20230711104255.16488-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zh_l20uUVBrtsJ5Q6-lVp7w98VV25frk
X-Proofpoint-ORIG-GUID: zh_l20uUVBrtsJ5Q6-lVp7w98VV25frk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=955
 clxscore=1011 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110094
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>

L4c is the supply for UFS vccq, As per UFS spec range of vccq is
1.14V to 1.26V, There are stability issues when operating at
marginal voltage. Hence configure the min and max vccq voltages
to 1.2V.

Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index ab767cfa51ff..26f5a4e0ffed 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -153,8 +153,8 @@
 
 		vreg_l4c: ldo4 {
 			regulator-name = "vreg_l4c";
-			regulator-min-microvolt = <1100000>;
-			regulator-max-microvolt = <1300000>;
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			/*
 			 * FIXME: This should have regulator-allow-set-load but
-- 
2.17.1

