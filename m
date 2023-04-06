Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D9A6D8F3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjDFGQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjDFGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:14:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD5EA256;
        Wed,  5 Apr 2023 23:14:42 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3365084U029480;
        Thu, 6 Apr 2023 06:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rrWFm4g2kka8YobOBx5TxnOwKU7kNUjdVQZ8CY5LXiQ=;
 b=Lj5hGLZVtxYeN/RFfbgRUDd2oH7rbgtpjY2WBZxazLEd8T7vWqv7RX5OnPM1B5UILPqF
 yFo3WSyt3tWNecPPfBgZfUOwciN5gn1nuSt7lrYd5GVhXW0IYG4pKlmNoeeqGKqt01p1
 Qbo7daQY93fx3xzW2ZVPEdOJlHzaL9n2wLrvklHv7C+UsAmhKXJBaJg1Byji6YEQQqmk
 hE8640P/pLVhiAcE4tv3G+UaLdi3qEW2+/ViF280iUaDmz+i31Lo2dg55oO6zkvZ7n/h
 RwOwusWNpMeIif6aeT9t4r5Q/6XqMK2C3k3LB6q0v2Hij4LvgMoPWbVD55qMJVA2od/V AA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prn7qmv47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 06:14:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3366EKOf001319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 06:14:20 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 23:14:12 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
Subject: [PATCH V3 5/5] arm64: defconfig: Enable ipq6018 apss clock and PLL controller
Date:   Thu, 6 Apr 2023 11:43:14 +0530
Message-ID: <20230406061314.10916-6-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406061314.10916-1-quic_devipriy@quicinc.com>
References: <20230406061314.10916-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4w4iFH4np_chfTmc2qL1RUMHbH5zUxB1
X-Proofpoint-GUID: 4w4iFH4np_chfTmc2qL1RUMHbH5zUxB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_02,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=825 suspectscore=0 adultscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060053
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLL and IPQ6018 APSS clock controller are used on several
IPQ platforms to clock the CPU. Hence it should be enabled and built-in.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- No change

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8f24c280dec2..27dc617ec296 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1153,6 +1153,7 @@ CONFIG_QCOM_CLK_APCS_MSM8916=y
 CONFIG_QCOM_CLK_APCC_MSM8996=y
 CONFIG_QCOM_CLK_SMD_RPM=y
 CONFIG_QCOM_CLK_RPMH=y
+CONFIG_IPQ_APSS_6018=y
 CONFIG_IPQ_GCC_5332=y
 CONFIG_IPQ_GCC_6018=y
 CONFIG_IPQ_GCC_8074=y
-- 
2.17.1

