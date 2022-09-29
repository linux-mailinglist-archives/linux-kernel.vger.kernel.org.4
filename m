Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C435EEE9C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiI2HOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbiI2HON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:14:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D3F132FCF;
        Thu, 29 Sep 2022 00:14:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28T5I9ts008739;
        Thu, 29 Sep 2022 07:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=LEG2Dy3CKJ9OxR193VFBeLxSkB0ek88zkaBViONOeew=;
 b=DS/fudyg+fLRlfC/OEhtbZDpofp9joSaCT2fmQLch/Bg1p4QyIh6ylhk9WALuBumPnUY
 /l0eTOAf0JNeGrxsXeXcNAo1OLWSy9+rH5z8zfDcSLSE7hdYuv8x8QvJE4FS8HJCbfsO
 vrOY5URLt2O/abP9xo2Q7GwlQ0zhHCTXeQ7Quo9BuN64VqfwhFglAjgMjqM247oL3II8
 XG482ipeie2E3wllQRyJCIYAJKKXbaOhatFWKNiQwmppk1LeatRMYicXq3lqYxi+zQm7
 DVik2OlrrArZth54LXuO4/ZArngtCoapY5RGZXo/KxsnHKIjvuOlEUr2jHohcFUTNMnX XQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jw29u0saj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 07:13:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28T7DwDx019423
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 07:13:58 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 29 Sep 2022 00:13:55 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: sc7280: Update SNPS Phy params for SC7280
Date:   Thu, 29 Sep 2022 12:43:48 +0530
Message-ID: <1664435628-4011-1-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b2ZwlycUoJ_da6xy9JqN6AFIFvKTuR2I
X-Proofpoint-ORIG-GUID: b2ZwlycUoJ_da6xy9JqN6AFIFvKTuR2I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_04,2022-09-29_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011 mlxlogscore=906
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290042
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Override the SNPS Phy tuning parameters for SC7280 devices. These
values are common for both trogdor and herobrine variants.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 2125803..ae2c23e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3310,6 +3310,13 @@
 			clock-names = "ref";
 
 			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
+
+			qcom,hs-rise-fall-time-bp = <0>;
+			qcom,squelch-detector-bp = <(-2090)>;
+			qcom,hs-disconnect-bp = <1743>;
+			qcom,hs-amplitude-bp = <1780>;
+			qcom,hs-crossover-voltage-microvolt = <(-31000)>;
+			qcom,hs-output-impedance-micro-ohms = <2600000>;
 		};
 
 		usb_1_qmpphy: phy-wrapper@88e9000 {
-- 
2.7.4

