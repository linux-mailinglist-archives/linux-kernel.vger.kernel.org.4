Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775A9623C68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiKJHIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiKJHIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:08:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD4531376;
        Wed,  9 Nov 2022 23:08:43 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AA6SVCw018102;
        Thu, 10 Nov 2022 07:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=jsDth2khnliRLU44iQ7XLuDUNqjpD61W0t0bVnckekM=;
 b=AHOQxljvzWYfdsfpHgSeXVmdfr0vLfYay2Kk//HLM8sCY3128wpsNBNU+17eUvcvrknF
 8HRjChGb3cSc9BzmkIYHwxBRW5jnH11p7z0lVMpEXLHdf3xhLDufLCAfIa3VHik8QW9w
 kyGHzpoYAWB9fVJv00/B8248zv8z2hv5+Qjr1SOsv5SH8Bcz9cIhQQHfaCMxtrrn9idK
 BCCy4jQop+TxuX8/w1Uhye6YnkDZYcJtiOnPaPFa0XpZbgcrnuavx4khGsLXoNPWRBCl
 QckoEZPaP7730OAf9nv3qeOnjuloQUgQw8tVNmNH0N+ODBzOj8dujBzAiVZLjXQdKRsu OQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kruprg3h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 07:08:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AA78XeL010583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 07:08:33 GMT
Received: from blr-ubuntu-311.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 9 Nov 2022 23:08:29 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <dianders@chromium.org>,
        <jinghung.chen3@hotmail.com>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V4 1/2] arm64: dts: qcom: sc7280: Mark all Qualcomm reference boards as LTE
Date:   Thu, 10 Nov 2022 12:38:12 +0530
Message-ID: <20221110070813.1777-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y4L8UBUCOUF_cWCU4jrCyMGRKqanlpTI
X-Proofpoint-GUID: y4L8UBUCOUF_cWCU4jrCyMGRKqanlpTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=752 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the modem node was re-located to a separate LTE source file
"sc7280-herobrine-lte-sku.dtsi", some of the previous LTE users
weren't marked appropriately. Fix this by marking all Qualcomm
reference devices as LTE.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Fixes: d42fae738f3a ("arm64: dts: qcom: Add LTE SKUs for sc7280-villager family")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v4:
 * Remove duplicate lte source file [Doug]

v3:
 * Fix incorrect tag usage [Krzysztof]

 arch/arm64/boot/dts/qcom/sc7280-idp.dts  | 1 -
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 9ddfdfdd354e..ba64316b4427 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -10,7 +10,6 @@
 #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include "sc7280-idp.dtsi"
 #include "pmr735a.dtsi"
-#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 1ac7c091e03f..8ca228111681 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -13,6 +13,7 @@
 #include "pmk8350.dtsi"
 
 #include "sc7280-chrome-common.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	aliases {
-- 
2.17.1

