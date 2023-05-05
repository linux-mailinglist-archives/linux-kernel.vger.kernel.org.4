Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B5E6F7EDF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjEEIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjEEIXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:23:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CF117FF5;
        Fri,  5 May 2023 01:23:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3458BdVp013141;
        Fri, 5 May 2023 08:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FtwnUZ36Lc0zaZTvI3cx1AAnpycwroNKm1a/0KFDusY=;
 b=aB5PkICTOduH31NZz57HHQ3hDA4grxbHh1bK6p13X7WAtRliEjRFmCjFjFcXOdPX8LSl
 bZZ1zTd22FyXDbdQXfDBa7PCv4EtFBiLZUQywjHryX3Ndb4Z2gV8UFZgA1yfomRvniVi
 ATIQw72CMMydjeM7y7mkgH7zPj5YUGUspPHHPfMbKAtjgnRbGEgHCJTz6KkqdA28hl7x
 in685+9lseZdcCw+600tGy3+0yb3kvbKSwSjzNCsOJRC3plTf92NYANK06Sojq7q6Yef
 aqXqTYy9y7FFvuQt17y1KXEj6etx5Q9PAO+1nKoV2ILb97wZCHQ6BcJWPt1rwHRTg1Mq Eg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcmm391g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 08:22:56 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3458MtWo016951
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 08:22:55 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 5 May 2023 01:22:50 -0700
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
Subject: [PATCH v10 9/9] arm64: dts: qcom: ipq9574: Enable USB
Date:   Fri, 5 May 2023 13:05:10 +0530
Message-ID: <0ac9037a184bf95d4532f37cdd91007af58942ed.1683183860.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1683183860.git.quic_varada@quicinc.com>
References: <cover.1683183860.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BtwaytZvHGYcWKSoUBD-GhEESUe_C66x
X-Proofpoint-GUID: BtwaytZvHGYcWKSoUBD-GhEESUe_C66x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=652 mlxscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050069
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
index 1f5d14f..18d642c 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -70,6 +70,10 @@
 	};
 };
 
+&dwc_0 {
+	dr_mode = "host";
+};
+
 &pcie1_phy {
 	status = "okay";
 };
@@ -122,6 +126,21 @@
 	clock-frequency = <32000>;
 };
 
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
 &tlmm {
 
 	pcie_1_pin: pcie-1-state {
@@ -188,6 +207,10 @@
 	};
 };
 
+&usb3 {
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <24000000>;
 };
-- 
2.7.4

