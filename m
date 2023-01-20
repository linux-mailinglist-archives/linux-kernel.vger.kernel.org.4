Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A376757B6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjATOpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjATOp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:45:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBE12BF26;
        Fri, 20 Jan 2023 06:44:55 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KDnCAG005568;
        Fri, 20 Jan 2023 14:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=yheRbIbicAKXHUM+UATza2UYD1aXrGTJi0I0dCAwKAU=;
 b=n4yuM/F5al29iuNRTXd+YWnBjuAI4jc0QTANx2b2pzzP/L5gc7gkdrLoZWeVjo4SmRai
 w4xiPxhl4GoARUQzFYl2wTLlFAmGViG5+Bw/rw91v3lqkLr1SmRws3KOX3AzmYPwQLjM
 HJFqJX2VF+EmAh7bgeUK+UFBjr+KV+F24XprAE+i3m0GmDi+Rc3bJ96i5HlEDpTddQ4+
 AYsiJ+/QbswVVFiCO+rkpD/1+gKwW+m+Eh8GTbsS9sZkL4UoPfx/IKQbVVcSLH9zoVLb
 BVV5w1YykPug3iCcE/wxQi01uXTYZHxN7BDfOj88wrJQm8fNnAZuuZ8bjLhYAoHddRXT 8Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7q858hg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 14:16:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KEGwst029712
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 14:16:58 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 06:16:52 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <vkoul@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <alsa-devel@alsa-project.org>, <quic_rjendra@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mka@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v4 0/7] Add SC7280 audioreach device tree nodes
Date:   Fri, 20 Jan 2023 19:46:34 +0530
Message-ID: <1674224201-28109-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EYiwxHwuMw6YFLDceecAJkH_-CQRp9ek
X-Proofpoint-GUID: EYiwxHwuMw6YFLDceecAJkH_-CQRp9ek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_08,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200135
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SC7280 audioreach device tree nodes and extract audio specific
dtsi nodes and add them in new file.

This patch series depends on:
    -- https://patchwork.kernel.org/project/linux-clk/list/?series=713587
Corresponding dt-bindings not mainlined yet.
    -- https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/commit/?h=rproc-next&id=8490a99586abd480d7139893f78c019790a58979

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

Srinivasa Rao Mandadapu (7):
  arm64: dts: qcom: sc7280: Extract audio nodes from common idp dtsi
    file
  arm64: dts: qcom: sc7280: Add sound node for crd-rev3 board
  arm64: dts: qcom: sc7280: Add LPASS PIL node
  arm64: dts: qcom: sc7280: Update VA/RX/TX macro clock nodes
  arm64: dts: qcom: sc7280: Update lpass_tlmm node
  arm64: dts: qcom: sc7280: Update qcom,adsp-pil-mode property
  dt-bindings: remoteproc: qcom: sc7280-adsp-pil: Add missing properties

 .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  |  30 +++-
 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi     | 135 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts         |  24 +--
 .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 171 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           | 126 ---------------
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  96 ++++++++++++
 6 files changed, 429 insertions(+), 153 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi

-- 
2.7.4

