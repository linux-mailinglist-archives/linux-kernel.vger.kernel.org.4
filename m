Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1097E712985
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbjEZPcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243573AbjEZPcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:32:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254AFF7;
        Fri, 26 May 2023 08:32:15 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QBjjAe031444;
        Fri, 26 May 2023 15:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=4cZq0U/TESna6dAb93pmCft9SGYqyhe3RNhQJ9OXxWY=;
 b=gYaSIbtwktFgBBIrdsG6pTkqFfyDXWKcaEUHdSD55vlettDQpPLxvYPy8+LCzU7x2Bh6
 TvhOW5vWYY2yGryVgu4lSO0IiaVl0fsQwetwRo4SnomOVCQH+rj2YGPWoNaCuTxSsePp
 rf2tULnL9pLyx+tyDRr+Gs9DIWrvPpBRQpSYbBtjkk/ynsePVqHKep7Hi+GQgS8MDLjh
 aD2nxpphtd9yxjDy8e9hNsaOjZLj5023oJ/ItnZCqzodVgKwSMfGMwdGEzO7VqKbdx3G
 0F9pyWFiKXbV4+Dwh87tWKA40Uj52EN9CK2gaTpsXCBXFhDGyW1/3Jav/sDJnCOahVH5 6Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtu0u0nhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:32:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QFWAvg018667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:32:10 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 08:32:05 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
Subject: [PATCH 0/2] Add initial support for RDP453 of IPQ9574 family
Date:   Fri, 26 May 2023 21:01:50 +0530
Message-ID: <20230526153152.777-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Vzz_GkZKsBMNP-xkamW2OUx0EHGm9X_3
X-Proofpoint-GUID: Vzz_GkZKsBMNP-xkamW2OUx0EHGm9X_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=694
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree support for the Reference Design
Platform(RDP) 453 based on IPQ9574 family of SoCs. This patch series adds
support for Console UART, SPI NOR and SMPA1 regulator node.

The series depends on the below patch sets which adds support for
SPI NOR and SMPA1 regulator nodes.
https://lore.kernel.org/linux-arm-msm/20230329053726.14860-3-quic_kathirav@quicinc.com/
https://lore.kernel.org/linux-arm-msm/20230407155727.20615-1-quic_devipriy@quicinc.com/

Devi Priya (2):
  dt-bindings: arm: qcom: document AL02-C8 board based on IPQ9574 family
  arm64: dts: qcom: ipq9574: add support for RDP453 variant

 .../devicetree/bindings/arm/qcom.yaml         |  2 +
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts   | 80 +++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts

-- 
2.17.1

