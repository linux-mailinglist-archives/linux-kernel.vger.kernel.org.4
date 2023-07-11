Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DA374EAC0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjGKJhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjGKJhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:37:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201471BCB;
        Tue, 11 Jul 2023 02:36:57 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B9VC3t032505;
        Tue, 11 Jul 2023 09:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4uw/iduItdQzF8mL4viogNDU8G/22wARpV6uWpygvKQ=;
 b=L/AKka1Y1JRAiM7mZKyfswakmT0OXbNkh7Zg+c3M81rdE6vIxw5Paq4ydWLZMG5QYBuT
 3z/+tVMyBydMdxHV3e7ZyoJmOh93vDDYtbqHaSi5aKVn9AJVcy6AafLy/X9Shd1FaYn2
 ENxCnLxYsmrGLM2WPU2BAc198cmH7lJOGOMcpHOnrtjwCdGNRSkzNiNYJwA/uFBvI/Zt
 1Dpf9aQyMhVuwFnTQegGjuxG9PFie1ws4jHtHAkwO2DL7ZJpnKyMTxDpqZW4XZArcksR
 oizNOtoFfEXn4ASfwAzwltPOUHE5sWrH3bRYnuM4e8kIf6BU3PRQCIOJ8kaCX7JhQCaE DA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs459g1y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:36:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B9aV45018544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:36:31 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 02:36:24 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <arnd@arndb.de>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
Subject: [PATCH 6/6] arm64: defconfig: Build NSS Clock Controller driver for IPQ9574
Date:   Tue, 11 Jul 2023 15:05:29 +0530
Message-ID: <20230711093529.18355-7-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230711093529.18355-1-quic_devipriy@quicinc.com>
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cBxfNUyRzsrfKZHqtDprlPNszJqoXqZZ
X-Proofpoint-GUID: cBxfNUyRzsrfKZHqtDprlPNszJqoXqZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=838
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build Qualcomm IPQ9574 NSSCC driver.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9ce0f1554f4d..d10083da2401 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1180,6 +1180,7 @@ CONFIG_IPQ_GCC_5332=y
 CONFIG_IPQ_GCC_6018=y
 CONFIG_IPQ_GCC_8074=y
 CONFIG_IPQ_GCC_9574=y
+CONFIG_IPQ_NSSCC_9574=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8994=m
-- 
2.17.1

