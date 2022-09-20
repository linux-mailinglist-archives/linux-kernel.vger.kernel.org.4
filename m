Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1185BDD44
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiITGcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiITGbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:31:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21FD5E312;
        Mon, 19 Sep 2022 23:30:51 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K6DaQt026073;
        Tue, 20 Sep 2022 06:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0GHBlCazCW2LLwokKCWDIfYw/0NFoDBpSIMTrIDPjD4=;
 b=VhPTikCmZLhqSsvuMmXO4TkiJdiuw+ikjWSvv6UoXRIk9wOrtA/26NZ/KgfVVGWuFrp/
 ocbxquNuT3DJYqY95jSMGBYYW7D99ax0bhEU7xrWl8JTG0qF6FUW4k/xGs61y9obFDIN
 9/MN8ptHguDJ7Oe7rYWcUYb9808wR26B9ephMmX637er2+OV940T1vGPFV8ZLNsTPkM4
 4sPS/M6aKuCqA28c078NKg9y4L7Rh0hWCtIDBnJl/NHoVTMcwN2WENYQq41EtTpEiKVr
 pgnguv7gsOYGhxW+kOB9d0Dys9yHwcYOQNBOKk7E+EjQkZ814D/luQlAQvI2kHpJSLJw 7Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jpw789tp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 06:30:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28K6UA73016513
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 06:30:10 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 23:30:04 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v7 5/8] remoteproc: qcom: Replace hard coded values with macros
Date:   Tue, 20 Sep 2022 11:59:16 +0530
Message-ID: <1663655359-1402-6-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663655359-1402-1-git-send-email-quic_srivasam@quicinc.com>
References: <1663655359-1402-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: te6Qpd36C_3pDjuOtzDa-8Ryk_zpJojs
X-Proofpoint-GUID: te6Qpd36C_3pDjuOtzDa-8Ryk_zpJojs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200039
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hard coded values of QDSP6 boot control reg params
with appropriate macro names.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 9ea10b7..80c8169 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -54,6 +54,9 @@
 
 #define QCOM_Q6V5_RPROC_PROXY_PD_MAX	3
 
+#define LPASS_BOOT_CORE_START	BIT(0)
+#define LPASS_BOOT_CMD_START	BIT(0)
+
 struct adsp_pil_data {
 	int crash_reason_smem;
 	const char *firmware_name;
@@ -366,10 +369,10 @@ static int adsp_start(struct rproc *rproc)
 	writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
 
 	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
-	writel(0x1, adsp->qdsp6ss_base + CORE_START_REG);
+	writel(LPASS_BOOT_CORE_START, adsp->qdsp6ss_base + CORE_START_REG);
 
 	/* Trigger boot FSM to start QDSP6 */
-	writel(0x1, adsp->qdsp6ss_base + BOOT_CMD_REG);
+	writel(LPASS_BOOT_CMD_START, adsp->qdsp6ss_base + BOOT_CMD_REG);
 
 	/* Wait for core to come out of reset */
 	ret = readl_poll_timeout(adsp->qdsp6ss_base + BOOT_STATUS_REG,
-- 
2.7.4

