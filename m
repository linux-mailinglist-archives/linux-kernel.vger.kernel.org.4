Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E75673863
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjASM2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjASM14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:27:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A2A5EF93;
        Thu, 19 Jan 2023 04:27:41 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5EKQ4011379;
        Thu, 19 Jan 2023 12:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=d/0m3VKk0XA101r48UX+xpe8pkTNdjvuD09Cc8QIZIY=;
 b=NOeF2PtB/6CIfTlCjViP8BPJzH2bTKr9Zvu340jvCNMBxb2kctX+w1CUkf+iLDrvOsen
 f63W/fW4xPthHUSZOAcc1jcWME9JoZVpkmAVT/e0qQU2AkNcvys9XK+9QbSdd5rI1sHV
 n7a3CU6CHepgciqweqj+W+yGHTwUmWmBLHS5nUnFZwnH0PO/ZUdG+8c2lApAmdBltTY/
 lmUOrefE2aNj3kQDgZW8fLpoOhSpveinnSbCA+v1DzsOB0xa3doC6Ub4aiMXifzVKIZx
 /pCmqeZNJPGAuLSIyJer/vY7oSHECG6QuRhZbvx65SqNg7jBREXS7WXS85VwkqygY0I2 Nw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6vg01e33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:27:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JCRTN4013425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:27:30 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 04:27:24 -0800
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
Subject: [PATCH v3 0/7] Add SC7280 audioreach device tree nodes
Date:   Thu, 19 Jan 2023 17:57:00 +0530
Message-ID: <1674131227-26456-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0KSr5q0roJReaVlr4kgYtYSRrpYHOHYo
X-Proofpoint-GUID: 0KSr5q0roJReaVlr4kgYtYSRrpYHOHYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190098
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
    
Changes Since v2:
    -- Remove Patch related to Add CGCR reset property.
    -- Remove Patch related to Disable legacy path clock nodes.
    -- Add dt-bindings for missing properties.
    -- Change the order of nodes.
    -- Move digictal codec macro nodes to root nod from soc node.
    -- Add adsp-pil-mode property in required clock nodes.

Changes Since v1:
    -- Move remoteproc node to soc dtsi file.
    -- Add qcom, adsp-pil-mode reg property in lpasscc node.
    -- Fix typo errors.
    -- Remove redundant status properties.

Srinivasa Rao Mandadapu (7):
  arm64: dts: qcom: sc7280: Extract audio nodes from common idp dtsi
    file
  arm64: dts: qcom: sc7280: Add sound node
  arm64: dts: qcom: sc7280: Add LPASS PIL node
  arm64: dts: qcom: sc7280: Update VA/RX/TX macro clock nodes
  arm64: dts: qcom: sc7280: Update lpass_tlmm node
  arm64: dts: qcom: sc7280: Update qcom,adsp-pil-mode property
  dt-bindings: remoteproc: qcom: sc7280-adsp-pil: Add missing properties

 .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  |  30 +++-
 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi     | 135 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts         |  24 +--
 .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 194 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           | 126 -------------
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  95 ++++++++++
 6 files changed, 451 insertions(+), 153 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi

-- 
2.7.4

