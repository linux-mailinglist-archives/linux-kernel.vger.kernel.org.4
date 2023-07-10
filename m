Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC23774D3A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjGJKiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjGJKiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:38:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8EEAF;
        Mon, 10 Jul 2023 03:38:14 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A8VCcW008876;
        Mon, 10 Jul 2023 10:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=OiycSosvczbzSKAQATUa0bf1F7Cxl8InNuvTdg1jyhI=;
 b=eiOqFBr5m9qWOlgw+u6ouzesFfyX1JELoPrV+VHkiGsE7jEByZFDgLK+o8hRcxauAyMf
 QxvVeXKKBQDhSGrQlV0gsPzWSnBqRjfD2p7iHmAvpAKNjcAbqDnHTl48j7QWcjdQ3B5R
 itLSYNLQ0mmIL/TaQGaLQ1vshxsWgJlOfnA+Ur+4TGLfK0I2h7RhnIGXfcw7Nm0+P8j/
 klJY4JcOez/2+LrM/sv3zUlBLX1XWupeyyWFg0chndFZFDgGM8vmtmsF51NM1fo8lz4p
 Kp5Ru+HHejye5zYMndVJcaiqxjGK62RjQdYIGv1u56oWloojrzr1mkZA14RyElFW5UMa bw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rre730ey7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:38:09 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36AAbuhX018180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:37:56 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 03:37:51 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH 0/6] Add IPQ5332 TSENS support
Date:   Mon, 10 Jul 2023 16:07:29 +0530
Message-ID: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 66iA1ghp75yf2-RU6iUKKI_IkmrND0tP
X-Proofpoint-ORIG-GUID: 66iA1ghp75yf2-RU6iUKKI_IkmrND0tP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_08,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=679 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 uses tsens v2.3.3 IP with combined interrupt for
upper/lower and critical. IPQ5332 does not have RPM and
kernel has to take care of TSENS enablement and calibration.
This patch series adds the sensor enablement and calibration
support. On top, adds IPQ5332 TSENS support.

Praveenkumar I (6):
  dt-bindings: thermal: tsens: Add nvmem cells for calibration data
  thermal/drivers/tsens: Add TSENS enable and calibration support for V2
  dt-bindings: thermal: tsens: Add ipq5332 compatible
  arm64: dts: qcom: ipq5332: Add tsens node
  arm64: dts: qcom: ipq5332: Add thermal zone nodes
  thermal/drivers/tsens: Add IPQ5332 support

 .../bindings/thermal/qcom-tsens.yaml          |  34 +++-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 185 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c               | 129 ++++++++++++
 drivers/thermal/qcom/tsens.c                  |  40 +++-
 drivers/thermal/qcom/tsens.h                  |  58 +++++-
 5 files changed, 440 insertions(+), 6 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

