Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56310668561
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjALVai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbjALV2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:28:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD2F840AB;
        Thu, 12 Jan 2023 13:07:37 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CJnH0a030291;
        Thu, 12 Jan 2023 21:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=wHxUVG3llIAbwQXTY3rDFc7+V650XXE/ilqaMMgqOBQ=;
 b=F0oNkbW1cxUYJqhnEP4os5u6Z5rz2RQEswTe/z2njWx3xwo0v/06mXFITWVG81Fg8pHy
 97FvievJKtkEaC30aMgppY6WT5Ilt+k+v9Eey5SjYJR1Gv1v2Z0lbwVI1eR+BBxX3t/0
 Dj6+Sd8H0jjl473kehGpQ4/vRu/SiqYjS5HkRkTwZR502CqVq2MKPN+WeU++3RrYarhS
 96ON4ltyeghko9g8vwArQgEXmvCCnuUto2LS5MJqgGowvbL7dWHPr9V8pWYRyjg4lkgq
 tw1WejwiMU1Ucorw/BrzJ1OeG/C6SzU5JWyHTOavX4i4E7OOC5zNbN/69aAvNjktyxoY Dg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1kbqd3rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 21:07:34 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30CL7Xuv028218
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 21:07:33 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 13:07:33 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v6 0/2] Add base device tree files for QDU1000/QRU1000
Date:   Thu, 12 Jan 2023 13:07:20 -0800
Message-ID: <20230112210722.6234-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vTPkjoG-0PjLK0ampgovF1djaDB936DS
X-Proofpoint-ORIG-GUID: vTPkjoG-0PjLK0ampgovF1djaDB936DS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=565 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120150
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

This patchset requires the dt-bindings changes from [1-3].

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

[1] https://lore.kernel.org/all/20221216231426.24760-1-quic_molvera@quicinc.com/
[2] https://lore.kernel.org/all/20230112204446.30236-1-quic_molvera@quicinc.com/
[3] https://lore.kernel.org/all/20230112203653.23139-1-quic_molvera@quicinc.com/

Changes from v5:
- Moved XYZ-names fields under XYZ fields
- Removed irrelevant comments
- Updated ordering of some fields
- Removed unneeded fields
- Revised style on clocks and interrupts

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
 arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 1333 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts |  453 ++++++++
 arch/arm64/boot/dts/qcom/qru1000.dtsi    |   26 +
 5 files changed, 2267 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi


base-commit: 0a093b2893c711d82622a9ab27da4f1172821336
prerequisite-patch-id: d439ef85a730c7b736ed8c63162e24c7ae661b60
prerequisite-patch-id: c55ff1a38fed5356caa8f40a85ef0b8ebc4d1fa4
prerequisite-patch-id: 984e8570d2464f4027dc59294c10f47e7ae29a84
-- 
2.38.1

