Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A3E74BCB7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 09:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGHHcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 03:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjGHHcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 03:32:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686CF210C;
        Sat,  8 Jul 2023 00:31:29 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3687PsVr022163;
        Sat, 8 Jul 2023 07:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=AqFcIdTI/yoRSF9v2JX/YTplshDf+mYMDIug9kinJiU=;
 b=lIecd2WZ2YLJsAXxVbvG7VTSbc43g426qoJSf/f2Pt3c5mwFzw0YLxFTjvEg7nZPrBVM
 TlsVbqnGNeGZgbY3v/+464J5sBuIQSfVK/HcSGBOJlaUc+56NIUOIcpKH36lmQWnoV1J
 tcl4qTg6YZ7k7hA1HyIZkWgpWwjlTQdwsrhTyFKG0rgRyZDBiZE9ATgfn+135CyDbbKs
 wWhEGxIeLy0awEZnNAj4B+Li0ZxuvnH2AFa6OasNgT0ZOGXWq79JpcpsRTAU1tYy8eTi
 mnbhFc2dX9uW+e30I8eAmSvTqx+Fjs3B14z/xj9EAraZZYROLWoysoiHsFIjWkbY+Rg2 4g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpy4rr8a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 07:31:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3687VAbo013184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 07:31:10 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 00:31:02 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>,
        "Jishnu Prakash" <quic_jprakash@quicinc.com>
Subject: [PATCH 10/11] ARM: dts: qcom: Update devicetree for QCOM ADC bindings path change
Date:   Sat, 8 Jul 2023 12:58:34 +0530
Message-ID: <20230708072835.3035398-11-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cNkUEHwvoVaCpUxVdljJOn4o2p33_Tb8
X-Proofpoint-GUID: cNkUEHwvoVaCpUxVdljJOn4o2p33_Tb8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-08_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=525 spamscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307080065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ADC dt-bindings file paths in QCOM devicetree files to
match the dt-bindings change moving the files from 'iio' to
'iio/adc' folder.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 arch/arm64/boot/dts/qcom/pm6125.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/pm6150.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi                        | 2 +-
 arch/arm64/boot/dts/qcom/pm660l.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/pm7250b.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8150.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8150l.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/pm8950.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/pm8953.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/pmi632.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/pmi8950.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi                  | 2 +-
 arch/arm64/boot/dts/qcom/pmp8074.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pms405.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts                    | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                   | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                 | 4 ++--
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 +++---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts          | 2 +-
 24 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6125.dtsi b/arch/arm64/boot/dts/qcom/pm6125.dtsi
index 59092a551a16..f7f716dfcbd1 100644
--- a/arch/arm64/boot/dts/qcom/pm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6125.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 2e6afa296141..673bbcd69538 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index 6f7aa67501e2..d606520e05b7 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index 4bc717917f44..e9cf14fef96d 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2020, Konrad Dybcio
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
index 87b71b7205b8..dfbe9bb0d25c 100644
--- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2020, Konrad Dybcio
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index daa6f1d30efa..f5d14bde5300 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -3,7 +3,7 @@
  * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index db90c55fa2cf..a2d0168f4a2c 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -7,7 +7,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 66752cc063d6..9cb9603180d9 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -4,7 +4,7 @@
  * Copyright (c) 2019, Linaro Limited
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index cca45fad75ac..5a7cf8947dc4 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -4,7 +4,7 @@
  * Copyright (c) 2019, Linaro Limited
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index 1ea8920ff369..91990a7175b1 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
index 5ec38b7e335a..e8d707edc4cd 100644
--- a/arch/arm64/boot/dts/qcom/pm8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8950.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi b/arch/arm64/boot/dts/qcom/pm8953.dtsi
index 2268daf27fa7..025e851a6d2c 100644
--- a/arch/arm64/boot/dts/qcom/pm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index 672094c8ca58..8d150358b6ac 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 695d79116cde..34462b5172da 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /* Copyright 2018 Google LLC. */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qcom/pmi632.dtsi
index 4eb79e0ce40a..09f7af85d39b 100644
--- a/arch/arm64/boot/dts/qcom/pmi632.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
@@ -3,7 +3,7 @@
  * Copyright (C) 2023 Luca Weiss <luca@z3ntu.xyz>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
index 4891be3cd68a..ce6f79c14015 100644
--- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019, AngeloGioacchino Del Regno <kholk11@gmail.com>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
index ee1e428d3a6e..35838492ea99 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
@@ -6,7 +6,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
index 580684411d74..76438b4cda14 100644
--- a/arch/arm64/boot/dts/qcom/pmp8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 &spmi_bus {
 	pmic@0 {
diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 22edb47c6a84..2c87eae3d140 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -5,7 +5,7 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/input/linux-event-codes.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index bc65e6c6232f..e4afb554ba66 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -7,7 +7,7 @@
 
 /dts-v1/;
 
-#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pmr735a.h>
 #include "sc7280-idp.dtsi"
 #include "pmr735a.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index da413694e230..ac8922a222e7 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pmk8350.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include "sc7280.dtsi"
 #include "pm7325.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index ed26bff7432d..2abe5ce2af74 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -11,8 +11,8 @@
  * Copyright 2022 Google LLC.
  */
 
-#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pmr735a.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index cfd5dbbacdcb..dedfefd94a63 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -7,9 +7,9 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pm8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pmr735a.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 52119cc1250e..e9c06953a490 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -9,7 +9,7 @@
 #define PMK8350_SID 6
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc5-gen2-pmk8350.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
-- 
2.25.1

