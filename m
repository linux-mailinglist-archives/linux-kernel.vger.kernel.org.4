Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D34654CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiLWHea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWHeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:34:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8588316488;
        Thu, 22 Dec 2022 23:34:24 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BN5NcG5025206;
        Fri, 23 Dec 2022 07:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=U4eZB36qW05d1rIds4PBq70CCXyE6zlxu1m79zPhVo4=;
 b=R9L0LmXJ/km1WcUTKFTq/sTi8QC94Xh/sLYHqqiqnXvvw7o+4NEDvrMiDOgPLkHqp8ht
 pLAOXNxReTAsTl0SAnyg6IH7zSE+XKd3IZqh+5ud2z8a8k7pJ7MVtC/uH1VTGpXX1KNO
 dUH2qpoxrSHVUqGMsNHOcs4qjbM+ojxKQFz8lzoiJsYEEP6lJmK+99EE9+wLlSsTsv+d
 DXA5HYnEFNIuhw/gRiZiKD7yTbCXF07x2rdG2Nyz29r31gA17MXl4nb1Y0aBSxVhZ+IX
 WJ+GI+merdz8hOICxa7uRDaMrk06UVuj/HOuvV7rvPyeJidYQgTi+L2p8GSGxbYvbMm8 0Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm2brvm2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 07:34:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BN7YGfA017271
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 07:34:16 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 23:34:12 -0800
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <quic_mpubbise@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Youghandhar Chintala" <quic_youghand@quicinc.com>
Subject: [PATCH v2] arm64: dts: qcom: sc7280: Add wifi alias for SC7280-idp
Date:   Fri, 23 Dec 2022 13:03:53 +0530
Message-ID: <20221223073353.20612-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UVBOUgLjFo7fZsVpsedK-VHJn178dYKc
X-Proofpoint-GUID: UVBOUgLjFo7fZsVpsedK-VHJn178dYKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_02,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=838 adultscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212230064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the boot loader code used in the SC7280 SoC accesses
the WiFi node using node names (wifi@<addr>). Since the bootloader
is a common code that is used in SoCs having different WiFi chipsets,
it is better if the bootloader code accesses the WiFi node using
a WiFi alias. The advantage of this method is that the boot loader
code need not be changed for every new WiFi chip.
Therefore, add wifi alias entry for SC7280-idp device tree

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
V2:
 -Added purpose of this in the commit message
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

