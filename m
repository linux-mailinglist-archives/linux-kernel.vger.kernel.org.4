Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279736108F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiJ1Dmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbiJ1DmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:42:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE9FD0CC0;
        Thu, 27 Oct 2022 20:42:15 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S2o1OV026286;
        Fri, 28 Oct 2022 03:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=im6yITI1531e3Mh3hR1LfHjB0NtsCe0RG1IWCtmk4iY=;
 b=iwTont8evdsUviVhgp9O75tYPdiyTpn1kZrOae1lXRD7WHicr4U+FYyd38mKB1STUpld
 8akzpRmedS5PIS4L+92RDmFWqFbEf0gDpx2Urt4mKKvdDe+rwbIv2kscH9vE3I4k+Yqq
 /CreEPPkf6n0WiDmezvpZjnS5VtpqnU9vGzf7ADETJlLYwJODA+AhN+pwNLxqxSM9i+G
 pzItdQ96hHPCLvw8zv4XZxcKKl8bNmn9ajQZ4Dq82et5gWoJEH062dlRl6I0GRWi4BD3
 TFJ0mTyy0jaGquq6AHLt7lvQHCqcjrRk3ketyxUMyrV3iQHE0OABNcXCAK9OsZZljipM 1g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahwbxt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 03:42:05 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29S3g41c001405
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 03:42:04 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 27 Oct 2022 20:42:03 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/10] dt-bindings: interconnect: Add sm8350, sc8280xp and generic OSM L3 compatibles
Date:   Thu, 27 Oct 2022 20:41:50 -0700
Message-ID: <20221028034155.5580-6-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028034155.5580-1-quic_bjorande@quicinc.com>
References: <20221028034155.5580-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SR_D6yQBde2Tvf8ljaRrri17d423xc6k
X-Proofpoint-ORIG-GUID: SR_D6yQBde2Tvf8ljaRrri17d423xc6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280022
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EPSS L3 compatibles for sm8350 and sc8280xp, but while at it also
introduce generic compatible for both qcom,osm-l3 and qcom,epss-l3.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 .../bindings/interconnect/qcom,osm-l3.yaml    | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index bf538c0c5a81..ae0995341a78 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -16,13 +16,21 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,sc7180-osm-l3
-      - qcom,sc7280-epss-l3
-      - qcom,sc8180x-osm-l3
-      - qcom,sdm845-osm-l3
-      - qcom,sm8150-osm-l3
-      - qcom,sm8250-epss-l3
+    oneOf:
+      items:
+        - enum:
+            - qcom,sc7180-osm-l3
+            - qcom,sc8180x-osm-l3
+            - qcom,sdm845-osm-l3
+            - qcom,sm8150-osm-l3
+        - const: qcom,osm-l3
+      items:
+        - enum:
+            - qcom,sc7280-epss-l3
+            - qcom,sc8280xp-epss-l3
+            - qcom,sm8250-epss-l3
+            - qcom,sm8350-epss-l3
+        - const: qcom,epss-l3
 
   reg:
     maxItems: 1
-- 
2.37.3

