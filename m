Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B7E5E86CC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiIXAhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiIXAhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:37:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF75F3126;
        Fri, 23 Sep 2022 17:37:14 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NNNQWc009738;
        Sat, 24 Sep 2022 00:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=dTyaY1rjGMwDiJdQPQAA5lbzlz5wBfBZoikRMNyQRyc=;
 b=WmL9Tbp9zSppk5P0MyYmi3cQqeD25nxZ/eVL35hlUMwXG7LxFIxV71T6BtwGhMCTFFYZ
 VvUmGmHpqAdLouJTEIRwOeoA6KoS5V7WZqSmTnwFXBJ4g1+5LWverNI8gDlwMqCKhJnv
 ojPl0aQeLWuAekd365l2jqlfRNtZ8fIKkcXAWqs9uF8l6uqOPrJKjCdQhdNbHJSBDxmu
 uneXknNmEAkOdM9rP3jR0WvEKfWrUlwJwC8VR68VlA79z1raTC61DvXCYwSiCPH3W+E3
 2wDSIPhQAxH6yexjRAqs+grU767ua/ePXdQMHwgoIiLeiDOcvGoHor9BQ1zLUha4TJsh jQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3js67nketh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 00:37:04 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28O0b3Wp019484
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 00:37:03 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 23 Sep 2022 17:37:03 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH] bindings: Update maintainer's email address
Date:   Fri, 23 Sep 2022 17:36:57 -0700
Message-ID: <1663979817-1078-1-git-send-email-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Uwn_ozhGbLW6Xf7XKm32DFj30eO09btj
X-Proofpoint-GUID: Uwn_ozhGbLW6Xf7XKm32DFj30eO09btj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_10,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=598 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209240002
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Guru Das Srinagesh's email address.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
 Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
index 6a9c96f..480e4fb 100644
--- a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
+++ b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. PM8941 USB ID Extcon device
 
 maintainers:
-  - Guru Das Srinagesh <gurus@codeaurora.org>
+  - Guru Das Srinagesh <quic_gurus@quicinc.com>
 
 description: |
   Some Qualcomm PMICs have a "misc" module that can be used to detect when
diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index ec3138c..1f3ac59 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. PM8008 PMIC bindings
 
 maintainers:
-  - Guru Das Srinagesh <gurus@codeaurora.org>
+  - Guru Das Srinagesh <quic_gurus@quicinc.com>
 
 description: |
   Qualcomm Technologies, Inc. PM8008 is a dedicated camera PMIC that integrates
-- 
2.7.4

