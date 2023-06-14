Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F147A72F852
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbjFNIvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243784AbjFNIvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:51:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A891FEA;
        Wed, 14 Jun 2023 01:51:15 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E78USP028290;
        Wed, 14 Jun 2023 08:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=sXAe2c2RbdnFBaz+CiyJL/jie37GiP11K4iRMzI1jik=;
 b=hTceB8dOqKlDL7KgwmOc2GeVeg1fUucYVbf/rSyoWOV+Z557vHWrO0GVuOU7Se0OTK4q
 +N6yO1525vU7Dqycu94krggBfP3tTmZyN+GqhE2FUlXvad2jvhFUPSevvQT3B3vDctoF
 VAw7TkczPyI2uqgHGcJFVTD6j39uQCzotNmNa8ewmR9Uimz5COXRe/aUFDvwpsqajUYR
 9bN2QCTi8lQEh5uNpn/WEB81fMjaGkoef7heA9z3ey4ZTZxHZ5SstkSjYleUIvoZKSbo
 BMCEra4CQbNx6LzBrNE8Obic60qX72jqptEHpDKG4MGQFrbh3FlwkbCK0v+h/Z65sWYD Ig== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r69nwkw1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 08:51:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35E8p4hE024566
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 08:51:04 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 14 Jun 2023 01:50:59 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH 0/2] Add common RDP dtsi file for ipq9574
Date:   Wed, 14 Jun 2023 14:20:38 +0530
Message-ID: <20230614085040.22071-1-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rpNAoMJ8fx8v562xRj58RB3lFLzeij5G
X-Proofpoint-GUID: rpNAoMJ8fx8v562xRj58RB3lFLzeij5G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_05,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=403 impostorscore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some interfaces are common across RDPs.
Move the common nodes to ipq9574-rdp-common.dtsi.
Use rdp specific dts file to include interfaces that vary across RDPs.
Example, ipq9574 has 4 PCIE controllers.
RDP417 enables PCIE0 and PCIE1, RDP418 enables PCIE2 and PCIE3.
While at it, add support for WPS buttons.

Anusha Rao (2):
  arm64: dts: qcom: ipq9574: Add common RDP dtsi file
  arm64: dts: qcom: ipq9574: Enable WPS buttons

 .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 144 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts   | 107 +------------
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   |  88 +----------
 arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts   |  65 +-------
 arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts   |  65 +-------
 5 files changed, 148 insertions(+), 321 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi


base-commit: 1f6ce8392d6ff486af5ca96df9ded5882c4b6977
-- 
2.17.1

