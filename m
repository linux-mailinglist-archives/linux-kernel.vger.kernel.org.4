Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272AA64EA70
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiLPLaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiLPLaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:30:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DBB5D69F;
        Fri, 16 Dec 2022 03:30:09 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGAtFNG020170;
        Fri, 16 Dec 2022 11:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=IeZBshSzVfItkaX1QVPlQaUl2UHfGaDmAJb4HsMLpG0=;
 b=RlqNg3fSRHVsNYO8+pE9xF+kdlw4BOQJBGsjjmV5Qxro598w/bk2DGdZL79rycglpBK8
 w4e6CmXHJWWDFlYz2VCUEkpIa7PGompWOwmClP6G2No8g++gnfnnDUc15eFIY003k7JQ
 KvvoV3ZAypAeWnopPmoivQ1ktwXGMW0nesEnPMAXbKqOErc7scuhlEwCs0T8Z0GaB3pq
 wG6XPj3MESsn/eGzW2qXdqjMnszkPK0/QtVxgsVkVzL+DlHiFE/24ltUJYYmD1XpAoMj
 jRDLxivQD9wZ1kKM+jaWDE3ccnsISXDr0J6DaVf5qCTdnIwjlfQANJNZH2+GI0y8j3eg 1Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg8e6a7y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 11:30:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BGBU5Qq011384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 11:30:05 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 03:30:01 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD Pro boards
Date:   Fri, 16 Dec 2022 16:59:17 +0530
Message-ID: <20221216112918.1243-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cJ-YQAoSNpKN-JYlbP2fCnHae4-FdWFo
X-Proofpoint-ORIG-GUID: cJ-YQAoSNpKN-JYlbP2fCnHae4-FdWFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_07,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=792 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1011 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212160101
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for the Pro SKU of the sc7280 CRD boards
which come with a Pro variant of the qcard.
The Pro qcard variant has smps9 from pm8350c ganged up with
smps7 and smps8.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
v4 changes:
Added the zoglin-sku1536 compatible along with hoglin-sku1536.
Zoglin is same as the Hoglin variant, with the SPI Flash reduced
from 64MB to 8MB

 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1b5ac6b02bc5..07771d4c91bd 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -558,6 +558,12 @@ properties:
           - const: google,hoglin
           - const: qcom,sc7280
 
+      - description: Qualcomm Technologies, Inc. sc7280 CRD Pro platform (newest rev)
+        items:
+          - const: google,zoglin-sku1536
+          - const: google,hoglin-sku1536
+          - const: qcom,sc7280
+
       - description: Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform
         items:
           - const: qcom,sc7280-idp
-- 
2.17.1

