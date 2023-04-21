Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108186EAE74
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjDUP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjDUP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:57:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DD813F8D;
        Fri, 21 Apr 2023 08:57:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LErO0e029437;
        Fri, 21 Apr 2023 15:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=z3tqPuoZ/RuFARsjGTf5SmGdbLXmh/h8cED9Fbel4Vg=;
 b=JZN2DdwLBsT3TMMcglRAl1pbszYjWYtNv1/uTIR0yf6DODJIdCjxnUBkZr0Jetbjt2/p
 0Mq1Og1flRfQqSzFsyUgnmGMLxGHypLQ0a0vZ3UHMcdBpnWEJ4lCB+nQvFnGavI/1TQn
 YUZ6cjYfbYCL27jbu/dU4YSeWotpeUhCfSpx8QGu/OgnIEGPYf5FzwBrcfmRIdAez8l5
 XOZStPHlwTfSaDLoU1KCvdeEp1kQBmgKDloNx8lMQRQ584s3+uQEWz59k6gBPvFqc3er
 57MfV2r8LgBnh6w5pqLpHdlBNTM7h95QPhahFgsa6hoH82wNqAG2+DNwuJ0OUHiovPJO bA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3tmqrffx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 15:57:12 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33LFvBx5002419
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 15:57:11 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 21 Apr 2023 08:57:06 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v9 3/8] dt-bindings: usb: dwc3: Add IPQ9574 compatible
Date:   Fri, 21 Apr 2023 21:24:45 +0530
Message-ID: <f9ba5b4f3dfd299ec7cefd038bc1d9ed5a817b8d.1682092324.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1682092324.git.quic_varada@quicinc.com>
References: <cover.1682092324.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fvzqznHvTqCFIeJBfjt_jhdiQX0PA-VI
X-Proofpoint-ORIG-GUID: fvzqznHvTqCFIeJBfjt_jhdiQX0PA-VI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=783 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210140
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Document the IPQ9574 dwc3 compatible.

* Make power-domains as optional since IPQ9574 doesn't have GDSCs

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

---
 Changes in v9:
	- Place ipq9574 alongwith similar SoCs instead of new entry
	- Make power-domains as optional since IPQ9574 doesn't have GDSCs
 Changes in v6:
	- Made power-domains as optional
	- Resolved all 'make dtbs_check' messages

 Changes in v5:
	- Restore removed constraints

 Changes in v4:
	- Update other relevant sections
	- Remove constraints not applicable to IPQ9574
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index d842819..5c13229 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -17,6 +17,7 @@ properties:
           - qcom,ipq6018-dwc3
           - qcom,ipq8064-dwc3
           - qcom,ipq8074-dwc3
+          - qcom,ipq9574-dwc3
           - qcom,msm8953-dwc3
           - qcom,msm8994-dwc3
           - qcom,msm8996-dwc3
@@ -133,7 +134,6 @@ required:
   - "#address-cells"
   - "#size-cells"
   - ranges
-  - power-domains
   - clocks
   - clock-names
   - interrupts
@@ -177,6 +177,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq9574-dwc3
               - qcom,msm8953-dwc3
               - qcom,msm8996-dwc3
               - qcom,msm8998-dwc3
-- 
2.7.4

