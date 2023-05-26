Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD75A712587
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbjEZLdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjEZLdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:33:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F02E7;
        Fri, 26 May 2023 04:33:42 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q7V6lw024125;
        Fri, 26 May 2023 11:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=CXN/WLtg+szgpVqcY/RI10ElEFkV1LvPmjPuOZ5FUYs=;
 b=SuzMJe7o7ad5xhU5uejpLRiLyrbIAYOTlOU4bdn++DBIAbzQPLNcKSi51uSl8B7ZVA2z
 P8Tk4cgIjC/gZrsmDLqe3PsGG/7IHW1qiDM4PKucumIgBGgJiEULsKOe+NwZd/H6G6hp
 223FdTkNizb4vpPAG8SYYOfvyiL6zQpNRggb8J7OVXR05tXo0npTpulKlCbASJ6tmCC5
 EhCCSrRBv/JM8DNhuYBJBXdH4hTV8B+pySO/vA62HxLuAGydDr7xK4v5baICWhFBPvm7
 LS3dJgJdyhtQ/mQ7k/0AL0py7AHQN20k1kmYlX3AvfOcpD/6tGX8dCJPx3w8/auLt9Zx ug== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtrev8e48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 11:33:28 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QBXQxf023280
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 11:33:26 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 04:33:21 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <alsa-devel@alsa-project.org>,
        <quic_rjendra@quicinc.com>, <konrad.dybcio@somainline.org>,
        <mka@chromium.org>, <quic_visr@quicinc.com>
CC:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v6 0/8] Add SC7280 audioreach device tree nodes
Date:   Fri, 26 May 2023 17:02:50 +0530
Message-ID: <20230526113258.1467276-1-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EvzDCBRm7xaPQ1z-Xs_DAwe3YuWMk8wm
X-Proofpoint-GUID: EvzDCBRm7xaPQ1z-Xs_DAwe3YuWMk8wm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SC7280 audioreach device tree nodes and extract audio specific
dtsi nodes and add them in new file.

This patch series depends on:
    -- https://patchwork.kernel.org/project/linux-clk/list/?series=717985
Corresponding dt-bindings not mainlined yet.
    -- https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/commit/?h=rproc-next&id=8490a99586abd480d7139893f78c019790a58979

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

