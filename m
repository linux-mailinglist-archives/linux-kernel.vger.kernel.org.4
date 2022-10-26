Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E467960E8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiJZTKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiJZTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:08:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E140E0DB;
        Wed, 26 Oct 2022 12:06:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIoxr7021002;
        Wed, 26 Oct 2022 19:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=yvBLHefS2umnQUfDyzABpZHu2ghyKss90AgaZIhXL4o=;
 b=jMwlpZW//hIilnbFcvoNqjoEdhAKqFY83V52i5Qx5E6b6IyMU6Sgv6X9dF2DqWW3l+VZ
 oEdVr7qKaBsn8zwDJzkiStzM+1gT/9Z5IiRNr+Wsz4z0WaBPxajdUcPqUcByJrKzlYAB
 nyz+0PY8cdvSazkK81JdS8l0Pao37Fc4ITDZLVd5PDI74cBKAWh0hFCGQjSPYB51SjkO
 iSpAQKcfQ6e2CJDFDSRtp06zShAf0SgdxIfff6S0mFHP4uWVpQDB+igklJxmisdwy0hh
 xz71YjxrWBnCxD1s4dhT7833s6UexxbIXB7neIE5l8TT4O774sD7qxfiP+GtjGIJodEa yA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfah501yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:06:02 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QJ62ZM015176
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:06:02 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 12:06:01 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v3 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatibles
Date:   Wed, 26 Oct 2022 12:05:45 -0700
Message-ID: <20221026190549.4005703-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026190549.4005703-1-quic_molvera@quicinc.com>
References: <20221026190549.4005703-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fwNUYKh9luje36_ek2eHC_HYkK6VS0Sx
X-Proofpoint-ORIG-GUID: fwNUYKh9luje36_ek2eHC_HYkK6VS0Sx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210260107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for scm driver for QDU1000 and QRU1000 platforms.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 .../devicetree/bindings/firmware/qcom,scm.yaml    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index be1b5746eddb..5352181aa393 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -38,6 +38,7 @@ properties:
           - qcom,scm-msm8994
           - qcom,scm-msm8996
           - qcom,scm-msm8998
+          - qcom,scm-qdu1000
           - qcom,scm-sc7180
           - qcom,scm-sc7280
           - qcom,scm-sc8280xp
@@ -81,6 +82,20 @@ properties:
     description: TCSR hardware block
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,scm-qdu1000
+    then:
+      properties:
+        '#reset-cells':
+          maxItems: 1
+        clocks: false
+        clock-names: false
+
+      required:
+        - '#reset-cells'
   - if:
       properties:
         compatible:
-- 
2.25.1

