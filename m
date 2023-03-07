Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CBB6AD758
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjCGGY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjCGGYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:24:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB6559414;
        Mon,  6 Mar 2023 22:23:54 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32769EPX022041;
        Tue, 7 Mar 2023 06:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=hjy0vGXIqFJMuyKQ2jxXuZyr7nNquFXDn5KiKq/i8pk=;
 b=BSxsQtZBnwpv9rrLY3Q8YP2SN/LxlQPK5Pn90WCM9N/fyAn/BlXhhQT2GlqJtTHFOKQQ
 PnDEs/53q1lqyByuzCNFhei5BMMvgnYhqhHm4YzlowY7r1BE8Dr/sYkZQ+bwHLwywiHQ
 FHVrmZnFgxJdXeIR1Gm+x4/5flwsjp9SXayDJF8CYncSfLy1uBZPzfpfZJR5K5Nl0Dvm
 XLs908PVSuIT2HRSWjcXFNfRddhTtJceYU7byMcvOdOXBsHuXJQspYqMs546fSb3FYkq
 IevcudnCnRIYuLsEccdrtszoFJTW0+XEau8go1g9elQOFxLkFOV/Ui9ubYzcBGira1l6 hg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p5nkw9c1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 06:23:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3276NUiY021675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 06:23:30 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 22:23:23 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <arnd@arndb.de>, <dmitry.baryshkov@linaro.org>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V6 5/9] clk: qcom: ipq5332: mark GPLL4 as ignore unused temporarily
Date:   Tue, 7 Mar 2023 11:52:28 +0530
Message-ID: <20230307062232.4889-6-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230307062232.4889-1-quic_kathirav@quicinc.com>
References: <20230307062232.4889-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VJIZU27mvh-kDlif6CCgKKs7t-FzJ0wj
X-Proofpoint-ORIG-GUID: VJIZU27mvh-kDlif6CCgKKs7t-FzJ0wj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock framework disables the GPLL4 source since there are no active users
for this source currently. Some of the clocks initialized by the
bootloaders uses the GPLL4 as the source. Due to this, when the GPLL4 is
disabled by the clock framework, system is going for the reboot.

To avoid this, mark the GPLL4 as ignore unused so that clock framework
doesn't disable it. Once the users of this source is enabled, we can get
rid of this flag.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V6:
	- Newly added this patch in V6, to keep the dependent patches
	  together

 drivers/clk/qcom/gcc-ipq5332.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index 9e4baea33937..bdb4a0a11d07 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -128,6 +128,17 @@ static struct clk_alpha_pll gpll4_main = {
 			.parent_data = &gcc_parent_data_xo,
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_stromer_ops,
+			/*
+			 * There are no consumers for this GPLL in kernel yet,
+			 * (will be added soon), so the clock framework
+			 * disables this source. But some of the clocks
+			 * initialized by boot loaders uses this source. So we
+			 * need to keep this clock ON. Add the
+			 * CLK_IGNORE_UNUSED flag so the clock will not be
+			 * disabled. Once the consumer in kernel is added, we
+			 * can get rid of this flag.
+			 */
+			.flags = CLK_IGNORE_UNUSED,
 		},
 	},
 };
-- 
2.17.1

