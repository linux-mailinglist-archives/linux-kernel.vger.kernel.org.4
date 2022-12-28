Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2456574D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiL1Jlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiL1Jlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:41:39 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15747BC;
        Wed, 28 Dec 2022 01:41:38 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BS8Ipc8022054;
        Wed, 28 Dec 2022 09:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=HC+PlKiZ9c6c5DVqKyRgOzNHRWEIDjf4RJFNK6ueRKg=;
 b=DhZITVLVNE2HSSzH1HUWkHRzPRloizd0TowSERd9xPXLd/qol7A/exMGHr6bpV2FhIPx
 QsVfbLMULMPBTygkTI4ae0TnWtKZCKBL7g9H8Ytxm1wBEqxJ15SO3pfbdLUYl6NSJdXp
 XSq2X+5Vs6CxZNi+rFQ50g4RIEuFUPQ+jzaYJ8I5+V5vVz8qM5iJX1mRv45Dy74sqvSD
 UL1jt754WciwYUDBM2vGVcvVaZveqD04MZg0eUcSuyVDDr40MOvGepIY3j9JjwJMlgh3
 rMrF+wp6VJXykRyb8Wm8BYzk1eYVXpM2e5WIAyXuYOEX6aKwNtUAqK8+193WlDJ1jELk Ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mrau40r3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 09:41:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BS9fQ5N027282
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 09:41:26 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 28 Dec 2022 01:41:22 -0800
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mpubbise@quicinc.com>,
        "Youghandhar Chintala" <quic_youghand@quicinc.com>
Subject: [PATCH v3] arm64: dts: qcom: sc7280: Add wifi alias for SC7280-idp
Date:   Wed, 28 Dec 2022 15:11:03 +0530
Message-ID: <20221228094104.356-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0WoLkioMywfVj8jWvndvwaONg9eP6jfl
X-Proofpoint-ORIG-GUID: 0WoLkioMywfVj8jWvndvwaONg9eP6jfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_06,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=798 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212280080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, depth-charge Chrome OS bootloader code used in the SC7280
SoC accesses the WiFi node using node names (wifi@<addr>). Since
depth-charge Chrome OS bootloader is a common code that is used in
SoCs having different WiFi chipsets, it is better if the depth-charge
Chrome OS bootloader code accesses the WiFi node using a WiFi alias.
The advantage of this method is that the depth-charge Chrome OS
bootloader code need not be changed for every new WiFi chip.
Therefore, add wifi alias entry for SC7280-idp device tree.

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
V3:
 - Replaced bootloader with Depth-charge Chrome OS bootloader
   in the commit message
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index cd432a2856a7..c4f88d7b3758 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -18,6 +18,7 @@ / {
 	aliases {
 		bluetooth0 = &bluetooth;
 		serial1 = &uart7;
+		wifi0 = &wifi;
 	};
 
 	max98360a: audio-codec-0 {
-- 
2.38.0

