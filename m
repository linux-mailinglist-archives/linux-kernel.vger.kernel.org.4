Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91B3680C73
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjA3Ltn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbjA3Lt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:49:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E336098;
        Mon, 30 Jan 2023 03:48:57 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UBXQw5018578;
        Mon, 30 Jan 2023 11:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=u0nQkiQl9om8zkUXoGp60qZ08t5tJiNeSNaZzBSDMIE=;
 b=JHC7f0oCA9P0GDkSERAbSehKB5IvfcuCuKriw/teUUYOglLapwKvfpzz7cmDOtKBJoRp
 HckSoF3Fu/u2WHvhPs4QyXU7alMuCr/jI6oXhSzHApDcvs1dBAk2R+28cfzg5D3RqFIA
 IXAIxTdCzluPxg5qsqiiss7DUJIxx8goUJwMeBc/3g6jIUUEnVWmmpm2Hu0yanwPgZvf
 vBh+jeDiEH1QMxMp1ObZ6JtB5sOP+okOBIL0T6kstlkCmeIT+E/5/4cYNZmUKIdG/mSo
 9s6N2JcCU+Px1JNiWuPzSVnvjLyrURZ/YAd9wzl0g7Lz+/xiCyWJt7abOSPaAr4i4z33 6g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvvu3c1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 11:48:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UBmRYV014696
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 11:48:27 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 03:48:20 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <nfraprado@collabora.com>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 9/9] arm64: defconfig: Enable IPQ5332 SoC base configs
Date:   Mon, 30 Jan 2023 17:17:02 +0530
Message-ID: <20230130114702.20606-10-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230130114702.20606-1-quic_kathirav@quicinc.com>
References: <20230130114702.20606-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: giEXvMFJOUaUabDtFpI2TMf1lFYsJ08D
X-Proofpoint-ORIG-GUID: giEXvMFJOUaUabDtFpI2TMf1lFYsJ08D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_10,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=794 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301300113
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kathiravan T <quic_kathirav@quicinc.com>

Enable the clock and pinctrl related configs which are required for the
bootup.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changed in V2:
	- No changes

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 984553d55e17..4a18ea596b32 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -549,6 +549,7 @@ CONFIG_PINCTRL_IMX8ULP=y
 CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ8074=y
+CONFIG_PINCTRL_IPQ5332=y
 CONFIG_PINCTRL_IPQ6018=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8953=y
@@ -1105,6 +1106,7 @@ CONFIG_QCOM_CLK_APCS_MSM8916=y
 CONFIG_QCOM_CLK_APCC_MSM8996=y
 CONFIG_QCOM_CLK_SMD_RPM=y
 CONFIG_QCOM_CLK_RPMH=y
+CONFIG_IPQ_GCC_5332=y
 CONFIG_IPQ_GCC_6018=y
 CONFIG_IPQ_GCC_8074=y
 CONFIG_MSM_GCC_8916=y
-- 
2.17.1

