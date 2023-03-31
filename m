Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A07E6D23FD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjCaP3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjCaP25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:28:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B731D846;
        Fri, 31 Mar 2023 08:28:54 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V9XJKg020114;
        Fri, 31 Mar 2023 15:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=RRsxgAHgTlm+iwTceKr7VhVyxrmQp3oO7UsRfGYfjCw=;
 b=E/FiN/Y4o5BKcEr3tONep6GpbfedFOd0hEa/f+H6TypJh+XM+TuaM3+3wfO+C1Pmd3i6
 SHEdmWCqPUDKtzStsZs1NZDHCtd1zWElcD0lk+H5W4xZzKh1zNvLr2P1qGpcB5BdqkAQ
 lT/1Qa5yIWpHH9UKYC2kU8kam9ZR8nyT3T+7/wrmRA/bcNIF7gzznf6Zu+/d4ARMqOM/
 Dt6KAqNXvkrVYlwnwWM5SNH7zmpvMpKg9z4nSg5ns+s2AJlTFXF/4G4dtEtosH4spzqT
 v5vgUiSpqk5Vc+S5VLlKfN3vLY8SanP+BcQ5Su2MrjYWcEy4eSqjSvnH8aXTbrUggbzC uA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pnvyuh82s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 15:28:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32VFSlPV014746
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 15:28:47 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 31 Mar 2023 08:28:42 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <quic_visr@quicinc.com>
CC:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v10 3/3] clk: qcom: lpassaudiocc-sc7280: Add required gdsc power domain clks in lpass_cc_sc7280_desc
Date:   Fri, 31 Mar 2023 20:58:05 +0530
Message-ID: <20230331152805.3199968-4-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331152805.3199968-1-quic_mohs@quicinc.com>
References: <20230331152805.3199968-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KWc0Fshp3LlVZMIoQQ9bT9lMnGl7EVbN
X-Proofpoint-ORIG-GUID: KWc0Fshp3LlVZMIoQQ9bT9lMnGl7EVbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303310122
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GDSCs in lpass_cc_sc7280_desc struct.
When qcom,adsp-pil-mode is enabled, GDSCs required to solve
dependencies in lpass_audiocc probe().

Fixes: 0cbcfbe50cbf ("clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon")
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 drivers/clk/qcom/lpassaudiocc-sc7280.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 1339f9211a14..134eb1529ede 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -696,6 +696,8 @@ static const struct qcom_cc_desc lpass_cc_sc7280_desc = {
 	.config = &lpass_audio_cc_sc7280_regmap_config,
 	.clks = lpass_cc_sc7280_clocks,
 	.num_clks = ARRAY_SIZE(lpass_cc_sc7280_clocks),
+	.gdscs = lpass_aon_cc_sc7280_gdscs,
+	.num_gdscs = ARRAY_SIZE(lpass_aon_cc_sc7280_gdscs),
 };
 
 static const struct qcom_cc_desc lpass_audio_cc_sc7280_desc = {
-- 
2.25.1

