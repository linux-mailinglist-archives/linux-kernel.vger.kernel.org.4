Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CBB6CAAB1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjC0Qd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjC0Qdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:33:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E918F12F;
        Mon, 27 Mar 2023 09:33:35 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RD052L005981;
        Mon, 27 Mar 2023 16:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=PcMKdIBG2DYTNOElioIq9LXZxGMZd/qkiH5UTSqdpXc=;
 b=D+HBBSVl+HSb3UaLlsdkEiczXl0LvPgROg89m4nAO8M9uA/PiLIspo1PQdTxZAGqDWGp
 dbQaiV3wbQaNtSOmdwuWSdH/5G+hG+VdawO16jGFxt/bUovhGrPF6Q2n19uDgKsZs0M2
 VdmZxpW188276aA29ElJRyooHCQpacZJoxL06ukawvND6phho39yD5fsIvxwXCRm3/Md
 yPFDdKqjfery34Q+ftZNkbw7nBgF6eTAucSoJwNdfp73VPk1z6MGPJMazT6sIp+Sqp6I
 IDaI3UEKMVFRXy082zmhvCYyuSYeHa+TNKxuVAaa+zqP0Mrj75UZfcYHiONxtDwZFmij AQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkbmyrm9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 16:33:28 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32RGXSs7011541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 16:33:28 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Mar 2023 09:33:22 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <quic_visr@quicinc.com>
CC:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v1 2/4] dt-bindings: clock: qcom,sc7280-lpasscc: Remove qdsp6ss register region
Date:   Mon, 27 Mar 2023 22:02:47 +0530
Message-ID: <20230327163249.1081824-3-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327163249.1081824-1-quic_mohs@quicinc.com>
References: <20230327163249.1081824-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Dj0XzyoYDc-JkjGH47jQP4lsVq8855Ja
X-Proofpoint-GUID: Dj0XzyoYDc-JkjGH47jQP4lsVq8855Ja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270133
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qdsp6ss memory region 0x3000000 is being shared by ADSP remoteproc
device and lpasscc clock device, hence causing memory conflict and 
as the qdsp6ss clocks are being enabled in remoteproc driver,
remove the qdsp6ss register from lpasscc.

Changing the base address of lpasscc based on the first register memory.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 .../devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml    | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
index 6151fdebbff8..9c72b8eca450 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
@@ -33,12 +33,10 @@ properties:
 
   reg:
     items:
-      - description: LPASS qdsp6ss register
       - description: LPASS top-cc register
 
   reg-names:
     items:
-      - const: qdsp6ss
       - const: top_cc
 
 required:
@@ -54,10 +52,10 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sc7280.h>
     #include <dt-bindings/clock/qcom,lpass-sc7280.h>
-    clock-controller@3000000 {
+    clock-controller@3c04000 {
       compatible = "qcom,sc7280-lpasscc";
-      reg = <0x03000000 0x40>, <0x03c04000 0x4>;
-      reg-names = "qdsp6ss", "top_cc";
+      reg = <0x03c04000 0x4>;
+      reg-names = "top_cc";
       clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
       clock-names = "iface";
       #clock-cells = <1>;
-- 
2.25.1

