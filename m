Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59CD6875BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjBBGSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjBBGSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:18:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74FD46170;
        Wed,  1 Feb 2023 22:18:13 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3124wGfX015629;
        Thu, 2 Feb 2023 06:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=C+DPe6/9Bw8OnikJuQsEcIM5j9HXoXYDGLCNE8ijtnM=;
 b=L+/+Jqsk/ybO7DbCJTvYqtPT4vlwG7bUp00FkIAPOojXD6+ToyUVmnV71OxaxCzeBebV
 F53RuiXyTzarJdLp25AoF2KqZEO41YtidUoFlvp5Q/oVTHhvloHcUD2A8BCVLT2EnkRv
 Ou+Lg9TCLJYzkt1/Z7JBBok2TCl+CM7WteQtn/ezFRmeBzFO98o0wU0M4xF5IJJrLD3p
 AdfDGevOv6DM0FOxby5BcF6XdQDvW0YZN9aOv0FgZPR2p9v40R6Jlrkh6FJ6Qi7/cZws
 jBLS7rNG5QaZzLvWkWkf3uPzHiBASr2HmIsXxko/iYgHTRyeu8fAG4U3Zxgxan1+mtqf Qw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfn5j27ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 06:18:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3126I6T6023667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 06:18:06 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 22:18:01 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v7 2/5] dt-bindings: clock: lpassaudiocc-sc7280: Add binding headers for lpasscc
Date:   Thu, 2 Feb 2023 11:47:30 +0530
Message-ID: <1675318653-28352-3-git-send-email-quic_srivasam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Zodl14JxArs0Qk_DtG4-5RnM0HYz_zVL
X-Proofpoint-GUID: Zodl14JxArs0Qk_DtG4-5RnM0HYz_zVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_15,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=846 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302020058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding headers for lpasscc clocks to merge lpasscc clocks into
lpass_aon clk_regmap structure.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h b/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
index 22dcd47..c72a980 100644
--- a/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
+++ b/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
@@ -41,6 +41,8 @@
 #define LPASS_AON_CC_TX_MCLK_CLK			8
 #define LPASS_AON_CC_TX_MCLK_RCG_CLK_SRC		9
 #define LPASS_AON_CC_VA_MEM0_CLK			10
+#define LPASS_Q6_AHBM_CLK				11
+#define LPASS_Q6_AHBS_CLK				12
 
 /* LPASS_AON_CC power domains */
 #define LPASS_AON_CC_LPASS_AUDIO_HM_GDSC		0
-- 
2.7.4

