Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F9274AA59
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjGGFUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGGFUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:20:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0541FC6;
        Thu,  6 Jul 2023 22:20:24 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3674kCxK026768;
        Fri, 7 Jul 2023 05:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=gF32D2Z4XXDIlXgumOhKygoCgJP9fG53ARzmfoIcboU=;
 b=jAO6kSuK0MlhE6xxKF3LMsCDzpScQ0JbMRgmWOk+1I6pPMHpKoB3uJ7Mn2gTBf2iNv78
 fI4nted7hY88IhGTY5eTbu6HJdEhmLXjIlmY6GB1+GvTffjNpQvbiB5wskN4ks1xgioU
 h9Goce0jek9vMTfr0MstWndpGg0BeHBwsdYBxTeDNGNPAWTleLqMzJD4IJ3GiVFQhYS6
 a/sKt3nToIOd/quGl0MdOR/eJ0VcaJUlZciD9JkP2iPI2bCvh0xzJBQITt9vDTbXm5wd
 LqSVoVWkDzA0qu2dEjsoA9w+9j9MlQziJVhoniuc3jpGFpyxCeN0J3bcMIqi10gnkS3m Ew== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnsu72753-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 05:20:19 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3675KGmj029566;
        Fri, 7 Jul 2023 05:20:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7kp6yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 07 Jul 2023 05:20:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3675KG6P029556;
        Fri, 7 Jul 2023 05:20:16 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3675KGvS029552;
        Fri, 07 Jul 2023 05:20:16 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id AE31A4F8A; Fri,  7 Jul 2023 10:50:15 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 1/4] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba support
Date:   Fri,  7 Jul 2023 10:50:06 +0530
Message-Id: <1688707209-30151-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688707209-30151-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1688707209-30151-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -Oa4DKCTmU4KO-T_9ChjBABU74RoA2W8
X-Proofpoint-ORIG-GUID: -Oa4DKCTmU4KO-T_9ChjBABU74RoA2W8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_01,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=730
 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070048
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
index 8aaf501..3585031 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,pm6350-gpio
           - qcom,pm7250b-gpio
           - qcom,pm7325-gpio
+          - qcom,pm7550ba-gpio
           - qcom,pm8005-gpio
           - qcom,pm8008-gpio
           - qcom,pm8018-gpio
@@ -172,6 +173,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pm7550ba-gpio
               - qcom,pm8226-gpio
               - qcom,pm8350b-gpio
               - qcom,pm8550ve-gpio
@@ -413,6 +415,7 @@ $defs:
                  - gpio1-gpio9 for pm6350
                  - gpio1-gpio12 for pm7250b
                  - gpio1-gpio10 for pm7325
+                 - gpio1-gpio8 for pm7550ba
                  - gpio1-gpio4 for pm8005
                  - gpio1-gpio2 for pm8008
                  - gpio1-gpio6 for pm8018
-- 
2.7.4

