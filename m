Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE515B6288
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiILVHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiILVHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:07:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151AF4AD54;
        Mon, 12 Sep 2022 14:07:44 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CK7vG8016341;
        Mon, 12 Sep 2022 21:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=YZ9IBDpQS6c2IbLsN9TmXfVmaXQewY8d5xC0STEnOiA=;
 b=AYVR5afyAbkyROdu/kbCT1OwG3jfsFFKbhzBTDd0f4M3Y3H5+yxpFUEjsVdMVmdJllQm
 PsqAEUlsN9NmwYjGOm/SyosYtHhs0f+rWVBNEfaP9Sf7lHPtS3N6hgI3SbZDU0n7DR00
 LL+bnEtBECs/12qwUkukPczsDe314AVuSJVT1TK3VPthq8XTpiuJ4LcjZnx2/wYkVxky
 zX7TpfVaqkuO6Vi1e7+nK8hmE5TA8OmxHUwUvjEnWcpHtFEhCTzZxLf1aRS3CJGkkJri
 G344Mk47sJAyv5qBi4eS3b2GPSghzp1U03WaGpHAn6Z1+ERdaAixKk43tbL1EAv4tzB1 +Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk635b46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 21:07:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CL7b7I012314
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 21:07:37 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 14:07:37 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <konrad.dybcio@somainline.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 4/4] dt-bindings: qcom-pmic-gpio: Add PM7250B and PM8450 bindings
Date:   Mon, 12 Sep 2022 14:06:29 -0700
Message-ID: <20220912210624.4527-5-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220912210624.4527-1-quic_amelende@quicinc.com>
References: <20220912210624.4527-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X2D4hyQTpOfziAdFhrtolXC0lFd-50gR
X-Proofpoint-ORIG-GUID: X2D4hyQTpOfziAdFhrtolXC0lFd-50gR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_14,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=815 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209120072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
to include compatible strings for PM7250B and PM8450 PMICs.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 694898f382be..29dd503f9522 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,pm6150-gpio
           - qcom,pm6150l-gpio
           - qcom,pm6350-gpio
+          - qcom,pm7250b-gpio
           - qcom,pm7325-gpio
           - qcom,pm8005-gpio
           - qcom,pm8008-gpio
@@ -231,6 +232,7 @@ allOf:
             enum:
               - qcom,pm660l-gpio
               - qcom,pm6150l-gpio
+              - qcom,pm7250b-gpio
               - qcom,pm8038-gpio
               - qcom,pm8150b-gpio
               - qcom,pm8150l-gpio
@@ -392,6 +394,7 @@ $defs:
                  - gpio1-gpio10 for pm6150
                  - gpio1-gpio12 for pm6150l
                  - gpio1-gpio9 for pm6350
+                 - gpio1-gpio12 for pm7250b
                  - gpio1-gpio10 for pm7325
                  - gpio1-gpio4 for pm8005
                  - gpio1-gpio2 for pm8008
@@ -407,6 +410,7 @@ $defs:
                  - gpio1-gpio10 for pm8350
                  - gpio1-gpio8 for pm8350b
                  - gpio1-gpio9 for pm8350c
+                 - gpio1-gpio4 for pm8450
                  - gpio1-gpio38 for pm8917
                  - gpio1-gpio44 for pm8921
                  - gpio1-gpio36 for pm8941
-- 
2.35.1

