Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01CF732F01
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbjFPKqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345873AbjFPKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:45:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD221131F8;
        Fri, 16 Jun 2023 03:38:13 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G9g8b5029333;
        Fri, 16 Jun 2023 10:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=TiNH25i3b4SVV5Pb7GZe9FH60iyTKtljgRq+2ljwzCI=;
 b=WtqFtZh4/ge8G6e/9MVREysg6ktay9t7AAlqnHVWpkhpMlZbQps+RS8ucnsUMDQDZ0Lc
 LDU9LJM/fS54ilx85QzeGEZvx3luiJ9KJBveEfbQYt+ij+wCnA9fB+NEOFEPz1dkmJD9
 EfB9duh7GCVAOzvcKHWwge9x32fI403/aaUEIP3ke6smDAnLzvsZpVcXp5AQatvpyWog
 phxjSsQ+uwUjD/PomlkHA2AJxLPlU5lxN4BHJHIsERi/i+U6+T9vmuKmIYYysGr8uNuB
 m6YnbcdisLF4rbZIOdlvBpDncqfocIPop87dUn59uD7uET+HxQYenJD3Scs2t0ka5CzR MA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r8axuh5n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 10:36:50 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35GAan5n020410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 10:36:49 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 16 Jun 2023 03:36:44 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <swboyd@chromium.org>,
        <andersson@kernel.org>, <broonie@kernel.org>, <agross@kernel.org>
CC:     <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <konrad.dybcio@linaro.org>, <dianders@chromium.org>,
        <judyhsiao@chromium.org>, <quic_visr@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [RESEND v6 0/8] Add SC7280 audioreach device tree nodes
Date:   Fri, 16 Jun 2023 16:05:26 +0530
Message-ID: <20230616103534.4031331-1-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mMGKZnWTTbq8oXw54v3GbD0XAVMGQjc7
X-Proofpoint-GUID: mMGKZnWTTbq8oXw54v3GbD0XAVMGQjc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_06,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 lowpriorityscore=0
 mlxlogscore=942 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SC7280 audioreach device tree nodes and extract audio specific
dtsi nodes and add them in new file.

Changes Since v5:
    -- Re-arrange the patch list, driver changes should come after binding.
    -- Remove incorrect dai cells property in "Add sound node for crd-rev3 board" patch.
    -- Remove newlines in "Add LPASS PIL node" patch.
    -- Update the commit message in "Update VA/RX/TX macro clock nodes" patch.
    -- Update the commit message in "Update lpass_tlmm node" patch.
Changes Since v4:
    -- Modify lpasscc clock controller node name.
    -- Disable lpass_core node.
    -- Modify Model name in sound node in "Add sound node for crd-rev3 board" patch.
    -- Remove protection domain property in "Add LPASS PIL node".
Changes Since v3:
    -- Remove deleting digital codecs in crd-rev3 board specific dtsi and upadate them using phandle.
    -- Update commit message in "Update lpass_tlmm node" patch.
    -- Change the position of status property in LPASS PIL node.
    -- Update commit message in "Add sound node" patch.
Changes Since v2:
    -- Remove Patch related to Add CGCR reset property.
    -- Remove Patch related to Disable legacy path clock nodes.
    -- Add dt-bindings for missing properties.
    -- Change the order of nodes.
    -- Move digictal codec macro nodes to root node from soc node.
    -- Add adsp-pil-mode property in required clock nodes.
Changes Since v1:
    -- Move remoteproc node to soc dtsi file.
    -- Add qcom, adsp-pil-mode reg property in lpasscc node.
    -- Fix typo errors.
    -- Remove redundant status properties.

Srinivasa Rao Mandadapu (8):
  arm64: dts: qcom: sc7280: Modify lpasscc node name
  dt-bindings: remoteproc: qcom: sc7280-adsp-pil: Add missing properties
  arm64: dts: qcom: sc7280: Extract audio nodes from common idp dtsi
    file
  arm64: dts: qcom: sc7280: Add sound node for crd-rev3 board
  arm64: dts: qcom: sc7280: Add LPASS PIL node
  arm64: dts: qcom: sc7280: Modify VA/RX/TX macro clock nodes for
    audioreach solution
  arm64: dts: qcom: sc7280: Modify LPASS_MCC reg region size in the
    lpass_tlmm node
  arm64: dts: qcom: sc7280: Add qcom,adsp-pil-mode property in clock
    nodes

 .../remoteproc/qcom,sc7280-adsp-pil.yaml      |  30 ++-
 .../arm64/boot/dts/qcom/sc7280-audio-idp.dtsi | 131 +++++++++
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts    |   1 +
 .../sc7280-herobrine-audioreach-wcd9385.dtsi  | 253 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      | 122 ---------
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   4 +-
 6 files changed, 413 insertions(+), 128 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi

-- 
2.25.1

