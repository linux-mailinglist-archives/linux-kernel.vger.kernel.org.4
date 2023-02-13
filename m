Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B374694CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjBMQ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjBMQ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:28:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC9CC29;
        Mon, 13 Feb 2023 08:28:48 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8tdsj020574;
        Mon, 13 Feb 2023 16:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=UpJ30top4ueNQZ7rf9BD/EvTZUzNMW3Z0t2hHclSDcg=;
 b=fbxEPGj0+XkHbcwlsY5xv9wusDLBr0M7p9l8Tx6RkoMGjcQ/NS4lIIH+FfnjhXWG6Xrs
 Lw2SHpwvuBMg9hIkRJuggtuN1kfcMzyG6q3PAp7DX/4LtuyhTyFKLsuSspgYrHut/5RN
 FNCoIewhapxAGTfo19hC91QgtRDrcUQt09NnL6rwGBNdrQmpPDSNMA6m1cTQyCg/rw99
 e2Dc55oMmi8nS/GRookZG/nSEJqHDXLfx433JQ7sG4Zn5EbVWycclYHFQ2xFefZU8A9k
 oQCFVuNwJzSPsl3q2OvVdTRkLDXUa++/vpQp8YyRifF7N/aaQfYZLgktus9Kaf0OZFmv QQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np21fvsk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 16:28:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DGSR4Q022173
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 16:28:27 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 08:28:26 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/4] arm64: dts: qcom: sc8280xp: Enable external display
Date:   Mon, 13 Feb 2023 08:28:17 -0800
Message-ID: <20230213162821.1253831-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0Xkyv3UlCyP6B4_r5VCJwJO6tO36P_Sp
X-Proofpoint-ORIG-GUID: 0Xkyv3UlCyP6B4_r5VCJwJO6tO36P_Sp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_11,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=726 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces support for external display on the SC8280XP laptops.

Support for swapping orientation and changing the mode of the SuperSpeed
lanes is being implemented in the QMP driver, so at this point in time
this is not supported.

Bjorn Andersson (4):
  arm64: dts: qcom: sc8280xp: Add USB-C-related DP blocks
  arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink
  arm64: dts: qcom: sc8280xp-x13s: Enable external display
  arm64: defconfig: Enable DisplayPort on SC8280XP laptops

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 208 +++++++++++++++++-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 192 +++++++++++++++-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 182 ++++++++++++++-
 arch/arm64/configs/defconfig                  |   2 +
 4 files changed, 576 insertions(+), 8 deletions(-)

-- 
2.25.1

