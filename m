Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126CD6B4D48
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjCJQiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCJQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:37:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87544B776;
        Fri, 10 Mar 2023 08:35:36 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ADccxF006002;
        Fri, 10 Mar 2023 16:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=X25k0ljmd07bmkdZ/R1kKNVU+KtTLV92UgIrOURq3sg=;
 b=Rq84zF6cbbGGwgbUx4bWiF7kpp87Dbcgt6rYABDVXFsAsj7FRy0E24/ynbd+jiMbM3vC
 XEtKBqxaG4tsBZOKysHeq22wjiYfV7zWYy65wJPY1dGrXAcXNKRFEwAmryh92Qk88ixh
 yHY57rF5bGS2pV+c+7wuIBo1Ev0GKdpERwqpHMikTY+UN3aEzMIk54QULfhoEOcDvIr7
 WxDxPjl+XPwwyZaCc+Oe+DZcEJ8eu3EndBioX9KamHEvJvp8wV1bSOTfN30LOEkheEkG
 CEuH2P636A7/Q2sLVvOx/X9/A1F27SHw1xxCUdKgU24KEQ2RYmedTl1HdtxZijmPITls hg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7jutu3d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 16:35:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32AGZQGr000810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 16:35:26 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 10 Mar 2023 08:35:20 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH 8/8] arm64: dts: qcom: sa8540-ride: Enable first port of teritiary usb controller
Date:   Fri, 10 Mar 2023 22:04:20 +0530
Message-ID: <20230310163420.7582-9-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230310163420.7582-1-quic_kriskura@quicinc.com>
References: <20230310163420.7582-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SS672G8MjsPXXfB0eExUSBmgSz8QjXEZ
X-Proofpoint-ORIG-GUID: SS672G8MjsPXXfB0eExUSBmgSz8QjXEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_08,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=960 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100131
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable first port of Quad port Teritiary USB controller for SA8540 Ride.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 3ccb5ffdb3ca..46e9ca9c666e 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -309,6 +309,19 @@ &usb_2_qmpphy0 {
 	status = "okay";
 };
 
+&usb_2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_en_state>;
+
+	status = "okay";
+};
+
+&usb_2_dwc3 {
+	dr_mode = "host";
+	phy-names = "usb2-port0", "usb3-port0";
+	phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
@@ -401,4 +414,13 @@ wake-pins {
 			bias-pull-up;
 		};
 	};
+
+	usb2_en_state: usb2-en-state {
+		/* TS3USB221A USB2.0 mux select */
+		pins = "gpio24";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
 };
-- 
2.39.0

