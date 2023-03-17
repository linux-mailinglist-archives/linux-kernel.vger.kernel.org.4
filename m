Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5089C6BEAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCQORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCQORf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:17:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4871C1164A;
        Fri, 17 Mar 2023 07:17:34 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HAe7DX005458;
        Fri, 17 Mar 2023 14:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=XPUSFN5rMwASw7S2mvCgFefjhCcUhYDu5FUkofJ8Gm8=;
 b=gs99k0BBUk66M88++Ub73oFYOLkEBFKpBzbPynbQJHNKLJ/WvKXZyZd67EriKoOG4Grf
 I0LBxra4zgLVP6bNXIfZeEsv4cTsdOR6lfEPcJHNOBBtDDseT8NgV/U1hLIC1MbQtd5F
 BuvDJIo1aVyC2uZlFuFajgt4P983jCw3BP0W59IAYD/H0eU2tpwbUm8utMf1oKXVZZDH
 8hNYpu4/8U+H9iapnO+fixxIqxaLK65IP/5AMpvQ+ibPNUHOnUzEbKQ5yfAQZ2RCFx4A
 gadkvIq89ZdglBeBVbvuOJygL3TdwgZtu0cP7+hV6mjll01nWIwmaXQRk8Y5br0H4ySI iw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pckcfsc1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 14:17:19 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32HEHJ6r001008
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 14:17:19 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Mar 2023 07:17:14 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_visr@quicinc.com>
CC:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v9 3/4] clk: qcom: lpassaudiocc-sc7280: Add required gdsc power domain clks in lpass_cc_sc7280_desc strcuture
Date:   Fri, 17 Mar 2023 19:46:21 +0530
Message-ID: <20230317141622.1926573-4-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317141622.1926573-1-quic_mohs@quicinc.com>
References: <20230317141622.1926573-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cMhUkb9SuYLwW3MeWuwt55XGzhMDBEAB
X-Proofpoint-GUID: cMhUkb9SuYLwW3MeWuwt55XGzhMDBEAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_08,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=990 lowpriorityscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 clxscore=1015 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gdsc's in lpass_cc_sc7280_desc strcuture,
When qcom,adsp-pil-mode is enabled, gdsc's required to solve
dependencies in lpass_audiocc probe.

Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
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

