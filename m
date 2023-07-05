Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFF2747C78
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjGEFd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGEFdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:33:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10361E3;
        Tue,  4 Jul 2023 22:33:21 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3655AJrW022700;
        Wed, 5 Jul 2023 05:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=pylOfRWfH248mlqc1U0JPUDCsmfMI/NoUbc91IZ6M8Y=;
 b=dfPagyoKkQVdsIGmniW/sTWEaSQB8WVp+R8oqpFcH7EuGjgR8aryqEwJTdlI4bPMhhPL
 hefkbLDkzj1aC0rdnMCkHTkvBrxB0i4KXrzlKaULNbDBekOvmvZZQ+mzJXvYMhTvk+8h
 FHPwz6MTvXwiAKgkwszfnFTx90/TNWU8dj+Nqf6TB369zlA+QCYM2CFsGOiJVARcf7JG
 Z8zMch47j/KHUrlsEkIRp2IiICajNfp98OhvgodrRepo8bGtu2BKXbBszW345vcBBxCv
 m5Q948zy9/a3zy35YrwccsFbzWQ/nObfyRh6awiqOTosOx2JqJgeG5snkgWWaPd5q1mv QQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rm8v9jxrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 05:33:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3655X52h013701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 05:33:05 GMT
Received: from hu-schowdhu-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Tue, 4 Jul 2023 22:33:01 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V7 1/2] dt-bindings: firmware: bootstats: Add the dtschema
Date:   Wed, 5 Jul 2023 11:02:31 +0530
Message-ID: <b3105990e021a71039f621e6c4e70ab05fb348fa.1688533340.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1688533340.git.quic_schowdhu@quicinc.com>
References: <cover.1688533340.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: md7FFK7CBCdVAN8pRFrjBIamFuZUnvbN
X-Proofpoint-GUID: md7FFK7CBCdVAN8pRFrjBIamFuZUnvbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=794 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree bindings for boot stats. This has 2 properties
pre-abl-time and abl-time which records the timestamps for boot
stats.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Link: https://lore.kernel.org/linux-arm-kernel/7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com/
---
 .../bindings/firmware/qcom,bootstats.yaml     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml

diff --git a/Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml b/Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml
new file mode 100644
index 000000000000..22e697524058
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/qcom,bootstats.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Boot Stats
+
+maintainers:
+  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+
+description: |
+    Qualcomm's proprietary Android boot-loaders capture boot time
+    stats, like the time when the bootloader started execution and
+    at what point the bootloader handed over control to the kernel.
+    This is captured in the unit of ms in devicetree property.
+
+properties:
+  pre-abl-time:
+    description: The property to store the starting point of abl in ms.
+    $ref: /schemas/types.yaml#/definitions/string-array
+
+  abl-time:
+    description: The property to store the duration of abl in ms.
+    $ref: /schemas/types.yaml#/definitions/string-array
+
+required:
+  - pre-abl-time
+  - abl-time
+
+additionalProperties: false
+
+examples:
+  - |
+    bootstats {
+        pre-abl-time="17627";
+        abl-time="26748";
+    };
-- 
2.17.1

