Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9417697F39
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBOPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjBOPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:14:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259883402D;
        Wed, 15 Feb 2023 07:14:53 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FDHAYl016360;
        Wed, 15 Feb 2023 15:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=wfmGrrfC7vhTkVsssPLjO7EMgWkmtEjtqoWPrRqoWrc=;
 b=O+8bLldM896QeSmZFoEo+ysIAJi+MI7UWxxPixViz1/3Ml1KFsVDeOaFsGiSTOIFrtzG
 G+AFj+H6o8TX8lsA83MtGNu8rQcsod+syn4c+igTKUOb9s5GM6Mku5ZZy4Aom2Gn2PSm
 zTRWSCLAhNtkPFJ0ClPKkz8A37dhXODBv7KL1YUEcCpYEOTLF7AeWzXCfaOGntYM1XGr
 B68OxgwG6v1s1icT6efiWqjVPIWf0X1Z7wbSSDSfnZ3EAwYClL/AVxjWkB/ZVPBo6XHJ
 nvbiQQnAxWcG+la3bpunUWeRz0ige29HQB1vSwwj/R594QSykovOOSNv8C6mfE091ReE ww== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6qkm9bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 15:14:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31FFEjve006569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 15:14:45 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 15 Feb 2023 07:14:39 -0800
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <quic_visr@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND v8 1/5] dt-bindings: clock: qcom,sc7280-lpasscc: Add qcom,adsp-pil-mode property
Date:   Wed, 15 Feb 2023 20:43:26 +0530
Message-ID: <20230215151330.539885-2-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215151330.539885-1-quic_mohs@quicinc.com>
References: <20230215151330.539885-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vOhKOKPnyaUMY3Qn5b4_cgn7_oEP9ip3
X-Proofpoint-ORIG-GUID: vOhKOKPnyaUMY3Qn5b4_cgn7_oEP9ip3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=21
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

