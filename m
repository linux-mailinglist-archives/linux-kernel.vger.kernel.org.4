Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D2665EC9E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjAENOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjAENOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:14:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2195D11C;
        Thu,  5 Jan 2023 05:14:00 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305D1hXl018927;
        Thu, 5 Jan 2023 13:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=vjNXt612J0wjxSScDAWcbAirmr6yc+Fg0zIzMh3vWes=;
 b=VN63+5QeLYUcQEVEcQduORyJVSgelIWsrnOST4Mh4jyIz+DecD/ia6clMs9emPjgBmVc
 Tu5Rd947gDkDSQ83zmSb4c0b4znhxGucPMMV9jbn3pbFzBtTqWfVASe4VdBmIDQZ6byj
 7X18mK/Cfd4Yl0RUw1jqrW2EclklN2EB7eXF9T1cXG9ywiCmnlKmMTaS1X9vSvA7dpWa
 gTE/no9kXq8lvLlA6r+Dh02R14W98X3LAegK45NpFCM062Si3EzUt8ywjHkJjYq17yp0
 t0Tvs2kLFPtLpwXd8gHyP2MNMDPiXtmAyqCQWmGYe61ZLi1JsbqQkt0Znu4Q8J+1ZFLf Ag== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mwu4vrehe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 13:13:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 305DDCSD002403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Jan 2023 13:13:12 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 5 Jan 2023 05:13:05 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <mathieu.poirier@linaro.org>,
        <corbet@lwn.net>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH] dt-bindings: remoteproc: qcom: Add reg-names and power-domain-names
Date:   Thu, 5 Jan 2023 18:42:43 +0530
Message-ID: <1672924363-22938-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eCrg1MeUS0K4j-1wRT4HGlgxtnJnq4iL
X-Proofpoint-ORIG-GUID: eCrg1MeUS0K4j-1wRT4HGlgxtnJnq4iL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reg-names and power-domain-names for remoteproc ADSP pheripheral
loader. This is to make compatible with remoteproc ADSP PIL driver.
Also change power domain from LCX to CX.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 .../devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
index 94ca7a0..b5bee2c 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
@@ -23,6 +23,11 @@ properties:
       - description: qdsp6ss register
       - description: efuse q6ss register
 
+  reg-names:
+    items:
+      - const: qdsp6ss_base
+      - const: lpass_efuse
+
   iommus:
     items:
       - description: Phandle to apps_smmu node with sid mask
@@ -57,7 +62,11 @@ properties:
 
   power-domains:
     items:
-      - description: LCX power domain
+      - description: CX power domain
+
+  power-domain-names:
+    items:
+      - const: cx
 
   resets:
     items:
-- 
2.7.4

