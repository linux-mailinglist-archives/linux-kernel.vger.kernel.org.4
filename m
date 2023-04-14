Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24E36E24AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDNNtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDNNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:49:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27003AF36;
        Fri, 14 Apr 2023 06:49:00 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ECxlTs022529;
        Fri, 14 Apr 2023 13:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=bGJSg4QHg3Mdt9XB0epGlO/VU8HOYvpFzIafzWr02Yg=;
 b=CS8Nvv5XGxMzXPAASZgnr3744qYtnFsaS2Qwx1IgkXzLXBZWqPf1u23EOSmdDATgsAml
 il6je1DrLECujSdaUsa2Lbd66LLor2+cle/xhZ7GhyDOUpsV78+86kqhtU+nWhdQHldq
 YHggOXebtS0buL4JQqxZTuTgDt2a/bGG8Us34EswMeYo22ZJnPQ4ACzpBbn/AIF5J0vA
 GrYOE1kkfWL4V3R8qS+A8GhxJ5XKehrANXbp/+ZB9G24FZCrawYIPFw8lByVAOiir1RA
 kx+zE2X4EHD+vWbjxP4alGQ0f6eJBTGzSbbC2SnmYOpGl9qfYxI5qJaRqLt09nNJrp5p 1Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py0xurxx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 13:48:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EDmtv4006683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 13:48:55 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 14 Apr 2023 06:48:49 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH V1 4/4] arm64: dts: qcom: ipq9574: rename al02-c7 dts to rdp433
Date:   Fri, 14 Apr 2023 19:18:12 +0530
Message-ID: <20230414134812.16812-5-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414134812.16812-1-quic_devipriy@quicinc.com>
References: <20230414134812.16812-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3a0NKACu2y04aVhP6DXGtYAJYeXMCzce
X-Proofpoint-ORIG-GUID: 3a0NKACu2y04aVhP6DXGtYAJYeXMCzce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_06,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=929 priorityscore=1501 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304140123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the dts after Reference Design Platform(RDP) to adopt
standard naming convention.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes since V9:
	- Renamed the Board Device Tree Source to use the RDP numbers

 arch/arm64/boot/dts/qcom/Makefile                               | 2 +-
 .../boot/dts/qcom/{ipq9574-al02-c7.dts => ipq9574-rdp433.dts}   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm64/boot/dts/qcom/{ipq9574-al02-c7.dts => ipq9574-rdp433.dts} (97%)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index e0e2def48470..f926e7e1aa7d 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -9,7 +9,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-al02-c7.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
similarity index 97%
rename from arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
rename to arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 2c8430197ec0..2ce8e09e7565 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
- * IPQ9574 AL02-C7 board device tree source
+ * IPQ9574 RDP433 board device tree source
  *
  * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
  * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
-- 
2.17.1

