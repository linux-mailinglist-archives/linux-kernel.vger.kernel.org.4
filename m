Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5A474BCBB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 09:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjGHHdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 03:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjGHHcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 03:32:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF4271C;
        Sat,  8 Jul 2023 00:32:10 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3687R9SC024197;
        Sat, 8 Jul 2023 07:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=PmM8tRLhmkVT1MdvSvU5NUYWaepYihTBPy6MA37TDyU=;
 b=o28hDMp1rhvj2NBdC8XBpTGx08VMyUxgHY3CCyZJFQF7Px8v1p6RRrL6YhNnqVNkrhQ4
 5K5p98bqQ+hefp6e9ioQfSS8goH4uJNMCcLdUjYIFqz5ouSUPOAmh/5tW4A21EGZSiS5
 s/Mr70ldJoX0IcRedh5eE9XtHMPdIf0l/MDgY3FQ8KOy4AEr+1HEb0gThbr5khTtAQ8L
 ZzbwCO9otLkw4BgeQgoqHdiuAnPTUQWS+rTTKGyZahf74mU5q/s9KV9m19+58XYx3AFw
 sIIVLNXGqmPZQMmdk2b8X72NRnnbjDQF0+ct5rSrEfUwJsgtRxGtys7V9Cm5FuzEVQAX Ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rq06d06et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 07:31:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3687VK56025711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 07:31:20 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 00:31:12 -0700
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
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH 11/11] dt-bindings: iio: remove QCOM ADC files from iio folder
Date:   Sat, 8 Jul 2023 12:58:35 +0530
Message-ID: <20230708072835.3035398-12-quic_jprakash@quicinc.com>
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
X-Proofpoint-ORIG-GUID: lwRZrpc5zNpHb8Jn7ic75SEHd-b6JDPF
X-Proofpoint-GUID: lwRZrpc5zNpHb8Jn7ic75SEHd-b6JDPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-08_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307080065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the ADC dt-binding paths have been updated everywhere
to use the files copied to the 'iio/adc' folder, remove them
from the 'iio' folder.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 .../iio/qcom,spmi-adc5-gen2-pm8350.h          |  64 ---
 .../iio/qcom,spmi-adc5-gen2-pm8350b.h         |  89 ----
 .../iio/qcom,spmi-adc5-gen2-pmk8350.h         |  47 ---
 .../iio/qcom,spmi-adc5-gen2-pmr735a.h         |  29 --
 .../iio/qcom,spmi-adc5-gen2-pmr735b.h         |  28 --
 .../iio/qcom,spmi-adc5-gen3-pm8550.h          |  48 ---
 .../iio/qcom,spmi-adc5-gen3-pm8550b.h         |  97 -----
 .../iio/qcom,spmi-adc5-gen3-pm8550vx.h        |  20 -
 .../iio/qcom,spmi-adc5-gen3-pmk8550.h         |  54 ---
 include/dt-bindings/iio/qcom,spmi-vadc.h      | 379 ------------------
 10 files changed, 855 deletions(-)
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350b.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735b.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-vadc.h

diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h
deleted file mode 100644
index 77259beaf6e9..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
-
-/* ADC channels for PM8350_ADC for PMIC5 Gen2 */
-#define PM8350_ADC5_GEN2_REF_GND(sid)		((sid) << 8 | 0x0)
-#define PM8350_ADC5_GEN2_1P25VREF(sid)		((sid) << 8 | 0x01)
-#define PM8350_ADC5_GEN2_VREF_VADC(sid)		((sid) << 8 | 0x02)
-#define PM8350_ADC5_GEN2_DIE_TEMP(sid)		((sid) << 8 | 0x03)
-
-#define PM8350_ADC5_GEN2_AMUX_THM1(sid)		((sid) << 8 | 0x04)
-#define PM8350_ADC5_GEN2_AMUX_THM2(sid)		((sid) << 8 | 0x05)
-#define PM8350_ADC5_GEN2_AMUX_THM3(sid)	((sid) << 8 | 0x06)
-#define PM8350_ADC5_GEN2_AMUX_THM4(sid)		((sid) << 8 | 0x07)
-#define PM8350_ADC5_GEN2_AMUX_THM5(sid)	((sid) << 8 | 0x08)
-#define PM8350_ADC5_GEN2_GPIO1(sid)		((sid) << 8 | 0x0a)
-#define PM8350_ADC5_GEN2_GPIO2(sid)		((sid) << 8 | 0x0b)
-#define PM8350_ADC5_GEN2_GPIO3(sid)		((sid) << 8 | 0x0c)
-#define PM8350_ADC5_GEN2_GPIO4(sid)		((sid) << 8 | 0x0d)
-
-/* 30k pull-up1 */
-#define PM8350_ADC5_GEN2_AMUX_THM1_30K_PU(sid)		((sid) << 8 | 0x24)
-#define PM8350_ADC5_GEN2_AMUX_THM2_30K_PU(sid)		((sid) << 8 | 0x25)
-#define PM8350_ADC5_GEN2_AMUX_THM3_30K_PU(sid)		((sid) << 8 | 0x26)
-#define PM8350_ADC5_GEN2_AMUX_THM4_30K_PU(sid)		((sid) << 8 | 0x27)
-#define PM8350_ADC5_GEN2_AMUX_THM5_30K_PU(sid)		((sid) << 8 | 0x28)
-#define PM8350_ADC5_GEN2_GPIO1_30K_PU(sid)		((sid) << 8 | 0x2a)
-#define PM8350_ADC5_GEN2_GPIO2_30K_PU(sid)		((sid) << 8 | 0x2b)
-#define PM8350_ADC5_GEN2_GPIO3_30K_PU(sid)		((sid) << 8 | 0x2c)
-#define PM8350_ADC5_GEN2_GPIO4_30K_PU(sid)		((sid) << 8 | 0x2d)
-
-/* 100k pull-up2 */
-#define PM8350_ADC5_GEN2_AMUX_THM1_100K_PU(sid)		((sid) << 8 | 0x44)
-#define PM8350_ADC5_GEN2_AMUX_THM2_100K_PU(sid)		((sid) << 8 | 0x45)
-#define PM8350_ADC5_GEN2_AMUX_THM3_100K_PU(sid)		((sid) << 8 | 0x46)
-#define PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(sid)		((sid) << 8 | 0x47)
-#define PM8350_ADC5_GEN2_AMUX_THM5_100K_PU(sid)		((sid) << 8 | 0x48)
-#define PM8350_ADC5_GEN2_GPIO1_100K_PU(sid)		((sid) << 8 | 0x4a)
-#define PM8350_ADC5_GEN2_GPIO2_100K_PU(sid)		((sid) << 8 | 0x4b)
-#define PM8350_ADC5_GEN2_GPIO3_100K_PU(sid)		((sid) << 8 | 0x4c)
-#define PM8350_ADC5_GEN2_GPIO4_100K_PU(sid)		((sid) << 8 | 0x4d)
-
-/* 400k pull-up3 */
-#define PM8350_ADC5_GEN2_AMUX_THM1_400K_PU(sid)		((sid) << 8 | 0x64)
-#define PM8350_ADC5_GEN2_AMUX_THM2_400K_PU(sid)		((sid) << 8 | 0x65)
-#define PM8350_ADC5_GEN2_AMUX_THM3_400K_PU(sid)		((sid) << 8 | 0x66)
-#define PM8350_ADC5_GEN2_AMUX_THM4_400K_PU(sid)		((sid) << 8 | 0x67)
-#define PM8350_ADC5_GEN2_AMUX_THM5_400K_PU(sid)		((sid) << 8 | 0x68)
-#define PM8350_ADC5_GEN2_GPIO1_400K_PU(sid)		((sid) << 8 | 0x6a)
-#define PM8350_ADC5_GEN2_GPIO2_400K_PU(sid)		((sid) << 8 | 0x6b)
-#define PM8350_ADC5_GEN2_GPIO3_400K_PU(sid)		((sid) << 8 | 0x6c)
-#define PM8350_ADC5_GEN2_GPIO4_400K_PU(sid)		((sid) << 8 | 0x6d)
-
-/* 1/3 Divider */
-#define PM8350_ADC5_GEN2_GPIO4_DIV3(sid)		((sid) << 8 | 0x8d)
-
-#define PM8350_ADC5_GEN2_VPH_PWR(sid)		((sid) << 8 | 0x8e)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350b.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350b.h
deleted file mode 100644
index c7bb54e0b6a6..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pm8350b.h
+++ /dev/null
@@ -1,89 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H
-
-#ifndef PM8350B_SID
-#define PM8350B_SID					3
-#endif
-
-/* ADC channels for PM8350B_ADC for PMIC5 Gen2 */
-#define PM8350B_ADC5_GEN2_REF_GND			(PM8350B_SID << 8 | 0x0)
-#define PM8350B_ADC5_GEN2_1P25VREF			(PM8350B_SID << 8 | 0x01)
-#define PM8350B_ADC5_GEN2_VREF_VADC			(PM8350B_SID << 8 | 0x02)
-#define PM8350B_ADC5_GEN2_DIE_TEMP			(PM8350B_SID << 8 | 0x03)
-
-#define PM8350B_ADC5_GEN2_AMUX_THM1			(PM8350B_SID << 8 | 0x04)
-#define PM8350B_ADC5_GEN2_AMUX_THM2			(PM8350B_SID << 8 | 0x05)
-#define PM8350B_ADC5_GEN2_AMUX_THM3			(PM8350B_SID << 8 | 0x06)
-#define PM8350B_ADC5_GEN2_AMUX_THM4			(PM8350B_SID << 8 | 0x07)
-#define PM8350B_ADC5_GEN2_AMUX_THM5			(PM8350B_SID << 8 | 0x08)
-#define PM8350B_ADC5_GEN2_AMUX_THM6			(PM8350B_SID << 8 | 0x09)
-#define PM8350B_ADC5_GEN2_GPIO1			(PM8350B_SID << 8 | 0x0a)
-#define PM8350B_ADC5_GEN2_GPIO2			(PM8350B_SID << 8 | 0x0b)
-#define PM8350B_ADC5_GEN2_GPIO3			(PM8350B_SID << 8 | 0x0c)
-#define PM8350B_ADC5_GEN2_GPIO4			(PM8350B_SID << 8 | 0x0d)
-
-#define PM8350B_ADC5_GEN2_CHG_TEMP			(PM8350B_SID << 8 | 0x10)
-#define PM8350B_ADC5_GEN2_USB_IN_V_16		(PM8350B_SID << 8 | 0x11)
-#define PM8350B_ADC5_GEN2_VDC_16			(PM8350B_SID << 8 | 0x12)
-#define PM8350B_ADC5_GEN2_CC1_ID			(PM8350B_SID << 8 | 0x13)
-#define PM8350B_ADC5_GEN2_VREF_BAT_THERM		(PM8350B_SID << 8 | 0x15)
-#define PM8350B_ADC5_GEN2_IIN_FB			(PM8350B_SID << 8 | 0x17)
-
-/* 30k pull-up1 */
-#define PM8350B_ADC5_GEN2_AMUX_THM1_30K_PU		(PM8350B_SID << 8 | 0x24)
-#define PM8350B_ADC5_GEN2_AMUX_THM2_30K_PU		(PM8350B_SID << 8 | 0x25)
-#define PM8350B_ADC5_GEN2_AMUX_THM3_30K_PU		(PM8350B_SID << 8 | 0x26)
-#define PM8350B_ADC5_GEN2_AMUX_THM4_30K_PU		(PM8350B_SID << 8 | 0x27)
-#define PM8350B_ADC5_GEN2_AMUX_THM5_30K_PU		(PM8350B_SID << 8 | 0x28)
-#define PM8350B_ADC5_GEN2_AMUX_THM6_30K_PU		(PM8350B_SID << 8 | 0x29)
-#define PM8350B_ADC5_GEN2_GPIO1_30K_PU		(PM8350B_SID << 8 | 0x2a)
-#define PM8350B_ADC5_GEN2_GPIO2_30K_PU		(PM8350B_SID << 8 | 0x2b)
-#define PM8350B_ADC5_GEN2_GPIO3_30K_PU		(PM8350B_SID << 8 | 0x2c)
-#define PM8350B_ADC5_GEN2_GPIO4_30K_PU		(PM8350B_SID << 8 | 0x2d)
-#define PM8350B_ADC5_GEN2_CC1_ID_30K_PU		(PM8350B_SID << 8 | 0x33)
-
-/* 100k pull-up2 */
-#define PM8350B_ADC5_GEN2_AMUX_THM1_100K_PU		(PM8350B_SID << 8 | 0x44)
-#define PM8350B_ADC5_GEN2_AMUX_THM2_100K_PU		(PM8350B_SID << 8 | 0x45)
-#define PM8350B_ADC5_GEN2_AMUX_THM3_100K_PU		(PM8350B_SID << 8 | 0x46)
-#define PM8350B_ADC5_GEN2_AMUX_THM4_100K_PU		(PM8350B_SID << 8 | 0x47)
-#define PM8350B_ADC5_GEN2_AMUX_THM5_100K_PU		(PM8350B_SID << 8 | 0x48)
-#define PM8350B_ADC5_GEN2_AMUX_THM6_100K_PU		(PM8350B_SID << 8 | 0x49)
-#define PM8350B_ADC5_GEN2_GPIO1_100K_PU		(PM8350B_SID << 8 | 0x4a)
-#define PM8350B_ADC5_GEN2_GPIO2_100K_PU		(PM8350B_SID << 8 | 0x4b)
-#define PM8350B_ADC5_GEN2_GPIO3_100K_PU		(PM8350B_SID << 8 | 0x4c)
-#define PM8350B_ADC5_GEN2_GPIO4_100K_PU		(PM8350B_SID << 8 | 0x4d)
-#define PM8350B_ADC5_GEN2_CC1_ID_100K_PU		(PM8350B_SID << 8 | 0x53)
-
-/* 400k pull-up3 */
-#define PM8350B_ADC5_GEN2_AMUX_THM1_400K_PU		(PM8350B_SID << 8 | 0x64)
-#define PM8350B_ADC5_GEN2_AMUX_THM2_400K_PU		(PM8350B_SID << 8 | 0x65)
-#define PM8350B_ADC5_GEN2_AMUX_THM3_400K_PU		(PM8350B_SID << 8 | 0x66)
-#define PM8350B_ADC5_GEN2_AMUX_THM4_400K_PU		(PM8350B_SID << 8 | 0x67)
-#define PM8350B_ADC5_GEN2_AMUX_THM5_400K_PU		(PM8350B_SID << 8 | 0x68)
-#define PM8350B_ADC5_GEN2_AMUX_THM6_400K_PU		(PM8350B_SID << 8 | 0x69)
-#define PM8350B_ADC5_GEN2_GPIO1_400K_PU		(PM8350B_SID << 8 | 0x6a)
-#define PM8350B_ADC5_GEN2_GPIO2_400K_PU		(PM8350B_SID << 8 | 0x6b)
-#define PM8350B_ADC5_GEN2_GPIO3_400K_PU		(PM8350B_SID << 8 | 0x6c)
-#define PM8350B_ADC5_GEN2_GPIO4_400K_PU		(PM8350B_SID << 8 | 0x6d)
-#define PM8350B_ADC5_GEN2_CC1_ID_400K_PU		(PM8350B_SID << 8 | 0x73)
-
-/* 1/3 Divider */
-#define PM8350B_ADC5_GEN2_GPIO1_DIV3			(PM8350B_SID << 8 | 0x8a)
-#define PM8350B_ADC5_GEN2_GPIO2_DIV3			(PM8350B_SID << 8 | 0x8b)
-#define PM8350B_ADC5_GEN2_GPIO3_DIV3			(PM8350B_SID << 8 | 0x8c)
-#define PM8350B_ADC5_GEN2_GPIO4_DIV3			(PM8350B_SID << 8 | 0x8d)
-
-#define PM8350B_ADC5_GEN2_VPH_PWR			(PM8350B_SID << 8 | 0x8e)
-#define PM8350B_ADC5_GEN2_VBAT_SNS			(PM8350B_SID << 8 | 0x8f)
-
-#define PM8350B_ADC5_GEN2_SBUx			(PM8350B_SID << 8 | 0x94)
-#define PM8350B_ADC5_GEN2_VBAT_2S_MID		(PM8350B_SID << 8 | 0x96)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h
deleted file mode 100644
index 8de4ee86f875..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmk8350.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
-
-#ifndef PMK8350_SID
-#define PMK8350_SID					0
-#endif
-
-/* ADC channels for PMK8350_ADC for PMIC5 Gen2 */
-#define PMK8350_ADC5_GEN2_REF_GND			(PMK8350_SID << 8 | 0x0)
-#define PMK8350_ADC5_GEN2_1P25VREF			(PMK8350_SID << 8 | 0x01)
-#define PMK8350_ADC5_GEN2_VREF_VADC			(PMK8350_SID << 8 | 0x02)
-#define PMK8350_ADC5_GEN2_DIE_TEMP			(PMK8350_SID << 8 | 0x03)
-
-#define PMK8350_ADC5_GEN2_AMUX_THM1			(PMK8350_SID << 8 | 0x04)
-#define PMK8350_ADC5_GEN2_AMUX_THM2			(PMK8350_SID << 8 | 0x05)
-#define PMK8350_ADC5_GEN2_AMUX_THM3			(PMK8350_SID << 8 | 0x06)
-#define PMK8350_ADC5_GEN2_AMUX_THM4			(PMK8350_SID << 8 | 0x07)
-#define PMK8350_ADC5_GEN2_AMUX_THM5			(PMK8350_SID << 8 | 0x08)
-
-/* 30k pull-up1 */
-#define PMK8350_ADC5_GEN2_AMUX_THM1_30K_PU		(PMK8350_SID << 8 | 0x24)
-#define PMK8350_ADC5_GEN2_AMUX_THM2_30K_PU		(PMK8350_SID << 8 | 0x25)
-#define PMK8350_ADC5_GEN2_AMUX_THM3_30K_PU		(PMK8350_SID << 8 | 0x26)
-#define PMK8350_ADC5_GEN2_AMUX_THM4_30K_PU		(PMK8350_SID << 8 | 0x27)
-#define PMK8350_ADC5_GEN2_AMUX_THM5_30K_PU		(PMK8350_SID << 8 | 0x28)
-
-/* 100k pull-up2 */
-#define PMK8350_ADC5_GEN2_AMUX_THM1_100K_PU		(PMK8350_SID << 8 | 0x44)
-#define PMK8350_ADC5_GEN2_AMUX_THM2_100K_PU		(PMK8350_SID << 8 | 0x45)
-#define PMK8350_ADC5_GEN2_AMUX_THM3_100K_PU		(PMK8350_SID << 8 | 0x46)
-#define PMK8350_ADC5_GEN2_AMUX_THM4_100K_PU		(PMK8350_SID << 8 | 0x47)
-#define PMK8350_ADC5_GEN2_AMUX_THM5_100K_PU		(PMK8350_SID << 8 | 0x48)
-
-/* 400k pull-up3 */
-#define PMK8350_ADC5_GEN2_AMUX_THM1_400K_PU		(PMK8350_SID << 8 | 0x64)
-#define PMK8350_ADC5_GEN2_AMUX_THM2_400K_PU		(PMK8350_SID << 8 | 0x65)
-#define PMK8350_ADC5_GEN2_AMUX_THM3_400K_PU		(PMK8350_SID << 8 | 0x66)
-#define PMK8350_ADC5_GEN2_AMUX_THM4_400K_PU		(PMK8350_SID << 8 | 0x67)
-#define PMK8350_ADC5_GEN2_AMUX_THM5_400K_PU		(PMK8350_SID << 8 | 0x68)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h
deleted file mode 100644
index 0f8ad745845b..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735a.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H
-
-#ifndef PMR735A_SID
-#define PMR735A_SID					4
-#endif
-
-/* ADC channels for PMR735A_ADC for PMIC5 Gen2 */
-#define PMR735A_ADC5_GEN2_REF_GND			(PMR735A_SID << 8 | 0x0)
-#define PMR735A_ADC5_GEN2_1P25VREF			(PMR735A_SID << 8 | 0x01)
-#define PMR735A_ADC5_GEN2_VREF_VADC			(PMR735A_SID << 8 | 0x02)
-#define PMR735A_ADC5_GEN2_DIE_TEMP			(PMR735A_SID << 8 | 0x03)
-
-#define PMR735A_ADC5_GEN2_GPIO1			(PMR735A_SID << 8 | 0x0a)
-#define PMR735A_ADC5_GEN2_GPIO2			(PMR735A_SID << 8 | 0x0b)
-#define PMR735A_ADC5_GEN2_GPIO3			(PMR735A_SID << 8 | 0x0c)
-
-/* 100k pull-up2 */
-#define PMR735A_ADC5_GEN2_GPIO1_100K_PU		(PMR735A_SID << 8 | 0x4a)
-#define PMR735A_ADC5_GEN2_GPIO2_100K_PU		(PMR735A_SID << 8 | 0x4b)
-#define PMR735A_ADC5_GEN2_GPIO3_100K_PU		(PMR735A_SID << 8 | 0x4c)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735b.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735b.h
deleted file mode 100644
index d05d057276e3..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc5-gen2-pmr735b.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H
-
-#ifndef PMR735B_SID
-#define PMR735B_SID					5
-#endif
-
-/* ADC channels for PMR735B_ADC for PMIC5 Gen2 */
-#define PMR735B_ADC5_GEN2_REF_GND			(PMR735B_SID << 8 | 0x0)
-#define PMR735B_ADC5_GEN2_1P25VREF			(PMR735B_SID << 8 | 0x01)
-#define PMR735B_ADC5_GEN2_VREF_VADC			(PMR735B_SID << 8 | 0x02)
-#define PMR735B_ADC5_GEN2_DIE_TEMP			(PMR735B_SID << 8 | 0x03)
-
-#define PMR735B_ADC5_GEN2_GPIO1			(PMR735B_SID << 8 | 0x0a)
-#define PMR735B_ADC5_GEN2_GPIO2			(PMR735B_SID << 8 | 0x0b)
-#define PMR735B_ADC5_GEN2_GPIO3			(PMR735B_SID << 8 | 0x0c)
-
-/* 100k pull-up2 */
-#define PMR735B_ADC5_GEN2_GPIO1_100K_PU		(PMR735B_SID << 8 | 0x4a)
-#define PMR735B_ADC5_GEN2_GPIO2_100K_PU		(PMR735B_SID << 8 | 0x4b)
-#define PMR735B_ADC5_GEN2_GPIO3_100K_PU		(PMR735B_SID << 8 | 0x4c)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
deleted file mode 100644
index 74e6e2f6f9ed..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
-
-#ifndef PM8550_SID
-#define PM8550_SID		1
-#endif
-
-/* ADC channels for PM8550_ADC for PMIC5 Gen3 */
-#define PM8550_ADC5_GEN3_OFFSET_REF			(PM8550_SID << 8 | 0x00)
-#define PM8550_ADC5_GEN3_1P25VREF			(PM8550_SID << 8 | 0x01)
-#define PM8550_ADC5_GEN3_VREF_VADC			(PM8550_SID << 8 | 0x02)
-#define PM8550_ADC5_GEN3_DIE_TEMP			(PM8550_SID << 8 | 0x03)
-
-#define PM8550_ADC5_GEN3_AMUX_THM1			(PM8550_SID << 8 | 0x04)
-#define PM8550_ADC5_GEN3_AMUX_THM2			(PM8550_SID << 8 | 0x05)
-#define PM8550_ADC5_GEN3_AMUX_THM3			(PM8550_SID << 8 | 0x06)
-#define PM8550_ADC5_GEN3_AMUX_THM4			(PM8550_SID << 8 | 0x07)
-#define PM8550_ADC5_GEN3_AMUX_THM5			(PM8550_SID << 8 | 0x08)
-#define PM8550_ADC5_GEN3_AMUX_THM6_GPIO2		(PM8550_SID << 8 | 0x09)
-#define PM8550_ADC5_GEN3_AMUX1_GPIO3			(PM8550_SID << 8 | 0x0a)
-#define PM8550_ADC5_GEN3_AMUX2_GPIO4			(PM8550_SID << 8 | 0x0b)
-#define PM8550_ADC5_GEN3_AMUX3_GPIO7			(PM8550_SID << 8 | 0x0c)
-#define PM8550_ADC5_GEN3_AMUX4_GPIO12			(PM8550_SID << 8 | 0x0d)
-
-/* 100k pull-up */
-#define PM8550_ADC5_GEN3_AMUX_THM1_100K_PU		(PM8550_SID << 8 | 0x44)
-#define PM8550_ADC5_GEN3_AMUX_THM2_100K_PU		(PM8550_SID << 8 | 0x45)
-#define PM8550_ADC5_GEN3_AMUX_THM3_100K_PU		(PM8550_SID << 8 | 0x46)
-#define PM8550_ADC5_GEN3_AMUX_THM4_100K_PU		(PM8550_SID << 8 | 0x47)
-#define PM8550_ADC5_GEN3_AMUX_THM5_100K_PU		(PM8550_SID << 8 | 0x48)
-#define PM8550_ADC5_GEN3_AMUX_THM6_GPIO2_100K_PU	(PM8550_SID << 8 | 0x49)
-#define PM8550_ADC5_GEN3_AMUX1_GPIO3_100K_PU		(PM8550_SID << 8 | 0x4a)
-#define PM8550_ADC5_GEN3_AMUX2_GPIO4_100K_PU		(PM8550_SID << 8 | 0x4b)
-#define PM8550_ADC5_GEN3_AMUX3_GPIO7_100K_PU		(PM8550_SID << 8 | 0x4c)
-#define PM8550_ADC5_GEN3_AMUX4_GPIO12_100K_PU		(PM8550_SID << 8 | 0x4d)
-
-/* 1/3 Divider */
-#define PM8550_ADC5_GEN3_AMUX3_GPIO7_DIV3		(PM8550_SID << 8 | 0x8c)
-#define PM8550_ADC5_GEN3_AMUX4_GPIO12_DIV3		(PM8550_SID << 8 | 0x8d)
-
-#define PM8550_ADC5_GEN3_VPH_PWR			(PM8550_SID << 8 | 0x8e)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h
deleted file mode 100644
index 35483dfd970e..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H
-
-#ifndef PM8550B_SID
-#define PM8550B_SID		7
-#endif
-
-/* ADC channels for PM8550B_ADC for PMIC5 Gen3 */
-#define PM8550B_ADC5_GEN3_OFFSET_REF			(PM8550B_SID << 8 | 0x00)
-#define PM8550B_ADC5_GEN3_1P25VREF			(PM8550B_SID << 8 | 0x01)
-#define PM8550B_ADC5_GEN3_VREF_VADC			(PM8550B_SID << 8 | 0x02)
-#define PM8550B_ADC5_GEN3_DIE_TEMP			(PM8550B_SID << 8 | 0x03)
-
-#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM		(PM8550B_SID << 8 | 0x04)
-#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID		(PM8550B_SID << 8 | 0x05)
-#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V		(PM8550B_SID << 8 | 0x06)
-#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM		(PM8550B_SID << 8 | 0x07)
-#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION		(PM8550B_SID << 8 | 0x08)
-#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10		(PM8550B_SID << 8 | 0x09)
-#define PM8550B_ADC5_GEN3_AMUX1_GPIO1			(PM8550B_SID << 8 | 0x0a)
-#define PM8550B_ADC5_GEN3_AMUX2_GPIO5			(PM8550B_SID << 8 | 0x0b)
-#define PM8550B_ADC5_GEN3_AMUX3_GPIO6			(PM8550B_SID << 8 | 0x0c)
-#define PM8550B_ADC5_GEN3_AMUX4_GPIO12			(PM8550B_SID << 8 | 0x0d)
-
-#define PM8550B_ADC5_GEN3_CHG_TEMP			(PM8550B_SID << 8 | 0x10)
-#define PM8550B_ADC5_GEN3_USB_SNS_V_16			(PM8550B_SID << 8 | 0x11)
-#define PM8550B_ADC5_GEN3_VIN_DIV16_MUX			(PM8550B_SID << 8 | 0x12)
-#define PM8550B_ADC5_GEN3_USBC_MUX			(PM8550B_SID << 8 | 0x13)
-#define PM8550B_ADC5_GEN3_VREF_BAT_THERM		(PM8550B_SID << 8 | 0x15)
-#define PM8550B_ADC5_GEN3_IIN_FB			(PM8550B_SID << 8 | 0x17)
-#define PM8550B_ADC5_GEN3_TEMP_ALARM_LITE		(PM8550B_SID << 8 | 0x18)
-#define PM8550B_ADC5_GEN3_SMB_IIN			(PM8550B_SID << 8 | 0x19)
-#define PM8550B_ADC5_GEN3_VREF_BAT2_THERM		(PM8550B_SID << 8 | 0x1a)
-#define PM8550B_ADC5_GEN3_SMB_ICHG			(PM8550B_SID << 8 | 0x1b)
-#define PM8550B_ADC5_GEN3_SMB_TEMP_I			(PM8550B_SID << 8 | 0x1e)
-#define PM8550B_ADC5_GEN3_CHG_TEMP_I			(PM8550B_SID << 8 | 0x1f)
-#define PM8550B_ADC5_GEN3_ICHG_FB			(PM8550B_SID << 8 | 0xa1)
-
-/* 30k pull-up */
-#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_30K_PU	(PM8550B_SID << 8 | 0x24)
-#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_30K_PU	(PM8550B_SID << 8 | 0x25)
-#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_30K_PU	(PM8550B_SID << 8 | 0x26)
-#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_30K_PU	(PM8550B_SID << 8 | 0x27)
-#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_30K_PU	(PM8550B_SID << 8 | 0x28)
-#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_30K_PU	(PM8550B_SID << 8 | 0x29)
-#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_30K_PU		(PM8550B_SID << 8 | 0x2a)
-#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_30K_PU		(PM8550B_SID << 8 | 0x2b)
-#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_30K_PU		(PM8550B_SID << 8 | 0x2c)
-#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_30K_PU		(PM8550B_SID << 8 | 0x2d)
-
-#define PM8550B_ADC5_GEN3_USBC_MUX_30K_PU		(PM8550B_SID << 8 | 0x33)
-
-/* 100k pull-up */
-#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_100K_PU	(PM8550B_SID << 8 | 0x44)
-#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_100K_PU	(PM8550B_SID << 8 | 0x45)
-#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_100K_PU	(PM8550B_SID << 8 | 0x46)
-#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_100K_PU	(PM8550B_SID << 8 | 0x47)
-#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_100K_PU	(PM8550B_SID << 8 | 0x48)
-#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_100K_PU	(PM8550B_SID << 8 | 0x49)
-#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_100K_PU		(PM8550B_SID << 8 | 0x4a)
-#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_100K_PU		(PM8550B_SID << 8 | 0x4b)
-#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_100K_PU		(PM8550B_SID << 8 | 0x4c)
-#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_100K_PU		(PM8550B_SID << 8 | 0x4d)
-
-#define PM8550B_ADC5_GEN3_USBC_MUX_100K_PU		(PM8550B_SID << 8 | 0x53)
-
-/* 400k pull-up */
-#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_400K_PU	(PM8550B_SID << 8 | 0x64)
-#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_400K_PU	(PM8550B_SID << 8 | 0x65)
-#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_400K_PU	(PM8550B_SID << 8 | 0x66)
-#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_400K_PU	(PM8550B_SID << 8 | 0x67)
-#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_400K_PU	(PM8550B_SID << 8 | 0x68)
-#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_400K_PU	(PM8550B_SID << 8 | 0x69)
-#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_400K_PU		(PM8550B_SID << 8 | 0x6a)
-#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_400K_PU		(PM8550B_SID << 8 | 0x6b)
-#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_400K_PU		(PM8550B_SID << 8 | 0x6c)
-#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_400K_PU		(PM8550B_SID << 8 | 0x6d)
-
-#define PM8550B_ADC5_GEN3_USBC_MUX_400K_PU		(PM8550B_SID << 8 | 0x73)
-
-/* 1/3 Divider */
-#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_DIV3		(PM8550B_SID << 8 | 0x8a)
-#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_DIV3		(PM8550B_SID << 8 | 0x8b)
-#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_DIV3		(PM8550B_SID << 8 | 0x8c)
-
-#define PM8550B_ADC5_GEN3_VPH_PWR			(PM8550B_SID << 8 | 0x8e)
-#define PM8550B_ADC5_GEN3_VBAT_SNS_QBG			(PM8550B_SID << 8 | 0x8f)
-#define PM8550B_ADC5_GEN3_VBAT_SNS_CHGR			(PM8550B_SID << 8 | 0x94)
-#define PM8550B_ADC5_GEN3_VBAT_2S_MID_QBG		(PM8550B_SID << 8 | 0x96)
-#define PM8550B_ADC5_GEN3_VBAT_2S_MID_CHGR		(PM8550B_SID << 8 | 0x9d)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h
deleted file mode 100644
index 337e13f7f56f..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H
-
-/* ADC channels for PM8550VX_ADC for PMIC5 Gen3 */
-#define PM8550VS_ADC5_GEN3_OFFSET_REF(sid)			((sid) << 8 | 0x00)
-#define PM8550VS_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | 0x01)
-#define PM8550VS_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | 0X02)
-#define PM8550VS_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | 0x03)
-
-#define PM8550VE_ADC5_GEN3_OFFSET_REF(sid)			((sid) << 8 | 0x00)
-#define PM8550VE_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | 0x01)
-#define PM8550VE_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | 0X02)
-#define PM8550VE_ADC5_GEN3_DIE_TEMP(sid)		((sid) << 8 | 0x03)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h
deleted file mode 100644
index 126fc16d5b20..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H
-
-#ifndef PMK8550_SID
-#define PMK8550_SID		0
-#endif
-
-/* ADC channels for PMK8550_ADC for PMIC5 Gen3 */
-#define PMK8550_ADC5_GEN3_OFFSET_REF			(PMK8550_SID << 8 | 0x00)
-#define PMK8550_ADC5_GEN3_1P25VREF			(PMK8550_SID << 8 | 0x01)
-#define PMK8550_ADC5_GEN3_VREF_VADC			(PMK8550_SID << 8 | 0x02)
-#define PMK8550_ADC5_GEN3_DIE_TEMP			(PMK8550_SID << 8 | 0x03)
-
-#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM		(PMK8550_SID << 8 | 0x04)
-#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1		(PMK8550_SID << 8 | 0x05)
-#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2		(PMK8550_SID << 8 | 0x06)
-#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3		(PMK8550_SID << 8 | 0x07)
-#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4		(PMK8550_SID << 8 | 0x08)
-#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5		(PMK8550_SID << 8 | 0x09)
-#define PMK8550_ADC5_GEN3_AMUX1_GPIO6			(PMK8550_SID << 8 | 0x0a)
-
-/* 30k pull-up */
-#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_30K_PU	(PMK8550_SID << 8 | 0x24)
-#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_30K_PU	(PMK8550_SID << 8 | 0x25)
-#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_30K_PU	(PMK8550_SID << 8 | 0x26)
-#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_30K_PU	(PMK8550_SID << 8 | 0x27)
-#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_30K_PU	(PMK8550_SID << 8 | 0x28)
-#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_30K_PU	(PMK8550_SID << 8 | 0x29)
-#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_30K_PU		(PMK8550_SID << 8 | 0x2a)
-
-/* 100k pull-up */
-#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_100K_PU	(PMK8550_SID << 8 | 0x44)
-#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_100K_PU	(PMK8550_SID << 8 | 0x45)
-#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_100K_PU	(PMK8550_SID << 8 | 0x46)
-#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_100K_PU	(PMK8550_SID << 8 | 0x47)
-#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_100K_PU	(PMK8550_SID << 8 | 0x48)
-#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_100K_PU	(PMK8550_SID << 8 | 0x49)
-#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_100K_PU		(PMK8550_SID << 8 | 0x4a)
-
-/* 400k pull-up */
-#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_400K_PU	(PMK8550_SID << 8 | 0x64)
-#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_400K_PU	(PMK8550_SID << 8 | 0x65)
-#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_400K_PU	(PMK8550_SID << 8 | 0x66)
-#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_400K_PU	(PMK8550_SID << 8 | 0x67)
-#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_400K_PU	(PMK8550_SID << 8 | 0x68)
-#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_400K_PU	(PMK8550_SID << 8 | 0x69)
-#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_400K_PU		(PMK8550_SID << 8 | 0x6a)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
deleted file mode 100644
index ca5a0a947b3b..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-vadc.h
+++ /dev/null
@@ -1,379 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_H
-
-/* Voltage ADC channels */
-#define VADC_USBIN				0x00
-#define VADC_DCIN				0x01
-#define VADC_VCHG_SNS				0x02
-#define VADC_SPARE1_03				0x03
-#define VADC_USB_ID_MV				0x04
-#define VADC_VCOIN				0x05
-#define VADC_VBAT_SNS				0x06
-#define VADC_VSYS				0x07
-#define VADC_DIE_TEMP				0x08
-#define VADC_REF_625MV				0x09
-#define VADC_REF_1250MV				0x0a
-#define VADC_CHG_TEMP				0x0b
-#define VADC_SPARE1				0x0c
-#define VADC_SPARE2				0x0d
-#define VADC_GND_REF				0x0e
-#define VADC_VDD_VADC				0x0f
-
-#define VADC_P_MUX1_1_1				0x10
-#define VADC_P_MUX2_1_1				0x11
-#define VADC_P_MUX3_1_1				0x12
-#define VADC_P_MUX4_1_1				0x13
-#define VADC_P_MUX5_1_1				0x14
-#define VADC_P_MUX6_1_1				0x15
-#define VADC_P_MUX7_1_1				0x16
-#define VADC_P_MUX8_1_1				0x17
-#define VADC_P_MUX9_1_1				0x18
-#define VADC_P_MUX10_1_1			0x19
-#define VADC_P_MUX11_1_1			0x1a
-#define VADC_P_MUX12_1_1			0x1b
-#define VADC_P_MUX13_1_1			0x1c
-#define VADC_P_MUX14_1_1			0x1d
-#define VADC_P_MUX15_1_1			0x1e
-#define VADC_P_MUX16_1_1			0x1f
-
-#define VADC_P_MUX1_1_3				0x20
-#define VADC_P_MUX2_1_3				0x21
-#define VADC_P_MUX3_1_3				0x22
-#define VADC_P_MUX4_1_3				0x23
-#define VADC_P_MUX5_1_3				0x24
-#define VADC_P_MUX6_1_3				0x25
-#define VADC_P_MUX7_1_3				0x26
-#define VADC_P_MUX8_1_3				0x27
-#define VADC_P_MUX9_1_3				0x28
-#define VADC_P_MUX10_1_3			0x29
-#define VADC_P_MUX11_1_3			0x2a
-#define VADC_P_MUX12_1_3			0x2b
-#define VADC_P_MUX13_1_3			0x2c
-#define VADC_P_MUX14_1_3			0x2d
-#define VADC_P_MUX15_1_3			0x2e
-#define VADC_P_MUX16_1_3			0x2f
-
-#define VADC_LR_MUX1_BAT_THERM			0x30
-#define VADC_LR_MUX2_BAT_ID			0x31
-#define VADC_LR_MUX3_XO_THERM			0x32
-#define VADC_LR_MUX4_AMUX_THM1			0x33
-#define VADC_LR_MUX5_AMUX_THM2			0x34
-#define VADC_LR_MUX6_AMUX_THM3			0x35
-#define VADC_LR_MUX7_HW_ID			0x36
-#define VADC_LR_MUX8_AMUX_THM4			0x37
-#define VADC_LR_MUX9_AMUX_THM5			0x38
-#define VADC_LR_MUX10_USB_ID			0x39
-#define VADC_AMUX_PU1				0x3a
-#define VADC_AMUX_PU2				0x3b
-#define VADC_LR_MUX3_BUF_XO_THERM		0x3c
-
-#define VADC_LR_MUX1_PU1_BAT_THERM		0x70
-#define VADC_LR_MUX2_PU1_BAT_ID			0x71
-#define VADC_LR_MUX3_PU1_XO_THERM		0x72
-#define VADC_LR_MUX4_PU1_AMUX_THM1		0x73
-#define VADC_LR_MUX5_PU1_AMUX_THM2		0x74
-#define VADC_LR_MUX6_PU1_AMUX_THM3		0x75
-#define VADC_LR_MUX7_PU1_AMUX_HW_ID		0x76
-#define VADC_LR_MUX8_PU1_AMUX_THM4		0x77
-#define VADC_LR_MUX9_PU1_AMUX_THM5		0x78
-#define VADC_LR_MUX10_PU1_AMUX_USB_ID		0x79
-#define VADC_LR_MUX3_BUF_PU1_XO_THERM		0x7c
-
-#define VADC_LR_MUX1_PU2_BAT_THERM		0xb0
-#define VADC_LR_MUX2_PU2_BAT_ID			0xb1
-#define VADC_LR_MUX3_PU2_XO_THERM		0xb2
-#define VADC_LR_MUX4_PU2_AMUX_THM1		0xb3
-#define VADC_LR_MUX5_PU2_AMUX_THM2		0xb4
-#define VADC_LR_MUX6_PU2_AMUX_THM3		0xb5
-#define VADC_LR_MUX7_PU2_AMUX_HW_ID		0xb6
-#define VADC_LR_MUX8_PU2_AMUX_THM4		0xb7
-#define VADC_LR_MUX9_PU2_AMUX_THM5		0xb8
-#define VADC_LR_MUX10_PU2_AMUX_USB_ID		0xb9
-#define VADC_LR_MUX3_BUF_PU2_XO_THERM		0xbc
-
-#define VADC_LR_MUX1_PU1_PU2_BAT_THERM		0xf0
-#define VADC_LR_MUX2_PU1_PU2_BAT_ID		0xf1
-#define VADC_LR_MUX3_PU1_PU2_XO_THERM		0xf2
-#define VADC_LR_MUX4_PU1_PU2_AMUX_THM1		0xf3
-#define VADC_LR_MUX5_PU1_PU2_AMUX_THM2		0xf4
-#define VADC_LR_MUX6_PU1_PU2_AMUX_THM3		0xf5
-#define VADC_LR_MUX7_PU1_PU2_AMUX_HW_ID		0xf6
-#define VADC_LR_MUX8_PU1_PU2_AMUX_THM4		0xf7
-#define VADC_LR_MUX9_PU1_PU2_AMUX_THM5		0xf8
-#define VADC_LR_MUX10_PU1_PU2_AMUX_USB_ID	0xf9
-#define VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM	0xfc
-
-/* ADC channels for SPMI PMIC5 */
-
-#define ADC5_REF_GND				0x00
-#define ADC5_1P25VREF				0x01
-#define ADC5_VREF_VADC				0x02
-#define ADC5_VREF_VADC5_DIV_3			0x82
-#define ADC5_VPH_PWR				0x83
-#define ADC5_VBAT_SNS				0x84
-#define ADC5_VCOIN				0x85
-#define ADC5_DIE_TEMP				0x06
-#define ADC5_USB_IN_I				0x07
-#define ADC5_USB_IN_V_16			0x08
-#define ADC5_CHG_TEMP				0x09
-#define ADC5_BAT_THERM				0x0a
-#define ADC5_BAT_ID				0x0b
-#define ADC5_XO_THERM				0x0c
-#define ADC5_AMUX_THM1				0x0d
-#define ADC5_AMUX_THM2				0x0e
-#define ADC5_AMUX_THM3				0x0f
-#define ADC5_AMUX_THM4				0x10
-#define ADC5_AMUX_THM5				0x11
-#define ADC5_GPIO1				0x12
-#define ADC5_GPIO2				0x13
-#define ADC5_GPIO3				0x14
-#define ADC5_GPIO4				0x15
-#define ADC5_GPIO5				0x16
-#define ADC5_GPIO6				0x17
-#define ADC5_GPIO7				0x18
-#define ADC5_SBUx				0x99
-#define ADC5_MID_CHG_DIV6			0x1e
-#define ADC5_OFF				0xff
-
-/* 30k pull-up1 */
-#define ADC5_BAT_THERM_30K_PU			0x2a
-#define ADC5_BAT_ID_30K_PU			0x2b
-#define ADC5_XO_THERM_30K_PU			0x2c
-#define ADC5_AMUX_THM1_30K_PU			0x2d
-#define ADC5_AMUX_THM2_30K_PU			0x2e
-#define ADC5_AMUX_THM3_30K_PU			0x2f
-#define ADC5_AMUX_THM4_30K_PU			0x30
-#define ADC5_AMUX_THM5_30K_PU			0x31
-#define ADC5_GPIO1_30K_PU			0x32
-#define ADC5_GPIO2_30K_PU			0x33
-#define ADC5_GPIO3_30K_PU			0x34
-#define ADC5_GPIO4_30K_PU			0x35
-#define ADC5_GPIO5_30K_PU			0x36
-#define ADC5_GPIO6_30K_PU			0x37
-#define ADC5_GPIO7_30K_PU			0x38
-#define ADC5_SBUx_30K_PU			0x39
-
-/* 100k pull-up2 */
-#define ADC5_BAT_THERM_100K_PU			0x4a
-#define ADC5_BAT_ID_100K_PU			0x4b
-#define ADC5_XO_THERM_100K_PU			0x4c
-#define ADC5_AMUX_THM1_100K_PU			0x4d
-#define ADC5_AMUX_THM2_100K_PU			0x4e
-#define ADC5_AMUX_THM3_100K_PU			0x4f
-#define ADC5_AMUX_THM4_100K_PU			0x50
-#define ADC5_AMUX_THM5_100K_PU			0x51
-#define ADC5_GPIO1_100K_PU			0x52
-#define ADC5_GPIO2_100K_PU			0x53
-#define ADC5_GPIO3_100K_PU			0x54
-#define ADC5_GPIO4_100K_PU			0x55
-#define ADC5_GPIO5_100K_PU			0x56
-#define ADC5_GPIO6_100K_PU			0x57
-#define ADC5_GPIO7_100K_PU			0x58
-#define ADC5_SBUx_100K_PU			0x59
-
-/* 400k pull-up3 */
-#define ADC5_BAT_THERM_400K_PU			0x6a
-#define ADC5_BAT_ID_400K_PU			0x6b
-#define ADC5_XO_THERM_400K_PU			0x6c
-#define ADC5_AMUX_THM1_400K_PU			0x6d
-#define ADC5_AMUX_THM2_400K_PU			0x6e
-#define ADC5_AMUX_THM3_400K_PU			0x6f
-#define ADC5_AMUX_THM4_400K_PU			0x70
-#define ADC5_AMUX_THM5_400K_PU			0x71
-#define ADC5_GPIO1_400K_PU			0x72
-#define ADC5_GPIO2_400K_PU			0x73
-#define ADC5_GPIO3_400K_PU			0x74
-#define ADC5_GPIO4_400K_PU			0x75
-#define ADC5_GPIO5_400K_PU			0x76
-#define ADC5_GPIO6_400K_PU			0x77
-#define ADC5_GPIO7_400K_PU			0x78
-#define ADC5_SBUx_400K_PU			0x79
-
-/* 1/3 Divider */
-#define ADC5_GPIO1_DIV3				0x92
-#define ADC5_GPIO2_DIV3				0x93
-#define ADC5_GPIO3_DIV3				0x94
-#define ADC5_GPIO4_DIV3				0x95
-#define ADC5_GPIO5_DIV3				0x96
-#define ADC5_GPIO6_DIV3				0x97
-#define ADC5_GPIO7_DIV3				0x98
-#define ADC5_SBUx_DIV3				0x99
-
-/* Current and combined current/voltage channels */
-#define ADC5_INT_EXT_ISENSE			0xa1
-#define ADC5_PARALLEL_ISENSE			0xa5
-#define ADC5_CUR_REPLICA_VDS			0xa7
-#define ADC5_CUR_SENS_BATFET_VDS_OFFSET		0xa9
-#define ADC5_CUR_SENS_REPLICA_VDS_OFFSET	0xab
-#define ADC5_EXT_SENS_OFFSET			0xad
-
-#define ADC5_INT_EXT_ISENSE_VBAT_VDATA		0xb0
-#define ADC5_INT_EXT_ISENSE_VBAT_IDATA		0xb1
-#define ADC5_EXT_ISENSE_VBAT_VDATA		0xb2
-#define ADC5_EXT_ISENSE_VBAT_IDATA		0xb3
-#define ADC5_PARALLEL_ISENSE_VBAT_VDATA		0xb4
-#define ADC5_PARALLEL_ISENSE_VBAT_IDATA		0xb5
-
-#define ADC5_MAX_CHANNEL			0xc0
-
-/* ADC channels for ADC for PMIC5 Gen2 */
-
-#define ADC5_GEN2_REF_GND				0x00
-#define ADC5_GEN2_1P25VREF				0x01
-#define ADC5_GEN2_VREF_VADC				0x02
-#define ADC5_GEN2_DIE_TEMP				0x03
-
-#define ADC5_GEN2_AMUX_THM1				0x04
-#define ADC5_GEN2_AMUX_THM2				0x05
-#define ADC5_GEN2_AMUX_THM3				0x06
-#define ADC5_GEN2_AMUX_THM4				0x07
-#define ADC5_GEN2_AMUX_THM5				0x08
-#define ADC5_GEN2_AMUX_THM6				0x09
-#define ADC5_GEN2_GPIO1				0x0a
-#define ADC5_GEN2_GPIO2				0x0b
-#define ADC5_GEN2_GPIO3				0x0c
-#define ADC5_GEN2_GPIO4				0x0d
-
-#define ADC5_GEN2_CHG_TEMP				0x10
-#define ADC5_GEN2_USB_IN_V_16			0x11
-#define ADC5_GEN2_VDC_16				0x12
-#define ADC5_GEN2_CC1_ID				0x13
-#define ADC5_GEN2_VREF_BAT_THERM			0x15
-#define ADC5_GEN2_IIN_FB				0x17
-
-/* 30k pull-up1 */
-#define ADC5_GEN2_AMUX_THM1_30K_PU			0x24
-#define ADC5_GEN2_AMUX_THM2_30K_PU			0x25
-#define ADC5_GEN2_AMUX_THM3_30K_PU			0x26
-#define ADC5_GEN2_AMUX_THM4_30K_PU			0x27
-#define ADC5_GEN2_AMUX_THM5_30K_PU			0x28
-#define ADC5_GEN2_AMUX_THM6_30K_PU			0x29
-#define ADC5_GEN2_GPIO1_30K_PU			0x2a
-#define ADC5_GEN2_GPIO2_30K_PU			0x2b
-#define ADC5_GEN2_GPIO3_30K_PU			0x2c
-#define ADC5_GEN2_GPIO4_30K_PU			0x2d
-#define ADC5_GEN2_CC1_ID_30K_PU			0x33
-
-/* 100k pull-up2 */
-#define ADC5_GEN2_AMUX_THM1_100K_PU			0x44
-#define ADC5_GEN2_AMUX_THM2_100K_PU			0x45
-#define ADC5_GEN2_AMUX_THM3_100K_PU			0x46
-#define ADC5_GEN2_AMUX_THM4_100K_PU			0x47
-#define ADC5_GEN2_AMUX_THM5_100K_PU			0x48
-#define ADC5_GEN2_AMUX_THM6_100K_PU			0x49
-#define ADC5_GEN2_GPIO1_100K_PU			0x4a
-#define ADC5_GEN2_GPIO2_100K_PU			0x4b
-#define ADC5_GEN2_GPIO3_100K_PU			0x4c
-#define ADC5_GEN2_GPIO4_100K_PU			0x4d
-#define ADC5_GEN2_CC1_ID_100K_PU			0x53
-
-/* 400k pull-up3 */
-#define ADC5_GEN2_AMUX_THM1_400K_PU			0x64
-#define ADC5_GEN2_AMUX_THM2_400K_PU			0x65
-#define ADC5_GEN2_AMUX_THM3_400K_PU			0x66
-#define ADC5_GEN2_AMUX_THM4_400K_PU			0x67
-#define ADC5_GEN2_AMUX_THM5_400K_PU			0x68
-#define ADC5_GEN2_AMUX_THM6_400K_PU			0x69
-#define ADC5_GEN2_GPIO1_400K_PU			0x6a
-#define ADC5_GEN2_GPIO2_400K_PU			0x6b
-#define ADC5_GEN2_GPIO3_400K_PU			0x6c
-#define ADC5_GEN2_GPIO4_400K_PU			0x6d
-#define ADC5_GEN2_CC1_ID_400K_PU			0x73
-
-/* 1/3 Divider */
-#define ADC5_GEN2_GPIO1_DIV3				0x8a
-#define ADC5_GEN2_GPIO2_DIV3				0x8b
-#define ADC5_GEN2_GPIO3_DIV3				0x8c
-#define ADC5_GEN2_GPIO4_DIV3				0x8d
-
-#define ADC5_GEN2_VPH_PWR				0x8e
-#define ADC5_GEN2_VBAT_SNS				0x8f
-
-#define ADC5_GEN2_SBUx				0x94
-#define ADC5_GEN2_VBAT_2S_MID			0x96
-
-/* ADC channels for PMIC5 Gen3 */
-
-#define ADC5_GEN3_OFFSET_REF			0x00
-#define ADC5_GEN3_1P25VREF			0x01
-#define ADC5_GEN3_VREF_VADC			0x02
-#define ADC5_GEN3_DIE_TEMP			0x03
-
-#define ADC5_GEN3_AMUX1_THM			0x04
-#define ADC5_GEN3_AMUX2_THM			0x05
-#define ADC5_GEN3_AMUX3_THM			0x06
-#define ADC5_GEN3_AMUX4_THM			0x07
-#define ADC5_GEN3_AMUX5_THM			0x08
-#define ADC5_GEN3_AMUX6_THM			0x09
-#define ADC5_GEN3_AMUX1_GPIO			0x0a
-#define ADC5_GEN3_AMUX2_GPIO			0x0b
-#define ADC5_GEN3_AMUX3_GPIO			0x0c
-#define ADC5_GEN3_AMUX4_GPIO			0x0d
-
-#define ADC5_GEN3_CHG_TEMP			0x10
-#define ADC5_GEN3_USB_SNS_V_16			0x11
-#define ADC5_GEN3_VIN_DIV16_MUX			0x12
-#define ADC5_GEN3_VREF_BAT_THERM		0x15
-#define ADC5_GEN3_IIN_FB			0x17
-#define ADC5_GEN3_TEMP_ALARM_LITE		0x18
-#define ADC5_GEN3_IIN_SMB			0x19
-#define ADC5_GEN3_ICHG_SMB			0x1b
-#define ADC5_GEN3_ICHG_FB			0xa1
-
-/* 30k pull-up1 */
-#define ADC5_GEN3_AMUX1_THM_30K_PU		0x24
-#define ADC5_GEN3_AMUX2_THM_30K_PU		0x25
-#define ADC5_GEN3_AMUX3_THM_30K_PU		0x26
-#define ADC5_GEN3_AMUX4_THM_30K_PU		0x27
-#define ADC5_GEN3_AMUX5_THM_30K_PU		0x28
-#define ADC5_GEN3_AMUX6_THM_30K_PU		0x29
-#define ADC5_GEN3_AMUX1_GPIO_30K_PU		0x2a
-#define ADC5_GEN3_AMUX2_GPIO_30K_PU		0x2b
-#define ADC5_GEN3_AMUX3_GPIO_30K_PU		0x2c
-#define ADC5_GEN3_AMUX4_GPIO_30K_PU		0x2d
-
-/* 100k pull-up2 */
-#define ADC5_GEN3_AMUX1_THM_100K_PU		0x44
-#define ADC5_GEN3_AMUX2_THM_100K_PU		0x45
-#define ADC5_GEN3_AMUX3_THM_100K_PU		0x46
-#define ADC5_GEN3_AMUX4_THM_100K_PU		0x47
-#define ADC5_GEN3_AMUX5_THM_100K_PU		0x48
-#define ADC5_GEN3_AMUX6_THM_100K_PU		0x49
-#define ADC5_GEN3_AMUX1_GPIO_100K_PU		0x4a
-#define ADC5_GEN3_AMUX2_GPIO_100K_PU		0x4b
-#define ADC5_GEN3_AMUX3_GPIO_100K_PU		0x4c
-#define ADC5_GEN3_AMUX4_GPIO_100K_PU		0x4d
-
-/* 400k pull-up3 */
-#define ADC5_GEN3_AMUX1_THM_400K_PU		0x64
-#define ADC5_GEN3_AMUX2_THM_400K_PU		0x65
-#define ADC5_GEN3_AMUX3_THM_400K_PU		0x66
-#define ADC5_GEN3_AMUX4_THM_400K_PU		0x67
-#define ADC5_GEN3_AMUX5_THM_400K_PU		0x68
-#define ADC5_GEN3_AMUX6_THM_400K_PU		0x69
-#define ADC5_GEN3_AMUX1_GPIO_400K_PU		0x6a
-#define ADC5_GEN3_AMUX2_GPIO_400K_PU		0x6b
-#define ADC5_GEN3_AMUX3_GPIO_400K_PU		0x6c
-#define ADC5_GEN3_AMUX4_GPIO_400K_PU		0x6d
-
-/* 1/3 Divider */
-#define ADC5_GEN3_AMUX1_GPIO_DIV3		0x8a
-#define ADC5_GEN3_AMUX2_GPIO_DIV3		0x8b
-#define ADC5_GEN3_AMUX3_GPIO_DIV3		0x8c
-
-#define ADC5_GEN3_VPH_PWR			0x8e
-#define ADC5_GEN3_VBAT_SNS_QBG			0x8f
-
-#define ADC5_GEN3_VBAT_SNS_CHGR			0x94
-#define ADC5_GEN3_VBAT_2S_MID_QBG		0x96
-#define ADC5_GEN3_VBAT_2S_MID_CHGR		0x9d
-
-#define ADC5_GEN3_OFFSET_EXT2			0xf8
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_H */
-- 
2.25.1

