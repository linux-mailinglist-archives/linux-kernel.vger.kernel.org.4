Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24086757BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjATOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjATOtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:49:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E2CA22;
        Fri, 20 Jan 2023 06:48:43 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KE002n012423;
        Fri, 20 Jan 2023 14:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tCMmsGxjVOPqGpJtvEuIpzeN2pqDdD6CYa5WnwUj7eQ=;
 b=bCYSfEseRqVGEnZsB4wLThqQzHrTZLn8RcRCY0zLyrjR+TNLX/+MKLsI8ecN1aKltvD3
 SHoMoqvJ/KBoDwpceLt4GIeUK7exNdFSg1Ze3lDz4CfCvAYJk4yOIKQ7qs7sLqrVfsaL
 V6iHLZX1zjP59zvEgLVLPOjos2nij+ooq6nmWlEAOdmftPuLubsZgksqyZ86J6GjxUb7
 lmHNeWkcGTPD+aVg5tAC/sAw27kt+bi4mYy745Q/HMWrg6yqdzomGywpQUybEG+XW9qx
 voxoZ8jhEv1iIX7y/81BxG4QpLlcSAFQ3ZPLcPx/ubw5YjU4IlgyWqJL1UGzMIJ/A7/t 2g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7593ttxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 14:17:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KEHbGM028012
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 14:17:37 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 06:17:30 -0800
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
Subject: [PATCH v4 6/7] arm64: dts: qcom: sc7280: Update qcom,adsp-pil-mode property
Date:   Fri, 20 Jan 2023 19:46:40 +0530
Message-ID: <1674224201-28109-7-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674224201-28109-1-git-send-email-quic_srivasam@quicinc.com>
References: <1674224201-28109-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mI5oM37n6RLiVFAL4dyQHWBoMwnF2myL
X-Proofpoint-ORIG-GUID: mI5oM37n6RLiVFAL4dyQHWBoMwnF2myL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_08,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301200135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "qcom,adsp-pil-mode" property in clock nodes for herobrine
crd revision 3 board specific device tree.
This is to register clocks conditionally by differentiating ADSP
based platforms and legacy path platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 .../boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
index 4def6b3..b95bfd1 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
@@ -108,6 +108,14 @@
 	};
 };
 
+&lpass_aon {
+	qcom,adsp-pil-mode;
+};
+
+&lpass_core {
+	qcom,adsp-pil-mode;
+};
+
 &lpass_rx_macro {
 	/delete-property/ power-domains;
 	/delete-property/ power-domain-names;
@@ -154,6 +162,10 @@
 	status = "okay";
 };
 
+&lpasscc {
+	qcom,adsp-pil-mode;
+};
+
 &remoteproc_adsp {
 	status = "okay";
 };
-- 
2.7.4

