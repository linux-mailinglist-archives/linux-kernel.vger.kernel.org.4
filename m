Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367BA749DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGFNag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjGFNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:30:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ECF1BE3;
        Thu,  6 Jul 2023 06:30:26 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366DEGE9020728;
        Thu, 6 Jul 2023 13:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=izNliuJSoHnwU+fTrg3NMKW1PdN/2fio2g72kduAqss=;
 b=V3t+MX52WfIW/ys5l3SpePpkxRA8AZisHBb1CXSxb0IM8oIKvcA+JtEB2s8XWbGzjMyu
 +L52tL2/57CfaClKl9zvYmH2QuClqiMo1n3VgPiy9jmauIoLNN+/A+2ACuoPjcnv/gzX
 QkDcPOBF2PH9R9V6Km5XWjX2NOEWX/Q7K51pR8SR8Q2g8FeXsEmsMQKArtoBicycOMcz
 M15EFnlMuY1zuB4+mNFu0r0CLg/r4DDLbM85lEk8ghHO7fNRf4SGhA3zu/gB7/s0i2jf
 aD3GG5psy8ZTpo4f+1ANtwmsZqc2gg1sVhYY12XaRnK5s+ZWmhPT5zYkGIh51eoH8wxM Mg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn5ht384j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 13:30:21 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 366DUIfE011587;
        Thu, 6 Jul 2023 13:30:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7kkq3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 06 Jul 2023 13:30:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 366DUIFQ011569;
        Thu, 6 Jul 2023 13:30:18 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 366DUHMF011566;
        Thu, 06 Jul 2023 13:30:18 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 58F634EA1; Thu,  6 Jul 2023 19:00:17 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/4] dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx75 support
Date:   Thu,  6 Jul 2023 19:00:07 +0530
Message-Id: <1688650209-25119-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688650209-25119-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1688650209-25119-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ps6859XOUlLsP_u3GUF4jY9YS35ZcU_l
X-Proofpoint-GUID: ps6859XOUlLsP_u3GUF4jY9YS35ZcU_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=749 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060120
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the pmx75 GPIO support to the Qualcomm PMIC GPIO
binding.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 3585031..52b3d78 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -69,6 +69,7 @@ properties:
           - qcom,pms405-gpio
           - qcom,pmx55-gpio
           - qcom,pmx65-gpio
+          - qcom,pmx75-gpio
 
       - enum:
           - qcom,spmi-gpio
@@ -303,6 +304,7 @@ allOf:
           contains:
             enum:
               - qcom,pmx65-gpio
+              - qcom,pmx75-gpio
     then:
       properties:
         gpio-line-names:
@@ -459,6 +461,7 @@ $defs:
                  - gpio1-gpio11 for pmx55 (holes on gpio3, gpio7, gpio10
                                             and gpio11)
                  - gpio1-gpio16 for pmx65
+                 - gpio1-gpio16 for pmx75
 
         items:
           pattern: "^gpio([0-9]+)$"
-- 
2.7.4

