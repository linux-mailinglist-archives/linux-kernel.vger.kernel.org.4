Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE3D727A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbjFHI4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjFHI4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:56:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D2A1984;
        Thu,  8 Jun 2023 01:56:18 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3586lFqg027847;
        Thu, 8 Jun 2023 08:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=e1vi0RkXitXyaD8Zh+Bdc/oErRhEGUNSbSG/QbaiVUw=;
 b=evMlry79ky2J8Xco/oNHvxHVj1kdXyDkqIHm8sfjWd52pca63iCMr/l9KzeYTyDImCtH
 ysQxAQ/ObQbOkg6RT9N/xxNxnDHVt4fW8mkm/IWGwGuHPCqWkIMdRpU+K2CCEZmxPoDG
 K8KiMCqaoiQ6EuMCjTOiXNIxPUtMUrZO9XlnDxSIbtT4pZdrGFjT/4bPTAnam2g6ywia
 U6PVn4xs8FOLzwPnwpV4vlvncwkz6KI8vCeKfIR0WSBq0e1uipA+m9mp4xWgiHjqu9/t
 ayZBJsCzoAOxvzkt5Cbm6oI0vhFs3nSp7kRdYOTSteUQ8PalFlPUAo13XKw3cEkrtaUR pw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r38rbrcde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 08:56:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3588uDIl025991
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 08:56:13 GMT
Received: from hu-tnimkar-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 8 Jun 2023 01:56:10 -0700
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_lsrao@quicinc.com>,
        <quic_mkshah@quicinc.com>,
        Tushar Nimkar <quic_tnimkar@quicinc.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: cpu: idle-states: Add idle-state-disabled property
Date:   Thu, 8 Jun 2023 14:25:43 +0530
Message-ID: <20230608085544.16211-3-quic_tnimkar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Py0uuWfiO6WH7WcAehvvgM7tVo4EoHSy
X-Proofpoint-ORIG-GUID: Py0uuWfiO6WH7WcAehvvgM7tVo4EoHSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_05,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=916 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds idle-state-disabled property using which certain or all
idle-states can be kept disabled during boot-up. Once boot-up is completed
same can be enabled using below command.

echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable

Cc: devicetree@vger.kernel.org
Signed-off-by: Tushar Nimkar <quic_tnimkar@quicinc.com>
---
 Documentation/devicetree/bindings/cpu/idle-states.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpu/idle-states.yaml b/Documentation/devicetree/bindings/cpu/idle-states.yaml
index b8cc826c9501..f999bc666bbd 100644
--- a/Documentation/devicetree/bindings/cpu/idle-states.yaml
+++ b/Documentation/devicetree/bindings/cpu/idle-states.yaml
@@ -358,6 +358,13 @@ patternProperties:
           systems entry-latency-us + exit-latency-us will exceed
           wakeup-latency-us by this duration.
 
+      idle-state-disabled:
+        description: |
+          If present the idle state stays disabled. It can be enabled back from
+          shell using below command.
+          echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
+        type: boolean
+
       idle-state-name:
         $ref: /schemas/types.yaml#/definitions/string
         description:
@@ -548,6 +555,7 @@ examples:
             CPU_SLEEP_0_0: cpu-sleep-0-0 {
                 compatible = "arm,idle-state";
                 local-timer-stop;
+                idle-state-disabled;
                 arm,psci-suspend-param = <0x0010000>;
                 entry-latency-us = <250>;
                 exit-latency-us = <500>;
-- 
2.17.1

