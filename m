Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93276FC5A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjEIL4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjEIL4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:56:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0695B49C2;
        Tue,  9 May 2023 04:55:41 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3498Njc0010792;
        Tue, 9 May 2023 11:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=2DEuaB+0Kvgjo/S0/NlOOfk9vDVowCbiMci8l0m/HWQ=;
 b=ai4Tz1O4Vo45n9hNfF3fIPhnmUGDRwpp9pJ2HEDdajkPsQuMg5wZZYEX1sdcJL31eS/H
 Qo4tsUSNyRSr/wrDldRJUo82Ub6zcanGX2hTu0BWHAbdu4YlHxPpaFJJpvqGiYrQt5qI
 pLUXoUXbCKkzTpl5ADzcanoO3fZ2PMD4YOQu2hQ4Sk/WWnWWGzjBzTkSk6lJ5rh6LvwL
 1DADkzFIGRzaYJZP2aKgjzo686OTrVn+Ms1Gnvm+lBYumTdjLbxSv1ZCiFM+fHPlN+Kn
 g+RJSU8C0XeZtBgF3JmX3kqZ7n0AE4r0lD3INX/R96a4/98UMCkpT5yHPrpMTMxDaxMF IA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf78pskke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 11:55:10 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349Bt9fg015776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 11:55:10 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 04:55:04 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v11 9/9] arm64: dts: qcom: ipq9574: Enable USB
Date:   Tue, 9 May 2023 17:24:09 +0530
Message-ID: <1691872a83758cb65053dce7001e96e88dbeed2a.1683630932.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1683630932.git.quic_varada@quicinc.com>
References: <cover.1683630932.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fD4avqo5DRB3IqlOVr9CjVBt-ctpVdjx
X-Proofpoint-GUID: fD4avqo5DRB3IqlOVr9CjVBt-ctpVdjx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 mlxlogscore=689 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305090095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn on USB related nodes
Provide vdd info

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Changes in v11:
	- Rename dwc_0 -> usb_0_dwc3
	- Maintain sorted order for the usb nodes

 Changes in v10:
	- Provide vdd info

 Changes in v5:
	- Move "host" mode specification to board dts
	- Due to dependency with earlier patches board dts
	  filename changed ipq9574-al02-c7.dts -> ipq9574-rdp433.dts

 Changes in v2:
	- Fix node placement and coding style
	- "ok" -> "okay"
---
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 1f5d14f..ea38098 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -188,6 +188,29 @@
 	};
 };
 
+&usb_0_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_0_qmpphy {
+	vdda-pll-supply = <&mp5496_l2>;
+	vdda-phy-supply = <&fixed_0p925>;
+
+	status = "okay";
+};
+
+&usb_0_qusbphy {
+	vdd-supply = <&fixed_0p925>;
+	vdda-pll-supply = <&mp5496_l2>;
+	vdda-phy-dpdm-supply = <&fixed_3p3>;
+
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <24000000>;
 };
-- 
2.7.4

