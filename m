Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F13E621107
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiKHMkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiKHMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:40:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D639850F30;
        Tue,  8 Nov 2022 04:40:08 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A8BHKFf027473;
        Tue, 8 Nov 2022 12:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=cX7FZc3jEmQUhiwgS8NCoCB1Yjw+v7A7EvphLKLAlFI=;
 b=Vm85AE2wcDV9vgmoIEJBFqjbcVyPHkBc0HfODkcpuhb+pF0HrUfQ27lDfTt+p5uFZUbZ
 2gNvrm8diPCSYeGjaf1xKjG97lM7HOLGTGoj+28OEALmTLFcA43ycYyUir+J+YQlUqV5
 vjhVRVwH3y2iRlHSU4Ce6XNJ4/facT8so1qiIeV94MHq+4GXobFd/JXgmXTrZMU2MpQ4
 uaPpbC6hCMq+bjz2pmoK2xLo/uGX2CPU0+eFbyG2TaJxrLTr4uqOuRL5YOz3Jwas0R4/
 8WVFtG9JR+CfNWevA3N3zQqd7q4BQlqBB8H9mJXcKKR2ZD932CTgC5mqUnSb+8hH46cf hA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqhmk8u28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 12:40:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A8CdxDZ003027
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 12:39:59 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 8 Nov 2022 04:39:53 -0800
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
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Ratna Deepthi Kudaravalli" <quic_rkudarav@quicinc.com>
Subject: [PATCH v5 3/4] arm64: dts: qcom: sc7280: Remove redundant soundwire property
Date:   Tue, 8 Nov 2022 18:09:15 +0530
Message-ID: <1667911156-19238-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667911156-19238-1-git-send-email-quic_srivasam@quicinc.com>
References: <1667911156-19238-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SFiwtp0Rc8Uiszc00ALWeCMJYebMGvxL
X-Proofpoint-ORIG-GUID: SFiwtp0Rc8Uiszc00ALWeCMJYebMGvxL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxlogscore=727
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211080073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant and undocumented property qcom,port-offset in
soundwire controller nodes.
This patch is required to avoid dtbs_check errors with
qcom,soundwie.yaml

Fixes: 12ef689f09ab ("arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital macro codecs")

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 748eef6..71be873 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2317,7 +2317,6 @@
 			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff>;
 			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff>;
 			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00>;
-			qcom,port-offset = <1>;
 
 			#sound-dai-cells = <1>;
 			#address-cells = <2>;
-- 
2.7.4

