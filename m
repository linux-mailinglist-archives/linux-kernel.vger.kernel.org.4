Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA0745EE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGCOoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGCOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:42:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D562010E7;
        Mon,  3 Jul 2023 07:42:42 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363B0j29023406;
        Mon, 3 Jul 2023 14:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=koSVaN/m8jagg/fvKUF5HD38Lnhn6VOiATRB1qRoOyM=;
 b=aBaF2pXiYBgRbymdjMiSzz6Xl/JloAfqPBsVKZwd90X/e8V70aJINx8DNMZYEGHtwbCb
 MkwD5MrQwGyWbbGipUDMAxqqHlL2a03+rBwXsllJeMYZp99ZYsaUtW86NEzk+f7uHVVH
 bKrHsExXqsIPPndNB6EhAeMlxGod/9hkhTZFshK+wvxcW/GZurzXXkPYfxX7vdR8Py0M
 cL/utW0mSuYVZ0kOsjYDHeZ3O9YXFZxZob+flbqJ92O2Ctl2P3QXqM63HEOwiYRPXw0y
 D0NdXHJfJEc2D0FZJe712raoGii4ezTZEaxHvF+P96oG+9B7ckLxGTSfi1OE98qlW7km lw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjb5dc9jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 14:42:32 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 363EgUl3031920;
        Mon, 3 Jul 2023 14:42:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7k8get-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 03 Jul 2023 14:42:30 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363EgRgP031491;
        Mon, 3 Jul 2023 14:42:29 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 363EgTaF031748;
        Mon, 03 Jul 2023 14:42:29 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id EFA455025; Mon,  3 Jul 2023 20:12:28 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 04/10] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba support
Date:   Mon,  3 Jul 2023 20:12:20 +0530
Message-Id: <1688395346-3126-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: em8H7dHa_ZULdPwjzN4anNYrswcmO22b
X-Proofpoint-GUID: em8H7dHa_ZULdPwjzN4anNYrswcmO22b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxlogscore=736 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030132
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the pm7550ba GPIO support to the Qualcomm PMIC GPIO
binding.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index eaadd5a..9470eb0 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -25,6 +25,7 @@ properties:
           - qcom,pm6150l-gpio
           - qcom,pm6350-gpio
           - qcom,pm7250b-gpio
+          - qcom,pm7550ba-gpio
           - qcom,pm7325-gpio
           - qcom,pm8005-gpio
           - qcom,pm8008-gpio
@@ -171,6 +172,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pm7550ba-gpio
               - qcom,pm8226-gpio
               - qcom,pm8350b-gpio
               - qcom,pm8550ve-gpio
@@ -411,6 +413,7 @@ $defs:
                  - gpio1-gpio9 for pm6350
                  - gpio1-gpio12 for pm7250b
                  - gpio1-gpio10 for pm7325
+                 - gpio1-gpio8 for pm7550ba
                  - gpio1-gpio4 for pm8005
                  - gpio1-gpio2 for pm8008
                  - gpio1-gpio6 for pm8018
-- 
2.7.4

