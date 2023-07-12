Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BA775064F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjGLLjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjGLLjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:39:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4658DF5;
        Wed, 12 Jul 2023 04:39:17 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8dgb8029585;
        Wed, 12 Jul 2023 11:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=OnwlJdUYQVuoZRGlusai7hMzlLMdP2IuMcarNsL788E=;
 b=VWeP6V+TzTcV+eepvs3cMxP006cEtODRMpg4sRbH+ypnFrLC7EBveSE9fbH/K0RIbnDp
 h9ErjqAzFpVGMySQ8j8GJ3P9a5q+NfZrGID5N0XbMOBNsSoYcsJXZvkarEXIbz/2TSbJ
 6yqQqRBIyuxovdGNUoj+zAT56NvwouGk69tm309c7HJZLPtQZ9OQwGxrqqxQmdLZPrmM
 9X52b5d8fFBO/elCJIRWkxDS58etDre3gUn2cOiLFwzyRtVvMieO4IdQmhnT7UwuFnQN
 u2iPght778u4if7VHPAIEr2KMDespJxEkgEydShuKpGGArXKSILKQT5Mb+4zXXo3Z9mx XQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rshyu92y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:38:52 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CBcpf8013182
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:38:51 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 04:38:43 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v4 0/6] Enable IPQ5332 USB2
Date:   Wed, 12 Jul 2023 17:08:17 +0530
Message-ID: <cover.1689160067.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cc5tv1kTx82OqU53rLfd2oyYOn2odixc
X-Proofpoint-ORIG-GUID: cc5tv1kTx82OqU53rLfd2oyYOn2odixc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=315 phishscore=0
 clxscore=1015 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120103
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

v4:
	Binding and dts:-
		Change node name (bindings & dts)
	Driver:-
		Remove unused enum
		static const for '.data'
		Error handling for devm_clk_get
v3:
	Fix bindings file based on review comments

v1:
	Cleanup DTS
	Combine driver, kconfig and makefile patches
	Remove unused functions from M31 driver
	Drop the clock driver changes

Varadarajan Narayanan (6):
  dt-bindings: usb: dwc3: Add IPQ5332 compatible
  dt-bindings: phy: qcom,m31: Document qcom,m31 USB phy
  phy: qcom-m31: Introduce qcom,m31 USB phy driver
  arm64: dts: qcom: ipq5332: Add USB related nodes
  arm64: dts: qcom: ipq5332: Enable USB
  arm64: defconfig: Enable M31 USB phy driver

 .../bindings/phy/qcom,ipq5332-usb-hsphy.yaml       |  48 ++++
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   3 +
 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts        |  12 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi              |  53 +++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/phy/qualcomm/Kconfig                       |  11 +
 drivers/phy/qualcomm/Makefile                      |   1 +
 drivers/phy/qualcomm/phy-qcom-m31.c                | 256 +++++++++++++++++++++
 8 files changed, 385 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c

-- 
2.7.4

