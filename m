Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4223274E66B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGKFnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGKFnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:43:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031DD195;
        Mon, 10 Jul 2023 22:43:07 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B5gR8A021415;
        Tue, 11 Jul 2023 05:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=SmF8gFWZK/ulLhm//87qgNEIyb7zdCSCY6H1RlByBWY=;
 b=dxp6xGKFOy5Ux7v5Z+wIBpLiva6QFsLlF7U2RjevJ/l1sEYm0rSNaUU9muyAwGvnY/KS
 Wks3Eu31mEmRIuhuSBsnLkS+vIcPh+NwExonH/RLcWzwCXx10vBNEoUkVa2HOn2JhvNL
 DbDfdc3RT3LMHNmJkp8OmYk5PXHoFLvj675hGeP0RHR5Fxu104mYveip6lxgzg9pQtOh
 7J0lf3bhJ6HR5bPTWzK6aRM/6bjfBf6oh75mpl5atpllqSu/dUNMZB0thSTnIgWWkiAH
 tdXAZLWgqjErO2y7rOYiJ6GpnA5WnqkoBDTHjV9yRj6EdsBoFXH1bk43cfHY4FeDfwWV wQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs15nr01t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 05:43:03 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36B5gx2D005033;
        Tue, 11 Jul 2023 05:42:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rq0vm2h7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 05:42:59 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36B5gxxs004995;
        Tue, 11 Jul 2023 05:42:59 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36B5gwcS004967;
        Tue, 11 Jul 2023 05:42:59 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 54ADC5040; Tue, 11 Jul 2023 11:12:58 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 1/3] dt-bindings: power: rpmhpd: Add Generic RPMh PD indexes
Date:   Tue, 11 Jul 2023 11:12:47 +0530
Message-Id: <1689054169-10800-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689054169-10800-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689054169-10800-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h4n6sN0oks_VIK-FImTDgfBI74YE_T-Q
X-Proofpoint-ORIG-GUID: h4n6sN0oks_VIK-FImTDgfBI74YE_T-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=511 bulkscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110050
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Generic RPMh Power Domain indexes that can be used
for all the Qualcomm SoC henceforth.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/dt-bindings/power/qcom-rpmhpd.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h

diff --git a/include/dt-bindings/power/qcom-rpmhpd.h b/include/dt-bindings/power/qcom-rpmhpd.h
new file mode 100644
index 0000000..4da2e04
--- /dev/null
+++ b/include/dt-bindings/power/qcom-rpmhpd.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_POWER_QCOM_RPMHPD_H
+#define _DT_BINDINGS_POWER_QCOM_RPMHPD_H
+
+/* Generic RPMH Power Domain Indexes */
+#define CX               0
+#define MX               1
+#define CX_AO            2
+#define MX_AO            3
+#define GFX              4
+#define MSS              5
+#define EBI              6
+#define LCX              7
+#define LMX              8
+#define MMCX             9
+#define MMCX_AO          10
+#define MXC              11
+#define MXC_AO           12
+#define NSP              13
+#define NSP0             14
+#define NSP1             15
+#define QPHY             16
+#define DDR              17
+#define XO               18
+
+#endif
-- 
2.7.4

