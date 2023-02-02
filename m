Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF8C68809E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjBBOxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjBBOwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:52:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6E74204;
        Thu,  2 Feb 2023 06:52:33 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312EbVDA007329;
        Thu, 2 Feb 2023 14:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=bq/+gpa+Xc2tW3MBRu7pzVh4bcUQjgzBhx8XLYKtPXg=;
 b=cDTsqgHnmaxdS10L59R/zyWOnnK3zJX8fz7sePFTKn9b+H2rI90gLa4+yzNGhXiP3M88
 +ktmT0TWQl97VChBgD8FMDSwVHHOJ4qlir8mBmcgq82AeDvW9DNQhB5dVUOjKOtRGYhc
 xc1RQ8Rq3GzyO6nbA5bnL8cqs1MJuMKF/7J7TBjrGovhlJuDmA0kVskBLF6OA+utU8sC
 LhUAKN7Yz4YePkxUZ0a6Bd0uPQA66CvV/BfSOOdTLQm0x38OJ5z0JT/a035fMKI3wc5b
 2h272J7LvBmpzqnfe2ROsO0q9ACu+h+uqHkY+4ql0GJkatGr8tie8JtYS0XldhtWhYLr fQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfn5j357e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 14:52:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312EqRac002881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 14:52:27 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 06:52:23 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 0/6] Add APSS clock driver support for IPQ5332
Date:   Thu, 2 Feb 2023 20:22:02 +0530
Message-ID: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Q-pJWIfo6uQUe2rJGC--uhRO6cZJtVaY
X-Proofpoint-GUID: Q-pJWIfo6uQUe2rJGC--uhRO6cZJtVaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 adultscore=0 mlxscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=846 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302020133
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the APSS clock to bump the CPU frequency
above 800MHz.

APSS PLL found in the IPQ5332 is of type Stromer Plus. However the
existing IPQ targets uses the Huayra PLL. So the driver has to
refactored to accommodate the different PLL types. The first patch in
the series does the refactoring, which can be independenty merged.

For the Stromer PLL separate function clk_stromer_pll_configure is
introduced, so the 3rd patch in the series depends on the below patch
https://lore.kernel.org/linux-arm-msm/20230120082631.22053-1-quic_kathirav@quicinc.com/

DTS patch depends on the IPQ5332 baseport series
https://lore.kernel.org/linux-arm-msm/20230130114702.20606-1-quic_kathirav@quicinc.com/

Kathiravan T (6):
  clk: qcom: apss-ipq-pll: refactor the driver to accommodate different
    PLL types
  dt-bindings: clock: qcom,a53pll: add IPQ5332 compatible
  clk: qcom: apss-ipq-pll: add support for IPQ5332
  dt-bindings: mailbox: qcom: add compatible for the IPQ5332 SoC
  mailbox: qcom-apcs-ipc: add IPQ5332 APSS clock support
  arm64: dts: qcom: ipq5332: enable the CPUFreq support

 .../bindings/clock/qcom,a53pll.yaml           |   1 +
 .../mailbox/qcom,apcs-kpss-global.yaml        |   3 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  36 ++++++
 drivers/clk/qcom/apss-ipq-pll.c               | 111 +++++++++++++++---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c       |   1 +
 5 files changed, 133 insertions(+), 19 deletions(-)

-- 
2.34.1

