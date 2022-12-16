Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C033B64F35D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 22:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLPVpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 16:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLPVp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:45:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F176DCF9;
        Fri, 16 Dec 2022 13:45:25 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGKPm88008712;
        Fri, 16 Dec 2022 21:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=osncqwfoq41zjswtO2a53FTJp9uuZL6Fjyb+UALqYEM=;
 b=mapX1tPOMX0EENa7yU12vPi/gTl4H6aCcTpYOTYLTiA9qGF5DEPQooEBCIUqSIMnkDXx
 pOo3ihPog77qEoSkJyGf8cq+idNNxWrEpK/VQyacPzVut6ptxmjnwxgeN5Z/uO5Ijpg1
 DqttO7CnHpVUaiCWSNQvqXRjo5vvihj3gkrF4HMflQbcRbjTrNkfdIogLiR92FcsMIS4
 qiPm1DqiaLPqNUV/N/BRpjxvR/TpUARuFeMQSZAEEe1HUhgWICmqzGKygWH/3X1WwVGz
 JSfVH3z3vVevFzmzJikkjztx2doVARMPEVTMZZo2odQZ15ct6xekziTDM0g2ukFJy0vk Jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mgufm10ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 21:45:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BGLjGbT009924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 21:45:16 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 13:45:15 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <airlied@gmail.com>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v15 2/5] dt-bindings: msm/dp: add data-lanes and link-frequencies property
Date:   Fri, 16 Dec 2022 13:44:59 -0800
Message-ID: <1671227102-21717-3-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671227102-21717-1-git-send-email-quic_khsieh@quicinc.com>
References: <1671227102-21717-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RZS8LEvUO3HR7EjTbZm10Y2I-qctHWxt
X-Proofpoint-GUID: RZS8LEvUO3HR7EjTbZm10Y2I-qctHWxt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To increase the flexibility of supporting different DP main link configuration
at different platform, add both data-lanes and link-frequencies property
into endpoint so that different platform can specify its own main link
combination of both data lanes and max supported link rate.

Changes in v7:
-- split yaml out of dtsi patch
-- link-frequencies from link rate to symbol rate
-- deprecation of old data-lanes property

Changes in v8:
-- correct Bjorn mail address to kernel.org

Changes in v10:
-- add menu item to data-lanes and link-frequecnis

Changes in v11:
-- add endpoint property at port@1

Changes in v12:
-- use enum for item at data-lanes and link-frequencies

Changes in v13:
-- revised changes at port@0
-- use correct ref schemas for both port@0 and port@1
-- mark both port@0 and port@1 are required
-- add line between data-lanes and link-frequencies properties

Changes in v14:
-- add "unevaluatedProperties: false: to endpoint at port@1
-- remove unnecessary quote to $ref
-- re store "$ref: /schemas/graph.yaml#/properties/port" to port@0

Changes in v15:
-- re store desciption of port@0

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 .../bindings/display/msm/dp-controller.yaml        | 25 +++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index f2515af..774ccb5 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -81,6 +81,7 @@ properties:
 
   data-lanes:
     $ref: /schemas/types.yaml#/definitions/uint32-array
+    deprecated: true
     minItems: 1
     maxItems: 4
     items:
@@ -102,8 +103,28 @@ properties:
         description: Input endpoint of the controller
 
       port@1:
-        $ref: /schemas/graph.yaml#/properties/port
+        $ref: /schemas/graph.yaml#/$defs/port-base
         description: Output endpoint of the controller
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+            properties:
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+                items:
+                  enum: [ 0, 1, 2, 3 ]
+
+              link-frequencies:
+                minItems: 1
+                maxItems: 4
+                items:
+                  enum: [ 1620000000, 2700000000, 5400000000, 8100000000 ]
+
+    required:
+      - port@0
+      - port@1
 
 required:
   - compatible
@@ -193,6 +214,8 @@ examples:
                 reg = <1>;
                 endpoint {
                     remote-endpoint = <&typec>;
+                    data-lanes = <0 1>;
+                    link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
                 };
             };
         };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

