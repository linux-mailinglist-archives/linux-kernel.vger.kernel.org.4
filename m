Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A63E64F4FF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiLPX2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPX2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:28:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334FC22521;
        Fri, 16 Dec 2022 15:28:10 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGKts1m006265;
        Fri, 16 Dec 2022 23:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=erMkxz+2npfdNa/sjAhoCOkjttH6JHlaNNRyrnpNyhI=;
 b=IbUm8n1UrL4wUJmE1yRaDybd0QuLXY/iUUuvUHFwylh/ITkU9C5n7L+QNuQCorejQtyZ
 /tnaw95Ug6ar9fs/cAGJaRbZ8xn4q89basbpibASA+BujQ3+VlTNXQ+ECwRvrr/20XYx
 npCwNfKnK1eXna1U6lcH844I2VWZVwGvI4cAvaoVg/1pvw91JWR0PSILHRj8Ec/k60I9
 RbxlGrEOdqhq2oZMq3u/cI8/BVIhBLR3WZNwsSrr27YHJzOR2985LszwpZ2WDuF6FmfG
 b62jCI5+3ChnawxRGYh1J5g9LY05U+1Ecy0Y/g5INDPVwgJWZh8riAmC3/veMe26Yin4 Bw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg3f8wfhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 23:28:07 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BGNS6cj028921
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 23:28:06 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 15:28:06 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v5 0/2] Add base device tree files for QDU1000/QRU1000
Date:   Fri, 16 Dec 2022 15:27:51 -0800
Message-ID: <20221216232753.6671-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BKRM4JwFTVeFqdh49E9MhBLWXessjEZ5
X-Proofpoint-ORIG-GUID: BKRM4JwFTVeFqdh49E9MhBLWXessjEZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxlogscore=619
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160206
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the base device tree files and DTS support for the
Qualcomm QDU1000 and QRU1000 IDP SoCs, including the clocks, tlmm, smmu,
regulators, mmc, interconnects, cpufreq, and qup. 

This patchset requires the dt-bindings cahnges from [1-7].

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

[1] https://lore.kernel.org/lkml/20221216230722.21404-2-quic_molvera@quicinc.com/
[2] https://lore.kernel.org/lkml/20221216230852.21691-2-quic_molvera@quicinc.com/
[3] https://lore.kernel.org/lkml/20221216230914.21771-2-quic_molvera@quicinc.com/
[4] https://lore.kernel.org/lkml/20221216231312.22574-1-quic_molvera@quicinc.com/
[5] https://lore.kernel.org/lkml/20221216231349.22835-1-quic_molvera@quicinc.com/
[6] https://lore.kernel.org/lkml/20221216231426.24760-1-quic_molvera@quicinc.com/
[7] https://lore.kernel.org/lkml/20221216231513.25085-1-quic_molvera@quicinc.com/

Changes from v4:
- Added chassis-type
- Added missing regulator voltages
- Sorted includes
- Remaned memory nodes
- Reorganized nodes to start with compatible/reg
- Removed unnecessary clocks
- Switched to deleting nodes by label
- Moved pin biases and drive strengths to dts files

Changes from v3:
- added PCIE and USB clocks
- added missing qdu1000 compats

Changes from v2:
- Revised device nodes to match updated dt-bindings
- Revised rpmh-rsc bindings to allow for generic regulator nodes
- Updated soc ordering
- Moved clock node to DTS files
- Updated regulator nodes to be generic
- Removed some unnecessary whitespace

Melody Olvera (2):
  arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
  arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs

 arch/arm64/boot/dts/qcom/Makefile        |    2 +
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  453 ++++++++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 1334 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts |  453 ++++++++
 arch/arm64/boot/dts/qcom/qru1000.dtsi    |   26 +
 5 files changed, 2268 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi


base-commit: ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291
prerequisite-patch-id: 33dc185eb002163bc54d0638d7adf1acb5389370
prerequisite-patch-id: c55ff1a38fed5356caa8f40a85ef0b8ebc4d1fa4
prerequisite-patch-id: 527e8f51e8f8f113d80952f26215ecbe491ba39e
prerequisite-patch-id: a6ce10162dcf7c392bf8318363081d7ef6749679
prerequisite-patch-id: d5d17b3d720b358b8478cb1ad87e21a70992f228
prerequisite-patch-id: 6c92672973fdc1524516942fa21c340e68e7c4fb
prerequisite-patch-id: 89c175b9874a926a7cc10d0dbae3a192d9b089dd
prerequisite-patch-id: 4a3c6a10c0070c0f411605aad07d664e20b01830
prerequisite-patch-id: 0a0f671fae0526d96f745ff1329b0ff8cbec1082
-- 
2.38.1

