Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFD86E2499
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDNNst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDNNsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:48:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0FEA262;
        Fri, 14 Apr 2023 06:48:42 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EDI4dW027619;
        Fri, 14 Apr 2023 13:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ATMltL+CDCIbngmpJK8u5JrM8dKbBp2sVCANoFvITwU=;
 b=iRhwumlPHYkOnMVGHYqAkECE6/VLCNaI86tPyEcjy0lF+DvZpCGrU/qa7qAZdpde0V2S
 XEd9/aOe6yG0sKLtfSS02OB/IDc2zMVqjSCZ9pOTLdPLWM6zkoX7IK/CmfO4/IMeifBn
 WSlsDCT28IP07DZ3M12v1f4fo5VIEG+ienPhf9rJw11zOLWZZ1awtgXN1FKzsNrCoBNx
 cz5btQYcqrigmIBpBd5pyuNY6hl+CM/Wbddap3sN7w/iljWrvyG8NUMLQnvpoVonyOJQ
 j0nddI6PIycsQdxbYuxCXToNLoDgJNyVrmrH5BKuSnFfZD61g9DvnitBpVx1vDbqalOs kQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py1wpgtn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 13:48:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EDmbxw010829
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 13:48:37 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 14 Apr 2023 06:48:31 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH V1 1/4] dt-bindings: clock: qcom,ipq9574-gcc: Drop the Bias PLL ubi clock source
Date:   Fri, 14 Apr 2023 19:18:09 +0530
Message-ID: <20230414134812.16812-2-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414134812.16812-1-quic_devipriy@quicinc.com>
References: <20230414134812.16812-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t8YKH9f8GdgvjruSs5YLF6y6DySE0cVE
X-Proofpoint-ORIG-GUID: t8YKH9f8GdgvjruSs5YLF6y6DySE0cVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_06,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bias_pll_ubi_nc_clk from the binding as it has been removed from
the Device Tree. Also added Bjorn Andersson to the maintainers list.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes since V9:
	- Dropped the clock description for Bias PLL ubi clock source
	  to reflect the gcc node in the DT
	- Added Bjorn Andersson to the maintainers list

 Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
index afc68eb9d7cc..8581de266750 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
@@ -7,6 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Global Clock & Reset Controller on IPQ9574
 
 maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
   - Anusha Rao <quic_anusha@quicinc.com>
 
 description: |
@@ -25,7 +26,6 @@ properties:
     items:
       - description: Board XO source
       - description: Sleep clock source
-      - description: Bias PLL ubi clock source
       - description: PCIE30 PHY0 pipe clock source
       - description: PCIE30 PHY1 pipe clock source
       - description: PCIE30 PHY2 pipe clock source
@@ -48,7 +48,6 @@ examples:
       reg = <0x01800000 0x80000>;
       clocks = <&xo_board_clk>,
                <&sleep_clk>,
-               <&bias_pll_ubi_nc_clk>,
                <&pcie30_phy0_pipe_clk>,
                <&pcie30_phy1_pipe_clk>,
                <&pcie30_phy2_pipe_clk>,
-- 
2.17.1

