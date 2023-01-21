Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869116767B5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjAURec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjAUReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:34:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781412BF2B;
        Sat, 21 Jan 2023 09:34:15 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30LHY9Yn002354;
        Sat, 21 Jan 2023 17:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Rog7IjBl53peKfwf86UNTR0z1spPZn0jX6cQAVnSuSI=;
 b=mYZTzt77je7668kDOCEyPdDBev5ESts//Cxbpqq7AmCFSj2Nvtnn71BQiKXccs+7nNRa
 S4APFmcAgwMC7cPul5fK0WSVhF2OXHIhLKb2nOwivM4B6CXxuOwD7h7dlGfXbTeKTzt3
 PIKy09y8Lv+cua5iLqYzpoybM3lxe0I6nnK5ntqL58qfJVNrFsAaD0W0rcxp3f49a5ov
 n+zAHI8QawlkIeUfbwgt/tdWsFv1OZpHZQeDtmwvpjNAPaFD8M77RWnedPUZZeMimhje
 ovJMKkelUcAvXql+yjfCxGT3GOS2iJo+DBWSerdeSZX1it4saKhnRKSze2CyZFJTRyOH Dw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89fr8nrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 17:34:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30LHY8Vj023826
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 17:34:08 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sat, 21 Jan 2023 09:34:03 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [RESEND v5 5/6] clk: qcom: lpassaudiocc-sc7280: Merge lpasscc into lpass_aon
Date:   Sat, 21 Jan 2023 23:02:19 +0530
Message-ID: <1674322340-25882-6-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674322340-25882-1-git-send-email-quic_srivasam@quicinc.com>
References: <1674322340-25882-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dvL7qJLCFnlzwV9XWoKEBGTkNIGpoTjy
X-Proofpoint-GUID: dvL7qJLCFnlzwV9XWoKEBGTkNIGpoTjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=719
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301210168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge lpasscc clocks into lpass_aon clk_regmap structure as they
are using same register space.
Add conditional check for doing lpasscc clock registration only
if regname specified in device tree node.
In existing implementation, lpasscc clocks and lpass_aon clocks are
being registered exclusively and overlapping if both of them are
to be used.
This is required to avoid such overlapping and to register
lpasscc clocks and lpass_aon clocks simultaneously.

Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 drivers/clk/qcom/lpassaudiocc-sc7280.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 1339f92..8e2f433 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -660,6 +660,8 @@ static struct clk_regmap *lpass_aon_cc_sc7280_clocks[] = {
 	[LPASS_AON_CC_TX_MCLK_2X_CLK] = &lpass_aon_cc_tx_mclk_2x_clk.clkr,
 	[LPASS_AON_CC_TX_MCLK_CLK] = &lpass_aon_cc_tx_mclk_clk.clkr,
 	[LPASS_AON_CC_TX_MCLK_RCG_CLK_SRC] = &lpass_aon_cc_tx_mclk_rcg_clk_src.clkr,
+	[LPASS_Q6_AHBM_CLK] = &lpass_q6ss_ahbm_clk.clkr,
+	[LPASS_Q6_AHBS_CLK] = &lpass_q6ss_ahbs_clk.clkr,
 };
 
 static struct gdsc *lpass_aon_cc_sc7280_gdscs[] = {
@@ -819,6 +821,7 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
 {
 	const struct qcom_cc_desc *desc;
 	struct regmap *regmap;
+	struct resource *res;
 	int ret;
 
 	ret = lpass_audio_setup_runtime_pm(pdev);
@@ -826,10 +829,12 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
 		return ret;
 
 	if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
-		lpass_audio_cc_sc7280_regmap_config.name = "cc";
-		desc = &lpass_cc_sc7280_desc;
-		ret = qcom_cc_probe(pdev, desc);
-		goto exit;
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cc");
+		if (res) {
+			lpass_audio_cc_sc7280_regmap_config.name = "cc";
+			desc = &lpass_cc_sc7280_desc;
+			return qcom_cc_probe(pdev, desc);
+		}
 	}
 
 	lpass_audio_cc_sc7280_regmap_config.name = "lpasscc_aon";
-- 
2.7.4

