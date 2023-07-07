Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4925074AB69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGGGxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGGxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:53:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F43B130;
        Thu,  6 Jul 2023 23:53:32 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3676lEWK017832;
        Fri, 7 Jul 2023 06:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=jSeIcUTc4fFDi+649dihFqOXbWSmjqqdFLpRKOEH0GY=;
 b=bV+SS682GeSkxQOMs6r25u1sLNTEoLbHQ99Pxe4YlKtOmCCxT++3l3MN20MZIrQGOjMx
 HqQbDFenx3L9p4eS9i6uu/o+bnZYuxP5ZRKlQPFRgvVOsELNqFas44nQG/R8c1pdiz6v
 b1zH3rLpAKtxPsOR7M7qoFBDEa0P/zpVtREnPRV1Mn4z/qR2EmU3lj3ct9Rs/Vk/mtp1
 nMXuNVK/qwbWPB4PinH8SLEZwJjGIEF3UbnLjl/SVK3BuqN2psCXrsaP2ncI5+hZEtQ7
 vYBJRo8jZtEUVRPNiUCa86KekVt4n2lo8cxdEUcKMRDzJ2SlnTWfzK3lLLbTDf3fsJHT ZQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rp8a60jd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 06:53:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3676rL8V010661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 06:53:21 GMT
Received: from rohkumar-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 23:53:16 -0700
From:   Rohit kumar <quic_rohkumar@quicinc.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <quic_rohkumar@quicinc.com>,
        <cychiang@chromium.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH] dt-bindings: sound: Update maintainer email id
Date:   Fri, 7 Jul 2023 12:22:59 +0530
Message-ID: <20230707065259.3099569-1-quic_rohkumar@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e5bfGYX6PDiD6qAYIu_3lmEA-inm5sHE
X-Proofpoint-GUID: e5bfGYX6PDiD6qAYIu_3lmEA-inm5sHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1011 phishscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated my mail id to latest quicinc id.

Signed-off-by: Rohit kumar <quic_rohkumar@quicinc.com>
---
 .../devicetree/bindings/sound/google,sc7180-trogdor.yaml        | 2 +-
 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
index 666a95ac22c8..ba5b7728cf33 100644
--- a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
+++ b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Google SC7180-Trogdor ASoC sound card driver
 
 maintainers:
-  - Rohit kumar <rohitkr@codeaurora.org>
+  - Rohit kumar <quic_rohkumar@quicinc.com>
   - Cheng-Yi Chiang <cychiang@chromium.org>
 
 description:
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
index 6cc8f86c7531..3a559bd07a79 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Technologies Inc. LPASS CPU dai driver
 
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
-  - Rohit kumar <rohitkr@codeaurora.org>
+  - Rohit kumar <quic_rohkumar@quicinc.com>
 
 description: |
   Qualcomm Technologies Inc. SOC Low-Power Audio SubSystem (LPASS) that consist
-- 
2.25.1

