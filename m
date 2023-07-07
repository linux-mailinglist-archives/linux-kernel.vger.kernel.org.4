Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C09774AC1F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGGHok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjGGHoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:44:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D30D1FCE;
        Fri,  7 Jul 2023 00:44:33 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3676sTCa024231;
        Fri, 7 Jul 2023 07:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=UIGR9bgCyltN2SO4cBQB/3NUEVmyGhECK43ChRaoVuA=;
 b=NSFE1nY5Pq1g91WYwh5W8eoKYlQvMotZS8e0gK3iD+0ZZjVr5WCrETx59zBR0NNBLJCI
 /DnU1a8Q+p+0BieglkOrVSDjCCnVqAdaefTkoEl7bPqTplWjTZPhmrCIRV4pNO5ZxiZH
 SsUqGaVsm9WMh9Hq6RaFE+kCWcBerm/l6xQjQKAzzafH04usT51UNHjOtt9JcJ7y8kEc
 OmCr9Fov/pnqMtWelMou2G4D7/QQx7HPXovpdzO+vIfoSViGgUkaurAfD1y8CJcntFPc
 rykQlRcCinPQ7u5qAo4PzfynW464m38D6BLx58hsWatcMgYpg+4m42R0Fjt5MDOZu2ww Tw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnvyvj4x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 07:44:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3677iFY2009193
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 07:44:15 GMT
Received: from rohkumar-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 7 Jul 2023 00:44:10 -0700
From:   Rohit kumar <quic_rohkumar@quicinc.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <quic_rohkumar@quicinc.com>,
        <cychiang@chromium.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] ASoC: dt-bindings: Update maintainer email id
Date:   Fri, 7 Jul 2023 13:13:36 +0530
Message-ID: <20230707074337.3120530-1-quic_rohkumar@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q9GijHBQwLKbeBQ9DnMc9Ymoms53_ekI
X-Proofpoint-ORIG-GUID: q9GijHBQwLKbeBQ9DnMc9Ymoms53_ekI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070070
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated my mail id to latest quicinc id.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Rohit kumar <quic_rohkumar@quicinc.com>
---
v2: Updated commit header

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

