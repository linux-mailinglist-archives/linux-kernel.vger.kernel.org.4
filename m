Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FAA6CAAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjC0QeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjC0Qd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:33:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6941FEF;
        Mon, 27 Mar 2023 09:33:41 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RCeXPO005427;
        Mon, 27 Mar 2023 16:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=1jNQZj/jHDoSzLFDy9LEfH/gUtOD1v39/i0Jo8HIFHA=;
 b=fbu29+u77x4GskmXAcSj/tSB2V2fWa4lE5iX27OOU/HoNTekIBkJWvTvAHAT6z43ZvcF
 ieMbjBFfIr5jkRHcCT5AkEvRD/s3iitcRh782Pt6h1V6st/OqpNQLfQP+Z5NtXVF2tSh
 h2W/K2l49UJwWZrKgkaIExl9S5DnM3B8gW5cD02mASvZNQdNi8E6p4gODlSbtB61t4aI
 1/poc0+pjM2KfQ59o1ZuP/WLUGv4kjgwXnmJmQpu2P8BBVnDN5DDi3Sh3AFQBOOqSBBj
 v3MBfmMK+ggjDfJx/8w/OKOpA6ERhExi23nM6zxLwcooYNfO06lCtfSvchL77+f4gGH9 zg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk53yhkcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 16:33:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32RGXXpS008631
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 16:33:33 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Mar 2023 09:33:27 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <quic_visr@quicinc.com>
CC:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v1 3/4] arm64: dts: qcom: sc7280: Remove qdsp6ss regmap region
Date:   Mon, 27 Mar 2023 22:02:48 +0530
Message-ID: <20230327163249.1081824-4-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327163249.1081824-1-quic_mohs@quicinc.com>
References: <20230327163249.1081824-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AaeLMJL_oIWO-kuQA8rRR16p1nHNW0Yl
X-Proofpoint-ORIG-GUID: AaeLMJL_oIWO-kuQA8rRR16p1nHNW0Yl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=812
 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 adultscore=1 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270133
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qdsp6ss memory region is being shared by ADSP remoteproc device and
lpasscc clock device, hence causing memory conflict and as the qdsp6ss
clocks are being enabled in remoteproc driver, remove the register memory
region from lpasscc device tree node.

Change the base address of lpasscc with top_cc register address.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 3914f262aa12..625ac36790a0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2230,11 +2230,10 @@ tcsr_2: syscon@1fc0000 {
 			reg = <0 0x01fc0000 0 0x30000>;
 		};
 
-		lpasscc: clock-controller@3000000 {
+		lpasscc: clock-controller@3c04000 {
 			compatible = "qcom,sc7280-lpasscc";
-			reg = <0 0x03000000 0 0x40>,
-			      <0 0x03c04000 0 0x4>;
-			reg-names = "qdsp6ss", "top_cc";
+			reg = <0 0x03c04000 0 0x4>;
+			reg-names = "top_cc";
 			clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
 			clock-names = "iface";
 			#clock-cells = <1>;
-- 
2.25.1

