Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526CA6BC928
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjCPIb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCPIbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:31:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2442C7A94;
        Thu, 16 Mar 2023 01:31:16 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G6asmv014764;
        Thu, 16 Mar 2023 08:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=b+eRWJFRbzpZ3EgMX0Sb2ascf1cYOdZwpTavwnV/1LY=;
 b=hXJ6UIR0QmWP5dhL0ba1qPp8zzB2NWMbuAq8uFCbbwzx0bRdNylnsr3SDSBRSuItyYFI
 U2hjqqNEaNE8AEBpVVxnewx8I5P2nyweF2dxshz8m2IGbldoOszk3kCfdLs4IFjmoNAO
 bPH6Gzmc62OKXZ+skvAQTSc2CGoGT1Pmizi0wpvtKRRWyelEAJ8gPnZLKurWFyfeQfh8
 z9o0DQwqaKlbvs//ZF9hyHMDChX0fCX/Myi6NM4n5ujRH1B0Kda4E7WjwjDjq+SJOIDH
 1UEu6r/i5VjPwGkKZBSHU59xgvJvLo+6qzxfs3f1c4tGSO5L9u/PVm1kFyOIqHcSFKov BA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxjs847-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 08:31:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32G8VBs1010337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 08:31:11 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Mar 2023 01:31:07 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_skakitap@quicinc.com>, <quic_jkona@quicinc.com>
Subject: [PATCH 0/3] Add video clock controller driver for SM8450
Date:   Thu, 16 Mar 2023 14:00:46 +0530
Message-ID: <20230316083049.29979-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3-YlfX30uLKBM3JLZLOldso8LHJk_tms
X-Proofpoint-ORIG-GUID: 3-YlfX30uLKBM3JLZLOldso8LHJk_tms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=628 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303160071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings, driver and DT node for video clock controller on SM8450.

Taniya Das (3):
  dt-bindings: clock: qcom: Add bindings for videocc on SM8450
  clk: qcom: videocc-sm8450: Add video clock controller driver for
    SM8450
  arm64: dts: qcom: sm8450: Add video clock controller

 .../bindings/clock/qcom,sm8450-videocc.yaml   |  84 ++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  13 +
 drivers/clk/qcom/Kconfig                      |   9 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/videocc-sm8450.c             | 464 ++++++++++++++++++
 .../dt-bindings/clock/qcom,videocc-sm8450.h   |  38 ++
 6 files changed, 609 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
 create mode 100644 drivers/clk/qcom/videocc-sm8450.c
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sm8450.h

--
2.17.1

