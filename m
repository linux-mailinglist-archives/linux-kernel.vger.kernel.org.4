Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EBC725CCB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbjFGLL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbjFGLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:11:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8BAE79;
        Wed,  7 Jun 2023 04:11:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357AfiTl028657;
        Wed, 7 Jun 2023 10:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ppwtIPRiaridEX22kKaoo8ZqQTqMCoFPO7Tl3CkigXA=;
 b=X3Loy+pNjTdqmzkfQvEFc2HEDoTc45M9Wi2jdsSiQTvu1E/NuwvPo+aKdiIZAt1JmIIJ
 t2d3tis7AverFGA8ULtCRiArM68iCZPtE/7P7VUqrJPIODOdZcmIY+aIRs+gJeM3+clE
 dQmdwvfmxVGJ/zgF4rr7B8er+DclOMU5RGkury9BhxZWTCd3bnWSZCQnVBdRIR7EiPs7
 EESw/3SuxvUIFXW23xp0oNbckeT6TJA9p7yJrL188DFd21wNfAYzgbwSdJVm/HNjUpkG
 JHBIEp+KTX5YrNy5ufNIUastztnhzDtOu6uKzyqji+a0RlP6cRXIQfvrGpAYCEgjXccF KQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2rbtg0u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 10:56:30 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357AuTJg025287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 10:56:29 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 03:56:20 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 0/9] Enable IPQ5332 USB2
Date:   Wed, 7 Jun 2023 16:26:04 +0530
Message-ID: <cover.1686126439.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8kHDuKT46JDbNroJKpYJwAP_zCYi0xy3
X-Proofpoint-ORIG-GUID: 8kHDuKT46JDbNroJKpYJwAP_zCYi0xy3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=272 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the relevant phy and controller
configurations for enabling USB2 on IPQ5332

Depends On: https://lore.kernel.org/linux-arm-msm/cover.1686045347.git.quic_varada@quicinc.com/

Varadarajan Narayanan (9):
  dt-bindings: usb: dwc3: Add IPQ5332 compatible
  dt-bindings: phy: qcom,m31: Document qcom,m31 USB phy
  phy: qcom-m31: Introduce qcom,m31 USB phy driver
  clk: qcom: ipq5332: Fix USB related clock defines
  phy: qcom-m31: Introduce qcom,m31 USB phy
  phy: qcom: Add qcom,m31 USB phy driver
  arm64: dts: qcom: ipq5332: Add USB related nodes
  arm64: dts: qcom: ipq5332: Enable USB
  arm64: defconfig: Enable QCOM M31 USB phy driver

 .../devicetree/bindings/phy/qcom,m31.yaml          |  69 ++++
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   2 +
 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts        |   8 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi              |  55 ++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/clk/qcom/gcc-ipq5332.c                     |  34 +-
 drivers/phy/qualcomm/Kconfig                       |  11 +
 drivers/phy/qualcomm/Makefile                      |   1 +
 drivers/phy/qualcomm/phy-qcom-m31.c                | 360 +++++++++++++++++++++
 9 files changed, 530 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,m31.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c

-- 
2.7.4

