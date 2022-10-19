Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5A660398D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJSGFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJSGFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:05:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835A265268;
        Tue, 18 Oct 2022 23:05:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J3Zvrw018588;
        Wed, 19 Oct 2022 06:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=5NfVmVQqCcsqOCHrXdcWbol610SDLeE/U6J5P9uZ/NE=;
 b=d9ulX5GW4h5ZUQCIrw9I3Pc7Z7Gz3aSpgLXJ8TvNBZOSGJ0cKl6TRaAzVBVlAWsR9Oou
 YBEe+F1KoYh9EV47UssMvBtcgeGNE/+Zevuxcw9yhSHb1N94O2FjM/6xfBrP34914/6o
 M89SLvYs7Mg3cIDeRGz9piRiR+1dIe0l8KoqgVMGSJuv9n3MIc6gTetMgKF7ukCak84s
 /an+C+MDmeGHF7W4qKguHEJavhDX6bSnbeJW80OzrIHbwQjFrmxSh9xVh0Prq2Z9wX+d
 bZee60RJtYfY138JxRwNq2etcyx1Lc/cIpOcJNv6UQuMXOm1MMeVPgLqMHBjIoPaYIwa lg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ka4250y72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 06:05:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29J65mIV005769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 06:05:48 GMT
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 18 Oct 2022 23:05:45 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH] clk: qcom: Update the force mem core bit for GPU clocks
Date:   Wed, 19 Oct 2022 11:35:35 +0530
Message-ID: <1666159535-6447-1-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HJLP6w6wFHlUYmlmOI9mFywuucD1InV_
X-Proofpoint-ORIG-GUID: HJLP6w6wFHlUYmlmOI9mFywuucD1InV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_02,2022-10-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1011 spamscore=0
 mlxlogscore=863 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190033
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <quic_tdas@quicinc.com>

There are few GPU clocks which are powering up the memories
and thus enable the FORCE_MEM_PERIPH always for these clocks
to force the periph_on signal to remain active during halt
state of the clock.

Fixes: a3cc092196ef ("clk: qcom: Add Global Clock controller (GCC) driver for SC7280")
Fixes: 3e0f01d6c7e7 ("clk: qcom: Add graphics clock controller driver for SC7280")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
 drivers/clk/qcom/gcc-sc7280.c   | 1 +
 drivers/clk/qcom/gpucc-sc7280.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 8afb757..46d41eb 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -3467,6 +3467,7 @@ static int gcc_sc7280_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x28004, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x28014, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0x7100C, BIT(13), BIT(13));
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
 			ARRAY_SIZE(gcc_dfs_clocks));
diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
index 9a832f2..1490cd4 100644
--- a/drivers/clk/qcom/gpucc-sc7280.c
+++ b/drivers/clk/qcom/gpucc-sc7280.c
@@ -463,6 +463,7 @@ static int gpu_cc_sc7280_probe(struct platform_device *pdev)
 	 */
 	regmap_update_bits(regmap, 0x1170, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x1098, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0x1098, BIT(13), BIT(13));
 
 	return qcom_cc_really_probe(pdev, &gpu_cc_sc7280_desc, regmap);
 }
-- 
2.7.4

