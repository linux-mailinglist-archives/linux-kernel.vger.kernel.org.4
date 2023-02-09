Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDD568FC80
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBIBPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjBIBO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:14:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98452112;
        Wed,  8 Feb 2023 17:14:58 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31915nuq014933;
        Thu, 9 Feb 2023 01:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=6gXvsueo4V2TYRjdqTu7+Svo6u8laPlpEu5sZ1d9BUI=;
 b=NBP3TpfSL9viGYOlxYmL5q8TPDtafOSi72pNGtgieiZRf8hu7DQPO5F5ZX3FtJ4I43DT
 nMuyX4IbrFTmVFp6ESEBwdqAvgzaTXXyMpkOe2KKrgZl+EMBWtxPkooL7G8WuGWjp7Lf
 hYIxf/OTfSOyG+Mll6EPLFBkk9DWGhI6sTuFTO4Qb0gmW4trCv5F+IYHXYOr3syB5P5U
 6ZEJee6fgtjMdw+INjaEaXNBj//ATXv+fwaXSLHlgol6S0omCEB4Lyw12m5cg161/kT8
 MXEvDoYqLQ8lMFcQvscwkCPIAFcSJopETHv3nO6l3RIqWgKZ9MMkZyLLxy9KitxvR3hc Hg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm86mt91c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 01:14:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3191Ei1b015201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 01:14:46 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 8 Feb 2023 17:14:45 -0800
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
Subject: [PATCH v2 4/4] arm64: defconfig: Enable DisplayPort on SC8280XP laptops
Date:   Wed, 8 Feb 2023 17:13:25 -0800
Message-ID: <20230209011325.2603663-5-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209011325.2603663-1-quic_bjorande@quicinc.com>
References: <20230209011325.2603663-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XlBvRH2JyG-wqrP9bLc7MZ9g-EqKGG2r
X-Proofpoint-ORIG-GUID: XlBvRH2JyG-wqrP9bLc7MZ9g-EqKGG2r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_11,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=853 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090010
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QCOM_PMIC_GLINK implements the parts of a TCPM necessary for
negotiating DP altmode and the TYPEC_MUX_GPIO_SBU driver is used for
controlling connection and orientation switching of the SBU lanes in the
USB-C connector  Enable these to enable USB Type-C DisplayPort on
SC8280XP laptops.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- None

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 695c4e44d241..edafb5c4b9a1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -972,6 +972,7 @@ CONFIG_TYPEC_TPS6598X=m
 CONFIG_TYPEC_HD3SS3220=m
 CONFIG_TYPEC_UCSI=m
 CONFIG_UCSI_CCG=m
+CONFIG_TYPEC_MUX_GPIO_SBU=m
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
@@ -1207,6 +1208,7 @@ CONFIG_QCOM_CPR=y
 CONFIG_QCOM_GENI_SE=y
 CONFIG_QCOM_LLCC=m
 CONFIG_QCOM_OCMEM=m
+CONFIG_QCOM_PMIC_GLINK=m
 CONFIG_QCOM_RMTFS_MEM=m
 CONFIG_QCOM_RPMH=y
 CONFIG_QCOM_RPMHPD=y
-- 
2.25.1

