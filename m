Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A812D6941BF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjBMJqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjBMJq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:46:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E3DC6;
        Mon, 13 Feb 2023 01:46:28 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8t33X017323;
        Mon, 13 Feb 2023 09:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=kzHLkNo46yxJmOPRtge2M+vbiZ6vPHni8mhT7QRhkg8=;
 b=MGQcKEMDyVyOkUomck/jMjHACVUrX+3lB7ZH0YxeL+Dz3/ofvWD/iRchpRjdZNVlhOce
 x2ZcCC4YtOOtf2Piz2yBCZsYy93zuWmxjAzWMDy+r6ol1LtmYyz454nBRFS8Se+CSWKM
 S/c5spYmopzjRh/Od+RLLZRdaZOW476zOOtl9GK5YR1YrWGInHhE88C13Q3PNjE+Mdnz
 Wh6qveIWqBw2gWJhuC4zhj2BJBc1MIIP/nM2aL5bVrjSwHOoDsux17mr49nfiekPeRjf
 zhq/qXNbP3eSo8UEod4xS3E8sRJNra1lrL3Tfbt0zPXBT+3EoucWBX2iSqffUe9uNHhR TQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np4agbhs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 09:46:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31D9kL2a029999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 09:46:21 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 01:46:15 -0800
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
Subject: [PATCH v8 1/5] dt-bindings: clock: qcom,sc7280-lpasscc: Add qcom,adsp-pil-mode property
Date:   Mon, 13 Feb 2023 15:15:24 +0530
Message-ID: <20230213094528.3733509-2-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213094528.3733509-1-quic_mohs@quicinc.com>
References: <20230213094528.3733509-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tTY6F2-LFFXoYeYxf1G1SP86QA8Wf2WS
X-Proofpoint-GUID: tTY6F2-LFFXoYeYxf1G1SP86QA8Wf2WS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_04,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 clxscore=1011 adultscore=8 bulkscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
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

