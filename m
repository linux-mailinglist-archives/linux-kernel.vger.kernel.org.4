Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2FA5E7B61
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiIWNHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiIWNHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:07:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D804113AF28;
        Fri, 23 Sep 2022 06:06:59 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NCOcl8032003;
        Fri, 23 Sep 2022 13:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=351hcwurwp7mxYYmlbzpMHFDlfa96t578ZoH6iSkHzs=;
 b=O8hW+d2KdevF74hI2G8tsAkLmKLVK9d9NsKFiLPI+jWhDx6CreBUa37uAoZ29CPV/V+I
 NpviCLgIX/BudQL9s/A0Y6y3ML6oM6vTisymMOmdYLKbLH4jZDZVEqNKDIMes7SYmEZ5
 825Vet+OhTmHxHPOyonDe7+1TFcxocp8mTjtvvWucjeKe2Uhw8ZRhMXs0Z8Wblnp83Uz
 hcCzvEEDPXe/EBgIpJUWGW5YpncJFcRVNynUiyG5Djx8zV8/+JUDvJV2Eonmn5B1lWbr
 mquy40+R3QrBmVCjqtsxvRHBB5WhL+sBZnPtodcNmikrvw9MESyZ78s1ugZiuJvfTajr 0w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3js67nhm37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 13:06:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28ND6HTM027783
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 13:06:17 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 23 Sep 2022 06:06:11 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v8 3/7] remoteproc: qcom: Add compatible name for SC7280 ADSP
Date:   Fri, 23 Sep 2022 18:35:36 +0530
Message-ID: <1663938340-24345-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663938340-24345-1-git-send-email-quic_srivasam@quicinc.com>
References: <1663938340-24345-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BfbCW2-HB4VwFmzmOnwP-pvRTGBlsjqn
X-Proofpoint-GUID: BfbCW2-HB4VwFmzmOnwP-pvRTGBlsjqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update adsp pil data and compatible name for loading ADSP
binary on SC7280 based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes since V5:
	-- Rename adsp_sandbox_needed to has_iommu.
	-- Change adsp binary extension name.
Changes since V3:
	-- Rename is_adsp_sb_needed to adsp_sandbox_needed.
	-- Update sc7280 compatible name entry in sorted order.
Changes since V2:
	-- Initialize is_adsp_sb_needed flag.
	-- Remove empty proxy pds array.

 drivers/remoteproc/qcom_q6v5_adsp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index fa2ccac..02d17b4 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -702,6 +702,21 @@ static const struct adsp_pil_data adsp_resource_init = {
 	},
 };
 
+static const struct adsp_pil_data adsp_sc7280_resource_init = {
+	.crash_reason_smem = 423,
+	.firmware_name = "adsp.pbn",
+	.load_state = "adsp",
+	.ssr_name = "lpass",
+	.sysmon_name = "adsp",
+	.ssctl_id = 0x14,
+	.has_iommu = true,
+	.auto_boot = true,
+	.clk_ids = (const char*[]) {
+		"gcc_cfg_noc_lpass", NULL
+	},
+	.num_clks = 1,
+};
+
 static const struct adsp_pil_data cdsp_resource_init = {
 	.crash_reason_smem = 601,
 	.firmware_name = "cdsp.mdt",
@@ -740,6 +755,7 @@ static const struct adsp_pil_data wpss_resource_init = {
 
 static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,qcs404-cdsp-pil", .data = &cdsp_resource_init },
+	{ .compatible = "qcom,sc7280-adsp-pil", .data = &adsp_sc7280_resource_init },
 	{ .compatible = "qcom,sc7280-wpss-pil", .data = &wpss_resource_init },
 	{ .compatible = "qcom,sdm845-adsp-pil", .data = &adsp_resource_init },
 	{ },
-- 
2.7.4

