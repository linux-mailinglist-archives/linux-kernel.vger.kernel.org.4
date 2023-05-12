Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC6C7007A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbjELMWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240862AbjELMWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:22:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D6611DB6;
        Fri, 12 May 2023 05:22:00 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CBC1e1022628;
        Fri, 12 May 2023 12:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=/65vKdetwmb43mDhATuCjOVP9mfTPNcvx1hM5S1jW5k=;
 b=E5FQ3BTuVXgpLajykfbFSaGMzvb0uqlL1f9wQZ9VDeNCB5ggSAJNFbZ0RkFx+TX6zXQS
 jUjB4zW0XewjZdtcKOfOJx+yGNzr7VOPcjN29RAPdqPr2GQ+BCkqX7aY9lKKaP6IVV+r
 HEbxhB49/V6nXGf6bbo/czUJZcyut1UjRpDq6mjyntMWwebHF+8og28EZaK8lK/EVT3l
 wRhzNoPDYShH+M/2Gjw/c6WKQ6dyWA/+Cgh6d57Q4dEa0dWw15PF0nnaCjWiOUTn/ChK
 cO6Qp53Y1hbMyy5vaBynKoBEnqPVm99q9DPcFuexXr+nYr+Qedoq2g/WN2Z6JAroyKYS wg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhes20x1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:21:56 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34CCLsE0029094;
        Fri, 12 May 2023 12:21:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdy59u1vv-1;
        Fri, 12 May 2023 12:21:54 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CCLrGe029088;
        Fri, 12 May 2023 12:21:54 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34CCLrUu029087;
        Fri, 12 May 2023 12:21:53 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 2F6F652974D; Fri, 12 May 2023 17:51:53 +0530 (+0530)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 08/10] Revert "arm64: dts: qcom: qdu1000: Add LLCC/system-cache-controller"
Date:   Fri, 12 May 2023 17:51:32 +0530
Message-Id: <20230512122134.24339-9-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uuuZVEWM02Vjk06CBbBu6nfsR_GNHvin
X-Proofpoint-GUID: uuuZVEWM02Vjk06CBbBu6nfsR_GNHvin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=789 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120103
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6209038f131fee84ff1536dc59864f54d06740f2.
Reverting change as it was merged before corresponding driver side
changes, resulting in incompatibility with the current implementation.
Committing the revert now.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 418644f396bc..ff21e7a6b312 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -1322,18 +1322,6 @@
 			#interconnect-cells = <2>;
 		};

-		system-cache-controller@19200000 {
-			compatible = "qcom,qdu1000-llcc";
-			reg = <0 0x19200000 0 0xd80000>,
-			      <0 0x1a200000 0 0x80000>,
-			      <0 0x221c8128 0 0x4>;
-			reg-names = "llcc_base",
-				    "llcc_broadcast_base",
-				    "multi_channel_register";
-			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
-			multi-ch-bit-off = <24 2>;
-		};
-
 		qfprom: efuse@221c8000 {
 			compatible = "qcom,qdu1000-qfprom", "qcom,qfprom";
 			reg = <0 0x221c8000 0 0x1000>;
--
2.17.1

