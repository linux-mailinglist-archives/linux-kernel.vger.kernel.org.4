Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3B063C435
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiK2Pxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiK2Pxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:53:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71A731DC0;
        Tue, 29 Nov 2022 07:53:50 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATFDcv9016366;
        Tue, 29 Nov 2022 15:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZX0B5BBuR1K+dA2SUfVbLudyajXUcyLamBRqEttKJ6k=;
 b=NFmyJRgukuDp0i84XXoTbvBpTzpgURFnxv8TlcQVed8902MA8/OzYf3IYrWF96VIVmlQ
 vWCbuQo6sHLnZOi/M6xBezvMfxdEcxMYZ+agmMdUA1T8VAt6W0HWcPUUqnBIu5C0ASm+
 kuKbgVvCebH+b+d+opCcEonvIJ7masjOHmVQK7+6fdVDNDYVcAW2JFJTleqYFwQkNklT
 tvN7JyUcbadFM7XPz8PumJg794eOedTHfTm4cw0+0GBZspXL/c65oe55HxgX3AIpUsj5
 86fm4VMIpHAT7qGSJhbjHE4z5GZll1Q/AUfesIvBEKzDON0vV8TLfdn2D4UMFLIILPOW hg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m5fjx0xj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 15:53:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ATFr4mX029742
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 15:53:04 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 29 Nov 2022 07:52:57 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for system PM ops
Date:   Tue, 29 Nov 2022 21:22:40 +0530
Message-ID: <1669737160-5282-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BPsAIBaRYB-MDZixTn5KMRp_j_R0FUlC
X-Proofpoint-GUID: BPsAIBaRYB-MDZixTn5KMRp_j_R0FUlC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_10,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 mlxlogscore=847
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __maybe_unused tag for system PM ops suspend and resume.
This is required to fix allmodconfig compilation issue.

Fixes: 2d68148f8f85 ("ASoC: qcom: lpass-sc7180: Add system suspend/resume PM ops")

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
--- 
Changes since v1:
    -- Updated Fixes tag.

 sound/soc/qcom/lpass-sc7180.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index b96b85a..41db661 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -163,14 +163,14 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
 	return 0;
 }
 
-static int sc7180_lpass_dev_resume(struct device *dev)
+static int __maybe_unused sc7180_lpass_dev_resume(struct device *dev)
 {
 	struct lpass_data *drvdata = dev_get_drvdata(dev);
 
 	return clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
 }
 
-static int sc7180_lpass_dev_suspend(struct device *dev)
+static int __maybe_unused sc7180_lpass_dev_suspend(struct device *dev)
 {
 	struct lpass_data *drvdata = dev_get_drvdata(dev);
 
-- 
2.7.4

