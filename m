Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F436D7D2C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbjDENAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbjDEM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:59:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15657659D;
        Wed,  5 Apr 2023 05:59:35 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335Am5No023262;
        Wed, 5 Apr 2023 12:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=BqN9zlJwlI3rSKgFUWuUraYXooqS7PR+lq7p9K+ZW9k=;
 b=ovV7+bQOzVAwnQPfWk/o1rS9TNuHCuVTlrCHoysPEUC1DL7wfavnA1JaudklS/q1bmId
 VKM6IuPUwKbQ0UcQqZPd274/b2J98ksmw899p1t5gBVvko42OC5xg9Rc0iIluSfesVKf
 pNFkSX9g0ywgKUsb/y99Cr+FiF+xEF5rP1Bc9krzbWJv+weSryx0aJcziibzXV8P+Jge
 S40EYPh5+OJWa9b2hm9u+bv5GsS50RYv3OPpKpFD4Wr4TDv92n3fiu1ROcDAGSmxHHqs
 WGKpthtFqi7FqPRM/wN1K9kZPenJ2oh/E6GtqSX9Vzh4D012YJKvdOE/dmXG6GZlh2iF 9Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prppujjbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 12:59:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335CxCOa010624
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 12:59:12 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 05:59:06 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v6 7/8] arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB ports
Date:   Wed, 5 Apr 2023 18:27:58 +0530
Message-ID: <20230405125759.4201-8-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405125759.4201-1-quic_kriskura@quicinc.com>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zbjTvuYgPgRikoeRuWdccTL1UIIJehdC
X-Proofpoint-ORIG-GUID: zbjTvuYgPgRikoeRuWdccTL1UIIJehdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_08,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=666 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050118
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable tertiary controller for SA8295P (based on SC8280XP).
Add pinctrl support for usb ports to provide VBUS to connected peripherals.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Link to v5: https://lore.kernel.org/all/20230310163420.7582-8-quic_kriskura@quicinc.com/

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 47 ++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index fd253942e5e5..7e6061c43835 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -584,6 +584,19 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&usb_2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_en_state>,
+			<&usb3_en_state>,
+			<&usb4_en_state>,
+			<&usb5_en_state>;
+	status = "okay";
+};
+
+&usb_2_dwc3 {
+	dr_mode = "host";
+};
+
 &usb_2_hsphy0 {
 	vdda-pll-supply = <&vreg_l5a>;
 	vdda18-supply = <&vreg_l7g>;
@@ -729,3 +742,37 @@ wake-n-pins {
 		};
 	};
 };
+
+&pmm8540c_gpios {
+	usb2_en_state: usb2-en-state {
+		pins = "gpio9";
+		function = "normal";
+		output-high;
+		power-source = <0>;
+	};
+};
+
+&pmm8540e_gpios {
+	usb3_en_state: usb3-en-state {
+		pins = "gpio5";
+		function = "normal";
+		output-high;
+		power-source = <0>;
+	};
+};
+
+&pmm8540g_gpios {
+	usb4_en_state: usb4-en-state {
+		pins = "gpio5";
+		function = "normal";
+		output-high;
+		power-source = <0>;
+	};
+
+	usb5_en_state: usb5-en-state {
+		pins = "gpio9";
+		function = "normal";
+		output-high;
+		power-source = <0>;
+	};
+};
-- 
2.40.0

