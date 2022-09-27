Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3583E5EC007
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiI0KoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiI0KoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:44:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA0AF392B;
        Tue, 27 Sep 2022 03:43:58 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RAPxIT027708;
        Tue, 27 Sep 2022 10:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=5LLrBsHbIrg4HP9shja11XjCheuLW7nPZK6y4XHFcMw=;
 b=mX5X1V4NI1rdv5WzxJP1uLzh1VVbqGPsCQDnxYlXFLKPTYkL7sfxqHjQE1pIfR/jR+Qe
 Alan4L9zA/voOtbe/CH9k2bfsY2e37pdStqSsaMvKIEY30TviRdUogMcohJO2QPHRFJ1
 JqpPODpwqr5kEKuqO8YRi/OlXIsrOrY7JXERhTyXpldgPnoe0dtdiE3DDrO64ZBIzCRV
 JM4VTsh3CDmBzaoi26XqqXuXALFO/shOM2bJg7oZmgclH23HqW1DdefMFNBM/3bYu4vK
 FKZnDrs3wBMaoXiyqaRsAkYtpPMMBz271n6UnEN8/h55sCfWPxtd+xdDjzOjdyD7GNr6 gQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jurq7912q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 10:43:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28RARSfF020593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 10:27:28 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 27 Sep 2022 03:27:24 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sboyd@kernel.org>,
        <mka@chromium.org>, <quic_kriskura@quicinc.com>,
        <dianders@chromium.org>, Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: sc7180: Add required-opps for USB
Date:   Tue, 27 Sep 2022 15:56:46 +0530
Message-ID: <20220927102646.14785-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QO3Q3p8E3gUcqGxqgNYLJa1fSxOyY1nV
X-Proofpoint-GUID: QO3Q3p8E3gUcqGxqgNYLJa1fSxOyY1nV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_03,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270063
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB has a requirement to put a performance state vote on 'cx'
while active. Use 'required-opps' to pass this information from
device tree, and since all the GDSCs in GCC (including USB) are
sub-domains of cx, we also add cx as a power-domain for GCC.
Now when any of the consumers of the GDSCs (in this case USB)
votes on a perforamance state, genpd framework can identify that
the GDSC itself does not support a performance state and it
then propogates the vote to the parent, which in this case is cx.

This change would also mean that any GDSC in GCC thats left enabled
during low power state (perhaps because its marked with a
ALWAYS_ON flag) can prevent the system from entering low power
since that would prevent cx from transitioning to low power.
Ideally any consumers that would need to have their devices
(partially) powered to support wakeups should look at making the
resp. GDSCs transtion to a Retention (PWRSTS_RET) state instead
of leaving them ALWAYS_ON.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 58976a1ba06b..f59692213745 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -662,6 +662,7 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			power-domains = <&rpmhpd SC7180_CX>;
 		};
 
 		qfprom: efuse@784000 {
@@ -2775,6 +2776,7 @@
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_PRIM_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
-- 
2.17.1

