Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6C97258E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbjFGI4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239748AbjFGIzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:55:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51B82683;
        Wed,  7 Jun 2023 01:54:24 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3578DNfK003482;
        Wed, 7 Jun 2023 08:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7I+g7B6vUIJD4Hd3WKHswnYLVY+aNyUAkSlEYThXeqc=;
 b=MTAUw17puN4hUaPLxkRaA9W6xqytNQDhxFf+BsyY5xtlo5XblFxYNj5RMdjhDN+KmEGb
 xRleuw05twWoo43gYx35XPbuXclSzZVHsXvFu9QBgykmLGywrUn1i1Kf0/zw5wqdUQZ3
 XYH8ADzHu47pteijloBZ8vlSNdSw5HFNLgZgG8kaJ8+ZHvdXU+r8r+88skUzh4zWgSFu
 0DEWg/xUVdSVo3mhcX1GoyChHtUTqYlL3VJnqNDc6EwQPkdb3Eklfw2NxU2f+Ih/Kikv
 8lZ1YIqdxoKV5kY2PcKuWhz6cjTVWCSjUTZeS+AOdo1C4J5MDBL761yyTAktIdTLEcsP Sg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a9t9ck8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 08:53:31 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3578rUj7019686
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 08:53:30 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 01:53:24 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Praveenkumar I <quic_ipkumar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v6 1/3] dt-bindings: thermal: tsens: Add ipq9574 compatible
Date:   Wed, 7 Jun 2023 14:23:08 +0530
Message-ID: <ec9799504fe5a141e107bb78955d8d427f00553f.1686125196.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1686125196.git.quic_varada@quicinc.com>
References: <cover.1686125196.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1D5KmzxDvQuA7KdHYMImQaSZptZnXakb
X-Proofpoint-GUID: 1D5KmzxDvQuA7KdHYMImQaSZptZnXakb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Praveenkumar I <quic_ipkumar@quicinc.com>

Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
[v5]:
        Fix dt_binding_check & dtbs_check errors without removing existing entries
[v4]:
        Add description about IPQ9574 and remove unnecessary
        additions to the file
[v3]:
        Fix dt_binding_check & dtbs_check errors (Used
        Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
        as reference/example)

        Drop 'Acked-by: Rob Herring' as suggested in review

[v2]:
        Thanks to Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
        for the tip to make qcom,ipq8074-tsens as fallback.
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d1ec963..e7d0341 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -67,6 +67,12 @@ properties:
         enum:
           - qcom,ipq8074-tsens
 
+      - description: v2 of TSENS with combined interrupt
+        items:
+          - enum:
+              - qcom,ipq9574-tsens
+          - const: qcom,ipq8074-tsens
+
   reg:
     items:
       - description: TM registers
-- 
2.7.4

