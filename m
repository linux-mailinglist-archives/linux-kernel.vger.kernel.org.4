Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEFF62EE5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiKRHbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiKRHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:31:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0E47DEDD;
        Thu, 17 Nov 2022 23:30:59 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AI518Fq005840;
        Fri, 18 Nov 2022 07:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=gIEiAoJnJJ5/CD0VmgJ7IgvkM9i2vgDSBiJqLRJPJ3U=;
 b=Ah9Fesh1xMNPX25YZM2SBeNoj0vLxGdqtZjIOmv21wP9qqFSmpc331lemIgcfFFvmBFK
 c6bOQsuiLEvBRuN8chzpZEuogjbOaexrPesh0++wBIjSxtGRpenwwVB+WdjD+IlqC13X
 7kTOmPFF65CxA0C7+yBdP2jVMQU2CjYCv11gZiFad/3Q1pFS00ToRtsjIMfM/NOAIMpy
 pCxROl0IneSVsUJM/yywPHQzuxTYF5yCtgAzrqmArvBjhYffX+yE2b5TkTfuC3eNZeBk
 Jk02wDIi08YViZoCsFsbg8gyl/vewcB9v5jbP579VQzfx/G3JmvineyRNgZXV3YoIBJB fQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kx0n1gvfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 07:30:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AI7Us9f007732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 07:30:54 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 17 Nov 2022 23:30:51 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD Pro boards
Date:   Fri, 18 Nov 2022 13:00:16 +0530
Message-ID: <20221118073017.26128-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Op-0G51ikNSStZiOC__4CUTP1rATj42l
X-Proofpoint-GUID: Op-0G51ikNSStZiOC__4CUTP1rATj42l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=738 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for the Pro SKU of the sc7280 CRD boards

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..2550ab251f7b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -613,6 +613,11 @@ properties:
           - const: google,hoglin
           - const: qcom,sc7280
 
+      - description: Qualcomm Technologies, Inc. sc7280 CRD Pro platform (newest rev)
+        items:
+          - const: google,hoglin-sku1536
+          - const: qcom,sc7280
+
       - description: Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform
         items:
           - const: qcom,sc7280-idp
-- 
2.17.1

