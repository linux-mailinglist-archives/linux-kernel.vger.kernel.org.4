Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A8A6875C3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjBBGSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjBBGS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:18:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA66D66FB9;
        Wed,  1 Feb 2023 22:18:27 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3124GC7w013713;
        Thu, 2 Feb 2023 06:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=OHG0ro/UZYxoArmD1HlyMM7ZrFyvrEcBVSGEmebwlrs=;
 b=giOG0r3vodTLK469GiReXYAVrgamjB3W4olFhiPMcuQcdOUuF6XmJfS+zT0Irdx9bjF8
 mQviUbK1xl0MmX7SC0Gx8fm4IR6hWjkU5cpbUwm8E2jSGM+ogwagJ+hVJ2oVlcm5XXOZ
 s35u0zRLtCUUNXHm6MLBOP3ZHI/Vz8UGC1RJejokNSqR8Ck2B2QgsEVXDg3BTYtjv8y6
 XS4QuYQFX12MhQZZs9eroZCMj8cNXuCjh61n/zBCmkXnbRrR6Ad5sWmY+cTkA0UIVoIP
 QZNmLtV6mONwSwesyKRPyk9TPpux8zTd4wpjTARCkwYwa6H0j+rIZ5prmPc9HR341udj 6g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfm9g2f5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 06:18:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3126ILHG018826
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 06:18:21 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 22:18:16 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v7 5/5] clk: qcom: lpassaudiocc-sc7280: Skip lpass_aon_cc_pll config
Date:   Thu, 2 Feb 2023 11:47:33 +0530
Message-ID: <1675318653-28352-6-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1675318653-28352-1-git-send-email-quic_srivasam@quicinc.com>
References: <1675318653-28352-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k24pNZr1JKsh9kZ4Ztdz48aVQD8I-g_F
X-Proofpoint-GUID: k24pNZr1JKsh9kZ4Ztdz48aVQD8I-g_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_15,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip lpass_aon_cc_pll configuration for ADSP based platforms
based on qcom,adsp-pil-mode property.
This is to avoid ADSP out of reset fail.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 drivers/clk/qcom/lpassaudiocc-sc7280.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 8e2f433..76611a3 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -847,7 +847,13 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
-	clk_lucid_pll_configure(&lpass_aon_cc_pll, regmap, &lpass_aon_cc_pll_config);
+	/*
+	 * ADSP firmware is in control of this PLL frequency when
+	 * remoteproc is used. Skip frequency configuration in that
+	 * case.
+	 */
+	if (!of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode"))
+		clk_lucid_pll_configure(&lpass_aon_cc_pll, regmap, &lpass_aon_cc_pll_config);
 
 	ret = qcom_cc_really_probe(pdev, &lpass_aon_cc_sc7280_desc, regmap);
 	if (ret) {
-- 
2.7.4

