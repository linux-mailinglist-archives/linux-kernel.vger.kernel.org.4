Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2479E6D778E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbjDEI5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbjDEI5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:57:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706C82D72;
        Wed,  5 Apr 2023 01:57:41 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3357BD4i025649;
        Wed, 5 Apr 2023 08:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ChqmUJrlRTEyWBsDOBatmTkEdc/WMissf/EhuQoASVo=;
 b=Ib14UIUstfa8a0PyPCJwkBA/PEeCZtFGxAMOCORmJvj+ZGTaD2JgpeNvtu/4btKs6hYD
 kDlAy0hUQPGT0qcI1LBr59JAWEs6bIjx/13XcmkX4afLuV9RK2QmewrRio/56ykzHt3/
 I3+omC4sG5H0BgsbiD/UnMOj6WDwiFB7iJvJ/BonmY6HUAD2YTzOZO4COZC+6TFzBaVK
 Rj2V1yLKtMTv5q9YGirG79A3ZhAcbNpa3Zsu9oeysMWVWnE6PaL5dONakY2gfoUE1Wch
 0GO3ZueE2lDxFnSk4pP5TmeaUghD7sH0ef6Y/4cZY7LiLJQv0tnsByJPdcOldMZefNGn +A== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prmkmthjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 08:57:12 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3358vBDl012946
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 08:57:11 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 01:57:04 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v6 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3 PHY
Date:   Wed, 5 Apr 2023 14:26:37 +0530
Message-ID: <b8a802ca423281649ad529b3aa455aee04a4d0df.1680682939.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1680682939.git.quic_varada@quicinc.com>
References: <cover.1680682939.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4hC2v3DHmQp07p7PLJZGCQBIvCUf42PS
X-Proofpoint-ORIG-GUID: 4hC2v3DHmQp07p7PLJZGCQBIvCUf42PS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_04,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=974 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050080
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Changes in v6:
	- Made power-domains optional

Note: In the earlier patch sets, had used the (legacy)
specification available in qcom,msm8996-qmp-usb3-phy.yaml. Moved
to newer specification in qcom,sc8280xp-qmp-usb3-uni-phy.yaml
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index 16fce10..0c0a548 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,ipq9574-qmp-usb3-phy
       - qcom,sc8280xp-qmp-usb3-uni-phy
 
   reg:
@@ -60,7 +61,6 @@ required:
   - reg
   - clocks
   - clock-names
-  - power-domains
   - resets
   - reset-names
   - vdda-phy-supply
-- 
2.7.4

