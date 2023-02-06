Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8144868B671
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 08:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBFHbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 02:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBFHbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:31:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749DF1D92B;
        Sun,  5 Feb 2023 23:31:23 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3166Em6r002272;
        Mon, 6 Feb 2023 07:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=WJ2PBCzCBe5jQknbYA/Frjaf7PliducbAMo3lx1yCwA=;
 b=Ve59Ldf3wWBaqtCGjEa9mg8y6c1+mYaR9jwd+38BQ3Q+GWzuD85C6XM7l2hBNQxyycmi
 VlZZ1+0cMo94/HD7YTVuQfbP3MlrWD8iBKTEqk9MXwu+nyCsL+vXcPCKGW51qVRchqoT
 zHf7LViIx58p+Uw8HVpNjZO3lVTwkarBTokyVmO3sE8molBx9YOAl08cM0FByqwEHnG/
 zaob7X0XEuBH6P34EnWGHKWVi+qGFZTuBCTTOwKRh/apqkS1skweW2Kl56BUKVg0grpr
 O+1GqksR2Vd+11rLIv4gq/81C1z7RXv0B1weFVZATO7u7sfrUZZdSfwMTX1haKtwH4fN lw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhcqxu8sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 07:31:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3167VJdG003541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 07:31:19 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 5 Feb 2023 23:31:15 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2] clk: qcom: ipq5332: mark GPLL4 as critical temporarily
Date:   Mon, 6 Feb 2023 13:01:01 +0530
Message-ID: <20230206073101.14796-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sYETrLwmqa0Vm2Kd3Qdcp-GcUCeycAql
X-Proofpoint-GUID: sYETrLwmqa0Vm2Kd3Qdcp-GcUCeycAql
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_03,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 mlxlogscore=815 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302060064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock framework disables the GPLL4 source since there are no active users
for this source currently. Some of the clocks initialized by the
bootloaders uses the GPLL4 as the source. Due to this, when the GPLL4 is
disabled by the clock framework, system is going for the reboot.

To avoid this, mark the GPLL4 as CRITICAL so that clock framework
doesn't disable it. Once the users of this source is enabled, we can get
rid of this flag.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Added a comment in driver explaining the need of the flag

 drivers/clk/qcom/gcc-ipq5332.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index c8a5fa1bafca..2e043d2d0598 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -127,6 +127,16 @@ static struct clk_alpha_pll gpll4_main = {
 			.parent_data = &gcc_parent_data_xo,
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_stromer_ops,
+			/*
+			 * There are no consumers for this GPLL in kernel yet,
+			 * (will be added soon), so the clock framework
+			 * disables this source. But some of the clocks
+			 * initialized by boot loaders uses this source. So we
+			 * need to keep this clock ON. Add the CRITICAL flag
+			 * so the clock will not be disabled. Once the consumer
+			 * in kernel is added, we can get rid off this flag.
+			 */
+			.flags = CLK_IS_CRITICAL,
 		},
 	},
 };
-- 
2.17.1

