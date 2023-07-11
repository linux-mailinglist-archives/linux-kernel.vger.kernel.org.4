Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82A74EC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGKK7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjGKK71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:59:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CD0E55;
        Tue, 11 Jul 2023 03:59:25 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BAMFS3004738;
        Tue, 11 Jul 2023 10:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Arf4vm6RhaE0vAgoXKr4ABZcfNQlS9/Cz4o9CeH6l7I=;
 b=UnA/XQoU/3Mwm/nq0oQhB+ECEik3FNrakCIC1xu28fqLHL0feEQAeWOsPilkudvvTyAq
 sLfyjpyZKZ8cWsMStUm0wRvVysa+bz/ie3EVWDzi60Zo3AG6g325E7FWlhdlOVhNM35E
 6CHLaiNWQ88KU8F/9Qsr3DVm0bXtTi4+wLcrIF9BmWD7r+/USu3GasaVvJXQ6pykOIMP
 BOd08PXX2HtjNk2vjyZL/pOrKqOP+J2gIcAqLARD0vksHpFgk4nlr3ZMsL1tMZco/Gas
 VC1frngTVPQjV7KUeRMgyPl2QCJpB0uEMPuOnFz3sI9ZUelQkwwpQFjKT6c5Eev4cb7m PA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs59181t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 10:59:22 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36BAxIX2010695;
        Tue, 11 Jul 2023 10:59:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rq0vm3cat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 10:59:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BAxIEB010690;
        Tue, 11 Jul 2023 10:59:18 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-narepall-hyd.qualcomm.com [10.213.107.70])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36BAxHx9010689;
        Tue, 11 Jul 2023 10:59:18 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3995025)
        id 68139500995; Tue, 11 Jul 2023 16:29:17 +0530 (+0530)
From:   Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
To:     quic_nitirawa@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V2] arm64: dts: qcom: sa8775p-ride: Update L4C parameters
Date:   Tue, 11 Jul 2023 16:29:14 +0530
Message-Id: <20230711105915.30581-1-quic_narepall@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jcsf8D-Fx8ljWZ8t8uM09iH5z0p3nj7z
X-Proofpoint-ORIG-GUID: Jcsf8D-Fx8ljWZ8t8uM09iH5z0p3nj7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=927
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110099
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

