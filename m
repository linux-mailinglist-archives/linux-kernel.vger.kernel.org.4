Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF5A669D47
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjAMQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjAMQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:08:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1EE8CBCF;
        Fri, 13 Jan 2023 08:01:30 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DDFUbF013491;
        Fri, 13 Jan 2023 16:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=cliwLmZmv0Rwb3t8+wNp9BpMnrZQpI53ZhYIDI4q6tw=;
 b=StkU67wW6yWbcqt5BRD8GJq8dNtAH/k9hWqrPRJSYYFMwF/UvRJ2ClltcDwHJjhbVREn
 OXTtizrResTsgRvtC5F/Idw2az9xxtOanVBq271yiJ+ykCq8CV7S8hBVDEtd+meLv1GP
 FNZS86167IiybGJIB+laGcHJvqMTeU/0rQpjHmPrEPXOcAUP36NZCK9WJk857ab9kC1q
 hJjxBMGtsJOh0Knvjf850iDVgq2bwm6LFN+SnwA3EgGiwqTPIN5AwfkPwg314kp3Edc8
 8mauBLNmOOV9FZddaficFLJnSf9GfgRy9z6eS5Mn/4dbHggfBZgJjbkr70g8xhyuSdXB iw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n351f91ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:01:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DG18Ju015509
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 16:01:08 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 08:01:00 -0800
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH 4/5] arm64: defconfig: Enable scm download mode config for IPQ9574 SoC.
Date:   Fri, 13 Jan 2023 21:30:11 +0530
Message-ID: <20230113160012.14893-5-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113160012.14893-1-quic_poovendh@quicinc.com>
References: <20230113160012.14893-1-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JUjUE1i6DYYYWMtpGWbxJcpM1Zpbpipw
X-Proofpoint-ORIG-GUID: JUjUE1i6DYYYWMtpGWbxJcpM1Zpbpipw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=883 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130107
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables scm download mode config.

Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Co-developed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8de3979b10a3..2bebdb040f1e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -255,6 +255,7 @@ CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
 CONFIG_INTEL_STRATIX10_RSU=m
+CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT=y
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
 CONFIG_IMX_SCU_PD=y
-- 
2.17.1

