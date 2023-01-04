Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6018565D7BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbjADP7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbjADP6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:58:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFBCBD8;
        Wed,  4 Jan 2023 07:58:47 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304FR83F012000;
        Wed, 4 Jan 2023 15:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=nLEGtR3xX/fAobQiHP8Fq1vCYtn2NPDHBpPXNLpRiNE=;
 b=Ord1RF83Cv1gZh5tvmw3Ntlboa+dOd0sL9AR8CN9Pgbylz5aKq4skr+cHrdsCG56kjox
 Sb1cX0RhT7hT6OVKiiivhV7aDbdovRmxMRVdXyaI66Gg5IU6r/DCBKNYnzEBEdXs5WSC
 8YtcoOXwWJaibJ27fa2lTrAnO3HP8WhicN8WUlKf/AOFl6XhI25RHCQxlyovv7GOodyt
 EimFDXSd6FS58cLQW16p9OXXniTsRMuizWXy7IvUZb9d2dVJAvvC/yk9r/TbiBMjK1FY
 XLwvU1IVHCxXAwTo2qVAXtbb9TWdISx8UIyub1ynaaZWsKXLfCjEvieaXnxbVw81JGxz kg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvgt506-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 15:58:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 304Fwe9x012337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Jan 2023 15:58:40 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 4 Jan 2023 07:58:35 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [RESEND v3 2/4] dt-bindings: clock: qcom,sc7280-lpasscc: Add resets for audioreach
Date:   Wed, 4 Jan 2023 21:28:10 +0530
Message-ID: <1672847892-25154-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1672847892-25154-1-git-send-email-quic_srivasam@quicinc.com>
References: <1672847892-25154-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FK1BXC5ZN5pn1fDYzwLESHUO5cFw_1fy
X-Proofpoint-ORIG-GUID: FK1BXC5ZN5pn1fDYzwLESHUO5cFw_1fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
for audioreach based SC7280 platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 .../devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml       | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
index 97c6bd9..054c496 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
@@ -31,15 +31,20 @@ properties:
   '#clock-cells':
     const: 1
 
+  '#reset-cells':
+    const: 1
+
   reg:
     items:
       - description: LPASS qdsp6ss register
       - description: LPASS top-cc register
+      - description: LPASS reset-cgcr register
 
   reg-names:
     items:
       - const: qdsp6ss
       - const: top_cc
+      - const: reset_cgcr
 
   qcom,adsp-pil-mode:
     description:
@@ -62,11 +67,14 @@ examples:
     #include <dt-bindings/clock/qcom,lpass-sc7280.h>
     clock-controller@3000000 {
       compatible = "qcom,sc7280-lpasscc";
-      reg = <0x03000000 0x40>, <0x03c04000 0x4>;
-      reg-names = "qdsp6ss", "top_cc";
+      reg = <0x03000000 0x40>,
+            <0x03c04000 0x4>,
+            <0x032a9000 0x1000>;
+      reg-names = "qdsp6ss", "top_cc", "reset_cgcr";
       clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
       clock-names = "iface";
       qcom,adsp-pil-mode;
       #clock-cells = <1>;
+      #reset-cells = <1>;
     };
 ...
-- 
2.7.4

