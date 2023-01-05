Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6070E65ED32
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjAENiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjAENiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:38:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC9111B;
        Thu,  5 Jan 2023 05:38:17 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305D0RXl007265;
        Thu, 5 Jan 2023 13:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ypm1RLqefGFLqScvF+BmG+jhoz8Y4fxx2uPYp3gBN9I=;
 b=PSSlMI344/3nx60Ug3+aKoRrO11hQ5uM1MpQLERc1r70xZdv8rOqXbyfTb8MEQI5W4ZY
 GOQECrTTIXqWO3FDcnEy7nNvg/8FbNbZwK/ZrwVRvPI8sDR+3STHwDtmN0dSTXJtENQG
 uENZiYeB6BdIpw8o2sqFVbfocHoJ84cGnRLn3jZofqw1VcUUnwyPq5s67NO8bopm3gL0
 uzwThpqMLcBk7Hr2agrU3jPIXxt0T2lqMEowL+d2NVkafeZ10wxi2susA/pphPYnYRix
 k/r0kQ/eceM0idG5AtMIyyjg22Fg9ZB9suWhblmeH8uNSeB9a7ZXWn3I2qMSa8uPFwVx 9A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mwvapgbac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 13:38:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 305DcCqF030667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Jan 2023 13:38:12 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 5 Jan 2023 05:38:07 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <konrad.dybcio@linaro.org>, <mka@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2 0/8] Add SC7280 audioreach device tree nodes.
Date:   Thu, 5 Jan 2023 19:07:47 +0530
Message-ID: <1672925875-2107-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KNL8wTMe8fFhsEKis8MiZQH2d2RGN4kl
X-Proofpoint-ORIG-GUID: KNL8wTMe8fFhsEKis8MiZQH2d2RGN4kl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxlogscore=865 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SC7280 audioreach device tree nodes and extract audio specific
dtsi nodes and add them in new file.

This patch depends on:
    -- https://patchwork.kernel.org/project/linux-clk/list/?series=707713

Srinivasa Rao Mandadapu (8):
  arm64: dts: qcom: sc7280: Extract audio nodes from common idp dtsi
    file
  arm64: dts: qcom: sc7280: audioreach: Add sound node
  arm64: dts: qcom: sc7280: audioreach: Add lpass pil node
  arm64: dts: qcom: sc7280: audioreach: Update VA/RX/TX macro clock
    nodes
  arm64: dts: qcom: sc7280: audioreach: Update lpass_tlmm node
  arm64: dts: qcom: sc7280: audioreach: Update lpasscc reg property
  arm64: dts: qcom: sc7280: audioreach: Add CGCR reset property
  arm64: dts: qcom: sc7280: audioreach: Disable legacy path clock nodes

 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi     | 135 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts         |  24 +--
 .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 204 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           | 126 -------------
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  96 +++++++++-
 5 files changed, 434 insertions(+), 151 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi

-- 
2.7.4

