Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C8669B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjAMOzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjAMOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:54:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF1569532;
        Fri, 13 Jan 2023 06:40:49 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DBdc0S019731;
        Fri, 13 Jan 2023 14:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=HM5xSvGbqqHtkUNjIzR2+WfHdaLsxvU6qaBRKEg0FcA=;
 b=dePc3oa1bALUgR3ObSdGhyhXK1hoVs+6bCIIC80u5WItWNZ2rqM+hOQ7GLbl4myHZZ/J
 /GwLDJbdgRTiO9tDYQ1Z5b63LNAAi6JFZJLKT7aMqopvwYIIWWIbOjKiNho+ccq2U8I3
 y7tsluJTm3Vxb6i1cmf3YIqjHeS1ERcBzRCwBfBGbDQDVHO6jVjwFNZSk6C1YfIqTlfy
 Ehuqo7ghQvsElCOtufKCSV67IEbH4qutQYVzEyuh2G+5GyKYl3/+pMMgGngXrvWr8ii3
 S9SQa2MWGyGCGgM0HOKIZ029fztsB1kWrqZxzUNMVEXTYlVwmCxijoCWSUUvpgxpT9m0 5g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2d75403c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 14:37:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DEbBO8015525
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 14:37:11 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 06:37:03 -0800
From:   devi priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 0/6] Add APSS clock controller support for IPQ9574
Date:   Fri, 13 Jan 2023 20:06:41 +0530
Message-ID: <20230113143647.14961-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5rnfP-18Ml1hcBS6pIGFo3cmW1jttdGo
X-Proofpoint-GUID: 5rnfP-18Ml1hcBS6pIGFo3cmW1jttdGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 mlxlogscore=694 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130096
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APSS clock controller in IPQ9574 based devices supports cpu with
frequencies above 800Mhz

This patch series adds the support for the same

This series depends on the below patchset
https://lore.kernel.org/linux-arm-msm/20230110121316.24892-1-quic_devipriy@quicinc.com/

devi priya (6):
  dt-bindings: clock: Add YAML schemas for QCOM A73 PLL
  clk: qcom: ipq9574: Enable APSS clock driver
  arm64: defconfig: Enable ipq6018 apss clock and PLL controller
  arm64: dts: qcom: ipq9574: Add support for APSS clock controller
  dt-bindings: mailbox: Add compatible for IPQ9574
  clk: qcom: Fix APSS PLL and RCG Configuration

 .../bindings/clock/qcom,a73pll.yaml           | 52 +++++++++++++++++++
 .../mailbox/qcom,apcs-kpss-global.yaml        |  3 ++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 17 ++++++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/clk/qcom/apss-ipq-pll.c               | 14 +++++
 drivers/clk/qcom/apss-ipq6018.c               |  8 ++-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c       |  5 ++
 7 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,a73pll.yaml


base-commit: 1fe4fd6f5cad346e598593af36caeadc4f5d4fa9
-- 
2.17.1

