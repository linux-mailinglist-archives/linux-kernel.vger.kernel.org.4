Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BAB6BEAED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCQOR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCQORY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:17:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC211C581;
        Fri, 17 Mar 2023 07:17:17 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H7YLCZ016596;
        Fri, 17 Mar 2023 14:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=wfmGrrfC7vhTkVsssPLjO7EMgWkmtEjtqoWPrRqoWrc=;
 b=nhFpRURC0QpycmopOzHshtqdcDq2CIG+05+kOD70HVUz3+Fzq2vfTKSs/yHqYw4u3KQ9
 qMKd0Z1Bd0dllgkkyH/TDCzH9NDyY0vrO7JBTFMQcafT1wLXMoj8Ul1Kc5J40jcQLFSX
 5lck42wJ/BUuiwS/KuLBchtGgrnVC5AdmYNeuXVoJq1Pskid5RqjejJat1VJpfeCm52C
 DzI3IC8NEIa7umqXY/mtm6tLpQZt2wuAhaDFIZHpGZnsV0CnZMBkdqEMDQYjZdZwg5lm
 1T7BxJ1D334fgHuc3KiCLIQGQN/APFxdgbGNkxbUwvI2i+lh4a9+LvvhRqFIQjo2eEfk Yw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pcbasab13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 14:17:10 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32HEH86S009238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 14:17:08 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Mar 2023 07:17:04 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_visr@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/4] dt-bindings: clock: qcom,sc7280-lpasscc: Add qcom,adsp-pil-mode property
Date:   Fri, 17 Mar 2023 19:46:19 +0530
Message-ID: <20230317141622.1926573-2-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317141622.1926573-1-quic_mohs@quicinc.com>
References: <20230317141622.1926573-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kz2dLmF6YHBaKfrEq5EIoBNZiJOGIxD9
X-Proofpoint-ORIG-GUID: kz2dLmF6YHBaKfrEq5EIoBNZiJOGIxD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_08,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=8
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

When this property is set, the remoteproc is used to boot the
LPASS and therefore qdsp6ss clocks would be used to bring LPASS
out of reset, hence they are directly controlled by the remoteproc.

This is a cleanup done to handle overlap of regmap of lpasscc
and adsp remoteproc blocks.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 .../devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
index 6151fdebbff8..97c6bd96e0cb 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
@@ -41,6 +41,12 @@ properties:
       - const: qdsp6ss
       - const: top_cc
 
+  qcom,adsp-pil-mode:
+    description:
+      Indicates if the LPASS would be brought out of reset using
+      remoteproc peripheral loader.
+    type: boolean
+
 required:
   - compatible
   - reg
@@ -60,6 +66,7 @@ examples:
       reg-names = "qdsp6ss", "top_cc";
       clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
       clock-names = "iface";
+      qcom,adsp-pil-mode;
       #clock-cells = <1>;
     };
 ...
-- 
2.25.1

