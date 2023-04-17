Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B02D6E3EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 07:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDQFeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 01:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQFe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:34:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B8C2713;
        Sun, 16 Apr 2023 22:34:28 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H30Uj5003694;
        Mon, 17 Apr 2023 05:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=5budlMC/TWBSN7orOMvIaRmn81J2KDv4KkmIkjnDggA=;
 b=G/vftIyn0rxLki5tnYasKsglRGaI8CeFne4UoO7IpGe+aRvxDWsX+1b25eU8iJPYTjkN
 rspe2IgIGwAuheH7yFQ0fufY0E/wa3F2Y0jqA2cSIqYaoVnbCvMtzUMlO9G2gUABhcLY
 2PF0ZSwSKwM+t31Fenh0TsI0VtV7DDiAy2RjMkWTS2Etet6fhux7Ls5ocdak9e3iBord
 r65Sw8XE1utuYiLkdwWZgj7LD89eA9MM+ItgtWlUSYe90HFOM825muPdVXyCtUr5456p
 RLLsaYHrHGArUOY2KQQNHcRRIFW4HYdtPG//nH/fhImzRGMCEVC9IMC7FdLfBJlcBzqo WQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pyn7etk2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 05:34:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H5YOcN020207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 05:34:24 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 16 Apr 2023 22:34:19 -0700
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
Subject: [PATCH V2 1/4] dt-bindings: clock: qcom,ipq9574-gcc: Drop bias_pll_ubi_nc_clk input
Date:   Mon, 17 Apr 2023 11:03:52 +0530
Message-ID: <20230417053355.25691-2-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230417053355.25691-1-quic_devipriy@quicinc.com>
References: <20230417053355.25691-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uX_oACe1TGb1kdYzNU4vFEqXuYEhBuO5
X-Proofpoint-GUID: uX_oACe1TGb1kdYzNU4vFEqXuYEhBuO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unused bias_pll_ubi_nc_clk input to the clock controller.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes since V9:
	- Dropped the unused bias_pll_ubi_nc_clk input
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

