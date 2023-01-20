Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF23067527F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjATKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjATKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:32:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAF73B3C7;
        Fri, 20 Jan 2023 02:32:03 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K9xwhX029234;
        Fri, 20 Jan 2023 10:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rGE8YD/svfv/6rOXc2gUpVo0LlpU9zfBZO0+yvqxhIw=;
 b=k3cu9FoS+4sRLqYfJ634gLd6SGz6h6/v4KQuwIgw4uF7V2hzNlJQTxXAfXTYPSsn0o4x
 50/qTc/ldjTSEqVq8YK5Yo4pf/JMQltsKo4nCFQKcz1UtZeAwjYugGFSwqWtf02X3MM8
 9t7tyno1j0ENZItTI3iId9Nre29jBdrXGArRpnayV+kCG3idyewh/tuf/4G4nnxA4Nx4
 75c4frC3qqOKvjTAs5shfvyGohSG9SO9bnMGEij0v1hqfrBqh21RelitGtD5PBCWrP57
 vGM+Pts4hyW1OZ/IefSAwUyjBO7pTV+HoQFr2Fl1o9ErfCfUlLGeFWLIF9J/HwQ0tefx tA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6wbsbp1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 10:31:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KAVtaL005324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 10:31:55 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 02:31:49 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2 2/2] ASoC: dt-bindings: google,sc7280-herobrine: Add platform property
Date:   Fri, 20 Jan 2023 16:01:25 +0530
Message-ID: <1674210685-19944-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674210685-19944-1-git-send-email-quic_srivasam@quicinc.com>
References: <1674210685-19944-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UKTq-x41vESYoqBK9AsEqeYNWhfq1dLd
X-Proofpoint-GUID: UKTq-x41vESYoqBK9AsEqeYNWhfq1dLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_06,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200099
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform property in sc7280 machine driver bindings for including
platform subnode in dai-links.
This is required for binding the frontend dai driver with codec driver
and cpu driver and to do dynamic pcm routing in ADSP based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 .../devicetree/bindings/sound/google,sc7280-herobrine.yaml   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
index 869b403..0b1a01a 100644
--- a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
+++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
@@ -75,6 +75,18 @@ patternProperties:
 
         additionalProperties: false
 
+      platform:
+        description: Holds subnode which includes the phandle of q6apm platform device.
+        type: object
+        properties:
+          sound-dai:
+            maxItems: 1
+
+        required:
+          - sound-dai
+
+        additionalProperties: false
+
     required:
       - link-name
       - cpu
-- 
2.7.4

