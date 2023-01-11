Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C22665AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbjAKLqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbjAKLpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:45:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89203D2FA;
        Wed, 11 Jan 2023 03:44:29 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B90Tsn025992;
        Wed, 11 Jan 2023 11:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=LK51BeKDmJ1w0wa5xttBxkdXdUKlvG/KRCLgmWha3WU=;
 b=aH2QVPOy4Vk5lfu1LCDrq5De9QPdiHeunT5Ky/W/DThDOVv0VOJykukv1izJs4aDnDbD
 gTqDhJUlCLR33xCEelIQAgJrPteSapDQ0x4pUlp+pZ/lHooM2yjBbpJE9q/tSlI1A9Hi
 t6KgPraTi9ZxmrFMCYO+8xRbfcfuqeeEVbqI7ihJwqbi3eUEIFbqxbar/EcUuWkWAueh
 j0ew27ENpMv8aKRoZ5Tor4XUDopVQGCIFZnWhvw8l+WSUj9X4ura7U/6rgbzJxkI6KYH
 wjOW/fVT2/rN033fDK8Q9x6A+fwoljZOAPZVlPFYvOVaMm/Tn8axb/4SzXS1Qr4oC0rR aA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1k7qs4kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 11:44:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30BBiGq8024813
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 11:44:16 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 03:44:11 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <konrad.dybcio@somainline.org>,
        <amit.pundir@linaro.org>, <regressions@leemhuis.info>,
        <sumit.semwal@linaro.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <robin.murphy@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V3 04/10] dt-bindings: remoteproc: qcom,sc7280-mss-pil: Update memory-region
Date:   Wed, 11 Jan 2023 17:13:31 +0530
Message-ID: <20230111114337.24782-5-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230111114337.24782-1-quic_sibis@quicinc.com>
References: <20230111114337.24782-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n1ZAwo8YDElHWfyEQtDVnNSh1PMydGC4
X-Proofpoint-ORIG-GUID: n1ZAwo8YDElHWfyEQtDVnNSh1PMydGC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_05,2023-01-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=984 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dynamic memory region used for metadata authentication would still
be a part of the kernel mapping and any access to this region by the
application processor after assigning it to the remote Q6 will result
in a XPU violation. This is fixed by using a no-map carveout instead.
Update the bindings to reflect the addition of the new modem metadata
carveout on SC7280 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v3:
 * remove double space [Krzysztof]
 * Pickup R-b

v2:
 * Pad commit message to explain bindings break [Krzysztof]
 * Split dt/bindings per SoC  [Krzysztof] 

 .../devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
index b4de0521a89d..005cb21732af 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
@@ -95,6 +95,7 @@ properties:
     items:
       - description: MBA reserved region
       - description: modem reserved region
+      - description: metadata reserved region
 
   firmware-name:
     $ref: /schemas/types.yaml#/definitions/string-array
@@ -240,7 +241,7 @@ examples:
                         <&rpmhpd SC7280_MSS>;
         power-domain-names = "cx", "mss";
 
-        memory-region = <&mba_mem>, <&mpss_mem>;
+        memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
 
         qcom,qmp = <&aoss_qmp>;
 
-- 
2.17.1

