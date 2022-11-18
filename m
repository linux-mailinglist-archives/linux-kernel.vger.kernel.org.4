Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A8C62FCB9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbiKRS2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242569AbiKRS2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:28:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE2A13D2A;
        Fri, 18 Nov 2022 10:26:43 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIHvfnd001271;
        Fri, 18 Nov 2022 18:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=UD+7cI3pZ8QcJkzcFP1/ZWQenO7c1rV6FUoEYhEgNCA=;
 b=AP5S74Hn3HBZMsMsfhL/neu0CXjns/Fje2lEqYANpBnlgtwIR9Z82a0QA3gCJVXofKTu
 XMIXlIHx5wJ+QYMLFqplFsWPCfFI1QFacph+JOg+4fULIjQvdA5mgmkCm+UoZSZW9/kQ
 Koj/U2rgO17OzwC4eABo9rPDF53kN4+G3vpLQqxR07pzE5Wz1PS31yVDwsgr1Y5EcFUc
 VrscJEZgpqt+sKMZSnERBnyVI3ikEQsmZq7gvVJMlrPY+CbJGbP0mbvz2Bd2ODCDcLPq
 +cMFgiynH+074zI6QN6C4tjZHScuuQWp4wCs+YA0Y2TxZCvKqwvng+Z5SSYIDIXHSiPy Nw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kx0ndswxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 18:26:40 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AIIQd6i003465
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 18:26:39 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 18 Nov 2022 10:26:38 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
CC:     Melody Olvera <quic_molvera@quicinc.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatible
Date:   Fri, 18 Nov 2022 10:26:15 -0800
Message-ID: <20221118182614.11774-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MXDmP514rcbAa69UNW-579ZbvOnKqiyC
X-Proofpoint-ORIG-GUID: MXDmP514rcbAa69UNW-579ZbvOnKqiyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for scm driver for QDU1000 and QRU1000 platforms. These drivers
only require the compatible field, so update the bindings accordingly for
these platforms.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
This patch is separated out from [1] and includes
changes addressing comments from that patch set.

[1] https://lore.kernel.org/all/20221026190549.4005703-2-quic_molvera@quicinc.com/

 .../devicetree/bindings/firmware/qcom,scm.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 25688571ee7c..71012d43a32f 100644
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
@@ -82,6 +83,16 @@ properties:
     description: TCSR hardware block
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,scm-qdu1000
+    then:
+      properties:
+        clocks: false
+        clock-names: false
+
   - if:
       properties:
         compatible:

base-commit: 147307c69ba4441ee90c1f8ce8edf5df4ea60f67
-- 
2.38.1

