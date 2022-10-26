Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8060E8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiJZTKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbiJZTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:08:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A0C101DE;
        Wed, 26 Oct 2022 12:06:06 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIos1W009040;
        Wed, 26 Oct 2022 19:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=WAXvIeEPPK+EV9+RY5EJVRXRb9MXIhAu1ZL6YuMk44I=;
 b=NHVxL1wRcFd6wxl0kVa+Ra3169OLU3DDoqhCm2bc4rWvF7B5xkahqwlIHbHXFR8PZtHC
 lGaCvE1FasJ84oAaCFHrqrRpW4oy7mChRCry3MpZ3hTE3mmUv1QGs9oahxvNHkeNkTTM
 q90ub7ONC+QcxcXDdp/0FSjPEcdC4OQNm5S6aFhnOQSY0iDQsm8MK7Id1kcJcN0YSCUd
 fOX3l0ZqMPNmlOiGs8btEyBoABbB3LvrQ3+SYemIEITfp4ZZS7dTzif+umq+bie0UQBK
 aSdAtojRjrZA5ClYMwDEyZnCPXrh1k8AUZs4oHdhreFoFue32DdVF+m0ux4mtTs0+4Bq Jw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfaheg1sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:06:03 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QJ62RD003991
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 19:06:02 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 12:06:02 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v3 2/5] dt-bindings: power: rpmpd: Add QDU1000/QRU1000 to rpmpd binding
Date:   Wed, 26 Oct 2022 12:05:46 -0700
Message-ID: <20221026190549.4005703-3-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026190549.4005703-1-quic_molvera@quicinc.com>
References: <20221026190549.4005703-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NjbW8PI5z1-C3Qopx20Gw4oV95ZeuC4Z
X-Proofpoint-ORIG-GUID: NjbW8PI5z1-C3Qopx20Gw4oV95ZeuC4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=619 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210260107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible and constants for the power domains exposed by the RPMH
in the Qualcomm QDU1000 and QRU1000 platforms.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 include/dt-bindings/power/qcom-rpmpd.h                  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 2ca98bad2d35..c0bee4e8a9db 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -28,6 +28,7 @@ properties:
       - qcom,msm8998-rpmpd
       - qcom,qcm2290-rpmpd
       - qcom,qcs404-rpmpd
+      - qcom,qdu1000-rpmhpd
       - qcom,sa8540p-rpmhpd
       - qcom,sdm660-rpmpd
       - qcom,sc7180-rpmhpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 578e060890dd..7b2e4b66419a 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -113,6 +113,12 @@
 #define SM8450_MXC_AO	11
 #define SM8450_MSS	12
 
+/* QDU1000/QRU1000 Power Domain Indexes */
+#define QDU1000_EBI	0
+#define QDU1000_MSS	1
+#define QDU1000_CX	2
+#define QDU1000_MX	3
+
 /* SC7180 Power Domain Indexes */
 #define SC7180_CX	0
 #define SC7180_CX_AO	1
-- 
2.25.1

