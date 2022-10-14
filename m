Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006825FF650
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJNWNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJNWMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:12:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472851C491C;
        Fri, 14 Oct 2022 15:12:19 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ELxdJR001482;
        Fri, 14 Oct 2022 22:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VALgQQSAgHcmYzUhCdu6q+oriLteK3QM6soQSovfbhA=;
 b=Tkxkql+rK0GOcHQOBbQloEzAzbE5gk2bB5NeEDNAoUDE+0y7MKALglvojnXRk2yldEvw
 sIXLa5ufWi2+9JOGo3lVMcWZBi8czKRFlGvEAipQ7TG5jRP0KWgvfWYxD6UcOMeM33Nh
 MoQD7v7d1l+5Q8tIhvh2ALKz8tAPae9yWF5M2FDIz2sE6WJJONJbuVIA8dtn9ZTCvVQx
 jXLF0PelV4AhMwlgEEywlI59t2r4pNdbAA0ZSxAAFw2x8B+pDVkcVzwO7k3tNmRhw6+r
 Y2hybVfu/YQMcHC18eZEj+6Lg6hgrN0JLSkleJ2mtHF6clOkWB+EPktLIXfobyQxEWG7 ew== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k7g14r203-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:12:15 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29EMCEDZ007461
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:12:14 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 14 Oct 2022 15:11:55 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs and boards
Date:   Fri, 14 Oct 2022 15:11:36 -0700
Message-ID: <20221014221138.7552-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014221138.7552-1-quic_molvera@quicinc.com>
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xYY-oZJfUWBmS33_iJ5WxvM3sFFjANX3
X-Proofpoint-GUID: xYY-oZJfUWBmS33_iJ5WxvM3sFFjANX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_11,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=788 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140122
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the QDU1000 and QRU1000 SoC bindings and the boards that use
them.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1b5ac6b02bc5..3370a50644a6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -40,6 +40,8 @@ description: |
         msm8996
         msm8998
         qcs404
+        qdu1000
+        qru1000
         sa8155p
         sa8540p
         sc7180
@@ -76,6 +78,7 @@ description: |
         mtp
         qrd
         sbc
+        x100
 
   The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
   where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
@@ -493,6 +496,19 @@ properties:
           - const: google,pompom-sku0
           - const: qcom,sc7180
 
+      - description: Qualcomm Technologies, Inc. Distributed Unit 1000 platform
+          - items:
+              - enum:
+                  - qcom,qdu1000-idp
+                  - qcom,qdu1000-x100
+              - const: qcom,qdu1000
+
+      - description: Qualcomm Technologies, Inc. Radio Unit 1000 platform
+          - items:
+              - enum:
+                  -qcom,qru1000-idp
+              - const: qcom,qru1000
+
       - description: Google Quackingstick (newest rev)
         items:
           - const: google,quackingstick-sku1537
-- 
2.38.0

