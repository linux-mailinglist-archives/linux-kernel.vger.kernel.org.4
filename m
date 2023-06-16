Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E80732D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344074AbjFPKUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344059AbjFPKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:20:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DECD35A4;
        Fri, 16 Jun 2023 03:19:13 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G8QCl6012606;
        Fri, 16 Jun 2023 10:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4/O20YBgTkoVlsk082BfVWNGW0SZtdAgY1OLJ8YrguQ=;
 b=U+ZVW4wlBG4z+xbhNGqc+AkZMgwxeOoT05Vlc/mMEjbfeITXtKhprnls114a9AEbe9ka
 558Sq5s3xTYWjiGBfRi0Tc+a+WUl7wQBIIsz0UbQeiUR3TDexvsYVNls5APf9/vBKVaD
 WCbUCzQrfyVYLJ7Gp4l1buiaIvP5RdIZfdHxLgkQ1XDk0lAlT4We5kF8Bs0h+7oKr1Xd
 dFHfF3QQZ3DXc0cgnqk+CiUojGYfUZ45U6N8XlfFjxuwxzsz6+dxM3ixVhIhpGQZNVsx
 /jD9HeoQemCXkieB9fGUwIi/m1VE+PMiVTLiJyx8Z562TlzFB30JnObPGZL9eCNHGNqw 9g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r8abb15j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 10:19:05 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35GAJ20k029587
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 10:19:02 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 16 Jun 2023 03:18:55 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robimarko@gmail.com>,
        <krzysztof.kozlowski@linaro.org>, <andy.shevchenko@gmail.com>,
        <quic_srichara@quicinc.com>
Subject: [v11 6/6] arm64: defconfig: Enable IPQ5018 SoC base configs
Date:   Fri, 16 Jun 2023 15:47:49 +0530
Message-ID: <20230616101749.2083974-7-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616101749.2083974-1-quic_srichara@quicinc.com>
References: <20230616101749.2083974-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jX5K4CWLk0JqPKX9C3Fa8O17vgYNsUSI
X-Proofpoint-GUID: jX5K4CWLk0JqPKX9C3Fa8O17vgYNsUSI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_06,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=752
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables clk & pinctrl related configs

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8d850be05835..5b5a4ea51373 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -560,6 +560,7 @@ CONFIG_PINCTRL_IMX8ULP=y
 CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ8074=y
+CONFIG_PINCTRL_IPQ5018=y
 CONFIG_PINCTRL_IPQ5332=y
 CONFIG_PINCTRL_IPQ6018=y
 CONFIG_PINCTRL_IPQ9574=y
@@ -1171,6 +1172,8 @@ CONFIG_QCOM_CLK_SMD_RPM=y
 CONFIG_QCOM_CLK_RPMH=y
 CONFIG_IPQ_APSS_6018=y
 CONFIG_IPQ_GCC_5332=y
+CONFIG_IPQ_APSS_5018=y
+CONFIG_IPQ_GCC_5018=y
 CONFIG_IPQ_GCC_6018=y
 CONFIG_IPQ_GCC_8074=y
 CONFIG_IPQ_GCC_9574=y
-- 
2.34.1

