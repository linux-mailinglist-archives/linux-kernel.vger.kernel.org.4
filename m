Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54850695040
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBMTCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjBMTCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:02:33 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5706823114;
        Mon, 13 Feb 2023 11:01:47 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DFM7XC027382;
        Mon, 13 Feb 2023 19:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=dQYWhXzT07LYVq0/if5nn8gaE/tTE5zoUmYBBa/F2V4=;
 b=bZrMZjbwO6ZGmnbkAlmDKmbStCKu8hDdrEpFYAGiT6xn759oEXJWnzMNByj0L05Cj0ug
 TyOksWz3o25Yf7DwmCPOnlN6HBH6VRUzATRpjdFbhzlYgpUVrIbagcMg8pybeb19T8hT
 DdyEm2ZuruBLYs0qyjMPjV9lYCW3oeSh3w1nPw81kXrh/n026VQTxVKfyjZyvWrpCT3D
 hGZL0cFwM6ISWZI0/ALcsMBASsbybTWItCYYixO5nwFSRpQwW6s/4oc4ekKRybQmMNMo
 C5sXAfknBBmm/kdHuJkP9/2tnx7YyhJMU7oCvdvEzxi+KelZPB7IMrVX3oxxDT6y8+s0 AQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3npmvrknqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:01:42 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DJ1e9r008124
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:01:40 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 11:01:40 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] arm64: dts: qcom: Add mpss support to QDU1000/QRU1000 SoCs
Date:   Mon, 13 Feb 2023 11:01:19 -0800
Message-ID: <20230213190122.178501-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OrZd8jJjKyJEBOCoiLJ2_Hf0m_yVVhre
X-Proofpoint-GUID: OrZd8jJjKyJEBOCoiLJ2_Hf0m_yVVhre
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=451 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130167
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the mpss found in the QDU1000 and QRU1000 SoCs.
It needs an RMB register space to be specified to enable a handshake
with the mpss to late attach the device. The firmware file paths are
also added in the IDP board DTs.

This patch set depends on the bindings from [1].

[1] https://lore.kernel.org/all/20230213185218.166520-1-quic_molvera@quicinc.com/

Melody Olvera (3):
  arm64: dts: qcom: qdu1000: Add IPCC, MPSS, AOSS nodes
  arm64: dts: qcom: qdu1000-idp: Enable mpss
  arm64: dts: qcom: qru1000-idp: Enable mpss

 arch/arm64/boot/dts/qcom/qdu1000-idp.dts |   6 ++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 105 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts |   6 ++
 3 files changed, 117 insertions(+)


base-commit: 09e41676e35ab06e4bce8870ea3bf1f191c3cb90
prerequisite-patch-id: ddc43db334e06b6938219e12964a5e943641126d
prerequisite-patch-id: dfbe05633d84289f35047a32502984b00112d4fd
prerequisite-patch-id: 6a55ae4bd86e2565d8362579ce5f09a14e93e422
prerequisite-patch-id: 7c8c18aef7f693eb0749ee9f296bfb59ca202eb7
prerequisite-patch-id: 8d4a7aa9e2af4659f7f820058e90ed985410deed
prerequisite-patch-id: 3a012cc3a5b28208ecf23b2a1b5a0310d15aa4ac
prerequisite-patch-id: ad32654fa37f8c5fb00162d093b577f81a511bd0
prerequisite-patch-id: d699495a3b22bb97c9d114024a82a9fadcc40082
prerequisite-patch-id: 819b2fb10cd0322fe815ac9ab3ffbaac7c51ad71
-- 
2.25.1

