Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5CE6E3F79
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjDQGOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjDQGOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:14:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370843A80;
        Sun, 16 Apr 2023 23:14:01 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H5TC2i028440;
        Mon, 17 Apr 2023 06:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=AnozYKldYPPiwWMIq1K3TwbJCUH1AaFWc9XPSNJKdfY=;
 b=OpDPN9XGLddpIKPD1p9VpzldGjNyKXh5j0gqk1jlvLqUSVKjJ9RunKZP0KpqyjIzbxJD
 pW5HMBzVk8fxxMZTdSY5uMtdlT8npsnyTFxeErTwPzlwh2ru76XHbOIcaClFAZih9/aY
 MKY5WLkzUjIl4kEmfjLYzliORMUJQPDTUot1nYDMdGAqcwQh0pk9j8a0TI+TSFw26mqv
 Gjx/S/vHJIl+U3Tum+cRVqSb4W7DT3BIsGg8sS54z/HSfiOfAYoN/LMzTfylb9MPxdan
 Mba36xS8mJqU0YDXFqg0byiECCQ+SR/D6fJizaatNhVBFi+HX3Mrp5UpPB3VFv6qpYzb Iw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymssjp0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 06:13:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H6Duk9006601
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 06:13:56 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 16 Apr 2023 23:13:51 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
Subject: [PATCH] dt-bindings: pinctrl: qcom: Add few missing functions
Date:   Mon, 17 Apr 2023 11:43:37 +0530
Message-ID: <20230417061337.6552-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xbX9dFsYVyjU8sP7m9cvME8TIP-_hnQo
X-Proofpoint-ORIG-GUID: xbX9dFsYVyjU8sP7m9cvME8TIP-_hnQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=914 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the missing functions cri_trng2, gpio and removed the
duplicate entry qdss_tracedata_b

Fixes: 5b63ccb69ee8 ("dt-bindings: pinctrl: qcom: Add support for IPQ9574")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 changes:
	- Separated out this pinctrl binding fix from PCIe series
	- Picked up the Acked-by tag 

 .../devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml      | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
index f32239d08c32..673713debac2 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
@@ -74,15 +74,15 @@ $defs:
                 blsp1_i2c, blsp1_spi, blsp1_uart, blsp2_i2c, blsp2_spi,
                 blsp2_uart, blsp3_i2c, blsp3_spi, blsp3_uart, blsp4_i2c,
                 blsp4_spi, blsp4_uart, blsp5_i2c, blsp5_uart, cri_trng0,
-                cri_trng1, cri_trng3, cxc0, cxc1, dbg_out, dwc_ddrphy,
-                gcc_plltest, gcc_tlmm, mac, mdc, mdio, pcie0_clk, pcie0_wake,
+                cri_trng1, cri_trng2, cri_trng3, cxc0, cxc1, dbg_out, dwc_ddrphy,
+                gcc_plltest, gcc_tlmm, gpio, mac, mdc, mdio, pcie0_clk, pcie0_wake,
                 pcie1_clk, pcie1_wake, pcie2_clk, pcie2_wake, pcie3_clk, pcie3_wake,
                 prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, pta, pwm,
                 qdss_cti_trig_in_a0, qdss_cti_trig_in_a1, qdss_cti_trig_in_b0,
                 qdss_cti_trig_in_b1, qdss_cti_trig_out_a0, qdss_cti_trig_out_a1,
                 qdss_cti_trig_out_b0, qdss_cti_trig_out_b1, qdss_traceclk_a,
                 qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b, qdss_tracedata_a,
-                qdss_tracedata_b, qdss_tracedata_b, qspi_clk, qspi_cs, qspi_data,
+                qdss_tracedata_b, qspi_clk, qspi_cs, qspi_data,
                 rx0, rx1, sdc_clk, sdc_cmd, sdc_data, sdc_rclk, tsens_max,
                 wci20, wci21, wsa_swrm ]
 
-- 
2.17.1

