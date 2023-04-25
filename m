Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F1F6EDE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjDYJAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjDYJAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:00:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68FF10DE;
        Tue, 25 Apr 2023 02:00:31 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P8GXpa018254;
        Tue, 25 Apr 2023 08:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FuX86khYoJUCC49Zb/H9dbx46Yosa3Eyr8oF0eaR7KE=;
 b=nnABB8DUjpKSrGLGbvnun2kZqjizl/dI8OmYDey3lcpKKnhbAOjDMfbVO0bb2u3Kglru
 fTK/8Zh5bKigV4FFCfnd9Ydr7uP7YYjIztHC6nTw3JKbY+VLbn2b0aX7TET6Gyk7exOf
 CpFtHmLZFKDiBMH2CS6Aiol/cc7cuop2Eg665dtK4TNUevEVe0EICkXdMUvyYAn13qBM
 ZIeYfSNRCLelKBqNNvnXug/fvrcZNHiBO0hIRv5+cGJ/IKTTYM1AxEP5ge76cnl8T4kj
 cpr82M9aKg3u6UO6KFI/jgpdAUrVOCFR/l+jd4MqgxFcm/8tidKJ4213enCT8GfRlaqR Pg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q6a4wr6cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 08:40:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33P8enjF032343
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 08:40:49 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 25 Apr 2023 01:40:43 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH V3 3/6] clk: qcom: gcc-ipq9574: Clean up included headers
Date:   Tue, 25 Apr 2023 14:10:07 +0530
Message-ID: <20230425084010.15581-4-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230425084010.15581-1-quic_devipriy@quicinc.com>
References: <20230425084010.15581-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Bk958ijpJ41noM4iOHqbxw-_MCup5rrm
X-Proofpoint-GUID: Bk958ijpJ41noM4iOHqbxw-_MCup5rrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxlogscore=959
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some included headers aren't actually used anywhere, while other headers
with the declaration of functions and structures aren't directly included.

Get rid of the unused ones, and add the ones that should be included
directly.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- Created a separate patch for the header clean up changes.

 drivers/clk/qcom/gcc-ipq9574.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index b2a2d618a5ec..8dd29bbd93b9 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -3,24 +3,24 @@
  * Copyright (c) 2023 The Linux Foundation. All rights reserved.
  */
 
+#include <linux/clk-provider.h>
 #include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#include <linux/reset-controller.h>
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
 
-#include "clk-rcg.h"
-#include "clk-branch.h"
 #include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
 #include "clk-regmap-phy-mux.h"
+#include "common.h"
 #include "reset.h"
 
 /* Need to match the order of clocks in DT binding */
-- 
2.17.1

