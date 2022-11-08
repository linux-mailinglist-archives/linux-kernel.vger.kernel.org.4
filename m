Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BF062173B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiKHOrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiKHOrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:47:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360561014;
        Tue,  8 Nov 2022 06:47:07 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A8E4BRU023741;
        Tue, 8 Nov 2022 14:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=XMsK3NgNdwgSlQSOgcdQfy9dxUcbd7/GBZAKmJJHubk=;
 b=j6KgLo+TWq4h7s2dD86L/W0SFE23dnXMtnMbIwz6hxpeB/snlme3VNSorCM2XyYUabMy
 1KnZKUzg1sPUozPevXXBQip0mnZxc1Q4zSeQObP+3gBtjANX4cLyQ5kBV9fZ4V6IrjyQ
 6BsJaugJy1ewKZGg2ffcqVMQeg7ftiLjY6vPeYIitMPkOw5gDEUNWBZEesJIUiMxgIR6
 hzyd4MNFhtKk/qq+Yryugr3x9v98apAJGuvoPaRxRND4b/oLMdx8UZZbFnUBL61BcTQD
 2ywlHJkVS8Ee2LuBLAdLQS1glYZO1l121Hdp4KpsZCge22qWEUITcS/Q4Cg0ti1+ecsA 0Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqhvj163c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 14:46:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A8EkvmS005283
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 14:46:57 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 8 Nov 2022 06:46:51 -0800
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
Subject: [PATCH v6 2/4] arm64: dts: qcom: sm8250: Remove redundant soundwire property
Date:   Tue, 8 Nov 2022 20:16:01 +0530
Message-ID: <1667918763-32445-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667918763-32445-1-git-send-email-quic_srivasam@quicinc.com>
References: <1667918763-32445-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aGAd9WEhVnrFxE_abR1tRdwAWRFnWuAS
X-Proofpoint-GUID: aGAd9WEhVnrFxE_abR1tRdwAWRFnWuAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=711 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080089
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
qcom,soundwire.yaml

Fixes: 24f52ef0c4bf ("arm64: dts: qcom: sm8250: Add nodes for tx and rx macros with soundwire masters")
Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index eb5a10c..0f430ca 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2360,7 +2360,6 @@
 			qcom,ports-word-length =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF>;
 			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF>;
 			qcom,ports-lane-control =	/bits/ 8 <0xFF 0x00 0x01 0x00 0x01>;
-			qcom,port-offset = <1>;
 			#sound-dai-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <0>;
-- 
2.7.4

