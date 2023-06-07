Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4108B725DB7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbjFGLyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240440AbjFGLym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:54:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3BE1BD5;
        Wed,  7 Jun 2023 04:54:40 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357BdWGj029208;
        Wed, 7 Jun 2023 11:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6WGzFGQ5zbxok2QL+v8A5MEM2UwtuU/HImhH6EHxrwM=;
 b=iDVAnnJnfSx7FI3c3D20anenPEkwBHa75z0PL95hY8A8+cxMTDDUNY6rj1H1811ByqUH
 QcClLCbO33YT2a9oXysm9oEQNuEva/Qu47z/usBLx7BF/ch8b35aN8FpspJzFjSjabzY
 AND9oMSxKEqQrt+HqjbDhN4CReI7P0KvGCiwH01Aq6FDcoXJnste+zGEFmJG1YNY4axM
 nezSm/gFzF4gFqwiOEPuP9tI5k4zxudAJtV04kpo3EoWtJWLOtHFb9NpH1j5cXNVT7w3
 0CYTlh6bn9F9SFXoo8+lhxaQdRHuQlgAVhaXZ1GaG1cQTNL5KvVlY+fgXNxHd+5WZczg Hw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a719s44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 11:54:38 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357Bscbm025549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 11:54:38 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 04:54:35 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v1 1/2] dt-bindings: misc: fastrpc: add fastrpc group IDs property
Date:   Wed, 7 Jun 2023 17:24:23 +0530
Message-ID: <1686138864-17136-2-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686138864-17136-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1686138864-17136-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7wgzR2MeZ6tu0TcBDQHemV7yJOofZcTN
X-Proofpoint-ORIG-GUID: 7wgzR2MeZ6tu0TcBDQHemV7yJOofZcTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=982 suspectscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070099
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "qcom,fastrpc-gids" property to the list of optional properties.
This property contains the list of privileged group IDs which is
used to offload process to remote subsystem with increased privileges.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 1ab9588..2a2124f 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -57,6 +57,11 @@ properties:
       Virtual machine IDs for remote processor.
     $ref: "/schemas/types.yaml#/definitions/uint32-array"
 
+  qcom,fastrpc-gids:
+    description:
+      Group IDs for fastrpc.
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+
   "#address-cells":
     const: 1
 
@@ -120,6 +125,7 @@ examples:
             qcom,glink-channels = "fastrpcglink-apps-dsp";
             label = "sdsp";
             qcom,non-secure-domain;
+            qcom,fastrpc-gids = <2908>
             #address-cells = <1>;
             #size-cells = <0>;
 
-- 
2.7.4

